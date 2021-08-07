/*
  Warnings:

  - Added the required column `mfgSuggestedSettingsId` to the `Filament` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `filament` DROP FOREIGN KEY `filament_ibfk_2`;

-- AlterTable
ALTER TABLE `filament` ADD COLUMN `mfgSuggestedSettingsId` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `Filament` ADD FOREIGN KEY (`mfgSuggestedSettingsId`) REFERENCES `mfgSuggestedSettings`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
