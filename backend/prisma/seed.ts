import { prisma } from "../src/lib/prisma";

async function main() {
  console.log("Seeding database...");

  // Create Users
  const user1 = await prisma.user.create({
    data: {
      email: "bidder1@example.com",
      password: "hashedpassword123", // In a real app, ensure this is hashed
      name: "Alice Bidder",
      bidder: {
        create: {},
      },
    },
    include: {
      bidder: true,
    },
  });

  const user2 = await prisma.user.create({
    data: {
      email: "auctioneer1@example.com",
      password: "hashedpassword456", // In a real app, ensure this is hashed
      name: "Bob Auctioneer",
      auctioneer: {
        create: {},
      },
    },
    include: {
      auctioneer: true,
    },
  });

  const user3 = await prisma.user.create({
    data: {
      email: "biddableuser@example.com",
      password: "hashedpassword789",
      name: "Charlie Both",
      bidder: {
        create: {},
      },
      auctioneer: {
        create: {},
      },
    },
    include: {
      bidder: true,
      auctioneer: true,
    },
  });

  if (!user2.auctioneer || !user3.auctioneer) {
    throw new Error("Failed to create auctioneers");
  }

  // Create an Auction
  const auction1 = await prisma.auction.create({
    data: {
      title: "Spring Antique Auction",
      description: "A wonderful collection of 19th-century antiques.",
      auctioneerId: user2.auctioneer.auctioneerId,
      items: {
        create: [
          {
            name: "Vintage Clock",
            description: "A beautiful grandfather clock from 1850.",
            minBid: 150.0,
            currentBid: 200.0,
          },
          {
            name: "Silver Teapot",
            description: "Sterling silver teapot in excellent condition.",
            minBid: 80.0,
          },
        ],
      },
    },
  });

  const auction2 = await prisma.auction.create({
    data: {
      title: "Modern Art Auction",
      description: "Exclusive modern art pieces.",
      auctioneerId: user3.auctioneer.auctioneerId,
      items: {
        create: [
          {
            name: "Abstract Canvas",
            description: "Colorful abstract painting by a rising artist.",
            minBid: 500.0,
          },
        ],
      },
    },
  });

  // Link Bidders to Auctions
  if (user1.bidder) {
    await prisma.bidderAuction.create({
      data: {
        bidderId: user1.bidder.bidderId,
        auctionId: auction1.auctionId,
      },
    });
  }

  if (user3.bidder) {
    await prisma.bidderAuction.create({
      data: {
        bidderId: user3.bidder.bidderId,
        auctionId: auction1.auctionId,
      },
    });
    await prisma.bidderAuction.create({
      data: {
        bidderId: user3.bidder.bidderId,
        auctionId: auction2.auctionId,
      },
    });
  }

  console.log("Database seeded successfully!");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
