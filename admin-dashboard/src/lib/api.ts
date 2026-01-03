import axios, { AxiosError, AxiosInstance, InternalAxiosRequestConfig } from 'axios';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000/api/v1';

const api: AxiosInstance = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
  timeout: 30000,
});

// Request interceptor to add auth token
api.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    const token = typeof window !== 'undefined' ? localStorage.getItem('token') : null;
    if (token && config.headers) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error: AxiosError) => {
    return Promise.reject(error);
  }
);

// Response interceptor for error handling
api.interceptors.response.use(
  (response) => response,
  async (error: AxiosError) => {
    if (error.response?.status === 401) {
      // Token expired or invalid - redirect to login
      if (typeof window !== 'undefined') {
        localStorage.removeItem('token');
        window.location.href = '/login';
      }
    }
    return Promise.reject(error);
  }
);

export default api;

// API response types
export interface ApiResponse<T = unknown> {
  success: boolean;
  message?: string;
  data?: T;
  errors?: unknown[];
  meta?: {
    page?: number;
    limit?: number;
    total?: number;
    totalPages?: number;
  };
}

// API endpoints
export const endpoints = {
  // Auth
  login: '/auth/login',
  logout: '/auth/logout',
  me: '/auth/me',

  // Users
  users: '/admin/users',
  customers: '/admin/customers',

  // Craftsmen
  craftsmen: '/admin/craftsmen',
  pendingCraftsmen: '/admin/craftsmen/pending',
  approveCraftsman: (id: string) => `/admin/craftsmen/${id}/approve`,
  rejectCraftsman: (id: string) => `/admin/craftsmen/${id}/reject`,
  suspendCraftsman: (id: string) => `/admin/craftsmen/${id}/suspend`,

  // Categories
  categories: '/categories',
  adminCategories: '/admin/categories',

  // Requests
  requests: '/admin/requests',

  // Transactions
  transactions: '/admin/transactions',
  payouts: '/admin/payouts',

  // Settings
  settings: '/admin/settings',
  zones: '/admin/zones',

  // Notifications
  notifications: '/admin/notifications',

  // Stats
  dashboard: '/admin/dashboard',
};
