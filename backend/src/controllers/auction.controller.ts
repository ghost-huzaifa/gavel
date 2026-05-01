import { prisma } from "../lib/prisma";

// POST
export const createAuction = async (req, res) => {
  const { title, description, auctioneerId } = req.body;

  const auctioneer = await prisma.auctioneer.findUnique({
    where: { auctioneerId },
  });

  if (!auctioneer) {
    return res.status(404).json({ error: "Auctioneer not found" });
  }

  const auction = await prisma.auction.create({
    data: {
      title,
      description,
      auctioneerId,
    },
  });

  return res.status(201).json(auction);
};

export const createItemsForAuction = async (req, res) => {
  const { auctionId } = req.params;
  const { items } = req.body;

  const auction = await assertAuction(res, auctionId);
  if (!auction) return;

  const createdItems = await prisma.item.createMany({
    data: items.map((item) => ({
      name: item.name,
      description: item.description,
      minBid: item.minBid,
      auctionId,
    })),
  });

  return res.status(201).json({ message: "Items created successfully" });
};

export const addBidderToAuction = async (req, res) => {
  const { auctionId } = req.params;
  const { bidderId } = req.body;

  const auction = await assertAuction(res, auctionId);
  if (!auction) return;

  const bidder = await prisma.bidder.findUnique({
    where: { bidderId },
  });

  if (!bidder) {
    return res.status(404).json({ error: "Bidder not found" });
  }

  await prisma.bidderAuction.create({
    data: {
      bidderId,
      auctionId,
    },
  });

  return res
    .status(200)
    .json({ message: "Bidder added to auction successfully" });
};

async function assertAuction(res: any, auctionId: string) {
  const auction = await prisma.auction.findUnique({
    where: { auctionId },
  });

  if (!auction) {
    res.status(404).json({ error: "Auction not found" });
    return null;
  }

  return auction;
}

// GET
export const getAuctions = async (req, res) => {
  const auctions = await prisma.auction.findMany({
    include: {
      auctioneer: {
        include: {
          user: true,
        },
      },
      items: true,
    },
  });

  return res.status(200).json(auctions);
};
