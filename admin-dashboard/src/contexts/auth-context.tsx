'use client';

import React, { createContext, useContext, useEffect, useState, useCallback } from 'react';
import { useRouter } from 'next/navigation';
import { AuthContextType, AuthState, LoginCredentials, User } from '@/types/auth';
import authService from '@/services/auth.service';

const initialState: AuthState = {
  user: null,
  token: null,
  isAuthenticated: false,
  isLoading: true,
  error: null,
};

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [state, setState] = useState<AuthState>(initialState);
  const router = useRouter();

  // Check auth status on mount
  useEffect(() => {
    checkAuth();
  }, []);

  const checkAuth = async () => {
    const token = authService.getToken();

    if (!token) {
      setState({
        ...initialState,
        isLoading: false,
      });
      return;
    }

    try {
      const user = await authService.getProfile();

      if (user.role !== 'admin') {
        authService.clearTokens();
        setState({
          ...initialState,
          isLoading: false,
          error: 'غير مصرح لك بالوصول',
        });
        return;
      }

      setState({
        user,
        token,
        isAuthenticated: true,
        isLoading: false,
        error: null,
      });
    } catch {
      authService.clearTokens();
      setState({
        ...initialState,
        isLoading: false,
      });
    }
  };

  const login = useCallback(async (credentials: LoginCredentials) => {
    setState((prev) => ({ ...prev, isLoading: true, error: null }));

    try {
      const { user, tokens } = await authService.login(credentials);

      if (user.role !== 'admin') {
        throw new Error('غير مصرح لك بالوصول');
      }

      authService.setToken(tokens.token);

      setState({
        user,
        token: tokens.token,
        isAuthenticated: true,
        isLoading: false,
        error: null,
      });

      router.push('/dashboard');
    } catch (error) {
      const message = error instanceof Error
        ? error.message
        : 'حدث خطأ أثناء تسجيل الدخول';

      setState((prev) => ({
        ...prev,
        isLoading: false,
        error: message,
      }));

      throw error;
    }
  }, [router]);

  const logout = useCallback(() => {
    authService.logout();
    authService.clearTokens();
    setState({
      ...initialState,
      isLoading: false,
    });
    router.push('/login');
  }, [router]);

  const clearError = useCallback(() => {
    setState((prev) => ({ ...prev, error: null }));
  }, []);

  return (
    <AuthContext.Provider
      value={{
        ...state,
        login,
        logout,
        clearError,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}

// HOC for protected pages
export function withAuth<P extends object>(
  Component: React.ComponentType<P>
): React.FC<P> {
  return function ProtectedRoute(props: P) {
    const { isAuthenticated, isLoading } = useAuth();
    const router = useRouter();

    useEffect(() => {
      if (!isLoading && !isAuthenticated) {
        router.push('/login');
      }
    }, [isAuthenticated, isLoading, router]);

    if (isLoading) {
      return (
        <div className="flex h-screen items-center justify-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
        </div>
      );
    }

    if (!isAuthenticated) {
      return null;
    }

    return <Component {...props} />;
  };
}
