export interface ApiResponse<T = unknown> {
  success: boolean;
  message?: string;
  data?: T;
  errors?: ApiError[];
  meta?: PaginationMeta;
}

export interface ApiError {
  field?: string;
  message: string;
  code?: string;
}

export interface PaginationMeta {
  page: number;
  limit: number;
  total: number;
  totalPages: number;
}

export interface PaginationParams {
  page?: number;
  limit?: number;
  sort?: string;
  order?: 'asc' | 'desc';
}

export interface LocationParams {
  lat?: number;
  lng?: number;
  radius?: number;
}

export interface AuthTokens {
  token: string;
  refreshToken: string;
  expiresIn: string;
}

export interface LoginRequest {
  phone: string;
  password?: string;
  otp?: string;
}

export interface RegisterRequest {
  phone: string;
  name: string;
  role: 'customer' | 'craftsman';
  email?: string;
  password?: string;
}

export interface SendOtpRequest {
  phone: string;
  type?: 'verification' | 'login' | 'password_reset';
}

export interface VerifyOtpRequest {
  phone: string;
  code: string;
  type?: 'verification' | 'login' | 'password_reset';
}
