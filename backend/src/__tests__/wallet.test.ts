import { calculateCommissionSplit } from '@services/wallet.service';

describe('calculateCommissionSplit', () => {
  test('applies the default 15% commission', () => {
    const { craftsmanPayout, platformFee, commissionRate } = calculateCommissionSplit(1000);
    expect(commissionRate).toBe(15);
    expect(platformFee).toBe(150);
    expect(craftsmanPayout).toBe(850);
  });

  test('handles fractional amounts to 2 decimal places', () => {
    const { craftsmanPayout, platformFee } = calculateCommissionSplit(123.45, 15);
    expect(platformFee).toBeCloseTo(18.52, 1); // 123.45 * 0.15 = 18.5175
    expect(craftsmanPayout).toBeCloseTo(104.93, 1);
  });

  test('zero amount → both sides zero', () => {
    const split = calculateCommissionSplit(0);
    expect(split.platformFee).toBe(0);
    expect(split.craftsmanPayout).toBe(0);
  });

  test('100% commission → craftsman gets nothing', () => {
    const split = calculateCommissionSplit(500, 100);
    expect(split.platformFee).toBe(500);
    expect(split.craftsmanPayout).toBe(0);
  });

  test('rejects negative amount', () => {
    expect(() => calculateCommissionSplit(-1)).toThrow();
  });

  test('rejects out-of-range commission rates', () => {
    expect(() => calculateCommissionSplit(100, -5)).toThrow();
    expect(() => calculateCommissionSplit(100, 101)).toThrow();
  });

  test('custom rate per-category override (e.g. 10% for plumbing)', () => {
    const split = calculateCommissionSplit(1000, 10);
    expect(split.commissionRate).toBe(10);
    expect(split.platformFee).toBe(100);
    expect(split.craftsmanPayout).toBe(900);
  });
});
