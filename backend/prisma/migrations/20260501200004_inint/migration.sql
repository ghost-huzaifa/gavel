-- CreateTable
CREATE TABLE "User" (
    "userId" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Bidder" (
    "bidderId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Bidder_pkey" PRIMARY KEY ("bidderId")
);

-- CreateTable
CREATE TABLE "BidderAuction" (
    "bidderId" TEXT NOT NULL,
    "auctionId" TEXT NOT NULL,

    CONSTRAINT "BidderAuction_pkey" PRIMARY KEY ("bidderId","auctionId")
);

-- CreateTable
CREATE TABLE "Auctioneer" (
    "auctionerId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Auctioneer_pkey" PRIMARY KEY ("auctionerId")
);

-- CreateTable
CREATE TABLE "AuctioneerAuction" (
    "auctioneerId" TEXT NOT NULL,
    "auctionId" TEXT NOT NULL,

    CONSTRAINT "AuctioneerAuction_pkey" PRIMARY KEY ("auctioneerId","auctionId")
);

-- CreateTable
CREATE TABLE "Auction" (
    "auctionId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Auction_pkey" PRIMARY KEY ("auctionId")
);

-- CreateTable
CREATE TABLE "Item" (
    "itemId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "minBid" DOUBLE PRECISION NOT NULL,
    "currentBid" DOUBLE PRECISION,
    "isSold" BOOLEAN NOT NULL DEFAULT false,
    "auctionId" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Item_pkey" PRIMARY KEY ("itemId")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Bidder_userId_key" ON "Bidder"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Auctioneer_userId_key" ON "Auctioneer"("userId");

-- AddForeignKey
ALTER TABLE "Bidder" ADD CONSTRAINT "Bidder_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BidderAuction" ADD CONSTRAINT "BidderAuction_bidderId_fkey" FOREIGN KEY ("bidderId") REFERENCES "Bidder"("bidderId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BidderAuction" ADD CONSTRAINT "BidderAuction_auctionId_fkey" FOREIGN KEY ("auctionId") REFERENCES "Auction"("auctionId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Auctioneer" ADD CONSTRAINT "Auctioneer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AuctioneerAuction" ADD CONSTRAINT "AuctioneerAuction_auctioneerId_fkey" FOREIGN KEY ("auctioneerId") REFERENCES "Auctioneer"("auctionerId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AuctioneerAuction" ADD CONSTRAINT "AuctioneerAuction_auctionId_fkey" FOREIGN KEY ("auctionId") REFERENCES "Auction"("auctionId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Item" ADD CONSTRAINT "Item_auctionId_fkey" FOREIGN KEY ("auctionId") REFERENCES "Auction"("auctionId") ON DELETE RESTRICT ON UPDATE CASCADE;
