// Egyptian Phone Regex
const EGYPT_PHONE_REGEX = /^\+20[0-9]{10}$/;

/**
 * Format phone number to Egyptian format (+20XXXXXXXXXX)
 */
export const formatPhone = (phone: string): string => {
  // Remove all non-digits
  const cleaned = phone.replace(/\D/g, '');

  // Handle different input formats
  if (cleaned.startsWith('20') && cleaned.length === 12) {
    return `+${cleaned}`;
  }

  if (cleaned.startsWith('0') && cleaned.length === 11) {
    return `+20${cleaned.slice(1)}`;
  }

  if (cleaned.length === 10 && cleaned.startsWith('1')) {
    return `+20${cleaned}`;
  }

  // Already in correct format
  if (phone.startsWith('+20') && phone.length === 13) {
    return phone;
  }

  return phone;
};

/**
 * Validate Egyptian phone number
 */
export const isValidPhone = (phone: string): boolean => {
  const formatted = formatPhone(phone);
  return EGYPT_PHONE_REGEX.test(formatted);
};

/**
 * Check if phone is a valid Egyptian mobile number
 * Mobile prefixes: 10, 11, 12, 15
 */
export const isValidMobilePhone = (phone: string): boolean => {
  const formatted = formatPhone(phone);
  const mobileRegex = /^\+20(10|11|12|15)[0-9]{8}$/;
  return mobileRegex.test(formatted);
};

/**
 * Mask phone number for display (privacy)
 */
export const maskPhone = (phone: string): string => {
  const formatted = formatPhone(phone);
  if (formatted.length < 8) return formatted;

  const prefix = formatted.slice(0, 4);
  const suffix = formatted.slice(-3);
  const masked = '*'.repeat(formatted.length - 7);

  return `${prefix}${masked}${suffix}`;
};

/**
 * Extract carrier from phone number
 */
export const getCarrier = (phone: string): string | null => {
  const formatted = formatPhone(phone);

  if (formatted.startsWith('+2010')) return 'Vodafone';
  if (formatted.startsWith('+2011')) return 'Etisalat';
  if (formatted.startsWith('+2012')) return 'Orange';
  if (formatted.startsWith('+2015')) return 'WE';

  return null;
};
