import express, { Application } from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import compression from 'compression';
import rateLimit from 'express-rate-limit';
import swaggerUi from 'swagger-ui-express';
import redoc from 'redoc-express';
import { config } from './config';
import { swaggerSpec } from './config/swagger';
import { errorHandler } from './middleware/errorHandler';
import { notFoundHandler } from './middleware/notFound';
import { logger } from './utils/logger';
import routes from './routes';

const createApp = (): Application => {
  const app = express();

  // Security middleware
  app.use(helmet());

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

  // Health check
  app.get('/health', (_req, res) => {
    res.status(200).json({
      success: true,
      message: 'Sana3y API is running',
      timestamp: new Date().toISOString(),
      environment: config.env,
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
