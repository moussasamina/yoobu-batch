-- CreateTable
CREATE TABLE `addresse_adr` (
    `adr_id` BIGINT NOT NULL AUTO_INCREMENT,
    `adr_address_type` VARCHAR(20) NULL,
    `adr_first_name` TEXT NULL,
    `adr_last_name` TEXT NULL,
    `adr_company` TEXT NULL,
    `adr_address_1` TEXT NULL,
    `adr_address_2` TEXT NULL,
    `adr_city` TEXT NULL,
    `adr_state` TEXT NULL,
    `adr_postcode` TEXT NULL,
    `adr_country` TEXT NULL,
    `adr_email` VARCHAR(320) NULL,
    `adr_phone` VARCHAR(100) NULL,

    PRIMARY KEY (`adr_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `colis_col` (
    `col_id` VARCHAR(191) NOT NULL,
    `col_delivery_date` DATETIME(0) NULL,
    `col_current_status` ENUM('NON_PREPAREE', 'PREPARATION_EN_COURS', 'PARTIELLEMENT_PREPAREE', 'PREPAREE', 'LIVRAISON_EN_COURS', 'PARTIELLEMENT_LIVREE', 'A_RELIVRER', 'LIVREE') NULL DEFAULT 'NON_PREPAREE',
    `col_order_id` BIGINT NOT NULL,
    `col_track_number` VARCHAR(191) NULL,
    `col_number` VARCHAR(191) NULL,
    `col_tyc_id` INTEGER NULL,

    UNIQUE INDEX `colis_col_col_track_number_key`(`col_track_number`),
    UNIQUE INDEX `colis_col_col_number_key`(`col_number`),
    INDEX `colis_col_col_order_id_fkey`(`col_order_id`),
    INDEX `colis_col_col_tyc_id_fkey`(`col_tyc_id`),
    PRIMARY KEY (`col_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `colisitems_ctm` (
    `ctm_id` VARCHAR(191) NOT NULL,
    `ctm_col_id` VARCHAR(191) NOT NULL,
    `ctm_ori_itm_id` BIGINT NOT NULL,
    `ctm_prod_count` INTEGER NOT NULL,

    INDEX `colisitems_ctm_ctm_col_id_fkey`(`ctm_col_id`),
    INDEX `colisitems_ctm_ctm_ori_itm_id_fkey`(`ctm_ori_itm_id`),
    PRIMARY KEY (`ctm_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orders_ord` (
    `ord_id` BIGINT NOT NULL AUTO_INCREMENT,
    `ord_order_id` BIGINT NOT NULL,
    `ord_seller_id` BIGINT NOT NULL,
    `ord_order_total` DECIMAL(19, 4) NULL,
    `ord_net_amount` DECIMAL(19, 4) NULL,
    `ord_order_status` VARCHAR(30) NULL,
    `ord_adr_id` BIGINT NULL,
    `ord_delivery_date` DATETIME(3) NULL,
    `ord_create_at` DATETIME(3) NULL,
    `ord_globalstatus` ENUM('NON_PREPAREE', 'PREPARATION_EN_COURS', 'PARTIELLEMENT_PREPAREE', 'PREPAREE', 'LIVRAISON_EN_COURS', 'PARTIELLEMENT_LIVREE', 'A_RELIVRER', 'LIVREE') NULL,

    UNIQUE INDEX `orders_ord_ord_order_id_key`(`ord_order_id`),
    UNIQUE INDEX `orders_ord_ord_adr_id_key`(`ord_adr_id`),
    INDEX `ord_order_id`(`ord_order_id`),
    PRIMARY KEY (`ord_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ordersitems_ori` (
    `ori_itm_id` BIGINT NOT NULL,
    `ori_itm_product_name` VARCHAR(191) NOT NULL,
    `ori_itm_count` INTEGER NULL,
    `ori_itm_order_id` BIGINT NULL,
    `ori_itm_product_id` BIGINT NULL,

    INDEX `ordersitems_ori_ori_itm_order_id_fkey`(`ori_itm_order_id`),
    PRIMARY KEY (`ori_itm_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `qrcode_qrc` (
    `qrc_id` VARCHAR(50) NOT NULL,
    `qrc_secretkey` TEXT NULL,
    `qrc_coli_id` VARCHAR(50) NOT NULL,

    UNIQUE INDEX `qrcode_qrc_qrc_id_key`(`qrc_id`),
    UNIQUE INDEX `qrc_coli_id`(`qrc_coli_id`),
    PRIMARY KEY (`qrc_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `scan_scn` (
    `scn_id` VARCHAR(50) NOT NULL,
    `scn_date` DATETIME(0) NULL,
    `scn_zon` VARCHAR(50) NULL,
    `scn_user_id` VARCHAR(50) NULL,
    `scn_qrcode_id` VARCHAR(50) NOT NULL,

    UNIQUE INDEX `scan_scn_scn_id_key`(`scn_id`),
    INDEX `scan_scn_scn_qrcode_id_fkey`(`scn_qrcode_id`),
    INDEX `scn_user_id`(`scn_user_id`),
    PRIMARY KEY (`scn_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users_usr` (
    `usr_id` VARCHAR(191) NOT NULL,
    `usr_active` BOOLEAN NOT NULL DEFAULT true,
    `usr_zon_id` VARCHAR(50) NULL,
    `usr_firstname` VARCHAR(50) NULL,
    `usr_lastname` VARCHAR(50) NULL,
    `usr_email` VARCHAR(50) NULL,
    `usr_role` ENUM('PREPARATEUR', 'LIVREUR', 'LOGISTICIEN') NULL,

    UNIQUE INDEX `usr_id`(`usr_id`),
    UNIQUE INDEX `users_usr_usr_email_key`(`usr_email`),
    PRIMARY KEY (`usr_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `zone_zon` (
    `zon_id` INTEGER NOT NULL AUTO_INCREMENT,
    `zon_code` VARCHAR(50) NULL,
    `zon_designation` VARCHAR(50) NULL,

    UNIQUE INDEX `zon_id`(`zon_id`),
    PRIMARY KEY (`zon_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `typeconditionnement_tyc` (
    `tyc_id` INTEGER NOT NULL AUTO_INCREMENT,
    `tyc_code` VARCHAR(191) NOT NULL,
    `tyc_designation` VARCHAR(191) NOT NULL,
    `tyc_largeur` DECIMAL(65, 30) NOT NULL,
    `tyc_longueur` DECIMAL(65, 30) NOT NULL,
    `tyc_poids` DECIMAL(65, 30) NOT NULL,
    `tyc_hauteur` DECIMAL(65, 30) NOT NULL,

    UNIQUE INDEX `typeconditionnement_tyc_tyc_id_key`(`tyc_id`),
    PRIMARY KEY (`tyc_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `colis_col` ADD CONSTRAINT `colis_col_col_order_id_fkey` FOREIGN KEY (`col_order_id`) REFERENCES `orders_ord`(`ord_order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `colis_col` ADD CONSTRAINT `colis_col_col_tyc_id_fkey` FOREIGN KEY (`col_tyc_id`) REFERENCES `typeconditionnement_tyc`(`tyc_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `colisitems_ctm` ADD CONSTRAINT `colisitems_ctm_ctm_col_id_fkey` FOREIGN KEY (`ctm_col_id`) REFERENCES `colis_col`(`col_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `colisitems_ctm` ADD CONSTRAINT `colisitems_ctm_ctm_ori_itm_id_fkey` FOREIGN KEY (`ctm_ori_itm_id`) REFERENCES `ordersitems_ori`(`ori_itm_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `orders_ord` ADD CONSTRAINT `orders_ord_ord_adr_id_fkey` FOREIGN KEY (`ord_adr_id`) REFERENCES `addresse_adr`(`adr_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ordersitems_ori` ADD CONSTRAINT `ordersitems_ori_ori_itm_order_id_fkey` FOREIGN KEY (`ori_itm_order_id`) REFERENCES `orders_ord`(`ord_order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `qrcode_qrc` ADD CONSTRAINT `qrcode_qrc_qrc_coli_id_fkey` FOREIGN KEY (`qrc_coli_id`) REFERENCES `colis_col`(`col_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `scan_scn` ADD CONSTRAINT `scan_scn_scn_qrcode_id_fkey` FOREIGN KEY (`scn_qrcode_id`) REFERENCES `qrcode_qrc`(`qrc_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
