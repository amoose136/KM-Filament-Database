/*
  Warnings:

  - You are about to drop the column `Temp` on the `heatdeflectiontemperature` table. All the data in the column will be lost.
  - You are about to drop the column `RGBapproximation` on the `physicalproperties` table. All the data in the column will be lost.
  - You are about to drop the column `XYZColor` on the `physicalproperties` table. All the data in the column will be lost.
  - Added the required column `temp` to the `HeatDeflectionTemperature` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `charpyimpactstrength` ADD COLUMN `batch` VARCHAR(191);

-- AlterTable
ALTER TABLE `heatdeflectiontemperature` DROP COLUMN `Temp`,
    ADD COLUMN `batch` VARCHAR(191),
    ADD COLUMN `temp` DOUBLE NOT NULL;

-- AlterTable
ALTER TABLE `physicalproperties` DROP COLUMN `RGBapproximation`,
    DROP COLUMN `XYZColor`,
    ADD COLUMN `RGBApproximation` VARCHAR(191);

-- AlterTable
ALTER TABLE `stressstraincurve` ADD COLUMN `batch` VARCHAR(191);

-- CreateTable
CREATE TABLE `absoluteColor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `xyzColor` VARCHAR(191) NOT NULL,
    `physicalPropertiesId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `absoluteColor` ADD FOREIGN KEY (`physicalPropertiesId`) REFERENCES `PhysicalProperties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
