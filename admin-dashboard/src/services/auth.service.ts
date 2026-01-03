import api, { ApiResponse } from '@/lib/api';
import { User, AuthTokens, LoginCredentials } from '@/types/auth';

interface LoginResponse {
  user: User;
  tokens: AuthTokens;
}

export const authService = {
  async login(credentials: LoginCredentials): Promise<LoginResponse> {
    const response = await api.post<ApiResponse<LoginResponse>>(
      '/auth/admin/login',
      credentials
    );

    if (!response.data.success || !response.data.data) {
      throw new Error(response.data.message || 'Login failed');
    }

    return response.data.data;
  },

  async getProfile(): Promise<User> {
    const response = await api.get<ApiResponse<{ user: User }>>('/auth/me');

    if (!response.data.success || !response.data.data) {
      throw new Error(response.data.message || 'Failed to get profile');
    }

    return response.data.data.user;
  },

  async logout(): Promise<void> {
    try {
      await api.post('/auth/logout');
    } catch {
      // Ignore logout errors
    }
  },

  setToken(token: string): void {
    if (typeof window !== 'undefined') {
      localStorage.setItem('token', token);
      localStorage.setItem('refreshToken', token);
    }
  },

  getToken(): string | null {
    if (typeof window !== 'undefined') {
      return localStorage.getItem('token');
    }
    return null;
  },

  clearTokens(): void {
    if (typeof window !== 'undefined') {
      localStorage.removeItem('token');
      localStorage.removeItem('refreshToken');
    }
  },

  isAuthenticated(): boolean {
    return !!this.getToken();
  },
};

export default authService;
