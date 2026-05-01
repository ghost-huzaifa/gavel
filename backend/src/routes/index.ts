import { Router } from "express";
import { getHealth } from "../controllers/health.controller";

const router = Router();

// Define your routes here
router.get("/health", getHealth);

export default router;
