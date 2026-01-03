import dayjs from 'dayjs';

type LogLevel = 'info' | 'warn' | 'error' | 'debug';

interface LogOptions {
  timestamp?: boolean;
  level?: boolean;
}

const defaultOptions: LogOptions = {
  timestamp: true,
  level: true,
};

const colors = {
  info: '\x1b[36m',
  warn: '\x1b[33m',
  error: '\x1b[31m',
  debug: '\x1b[35m',
  reset: '\x1b[0m',
};

const formatMessage = (level: LogLevel, message: string, options: LogOptions = defaultOptions): string => {
  const parts: string[] = [];

  if (options.timestamp) {
    parts.push(`[${dayjs().format('YYYY-MM-DD HH:mm:ss')}]`);
  }

  if (options.level) {
    parts.push(`[${level.toUpperCase()}]`);
  }

  parts.push(message);

  return parts.join(' ');
};

const log = (level: LogLevel, message: string, ...args: unknown[]): void => {
  const formattedMessage = formatMessage(level, message);
  const color = colors[level];
  const reset = colors.reset;

  switch (level) {
    case 'error':
      console.error(`${color}${formattedMessage}${reset}`, ...args);
      break;
    case 'warn':
      console.warn(`${color}${formattedMessage}${reset}`, ...args);
      break;
    default:
      // eslint-disable-next-line no-console
      console.log(`${color}${formattedMessage}${reset}`, ...args);
  }
};

export const logger = {
  info: (message: string, ...args: unknown[]): void => log('info', message, ...args),
  warn: (message: string, ...args: unknown[]): void => log('warn', message, ...args),
  error: (message: string, ...args: unknown[]): void => log('error', message, ...args),
  debug: (message: string, ...args: unknown[]): void => {
    if (process.env.NODE_ENV === 'development') {
      log('debug', message, ...args);
    }
  },
};

export default logger;
