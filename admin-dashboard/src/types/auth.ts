export interface User {
  _id: string;
  phone: string;
  email?: string;
  name: string;
  role: 'customer' | 'craftsman' | 'admin';
  avatar?: string;
  isPhoneVerified: boolean;
  isEmailVerified: boolean;
  isActive: boolean;
  lastLoginAt?: string;
  createdAt: string;
  updatedAt: string;
}

export interface AuthTokens {
  token: string;
  refreshToken: string;
  expiresIn: string;
}

export interface LoginCredentials {
  email: string;
  password: string;
}

export interface AuthState {
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
  isLoading: boolean;
  error: string | null;
}

export interface AuthContextType extends AuthState {
  login: (credentials: LoginCredentials) => Promise<void>;
  logout: () => void;
  clearError: () => void;
}
