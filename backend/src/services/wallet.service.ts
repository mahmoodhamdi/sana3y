import { Types } from 'mongoose';
import Transaction from '@models/Transaction';
import { config } from '@config/index';
import { BadRequestError } from '@utils/errors';

export interface WalletBalance {
  craftsmanUserId: string;
  totalEarned: number;
  totalPaidOut: number;
  pendingPayouts: number;
  availableBalance: number;
  currency: 'EGP';
  minWithdrawal: number;
}

/**
 * Compute the craftsman's wallet balance by aggregating Transaction records.
 *
 * Earned   = sum(netAmount) of `craftsman_payout` transactions where the craftsman
 *            is the `toUserId` and status is `completed`. These represent platform
 *            credits owed to the craftsman after each completed job.
 * PaidOut  = sum(amount) of `withdrawal` transactions where the craftsman is the
 *            `fromUserId` and status is `completed`.
 * Pending  = sum of `withdrawal` transactions still in `pending` state.
 * Available = totalEarned - totalPaidOut - pendingPayouts.
 */
export const getCraftsmanWalletBalance = async (
  craftsmanUserId: string
): Promise<WalletBalance> => {
  const userObjectId = new Types.ObjectId(craftsmanUserId);
  const aggregated = await Transaction.aggregate<{
    _id: { type: string; status: string };
    total: number;
  }>([
    {
      $match: {
        $or: [
          { type: 'craftsman_payout', toUserId: userObjectId },
          { type: 'withdrawal', fromUserId: userObjectId },
        ],
      },
    },
    {
      $group: {
        _id: { type: '$type', status: '$status' },
        total: {
          $sum: { $cond: [{ $eq: ['$type', 'craftsman_payout'] }, '$netAmount', '$amount'] },
        },
      },
    },
  ]);

  let totalEarned = 0;
  let totalPaidOut = 0;
  let pendingPayouts = 0;
  for (const row of aggregated) {
    if (row._id.type === 'craftsman_payout' && row._id.status === 'completed') {
      totalEarned += row.total;
    } else if (row._id.type === 'withdrawal' && row._id.status === 'completed') {
      totalPaidOut += row.total;
    } else if (row._id.type === 'withdrawal' && row._id.status === 'pending') {
      pendingPayouts += row.total;
    }
  }

  const availableBalance = Math.max(0, totalEarned - totalPaidOut - pendingPayouts);
  return {
    craftsmanUserId,
    totalEarned,
    totalPaidOut,
    pendingPayouts,
    availableBalance,
    currency: 'EGP',
    minWithdrawal: config.app.minWithdrawal,
  };
};

export interface WithdrawalRequestInput {
  craftsmanUserId: string;
  amount: number;
  method: 'bank_transfer' | 'instapay' | 'vodafone_cash' | 'cash_at_office';
  destinationRef: string;
}

/**
 * Create a pending Withdrawal transaction. Admin reviews and marks completed via
 * `/api/v1/admin/transactions/:id/complete`. The actual payout happens off-platform.
 */
export const requestWithdrawal = async (
  input: WithdrawalRequestInput
): Promise<{ transactionId: string; status: 'pending' }> => {
  const balance = await getCraftsmanWalletBalance(input.craftsmanUserId);
  if (input.amount < balance.minWithdrawal) {
    throw new BadRequestError(
      `الحد الأدنى للسحب ${balance.minWithdrawal} جنيه`
    );
  }
  if (input.amount > balance.availableBalance) {
    throw new BadRequestError('المبلغ المطلوب أكبر من الرصيد المتاح');
  }

  const txNumber = `WTH-${Date.now().toString(36).toUpperCase()}-${Math.random()
    .toString(36)
    .slice(2, 6)
    .toUpperCase()}`;

  const tx = await Transaction.create({
    transactionNumber: txNumber,
    type: 'withdrawal',
    fromUserId: new Types.ObjectId(input.craftsmanUserId),
    amount: input.amount,
    fee: 0,
    netAmount: input.amount,
    status: 'pending',
    paymentMethod: input.method,
    notes: `Withdrawal request → ${input.method}: ${input.destinationRef}`,
  });

  return { transactionId: tx._id.toString(), status: 'pending' };
};

/**
 * Calculate commission split for a completed job. Returns the craftsman payout amount
 * (after commission) and the platform fee that the platform retains.
 *
 * Used at request-completion time when we credit the craftsman's wallet.
 */
export const calculateCommissionSplit = (
  grossAmount: number,
  commissionRate: number = config.app.defaultCommission
): { craftsmanPayout: number; platformFee: number; commissionRate: number } => {
  if (grossAmount < 0) throw new BadRequestError('Gross amount must be non-negative');
  if (commissionRate < 0 || commissionRate > 100) {
    throw new BadRequestError('Commission rate must be between 0 and 100');
  }
  const platformFee = Math.round((grossAmount * commissionRate) / 100 * 100) / 100;
  const craftsmanPayout = Math.round((grossAmount - platformFee) * 100) / 100;
  return { craftsmanPayout, platformFee, commissionRate };
};
