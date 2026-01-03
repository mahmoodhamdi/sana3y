import { IUser, ICustomer, ICraftsman } from './index';

declare global {
  namespace Express {
    interface Request {
      user?: IUser;
      customer?: ICustomer;
      craftsman?: ICraftsman;
    }
  }
}

export {};
