-- CreateTable
CREATE TABLE `Filament` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `name` VARCHAR(191) NOT NULL,
    `materialClass` ENUM('ABS', 'ACRYLIC', 'ASA', 'BVOH', 'PLA', 'PETG', 'PC', 'NYLON', 'PP', 'PVA', 'HIPS', 'TPU', 'TPE', 'PEEK', 'PEKK', 'PEI', 'PURGE', 'CPE', 'BLEND') DEFAULT 'PLA',
    `materialSubclass` VARCHAR(191) NOT NULL DEFAULT 'PLA',
    `manufacturerId` INTEGER NOT NULL,
    `cost` DOUBLE,
    `weightPerSpool` DOUBLE DEFAULT 1.0,
    `FrontPicturePath` VARCHAR(191),
    `BacklitPicturePath` VARCHAR(191),
    `gifPath` VARCHAR(191),
    `published` BOOLEAN NOT NULL DEFAULT false,
    `comments` VARCHAR(191),
    `userId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL,
    `haxDBName` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `User.id_unique`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Link` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `link` VARCHAR(191) NOT NULL,
    `filamentId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Manufacturer` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191),
    `address` VARCHAR(191),
    `logoPath` VARCHAR(191),

    UNIQUE INDEX `Manufacturer.name_unique`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MaterialProperties` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `isSilk` BOOLEAN,
    `flexibilityClass` ENUM('SEMIFLEX', 'FLEX', 'RIGID'),
    `isBuoyant` BOOLEAN,
    `isComposite` BOOLEAN,
    `isAbrasive` BOOLEAN,
    `isExotic` BOOLEAN,
    `isGlowInDark` BOOLEAN,
    `isHydroscopic` BOOLEAN,
    `containsGlitter` BOOLEAN,
    `filamentId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PhysicalProperties` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ultimateTensileStrengthZ` DOUBLE,
    `ultimateTensileStrengthXY` DOUBLE,
    `ultimateTensilStrengthUnits` VARCHAR(191),
    `yieldStrengthZ` DOUBLE,
    `yieldStrengthXY` DOUBLE,
    `yieldStrengthUnits` VARCHAR(191),
    `charpyImpactStrengthXY` DOUBLE,
    `charpyImpactStrengthZ` DOUBLE,
    `charpyImpactUnits` VARCHAR(191),
    `shoreHardness` DOUBLE,
    `shoreScale` VARCHAR(191),
    `heatDeflectionTemperature` INTEGER,
    `density` DOUBLE,
    `densityUnits` VARCHAR(191),
    `opticalDensity` DOUBLE,
    `sheenLevel` ENUM('low', 'medium', 'high'),
    `RGBapproximation` VARCHAR(191),
    `XYZColor` VARCHAR(191),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `StressStrainCurve` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `physicalPropertiesId` INTEGER NOT NULL,

    UNIQUE INDEX `StressStrainCurve_physicalPropertiesId_unique`(`physicalPropertiesId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `StressStrainPoint` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `stress` DOUBLE NOT NULL,
    `strain` DOUBLE NOT NULL,
    `stressStrainCurveId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mfgSuggestedSettings` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `bedTemp` DOUBLE NOT NULL,
    `hotendTemp` DOUBLE NOT NULL,
    `enclosureNeeded` BOOLEAN NOT NULL DEFAULT false,
    `maxPrintSpeed` INTEGER,
    `comments` VARCHAR(191),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Filament` ADD FOREIGN KEY (`manufacturerId`) REFERENCES `Manufacturer`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Filament` ADD FOREIGN KEY (`id`) REFERENCES `mfgSuggestedSettings`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Filament` ADD FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Link` ADD FOREIGN KEY (`filamentId`) REFERENCES `Filament`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MaterialProperties` ADD FOREIGN KEY (`filamentId`) REFERENCES `Filament`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StressStrainCurve` ADD FOREIGN KEY (`physicalPropertiesId`) REFERENCES `PhysicalProperties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StressStrainCurve` ADD FOREIGN KEY (`physicalPropertiesId`) REFERENCES `PhysicalProperties`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StressStrainPoint` ADD FOREIGN KEY (`stressStrainCurveId`) REFERENCES `StressStrainCurve`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
