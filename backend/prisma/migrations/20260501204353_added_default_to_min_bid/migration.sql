/*
  Warnings:

  - Made the column `currentBid` on table `Item` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Item" ALTER COLUMN "currentBid" SET NOT NULL,
ALTER COLUMN "currentBid" SET DEFAULT 0;
