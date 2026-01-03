import api, { ApiResponse, endpoints } from '@/lib/api';

// Dashboard Stats
export interface DashboardStats {
  totalRequests: number;
  activeRequests: number;
  completedRequests: number;
  totalCraftsmen: number;
  activeCraftsmen: number;
  pendingCraftsmen: number;
  totalCustomers: number;
  activeCustomers: number;
  totalRevenue: number;
  monthlyRevenue: number;
  pendingPayouts: number;
  recentRequests: RecentRequest[];
  recentCraftsmen: RecentCraftsman[];
}

export interface RecentRequest {
  _id: string;
  title: string;
  status: string;
  customerName: string;
  createdAt: string;
}

export interface RecentCraftsman {
  _id: string;
  name: string;
  category: string;
  status: string;
  createdAt: string;
}

export const getDashboardStats = async (): Promise<DashboardStats> => {
  try {
    const response = await api.get<ApiResponse<DashboardStats>>(endpoints.dashboard);
    return response.data.data || getEmptyStats();
  } catch (error) {
    console.error('Failed to fetch dashboard stats:', error);
    return getEmptyStats();
  }
};

const getEmptyStats = (): DashboardStats => ({
  totalRequests: 0,
  activeRequests: 0,
  completedRequests: 0,
  totalCraftsmen: 0,
  activeCraftsmen: 0,
  pendingCraftsmen: 0,
  totalCustomers: 0,
  activeCustomers: 0,
  totalRevenue: 0,
  monthlyRevenue: 0,
  pendingPayouts: 0,
  recentRequests: [],
  recentCraftsmen: [],
});

// Customers
export interface Customer {
  _id: string;
  userId: {
    _id: string;
    name: string;
    phone: string;
    email?: string;
    isActive: boolean;
    createdAt: string;
  };
  location?: {
    governorate: string;
    city: string;
    address?: string;
  };
  totalRequests: number;
  totalSpent: number;
  createdAt: string;
}

export interface CustomersResponse {
  customers: Customer[];
  page: number;
  totalPages: number;
  total: number;
}

export const getCustomers = async (
  page = 1,
  limit = 20,
  search?: string,
  status?: string
): Promise<CustomersResponse> => {
  try {
    const params = new URLSearchParams({
      page: page.toString(),
      limit: limit.toString(),
    });
    if (search) params.append('search', search);
    if (status) params.append('status', status);

    const response = await api.get<ApiResponse<Customer[]>>(
      `${endpoints.customers}?${params}`
    );
    return {
      customers: response.data.data || [],
      page: response.data.meta?.page || 1,
      totalPages: response.data.meta?.totalPages || 1,
      total: response.data.meta?.total || 0,
    };
  } catch (error) {
    console.error('Failed to fetch customers:', error);
    return { customers: [], page: 1, totalPages: 1, total: 0 };
  }
};

export const toggleCustomerStatus = async (id: string, isActive: boolean): Promise<boolean> => {
  try {
    await api.put(`${endpoints.customers}/${id}/status`, { isActive });
    return true;
  } catch (error) {
    console.error('Failed to toggle customer status:', error);
    return false;
  }
};

// Requests
export interface ServiceRequest {
  _id: string;
  title: string;
  description?: string;
  status: string;
  urgency: string;
  customerId: {
    _id: string;
    userId: {
      name: string;
      phone: string;
    };
  };
  craftsmanId?: {
    _id: string;
    userId: {
      name: string;
      phone: string;
    };
  };
  categoryId: {
    _id: string;
    nameAr: string;
  };
  location: {
    governorate: string;
    city: string;
    address?: string;
  };
  quotedPrice?: number;
  finalPrice?: number;
  createdAt: string;
  completedAt?: string;
}

export interface RequestsResponse {
  requests: ServiceRequest[];
  page: number;
  totalPages: number;
  total: number;
}

export const getRequests = async (
  page = 1,
  limit = 20,
  filters?: {
    status?: string;
    category?: string;
    governorate?: string;
    dateFrom?: string;
    dateTo?: string;
    search?: string;
  }
): Promise<RequestsResponse> => {
  try {
    const params = new URLSearchParams({
      page: page.toString(),
      limit: limit.toString(),
    });
    if (filters?.status) params.append('status', filters.status);
    if (filters?.category) params.append('category', filters.category);
    if (filters?.governorate) params.append('governorate', filters.governorate);
    if (filters?.dateFrom) params.append('dateFrom', filters.dateFrom);
    if (filters?.dateTo) params.append('dateTo', filters.dateTo);
    if (filters?.search) params.append('search', filters.search);

    const response = await api.get<ApiResponse<ServiceRequest[]>>(
      `${endpoints.requests}?${params}`
    );
    return {
      requests: response.data.data || [],
      page: response.data.meta?.page || 1,
      totalPages: response.data.meta?.totalPages || 1,
      total: response.data.meta?.total || 0,
    };
  } catch (error) {
    console.error('Failed to fetch requests:', error);
    return { requests: [], page: 1, totalPages: 1, total: 0 };
  }
};

export const getRequestById = async (id: string): Promise<ServiceRequest | null> => {
  try {
    const response = await api.get<ApiResponse<ServiceRequest>>(`${endpoints.requests}/${id}`);
    return response.data.data || null;
  } catch (error) {
    console.error('Failed to fetch request:', error);
    return null;
  }
};

// Finance
export interface Transaction {
  _id: string;
  type: 'payment' | 'payout' | 'refund' | 'commission';
  amount: number;
  status: string;
  requestId?: {
    _id: string;
    title: string;
  };
  userId: {
    _id: string;
    name: string;
  };
  description?: string;
  createdAt: string;
}

export interface TransactionsResponse {
  transactions: Transaction[];
  page: number;
  totalPages: number;
  total: number;
}

export interface FinanceStats {
  totalRevenue: number;
  monthlyRevenue: number;
  totalCommissions: number;
  pendingPayouts: number;
  completedPayouts: number;
}

export const getTransactions = async (
  page = 1,
  limit = 20,
  filters?: {
    type?: string;
    status?: string;
    dateFrom?: string;
    dateTo?: string;
  }
): Promise<TransactionsResponse> => {
  try {
    const params = new URLSearchParams({
      page: page.toString(),
      limit: limit.toString(),
    });
    if (filters?.type) params.append('type', filters.type);
    if (filters?.status) params.append('status', filters.status);
    if (filters?.dateFrom) params.append('dateFrom', filters.dateFrom);
    if (filters?.dateTo) params.append('dateTo', filters.dateTo);

    const response = await api.get<ApiResponse<Transaction[]>>(
      `${endpoints.transactions}?${params}`
    );
    return {
      transactions: response.data.data || [],
      page: response.data.meta?.page || 1,
      totalPages: response.data.meta?.totalPages || 1,
      total: response.data.meta?.total || 0,
    };
  } catch (error) {
    console.error('Failed to fetch transactions:', error);
    return { transactions: [], page: 1, totalPages: 1, total: 0 };
  }
};

export const getFinanceStats = async (): Promise<FinanceStats> => {
  try {
    const response = await api.get<ApiResponse<FinanceStats>>(`${endpoints.transactions}/stats`);
    return response.data.data || {
      totalRevenue: 0,
      monthlyRevenue: 0,
      totalCommissions: 0,
      pendingPayouts: 0,
      completedPayouts: 0,
    };
  } catch (error) {
    console.error('Failed to fetch finance stats:', error);
    return {
      totalRevenue: 0,
      monthlyRevenue: 0,
      totalCommissions: 0,
      pendingPayouts: 0,
      completedPayouts: 0,
    };
  }
};

// Zones
export interface Zone {
  _id: string;
  governorate: string;
  city: string;
  isActive: boolean;
  deliveryFee?: number;
  createdAt: string;
}

export interface ZonesResponse {
  zones: Zone[];
  page: number;
  totalPages: number;
  total: number;
}

export const getZones = async (page = 1, limit = 50): Promise<ZonesResponse> => {
  try {
    const response = await api.get<ApiResponse<Zone[]>>(
      `${endpoints.zones}?page=${page}&limit=${limit}`
    );
    return {
      zones: response.data.data || [],
      page: response.data.meta?.page || 1,
      totalPages: response.data.meta?.totalPages || 1,
      total: response.data.meta?.total || 0,
    };
  } catch (error) {
    console.error('Failed to fetch zones:', error);
    return { zones: [], page: 1, totalPages: 1, total: 0 };
  }
};

export const createZone = async (data: Partial<Zone>): Promise<Zone | null> => {
  try {
    const response = await api.post<ApiResponse<Zone>>(endpoints.zones, data);
    return response.data.data || null;
  } catch (error) {
    console.error('Failed to create zone:', error);
    return null;
  }
};

export const updateZone = async (id: string, data: Partial<Zone>): Promise<boolean> => {
  try {
    await api.put(`${endpoints.zones}/${id}`, data);
    return true;
  } catch (error) {
    console.error('Failed to update zone:', error);
    return false;
  }
};

export const deleteZone = async (id: string): Promise<boolean> => {
  try {
    await api.delete(`${endpoints.zones}/${id}`);
    return true;
  } catch (error) {
    console.error('Failed to delete zone:', error);
    return false;
  }
};

// Settings
export interface AppSettings {
  commissionRate: number;
  serviceFee: number;
  urgentFee: number;
  defaultRadius: number;
  minWithdrawal: number;
  maxWithdrawal: number;
  supportPhone: string;
  supportEmail: string;
  termsUrl?: string;
  privacyUrl?: string;
}

export const getSettings = async (): Promise<AppSettings> => {
  try {
    const response = await api.get<ApiResponse<AppSettings>>(endpoints.settings);
    return response.data.data || getDefaultSettings();
  } catch (error) {
    console.error('Failed to fetch settings:', error);
    return getDefaultSettings();
  }
};

export const updateSettings = async (data: Partial<AppSettings>): Promise<boolean> => {
  try {
    await api.put(endpoints.settings, data);
    return true;
  } catch (error) {
    console.error('Failed to update settings:', error);
    return false;
  }
};

const getDefaultSettings = (): AppSettings => ({
  commissionRate: 15,
  serviceFee: 5,
  urgentFee: 20,
  defaultRadius: 10,
  minWithdrawal: 100,
  maxWithdrawal: 10000,
  supportPhone: '+201000000000',
  supportEmail: 'support@sana3y.com',
});

// Notifications
export interface Notification {
  _id: string;
  title: string;
  titleAr: string;
  body: string;
  bodyAr: string;
  type: 'all' | 'customers' | 'craftsmen';
  status: 'draft' | 'sent' | 'scheduled';
  scheduledAt?: string;
  sentAt?: string;
  recipientCount?: number;
  createdAt: string;
}

export interface NotificationsResponse {
  notifications: Notification[];
  page: number;
  totalPages: number;
  total: number;
}

export const getNotifications = async (page = 1, limit = 20): Promise<NotificationsResponse> => {
  try {
    const response = await api.get<ApiResponse<Notification[]>>(
      `${endpoints.notifications}?page=${page}&limit=${limit}`
    );
    return {
      notifications: response.data.data || [],
      page: response.data.meta?.page || 1,
      totalPages: response.data.meta?.totalPages || 1,
      total: response.data.meta?.total || 0,
    };
  } catch (error) {
    console.error('Failed to fetch notifications:', error);
    return { notifications: [], page: 1, totalPages: 1, total: 0 };
  }
};

export const sendNotification = async (data: {
  title: string;
  titleAr: string;
  body: string;
  bodyAr: string;
  type: 'all' | 'customers' | 'craftsmen';
}): Promise<boolean> => {
  try {
    await api.post(endpoints.notifications, data);
    return true;
  } catch (error) {
    console.error('Failed to send notification:', error);
    return false;
  }
};
