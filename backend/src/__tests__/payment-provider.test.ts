import {
  __resetPaymentProviderForTests,
  getPaymentProvider,
  listAvailablePaymentProviders,
} from '@/lib/payments';

afterEach(() => {
  __resetPaymentProviderForTests();
});

describe('Payment provider abstraction', () => {
  test('mock provider is always available and configured', () => {
    const provider = getPaymentProvider('mock');
    expect(provider.name).toBe('mock');
    expect(provider.isConfigured()).toBe(true);
  });

  test('mock provider returns a success payload on initialize', async () => {
    const provider = getPaymentProvider('mock');
    const result = await provider.initialize({
      userId: 'user-1',
      requestId: 'req-1',
      amount: 250,
      currency: 'EGP',
      customer: {
        firstName: 'Ahmed',
        lastName: 'Hassan',
        email: 'ahmed@example.com',
        phone: '+201012345678',
      },
    });
    expect(result.success).toBe(true);
    expect(result.provider).toBe('mock');
    expect(result.paymentId).toMatch(/^mock-/);
    expect(result.redirectUrl).toContain('mock://payment/');
  });

  test('listAvailablePaymentProviders includes Egyptian-market providers', () => {
    const providers = listAvailablePaymentProviders();
    const names = providers.map((p) => p.name);
    expect(names).toEqual(
      expect.arrayContaining(['mock', 'paymob', 'fawry', 'vodafone_cash', 'instapay'])
    );
    const fawry = providers.find((p) => p.name === 'fawry')!;
    expect(fawry.displayNameAr).toBe('فوري');
  });

  test('paymob webhook with no signature is not verified', async () => {
    const provider = getPaymentProvider('paymob');
    const result = await provider.handleWebhook({
      body: { obj: { id: 123, success: true, amount_cents: 25000 } },
      headers: {},
    });
    expect(result.verified).toBe(false);
  });

  test('fawry initialize returns "not configured" error when env vars missing', async () => {
    const provider = getPaymentProvider('fawry');
    const result = await provider.initialize({
      userId: 'user-1',
      requestId: 'req-1',
      amount: 100,
      currency: 'EGP',
      customer: {
        firstName: 'Ahmed',
        lastName: 'Hassan',
        email: 'ahmed@example.com',
        phone: '+201012345678',
      },
    });
    if (!provider.isConfigured()) {
      expect(result.success).toBe(false);
      expect(result.error).toMatch(/Fawry not configured/);
    }
  });
});
