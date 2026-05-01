import { Router } from "express";
import { getHealth } from "../controllers/health.controller";
import auctionRoutes from "./auction";

const router = Router();

// Define your routes here
router.get("/health", getHealth);
router.use("/auctions", auctionRoutes);

export default router;
