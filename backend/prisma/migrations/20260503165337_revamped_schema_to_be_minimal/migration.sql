/*
  Warnings:

  - You are about to drop the column `email` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Auctioneer` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Bidder` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `BidderAuction` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Auction" DROP CONSTRAINT "Auction_auctioneerId_fkey";

-- DropForeignKey
ALTER TABLE "Auctioneer" DROP CONSTRAINT "Auctioneer_userId_fkey";

-- DropForeignKey
ALTER TABLE "Bidder" DROP CONSTRAINT "Bidder_userId_fkey";

-- DropForeignKey
ALTER TABLE "BidderAuction" DROP CONSTRAINT "BidderAuction_auctionId_fkey";

-- DropForeignKey
ALTER TABLE "BidderAuction" DROP CONSTRAINT "BidderAuction_bidderId_fkey";

-- DropIndex
DROP INDEX "User_email_key";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "email",
DROP COLUMN "password";

-- DropTable
DROP TABLE "Auctioneer";

-- DropTable
DROP TABLE "Bidder";

-- DropTable
DROP TABLE "BidderAuction";

-- CreateTable
CREATE TABLE "_bidders" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_bidders_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_bidders_B_index" ON "_bidders"("B");

-- AddForeignKey
ALTER TABLE "Auction" ADD CONSTRAINT "Auction_auctioneerId_fkey" FOREIGN KEY ("auctioneerId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_bidders" ADD CONSTRAINT "_bidders_A_fkey" FOREIGN KEY ("A") REFERENCES "Auction"("auctionId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_bidders" ADD CONSTRAINT "_bidders_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("userId") ON DELETE CASCADE ON UPDATE CASCADE;
