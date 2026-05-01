import type { Request, Response } from "express";

export const getHealth = (req: Request, res: Response) => {
  res.status(200).json({
    status: "OK",
    message: "Server is healthy",
    timestamp: new Date(),
  });
};
