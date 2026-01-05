import jwt, { JwtPayload, SignOptions, Secret } from 'jsonwebtoken';
import { config } from '@config/index';

export interface AuthTokens {
  token: string;
  refreshToken: string;
  expiresIn: string;
}

export interface TokenPayload {
  userId: string;
  role: 'customer' | 'craftsman' | 'admin';
  email: string;
}

export interface DecodedToken extends TokenPayload, JwtPayload {
  iat: number;
  exp: number;
}

/**
 * Generate access token
 */
export const generateAccessToken = (payload: TokenPayload): string => {
  const options: SignOptions = {
    expiresIn: config.jwt.expiresIn as SignOptions['expiresIn'],
  };
  return jwt.sign(payload, config.jwt.secret as Secret, options);
};

/**
 * Generate refresh token
 */
export const generateRefreshToken = (payload: TokenPayload): string => {
  const options: SignOptions = {
    expiresIn: config.jwt.refreshExpiresIn as SignOptions['expiresIn'],
  };
  return jwt.sign(payload, config.jwt.refreshSecret as Secret, options);
};

/**
 * Generate both access and refresh tokens
 */
export const generateTokens = (payload: TokenPayload): AuthTokens => {
  return {
    token: generateAccessToken(payload),
    refreshToken: generateRefreshToken(payload),
    expiresIn: config.jwt.expiresIn,
  };
};

/**
 * Verify access token
 */
export const verifyAccessToken = (token: string): DecodedToken => {
  return jwt.verify(token, config.jwt.secret as Secret) as DecodedToken;
};

/**
 * Verify refresh token
 */
export const verifyRefreshToken = (token: string): DecodedToken => {
  return jwt.verify(token, config.jwt.refreshSecret as Secret) as DecodedToken;
};

/**
 * Decode token without verification (for expired tokens)
 */
export const decodeToken = (token: string): DecodedToken | null => {
  return jwt.decode(token) as DecodedToken | null;
};

/**
 * Check if token is expired
 */
export const isTokenExpired = (token: string): boolean => {
  const decoded = decodeToken(token);
  if (!decoded || !decoded.exp) return true;
  return Date.now() >= decoded.exp * 1000;
};

/**
 * Extract token from Authorization header
 */
export const extractTokenFromHeader = (authHeader: string | undefined): string | null => {
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return null;
  }
  return authHeader.slice(7);
};
