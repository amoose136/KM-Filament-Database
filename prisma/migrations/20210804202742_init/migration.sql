/*
  Warnings:

  - You are about to drop the column `isHydroscopic` on the `materialproperties` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `materialproperties` DROP COLUMN `isHydroscopic`,
    ADD COLUMN `isHygroscopic` BOOLEAN;
