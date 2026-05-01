import { Router } from "express";
import {
  addBidderToAuction,
  createAuction,
  createItemsForAuction,
  getAuctions,
} from "../controllers/auction.controller";

const router = Router();

router.post("/", createAuction);
router.get("/", getAuctions);
router.post("/:auctionId/items", createItemsForAuction);
router.post("/:auctionId/add-bidder", addBidderToAuction);

export default router;
