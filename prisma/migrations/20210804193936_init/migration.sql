/*
  Warnings:

  - You are about to drop the column `MaterialPropertiesId` on the `filament` table. All the data in the column will be lost.
  - Added the required column `updatedAt` to the `Link` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `filament` DROP FOREIGN KEY `filament_ibfk_4`;

-- AlterTable
ALTER TABLE `filament` DROP COLUMN `MaterialPropertiesId`;

-- AlterTable
ALTER TABLE `link` ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL;

-- AddForeignKey
ALTER TABLE `MaterialProperties` ADD FOREIGN KEY (`id`) REFERENCES `Filament`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
