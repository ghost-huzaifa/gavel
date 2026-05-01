/*
  Warnings:

  - You are about to drop the `AuctioneerAuction` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `auctioneerId` to the `Auction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "AuctioneerAuction" DROP CONSTRAINT "AuctioneerAuction_auctionId_fkey";

-- DropForeignKey
ALTER TABLE "AuctioneerAuction" DROP CONSTRAINT "AuctioneerAuction_auctioneerId_fkey";

-- AlterTable
ALTER TABLE "Auction" ADD COLUMN     "auctioneerId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "password" TEXT NOT NULL;

-- DropTable
DROP TABLE "AuctioneerAuction";

-- AddForeignKey
ALTER TABLE "Auction" ADD CONSTRAINT "Auction_auctioneerId_fkey" FOREIGN KEY ("auctioneerId") REFERENCES "Auctioneer"("auctionerId") ON DELETE RESTRICT ON UPDATE CASCADE;
