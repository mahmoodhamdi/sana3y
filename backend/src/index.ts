import http from 'http';
import { config } from './config';
import { connectDatabase } from './config/database';
import { configureCloudinary } from './config/cloudinary';
import { initializeFirebase } from './config/firebase';
import { initializeSocket } from './config/socket';
import createApp from './app';
import { logger } from './utils/logger';

const startServer = async (): Promise<void> => {
  try {
    // Connect to database
    await connectDatabase();

    // Configure Cloudinary
    configureCloudinary();

    // Initialize Firebase
    initializeFirebase();

    // Create Express app
    const app = createApp();

    // Create HTTP server
    const server = http.createServer(app);

    // Initialize Socket.io
    initializeSocket(server);

    // Start server
    server.listen(config.port, () => {
      logger.info(`🔧 Sana3y Backend running on port ${config.port}`);
      logger.info(`📌 Environment: ${config.env}`);
      logger.info(`🚀 API Version: ${config.apiVersion}`);
      logger.info(`📍 Health check: http://localhost:${config.port}/health`);
    });

    // Handle graceful shutdown
    const gracefulShutdown = async (signal: string): Promise<void> => {
      logger.info(`${signal} received. Shutting down gracefully...`);

      server.close(() => {
        logger.info('HTTP server closed');
        process.exit(0);
      });

      // Force close after 30 seconds
      setTimeout(() => {
        logger.error('Could not close connections in time, forcefully shutting down');
        process.exit(1);
      }, 30000);
    };

    process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
    process.on('SIGINT', () => gracefulShutdown('SIGINT'));

    // Handle unhandled promise rejections
    process.on('unhandledRejection', (reason: Error) => {
      logger.error('Unhandled Rejection:', reason);
      throw reason;
    });

    // Handle uncaught exceptions
    process.on('uncaughtException', (error: Error) => {
      logger.error('Uncaught Exception:', error);
      process.exit(1);
    });
  } catch (error) {
    logger.error('Failed to start server:', error);
    process.exit(1);
  }
};

startServer();
