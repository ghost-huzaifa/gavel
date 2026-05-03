import { Router } from "express";
import { getHealth } from "../controllers/health.controller";
import auctionRoutes from "./auction";
import { authCheck } from "../middlewares/auth.middleware";

const router = Router();

// Define your routes here
router.get("/health", getHealth);
router.use("/auctions", authCheck, auctionRoutes);

export default router;
