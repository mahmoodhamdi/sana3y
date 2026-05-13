export interface PaymentInitInput {
  userId: string;
  requestId: string;
  amount: number;
  currency: 'EGP' | 'SAR' | 'AED' | 'KWD' | 'USD';
  customer: {
    firstName: string;
    lastName: string;
    email: string;
    phone: string;
  };
  description?: string;
}

export interface PaymentInitResult {
  success: boolean;
  provider: string;
  /** Provider-side order/transaction id we should store and look up later. */
  paymentId: string;
  /** Customer-facing redirect URL (iframe, hosted page, or wallet deep link). */
  redirectUrl?: string;
  /** Optional iframe URL when the provider supports embedding. */
  iframeUrl?: string;
  /** Optional voucher reference for cash-collection providers (Fawry, etc.). */
  reference?: string;
  /** Optional human-readable instructions to display to the customer. */
  instructions?: string;
  error?: string;
}

export interface PaymentWebhookInput {
  body: unknown;
  headers: Record<string, string | string[] | undefined>;
  rawBody?: Buffer;
}

export interface PaymentWebhookResult {
  /** True if signature/HMAC checks pass and the event is trusted. */
  verified: boolean;
  /** Provider-side payment/order id from the webhook payload. */
  paymentId?: string;
  /** Normalised status. */
  status: 'pending' | 'succeeded' | 'failed' | 'refunded' | 'unknown';
  /** Optional amount in major units (EGP, SAR, etc.). */
  amount?: number;
  /** Free-form provider raw payload — useful for audit / reconciliation. */
  raw?: unknown;
  error?: string;
}

export interface PaymentProvider {
  readonly name: string;
  readonly displayNameAr: string;
  initialize(input: PaymentInitInput): Promise<PaymentInitResult>;
  handleWebhook(input: PaymentWebhookInput): Promise<PaymentWebhookResult>;
  isConfigured(): boolean;
}
