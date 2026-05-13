import { __resetSmsProviderForTests, getSmsProvider, sendSms } from '@/lib/sms';

const ORIGINAL_ENV = { ...process.env };

afterEach(() => {
  __resetSmsProviderForTests();
  process.env = { ...ORIGINAL_ENV };
});

describe('SMS provider abstraction', () => {
  test('falls back to mock when SMS_PROVIDER is unknown', () => {
    process.env.SMS_PROVIDER = 'flying-pigeon';
    jest.resetModules();
    const provider = getSmsProvider();
    expect(provider.name).toBe('mock');
  });

  test('mock provider always succeeds and returns a messageId', async () => {
    process.env.SMS_PROVIDER = 'mock';
    jest.resetModules();
    const res = await sendSms('+201012345678', 'hello');
    expect(res.success).toBe(true);
    expect(res.messageId).toMatch(/^mock-/);
  });

  test('twilio provider reports unconfigured when env vars are empty', async () => {
    process.env.SMS_PROVIDER = 'twilio';
    process.env.TWILIO_ACCOUNT_SID = '';
    process.env.TWILIO_AUTH_TOKEN = '';
    process.env.TWILIO_PHONE_NUMBER = '';
    jest.resetModules();
    const { getSmsProvider: getProv } = await import('@/lib/sms');
    const provider = getProv();
    // falls back to mock because twilio is not configured
    expect(provider.name).toBe('mock');
  });
});
