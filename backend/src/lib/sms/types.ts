export interface SmsResult {
  success: boolean;
  messageId?: string;
  error?: string;
  provider?: string;
}

export interface SmsProvider {
  readonly name: string;
  send(phone: string, message: string): Promise<SmsResult>;
  isConfigured(): boolean;
}
