import express, { Application } from 'express';
import cors from 'cors';
import helmet from 'helmet';
import mongoose from 'mongoose';
import morgan from 'morgan';
import compression from 'compression';
import rateLimit from 'express-rate-limit';
import hpp from 'hpp';
import swaggerUi from 'swagger-ui-express';
import redoc from 'redoc-express';
import { config } from './config';
import { swaggerSpec } from './config/swagger';
import { errorHandler } from './middleware/errorHandler';
import { notFoundHandler } from './middleware/notFound';
import { securityHeaders, preventNoSQLInjection } from './middleware/security';
import { logger } from './utils/logger';
import routes from './routes';

const createApp = (): Application => {
  const app = express();

  // Trust proxy for Cloudflare tunnel / reverse proxy
  app.set('trust proxy', 1);

  // Security middleware
  app.use(helmet());
  app.use(securityHeaders);

  // CORS
  app.use(
    cors({
      origin: config.cors.origin,
      credentials: true,
      methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
      allowedHeaders: ['Content-Type', 'Authorization'],
    })
  );

  // Rate limiting
  const limiter = rateLimit({
    windowMs: config.rateLimit.windowMs,
    max: config.rateLimit.maxRequests,
    message: {
      success: false,
      message: 'Too many requests, please try again later.',
    },
    standardHeaders: true,
    legacyHeaders: false,
  });
  app.use(limiter);

  // Body parsing
  app.use(express.json({ limit: '10mb' }));
  app.use(express.urlencoded({ extended: true, limit: '10mb' }));

  // Sanitize request data (Express 5 disallows reassigning req.query, so we use our
  // custom preventNoSQLInjection middleware instead of express-mongo-sanitize, which
  // tries to reassign it).
  app.use(preventNoSQLInjection);

  // HTTP Parameter Pollution protection
  app.use(hpp());

  // Compression
  app.use(compression());

  // Logging
  if (config.env === 'development') {
    app.use(morgan('dev'));
  } else {
    app.use(
      morgan('combined', {
        stream: {
          write: (message: string) => logger.info(message.trim()),
        },
      })
    );
  }

  // Health check (liveness)
  app.get('/health', (_req, res) => {
    res.status(200).json({
      success: true,
      message: 'Sana3y API is running',
      timestamp: new Date().toISOString(),
      environment: config.env,
    });
  });

  // Health check (readiness — DB + dependent services)
  app.get('/health/ready', (_req, res) => {
    const dbState = mongoose.connection.readyState;
    const dbStates: Record<number, string> = {
      0: 'disconnected',
      1: 'connected',
      2: 'connecting',
      3: 'disconnecting',
    };
    const isReady = dbState === 1;
    res.status(isReady ? 200 : 503).json({
      success: isReady,
      checks: {
        database: { status: dbStates[dbState] ?? 'unknown', healthy: isReady },
        smsProvider: { configured: config.smsProvider, healthy: true },
        paymentProvider: { configured: config.paymentProvider, healthy: true },
      },
      timestamp: new Date().toISOString(),
    });
  });

  // Health check (version — git SHA + package version)
  app.get('/health/version', (_req, res) => {
    res.json({
      success: true,
      version: process.env.npm_package_version || '1.0.0',
      commit: process.env.GIT_COMMIT || 'dev',
      buildTime: process.env.BUILD_TIME || null,
      node: process.version,
      environment: config.env,
      timestamp: new Date().toISOString(),
    });
  });

  // Swagger API Documentation
  app.use(
    '/api/docs',
    swaggerUi.serve,
    swaggerUi.setup(swaggerSpec, {
      customCss: '.swagger-ui .topbar { display: none }',
      customSiteTitle: 'Sana3y API Documentation',
      swaggerOptions: {
        persistAuthorization: true,
        displayRequestDuration: true,
        filter: true,
        showExtensions: true,
      },
    })
  );

  // Swagger JSON spec endpoint
  app.get('/api/docs.json', (_req, res) => {
    res.setHeader('Content-Type', 'application/json');
    res.send(swaggerSpec);
  });

  // ReDoc API Documentation
  app.get(
    '/api/redoc',
    redoc({
      title: 'Sana3y API Documentation - صنايعي',
      specUrl: '/api/docs.json',
      redocOptions: {
        theme: {
          colors: {
            primary: {
              main: '#1E88E5',
            },
          },
          typography: {
            fontSize: '16px',
            headings: {
              fontFamily: 'Cairo, Arial, sans-serif',
            },
          },
          rightPanel: {
            backgroundColor: '#1a1a1a',
          },
        },
        hideDownloadButton: false,
        expandResponses: '200,201',
        pathInMiddlePanel: true,
        sortPropsAlphabetically: true,
      },
    })
  );

  // API routes
  app.use(routes);

  // 404 handler
  app.use(notFoundHandler);

  // Error handler
  app.use(errorHandler);

  return app;
};

export default createApp;
