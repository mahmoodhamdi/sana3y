import { Server as HttpServer } from 'http';
import { Server as SocketIOServer, Socket } from 'socket.io';
import { config } from './index';
import { logger } from '../utils/logger';

let io: SocketIOServer | null = null;

export const initializeSocket = (server: HttpServer): SocketIOServer => {
  io = new SocketIOServer(server, {
    cors: {
      origin: config.cors.origin,
      methods: ['GET', 'POST'],
      credentials: true,
    },
    pingTimeout: 60000,
    pingInterval: 25000,
  });

  io.on('connection', (socket: Socket) => {
    logger.info(`Socket connected: ${socket.id}`);

    socket.on('join:user', (userId: string) => {
      socket.join(`user:${userId}`);
      logger.info(`User ${userId} joined their room`);
    });

    socket.on('join:request', (requestId: string) => {
      socket.join(`request:${requestId}`);
      logger.info(`Socket joined request room: ${requestId}`);
    });

    socket.on('leave:request', (requestId: string) => {
      socket.leave(`request:${requestId}`);
      logger.info(`Socket left request room: ${requestId}`);
    });

    socket.on('craftsman:online', (craftsmanId: string) => {
      socket.join('craftsmen:online');
      socket.join(`craftsman:${craftsmanId}`);
      logger.info(`Craftsman ${craftsmanId} is online`);
    });

    socket.on('craftsman:offline', (craftsmanId: string) => {
      socket.leave('craftsmen:online');
      logger.info(`Craftsman ${craftsmanId} is offline`);
    });

    socket.on('disconnect', () => {
      logger.info(`Socket disconnected: ${socket.id}`);
    });
  });

  logger.info('Socket.io initialized');
  return io;
};

export const getIO = (): SocketIOServer | null => io;

export const emitToUser = (userId: string, event: string, data: unknown): void => {
  if (io) {
    io.to(`user:${userId}`).emit(event, data);
  }
};

export const emitToRequest = (requestId: string, event: string, data: unknown): void => {
  if (io) {
    io.to(`request:${requestId}`).emit(event, data);
  }
};

export const emitToCraftsman = (craftsmanId: string, event: string, data: unknown): void => {
  if (io) {
    io.to(`craftsman:${craftsmanId}`).emit(event, data);
  }
};

export const emitToOnlineCraftsmen = (event: string, data: unknown): void => {
  if (io) {
    io.to('craftsmen:online').emit(event, data);
  }
};
