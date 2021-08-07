/*
  Warnings:

  - You are about to drop the column `published` on the `filament` table. All the data in the column will be lost.
  - The values [NYLON] on the enum `Filament_materialClass` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `filamentId` on the `materialproperties` table. All the data in the column will be lost.
  - You are about to drop the column `bedTemp` on the `mfgsuggestedsettings` table. All the data in the column will be lost.
  - You are about to drop the column `hotendTemp` on the `mfgsuggestedsettings` table. All the data in the column will be lost.
  - You are about to drop the column `charpyImpactStrengthXY` on the `physicalproperties` table. All the data in the column will be lost.
  - You are about to drop the column `charpyImpactStrengthZ` on the `physicalproperties` table. All the data in the column will be lost.
  - You are about to drop the column `charpyImpactUnits` on the `physicalproperties` table. All the data in the column will be lost.
  - You are about to drop the column `heatDeflectionTemperature` on the `physicalproperties` table. All the data in the column will be lost.
  - You are about to drop the column `ultimateTensilStrengthUnits` on the `physicalproperties` table. All the data in the column will be lost.
  - You are about to drop the column `ultimateTensileStrengthXY` on the `physicalproperties` table. All the data in the column will be lost.
  - You are about to drop the column `ultimateTensileStrengthZ` on the `physicalproperties` table. All the data in the column will be lost.
  - You are about to drop the column `yieldStrengthUnits` on the `physicalproperties` table. All the data in the column will be lost.
  - You are about to drop the column `yieldStrengthZ` on the `physicalproperties` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[materialPropertiesId]` on the table `PhysicalProperties` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `updatedAt` to the `Filament` table without a default value. This is not possible if the table is not empty.
  - Added the required column `bedTempMax` to the `mfgSuggestedSettings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `bedTempMin` to the `mfgSuggestedSettings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hotendTempMax` to the `mfgSuggestedSettings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hotendTempMin` to the `mfgSuggestedSettings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `mfgSuggestedSettings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `materialPropertiesId` to the `PhysicalProperties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `PhysicalProperties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `specimenPrintOrientation` to the `StressStrainCurve` table without a default value. This is not possible if the table is not empty.
  - Added the required column `specimenType` to the `StressStrainCurve` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `materialproperties` DROP FOREIGN KEY `materialproperties_ibfk_1`;

-- AlterTable
ALTER TABLE `filament` DROP COLUMN `published`,
    ADD COLUMN `MaterialPropertiesId` INTEGER,
    ADD COLUMN `basisId` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `isExternalMaterial` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `isPublished` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL,
    MODIFY `materialClass` ENUM('ABS', 'ACRYLIC', 'ASA', 'BVOH', 'PLA', 'PETG', 'PC', 'PA', 'PP', 'PVA', 'HIPS', 'TPU', 'TPE', 'PEEK', 'PEKK', 'PEI', 'PURGE', 'CPE', 'BLEND') DEFAULT 'PLA';

-- AlterTable
ALTER TABLE `materialproperties` DROP COLUMN `filamentId`,
    MODIFY `isGlowInDark` BOOLEAN DEFAULT false;

-- AlterTable
ALTER TABLE `mfgsuggestedsettings` DROP COLUMN `bedTemp`,
    DROP COLUMN `hotendTemp`,
    ADD COLUMN `CoolingNeeded` BOOLEAN DEFAULT true,
    ADD COLUMN `bedTempMax` DOUBLE NOT NULL,
    ADD COLUMN `bedTempMin` DOUBLE NOT NULL,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `enclosureHeaterNeeded` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `enclosureTempMax` DOUBLE,
    ADD COLUMN `enclosureTempMin` DOUBLE,
    ADD COLUMN `hotendTempMax` DOUBLE NOT NULL,
    ADD COLUMN `hotendTempMin` DOUBLE NOT NULL,
    ADD COLUMN `isAutoFilled` BOOLEAN NOT NULL DEFAULT true,
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL;

-- AlterTable
ALTER TABLE `physicalproperties` DROP COLUMN `charpyImpactStrengthXY`,
    DROP COLUMN `charpyImpactStrengthZ`,
    DROP COLUMN `charpyImpactUnits`,
    DROP COLUMN `heatDeflectionTemperature`,
    DROP COLUMN `ultimateTensilStrengthUnits`,
    DROP COLUMN `ultimateTensileStrengthXY`,
    DROP COLUMN `ultimateTensileStrengthZ`,
    DROP COLUMN `yieldStrengthUnits`,
    DROP COLUMN `yieldStrengthZ`,
    ADD COLUMN `PantoneApproximation` VARCHAR(191),
    ADD COLUMN `charpyImpactStrengthIsotropicMean` DOUBLE,
    ADD COLUMN `charpyImpactStrengthIsotropicUncertainty` DOUBLE,
    ADD COLUMN `charpyImpactStrengthXYMean` DOUBLE,
    ADD COLUMN `charpyImpactStrengthXYUncertainty` DOUBLE,
    ADD COLUMN `charpyImpactStrengthZMean` DOUBLE,
    ADD COLUMN `charpyImpactStrengthZUncertainty` DOUBLE,
    ADD COLUMN `elongationAtBreakIsotropicMean` DOUBLE,
    ADD COLUMN `elongationAtBreakIsotropicUncertainty` DOUBLE,
    ADD COLUMN `elongationAtBreakXYMean` DOUBLE,
    ADD COLUMN `elongationAtBreakXYUncertainty` DOUBLE,
    ADD COLUMN `elongationAtBreakZMean` DOUBLE,
    ADD COLUMN `elongationAtBreakZUncertainty` DOUBLE,
    ADD COLUMN `heatDeflectionTemperatureUncertainty` DOUBLE,
    ADD COLUMN `isDensityAutoFilled` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `isHardnessAutoFilled` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `isHeatDeflectionTemperatureAutoFilled` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `isImpactStrengthAutoFilled` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `isODAutoFilled` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `isSSAutoFilled` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `materialPropertiesId` INTEGER NOT NULL,
    ADD COLUMN `ultimateTensileStrengthIsotropicMean` DOUBLE,
    ADD COLUMN `ultimateTensileStrengthIsotropicUncertainty` DOUBLE,
    ADD COLUMN `ultimateTensileStrengthXYMean` DOUBLE,
    ADD COLUMN `ultimateTensileStrengthXYUncertainty` DOUBLE,
    ADD COLUMN `ultimateTensileStrengthZMean` DOUBLE,
    ADD COLUMN `ultimateTensileStrengthZUncertainty` DOUBLE,
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL,
    ADD COLUMN `yieldStrengthIsotropicMean` DOUBLE,
    ADD COLUMN `yieldStrengthIsotropicUncertainty` DOUBLE,
    ADD COLUMN `yieldStrengthXYUncertainty` DOUBLE,
    ADD COLUMN `yieldStrengthZMean` DOUBLE,
    ADD COLUMN `yieldStrengthZUncertainty` DOUBLE,
    MODIFY `shoreScale` VARCHAR(191) DEFAULT 'A',
    MODIFY `densityUnits` VARCHAR(191) DEFAULT 'kg/m^3';

-- AlterTable
ALTER TABLE `stressstraincurve` ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `specimenPrintOrientation` ENUM('XY', 'Z', 'UNKNOWN') NOT NULL,
    ADD COLUMN `specimenType` ENUM('ASTM_D638_Type1', 'ASTM_D638_Type2', 'ASTM_D638_Type3', 'ASTM_D638_Type4', 'ASTM_D638_Type5', 'ISO_527_2_1A', 'ISO_527_1BA', 'UNKNOWN') NOT NULL,
    ADD COLUMN `units` VARCHAR(191) NOT NULL DEFAULT 'MPa';

-- AlterTable
ALTER TABLE `stressstrainpoint` MODIFY `stressStrainCurveId` INTEGER;

-- CreateTable
CREATE TABLE `HeatDeflectionTemperature` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `Temp` DOUBLE NOT NULL,
    `units` VARCHAR(191) NOT NULL DEFAULT 'C',
    `specimenPrintOrientation` ENUM('XY', 'Z', 'UNKNOWN') NOT NULL,
    `specimenType` ENUM('UNKNOWN') NOT NULL,
    `physicalPropertiesId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CharpyImpactStrength` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `impactStrength` DOUBLE NOT NULL,
    `units` VARCHAR(191) NOT NULL DEFAULT 'J/m^2',
    `specimenPrintOrientation` ENUM('XY', 'Z', 'UNKNOWN') NOT NULL,
    `specimenType` ENUM('ISO_13802', 'ASTM_D6110', 'ISO_179', 'UNKNOWN') NOT NULL,
    `physicalPropertiesId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `PhysicalProperties_materialPropertiesId_unique` ON `PhysicalProperties`(`materialPropertiesId`);

-- AddForeignKey
ALTER TABLE `Filament` ADD FOREIGN KEY (`MaterialPropertiesId`) REFERENCES `MaterialProperties`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PhysicalProperties` ADD FOREIGN KEY (`materialPropertiesId`) REFERENCES `MaterialProperties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `HeatDeflectionTemperature` ADD FOREIGN KEY (`physicalPropertiesId`) REFERENCES `PhysicalProperties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CharpyImpactStrength` ADD FOREIGN KEY (`physicalPropertiesId`) REFERENCES `PhysicalProperties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
