/*
  Warnings:

  - The primary key for the `Auctioneer` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `auctionerId` on the `Auctioneer` table. All the data in the column will be lost.
  - The required column `auctioneerId` was added to the `Auctioneer` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropForeignKey
ALTER TABLE "Auction" DROP CONSTRAINT "Auction_auctioneerId_fkey";

-- AlterTable
ALTER TABLE "Auctioneer" DROP CONSTRAINT "Auctioneer_pkey",
DROP COLUMN "auctionerId",
ADD COLUMN     "auctioneerId" TEXT NOT NULL,
ADD CONSTRAINT "Auctioneer_pkey" PRIMARY KEY ("auctioneerId");

-- AddForeignKey
ALTER TABLE "Auction" ADD CONSTRAINT "Auction_auctioneerId_fkey" FOREIGN KEY ("auctioneerId") REFERENCES "Auctioneer"("auctioneerId") ON DELETE RESTRICT ON UPDATE CASCADE;
