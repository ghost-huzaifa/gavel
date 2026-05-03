import type { NextFunction, Request, Response } from "express";
import { supabase } from "../../lib/supabase";

export const authCheck = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  const token = req.headers.authorization;
  const user = await supabase.auth.getUser(token);
  if (user.data.user) {
    console.log(user.data.user?.id);
    next();
  } else {
    return res.status(401).json({
      error: "Invalid Access Token Provided, Please login again",
    });
  }
};
