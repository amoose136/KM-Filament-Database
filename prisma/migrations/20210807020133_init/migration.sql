/*
  Warnings:

  - You are about to drop the column `xyzColor` on the `absolutecolor` table. All the data in the column will be lost.
  - You are about to drop the column `batch` on the `charpyimpactstrength` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `filament` table. All the data in the column will be lost.
  - The values [ACRYLIC] on the enum `Filament_materialClass` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `batch` on the `heatdeflectiontemperature` table. All the data in the column will be lost.
  - You are about to drop the column `RGBApproximation` on the `physicalproperties` table. All the data in the column will be lost.
  - You are about to drop the column `batch` on the `stressstraincurve` table. All the data in the column will be lost.
  - Added the required column `x` to the `AbsoluteColor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `y` to the `AbsoluteColor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `z` to the `AbsoluteColor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `creatorUserId` to the `CharpyImpactStrength` table without a default value. This is not possible if the table is not empty.
  - Added the required column `creatorUserId` to the `HeatDeflectionTemperature` table without a default value. This is not possible if the table is not empty.
  - Added the required column `creatorUserId` to the `StressStrainCurve` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `filament` DROP FOREIGN KEY `filament_ibfk_3`;

-- AlterTable
ALTER TABLE `absolutecolor` DROP COLUMN `xyzColor`,
    ADD COLUMN `x` DOUBLE NOT NULL,
    ADD COLUMN `y` DOUBLE NOT NULL,
    ADD COLUMN `z` DOUBLE NOT NULL;

-- AlterTable
ALTER TABLE `charpyimpactstrength` DROP COLUMN `batch`,
    ADD COLUMN `creatorUserId` INTEGER NOT NULL,
    ADD COLUMN `filamentBatch` VARCHAR(191),
    MODIFY `specimenPrintOrientation` ENUM('XY', 'Z', 'SKEW', 'UNKNOWN') NOT NULL;

-- AlterTable
ALTER TABLE `filament` DROP COLUMN `userId`,
    ADD COLUMN `solventId` INTEGER,
    MODIFY `materialClass` ENUM('ABS', 'PMMA', 'ASA', 'BVOH', 'PLA', 'PE', 'PETG', 'PC', 'PCTG', 'PA', 'PP', 'PVA', 'HIPS', 'TPU', 'TPE', 'PEEK', 'PEKK', 'PEI', 'PURGE', 'CPE', 'BLEND', 'RESIN') DEFAULT 'PLA';

-- AlterTable
ALTER TABLE `heatdeflectiontemperature` DROP COLUMN `batch`,
    ADD COLUMN `creatorUserId` INTEGER NOT NULL,
    ADD COLUMN `filamentBatch` VARCHAR(191),
    MODIFY `specimenPrintOrientation` ENUM('XY', 'Z', 'SKEW', 'UNKNOWN') NOT NULL,
    MODIFY `specimenType` ENUM('ASTM_D648', 'ISO_75', 'UNKNOWN') NOT NULL;

-- AlterTable
ALTER TABLE `mfgsuggestedsettings` ADD COLUMN `bedTempIdeal` DOUBLE,
    ADD COLUMN `hotendTempIdeal` DOUBLE,
    MODIFY `bedTempMax` DOUBLE,
    MODIFY `bedTempMin` DOUBLE,
    MODIFY `hotendTempMax` DOUBLE,
    MODIFY `hotendTempMin` DOUBLE;

-- AlterTable
ALTER TABLE `physicalproperties` DROP COLUMN `RGBApproximation`,
    ADD COLUMN `elongationAtBreakSkewMean` DOUBLE,
    ADD COLUMN `elongationAtBreakSkewUncertainty` DOUBLE,
    ADD COLUMN `modulusOfElasticityIsotropicMean` DOUBLE,
    ADD COLUMN `modulusOfElasticityIsotropicUncertainty` DOUBLE,
    ADD COLUMN `modulusOfElasticitySkewMean` DOUBLE,
    ADD COLUMN `modulusOfElasticitySkewUncertainty` DOUBLE,
    ADD COLUMN `modulusOfElasticityXYMean` DOUBLE,
    ADD COLUMN `modulusOfElasticityXYUncertainty` DOUBLE,
    ADD COLUMN `modulusOfElasticityZMean` DOUBLE,
    ADD COLUMN `modulusOfElasticityZUncertainty` DOUBLE,
    ADD COLUMN `solubilityComment` VARCHAR(191),
    ADD COLUMN `ultimateTensileStrengthSkewMean` DOUBLE,
    ADD COLUMN `ultimateTensileStrengthSkewUncertainty` DOUBLE,
    ADD COLUMN `yieldStrengthSkewMean` DOUBLE,
    ADD COLUMN `yieldStrengthSkewUncertainty` DOUBLE;

-- AlterTable
ALTER TABLE `stressstraincurve` DROP COLUMN `batch`,
    ADD COLUMN `creatorUserId` INTEGER NOT NULL,
    ADD COLUMN `filamentBatch` VARCHAR(191),
    MODIFY `specimenPrintOrientation` ENUM('XY', 'Z', 'SKEW', 'UNKNOWN') NOT NULL;

-- CreateTable
CREATE TABLE `UsersOnFilaments` (
    `filamentId` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,
    `assignedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`userId`, `filamentId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Solvent` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `name` VARCHAR(191) NOT NULL,
    `materialSafetyDataSheetURL` VARCHAR(191),
    `physicalPropertiesId` INTEGER,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SolventsOnPhysicalProperties` (
    `solventId` INTEGER NOT NULL,
    `physicalPropertiesId` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,
    `assignedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`solventId`, `physicalPropertiesId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RGBApproximation` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `R` INTEGER NOT NULL,
    `G` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,
    `physicalPropertiesId` INTEGER NOT NULL,

    UNIQUE INDEX `RGBApproximation_physicalPropertiesId_unique`(`physicalPropertiesId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_FilamentToUser` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_FilamentToUser_AB_unique`(`A`, `B`),
    INDEX `_FilamentToUser_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_PhysicalPropertiesToUser` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_PhysicalPropertiesToUser_AB_unique`(`A`, `B`),
    INDEX `_PhysicalPropertiesToUser_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Filament` ADD FOREIGN KEY (`solventId`) REFERENCES `Solvent`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UsersOnFilaments` ADD FOREIGN KEY (`filamentId`) REFERENCES `Filament`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UsersOnFilaments` ADD FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Solvent` ADD FOREIGN KEY (`physicalPropertiesId`) REFERENCES `PhysicalProperties`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SolventsOnPhysicalProperties` ADD FOREIGN KEY (`solventId`) REFERENCES `Solvent`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SolventsOnPhysicalProperties` ADD FOREIGN KEY (`physicalPropertiesId`) REFERENCES `PhysicalProperties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SolventsOnPhysicalProperties` ADD FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `HeatDeflectionTemperature` ADD FOREIGN KEY (`creatorUserId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CharpyImpactStrength` ADD FOREIGN KEY (`creatorUserId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StressStrainCurve` ADD FOREIGN KEY (`creatorUserId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RGBApproximation` ADD FOREIGN KEY (`physicalPropertiesId`) REFERENCES `PhysicalProperties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_FilamentToUser` ADD FOREIGN KEY (`A`) REFERENCES `Filament`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_FilamentToUser` ADD FOREIGN KEY (`B`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_PhysicalPropertiesToUser` ADD FOREIGN KEY (`A`) REFERENCES `PhysicalProperties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_PhysicalPropertiesToUser` ADD FOREIGN KEY (`B`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
