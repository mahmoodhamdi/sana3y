import { Server as SocketIOServer, Socket } from 'socket.io';
import { Server as HTTPServer } from 'http';
import jwt from 'jsonwebtoken';
import User from '../models/User';
import Craftsman from '../models/Craftsman';

interface AuthenticatedSocket extends Socket {
  userId?: string;
  userRole?: string;
  craftsmanId?: string;
}

interface UserConnection {
  socketId: string;
  userId: string;
  role: string;
  craftsmanId?: string;
  connectedAt: Date;
}

class SocketService {
  private io: SocketIOServer | null = null;
  private userConnections: Map<string, UserConnection> = new Map();
  private craftsmanConnections: Map<string, string> = new Map(); // craftsmanId -> socketId

  // Initialize socket server
  initialize(httpServer: HTTPServer): SocketIOServer {
    this.io = new SocketIOServer(httpServer, {
      cors: {
        origin: process.env.CORS_ORIGIN?.split(',') || '*',
        methods: ['GET', 'POST'],
        credentials: true,
      },
      pingTimeout: 60000,
      pingInterval: 25000,
    });

    // Authentication middleware
    this.io.use(async (socket: AuthenticatedSocket, next) => {
      try {
        const token = socket.handshake.auth.token || socket.handshake.headers.authorization?.split(' ')[1];

        if (!token) {
          return next(new Error('Authentication required'));
        }

        const decoded = jwt.verify(token, process.env.JWT_SECRET!) as any;
        const user = await User.findById(decoded.id).select('role');

        if (!user) {
          return next(new Error('User not found'));
        }

        socket.userId = decoded.id;
        socket.userRole = user.role;

        // If user is a craftsman, get their craftsman ID
        if (user.role === 'craftsman') {
          const craftsman = await Craftsman.findOne({ user: decoded.id }).select('_id');
          if (craftsman) {
            socket.craftsmanId = craftsman._id.toString();
          }
        }

        next();
      } catch (_error) {
        next(new Error('Invalid token'));
      }
    });

    // Handle connections
    this.io.on('connection', (socket: AuthenticatedSocket) => {
      this.handleConnection(socket);
    });

    console.log('Socket.io server initialized');
    return this.io;
  }

  // Handle new socket connection
  private handleConnection(socket: AuthenticatedSocket) {
    const userId = socket.userId!;
    const role = socket.userRole!;

    // Store connection info
    this.userConnections.set(userId, {
      socketId: socket.id,
      userId,
      role,
      craftsmanId: socket.craftsmanId,
      connectedAt: new Date(),
    });

    // Store craftsman connection separately for quick lookup
    if (socket.craftsmanId) {
      this.craftsmanConnections.set(socket.craftsmanId, socket.id);
      this.updateCraftsmanOnlineStatus(socket.craftsmanId, true);
    }

    // Join user-specific room
    socket.join(`user:${userId}`);

    // If admin, join admin room
    if (role === 'admin') {
      socket.join('admin');
    }

    // If craftsman, join craftsman rooms based on their categories and areas
    if (socket.craftsmanId) {
      socket.join(`craftsman:${socket.craftsmanId}`);
      this.joinCraftsmanRooms(socket);
    }

    console.log(`User connected: ${userId} (${role})`);

    // Handle events
    this.setupEventHandlers(socket);

    // Handle disconnect
    socket.on('disconnect', () => {
      this.handleDisconnect(socket);
    });
  }

  // Setup event handlers for socket
  private setupEventHandlers(socket: AuthenticatedSocket) {
    // Craftsman location update
    socket.on('location:update', (data: { lat: number; lng: number }) => {
      if (socket.craftsmanId) {
        this.broadcastCraftsmanLocation(socket.craftsmanId, data);
      }
    });

    // Craftsman online status toggle
    socket.on('craftsman:status', async (isOnline: boolean) => {
      if (socket.craftsmanId) {
        await this.updateCraftsmanOnlineStatus(socket.craftsmanId, isOnline);
      }
    });

    // Join request room for real-time updates
    socket.on('request:join', (requestId: string) => {
      socket.join(`request:${requestId}`);
    });

    // Leave request room
    socket.on('request:leave', (requestId: string) => {
      socket.leave(`request:${requestId}`);
    });

    // Typing indicator for chat
    socket.on('chat:typing', (data: { chatId: string; isTyping: boolean }) => {
      socket.to(`chat:${data.chatId}`).emit('chat:typing', {
        userId: socket.userId,
        isTyping: data.isTyping,
      });
    });

    // Join chat room
    socket.on('chat:join', (chatId: string) => {
      socket.join(`chat:${chatId}`);
    });

    // Leave chat room
    socket.on('chat:leave', (chatId: string) => {
      socket.leave(`chat:${chatId}`);
    });
  }

  // Join craftsman to category/area rooms
  private async joinCraftsmanRooms(socket: AuthenticatedSocket) {
    if (!socket.craftsmanId) return;

    try {
      const craftsman = await Craftsman.findById(socket.craftsmanId)
        .select('services serviceZones')
        .lean();

      if (craftsman) {
        // Join category rooms based on services
        craftsman.services?.forEach((service: any) => {
          if (service.categoryId) {
            socket.join(`category:${service.categoryId.toString()}`);
          }
        });

        // Join service zone rooms
        craftsman.serviceZones?.forEach((zoneId: any) => {
          socket.join(`zone:${zoneId.toString()}`);
        });
      }
    } catch (error) {
      console.error('Error joining craftsman rooms:', error);
    }
  }

  // Handle socket disconnect
  private handleDisconnect(socket: AuthenticatedSocket) {
    const userId = socket.userId;
    if (userId) {
      this.userConnections.delete(userId);
    }

    if (socket.craftsmanId) {
      this.craftsmanConnections.delete(socket.craftsmanId);
      this.updateCraftsmanOnlineStatus(socket.craftsmanId, false);
    }

    console.log(`User disconnected: ${userId}`);
  }

  // Update craftsman online status in database
  private async updateCraftsmanOnlineStatus(
    craftsmanId: string,
    isOnline: boolean
  ): Promise<void> {
    try {
      await Craftsman.findByIdAndUpdate(craftsmanId, {
        isOnline,
        lastOnline: isOnline ? undefined : new Date(),
      });
    } catch (error) {
      console.error('Error updating craftsman online status:', error);
    }
  }

  // Broadcast craftsman location to relevant parties
  private broadcastCraftsmanLocation(
    craftsmanId: string,
    location: { lat: number; lng: number }
  ) {
    // Broadcast to admins and any tracking parties
    this.io?.to('admin').emit('craftsman:location', {
      craftsmanId,
      location,
      timestamp: new Date(),
    });
  }

  // ==================== Public Methods for Emitting Events ====================

  // Emit to specific user
  emitToUser(userId: string, event: string, data: any): void {
    this.io?.to(`user:${userId}`).emit(event, data);
  }

  // Emit to specific craftsman
  emitToCraftsman(craftsmanId: string, event: string, data: any): void {
    this.io?.to(`craftsman:${craftsmanId}`).emit(event, data);
  }

  // Emit to all craftsmen in a category
  emitToCategory(categoryId: string, event: string, data: any): void {
    this.io?.to(`category:${categoryId}`).emit(event, data);
  }

  // Emit to all craftsmen in an area
  emitToArea(governorate: string, city?: string, event?: string, data?: any): void {
    const room = city ? `area:${governorate}:${city}` : `area:${governorate}`;
    this.io?.to(room).emit(event!, data);
  }

  // Emit to request room
  emitToRequest(requestId: string, event: string, data: any): void {
    this.io?.to(`request:${requestId}`).emit(event, data);
  }

  // Emit to chat room
  emitToChat(chatId: string, event: string, data: any): void {
    this.io?.to(`chat:${chatId}`).emit(event, data);
  }

  // Emit to any room (generic)
  emitToRoom(room: string, event: string, data: any): void {
    this.io?.to(room).emit(event, data);
  }

  // Emit to all admins
  emitToAdmins(event: string, data: any): void {
    this.io?.to('admin').emit(event, data);
  }

  // Broadcast to all connected users
  broadcast(event: string, data: any): void {
    this.io?.emit(event, data);
  }

  // ==================== Notification Helper Methods ====================

  // Notify about new request (to matching craftsmen)
  notifyNewRequest(
    categoryId: string,
    governorate: string,
    city: string,
    requestData: any
  ): void {
    // Emit to craftsmen in this category
    this.emitToCategory(categoryId, 'request:new', requestData);

    // Also emit to area-specific rooms
    this.emitToArea(governorate, city, 'request:new', requestData);
  }

  // Notify about new quote on request
  notifyNewQuote(requestId: string, customerId: string, quoteData: any): void {
    // Notify customer
    this.emitToUser(customerId, 'quote:new', {
      requestId,
      quote: quoteData,
    });

    // Notify request room
    this.emitToRequest(requestId, 'request:quote_added', {
      requestId,
      quote: quoteData,
    });
  }

  // Notify about quote acceptance
  notifyQuoteAccepted(
    requestId: string,
    craftsmanId: string,
    quoteData: any
  ): void {
    // Notify craftsman
    this.emitToCraftsman(craftsmanId, 'quote:accepted', {
      requestId,
      quote: quoteData,
    });

    // Notify request room
    this.emitToRequest(requestId, 'request:quote_accepted', {
      requestId,
      acceptedQuote: quoteData,
    });
  }

  // Notify about status change
  notifyStatusChange(
    requestId: string,
    customerId: string,
    craftsmanId: string | undefined,
    status: string,
    statusData: any
  ): void {
    const eventData = {
      requestId,
      status,
      ...statusData,
      timestamp: new Date(),
    };

    // Notify customer
    this.emitToUser(customerId, 'request:status_changed', eventData);

    // Notify craftsman if assigned
    if (craftsmanId) {
      this.emitToCraftsman(craftsmanId, 'request:status_changed', eventData);
    }

    // Notify request room
    this.emitToRequest(requestId, 'request:status_changed', eventData);

    // Notify admins
    this.emitToAdmins('request:status_changed', eventData);
  }

  // Notify about new chat message
  notifyNewMessage(chatId: string, senderId: string, message: any): void {
    this.emitToChat(chatId, 'chat:message', {
      chatId,
      senderId,
      message,
      timestamp: new Date(),
    });
  }

  // ==================== Utility Methods ====================

  // Get connected users count
  getConnectedUsersCount(): number {
    return this.userConnections.size;
  }

  // Get online craftsmen count
  getOnlineCraftsmenCount(): number {
    return this.craftsmanConnections.size;
  }

  // Check if user is online
  isUserOnline(userId: string): boolean {
    return this.userConnections.has(userId);
  }

  // Check if craftsman is online
  isCraftsmanOnline(craftsmanId: string): boolean {
    return this.craftsmanConnections.has(craftsmanId);
  }

  // Get socket.io server instance
  getIO(): SocketIOServer | null {
    return this.io;
  }
}

// Export singleton instance
export default new SocketService();
