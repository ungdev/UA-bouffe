CREATE DATABASE IF NOT EXISTS bouffe;
USE bouffe;

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `needsPreparation` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `promoKey` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `orgaPrice` int(11) NOT NULL,
  `available` tinyint(1) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `key` (`key`),
  KEY `categoryId` (`categoryId`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `supplements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `orgaPrice` int(11) NOT NULL,
  `available` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `itemsupplements` (
  `itemKey` VARCHAR(255) NOT NULL,
  `supplementKey` VARCHAR(255) NOT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `itemKey` (`itemKey`),
  KEY `supplementKey` (`supplementKey`),
  CONSTRAINT `itemsupplements_ibfk_1` FOREIGN KEY (`itemKey`) REFERENCES `items` (`key`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `itemsupplements_ibfk_2` FOREIGN KEY (`supplementKey`) REFERENCES `supplements` (`key`) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY (`itemKey`,`supplementKey`)
);

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `place` varchar(255) NOT NULL,
  `status` enum('pending','preparing','ready','finished') NOT NULL DEFAULT 'pending',
  `method` enum('card','cash','ticket') NOT NULL,
  `orgaPrice` tinyint(1) NOT NULL,
  `total` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deletedAt` datetime,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3110 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `orderitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) NOT NULL,
  `itemId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deletedAt` datetime,
  PRIMARY KEY (`id`),
  KEY `orderId` (`orderId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`itemId`) REFERENCES `items` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ordersupplements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderItemId` int(11) NOT NULL,
  `supplementId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deletedAt` datetime,
  PRIMARY KEY (`id`),
  KEY `orderItemId` (`orderItemId`),
  KEY `supplementId` (`supplementId`),
  CONSTRAINT `ordersupplements_ibfk_1` FOREIGN KEY (`orderItemId`) REFERENCES `orderitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ordersupplements_ibfk_2` FOREIGN KEY (`supplementId`) REFERENCES `supplements` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `permissions` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `promotions` (
  `key` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `orgaPrice` int(11) NOT NULL,
  `formula` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `categories` (`id`,`name`,`key`,`needsPreparation`) VALUES 
	(1,'Boissons','boissons',0),
	(4,'Croques','croques',1),
	(8,'Sucré','sweet',1);
INSERT INTO `promotions` (`key`,`name`,`orgaPrice`,`price`,`formula`) VALUES 
	('croque','Promo 3 Croques',200,200,'croque|croque|croque');
INSERT INTO `users` (`id`,`name`,`key`,`permissions`) VALUES 
	(1,'Télévision','tv',NULL),
	(2,'Vendeur','seller','sell'),
	(4,'Administrateur','admin','admin');
INSERT INTO `items` (`id`,`name`,`key`,`promokey`,`orgaPrice`,`price`,`available`,`categoryId`) VALUES 
	(1,'Canette','canette','canette',60,60,1,1),
	(39,'Croque 3 fromages','croque3fromages','croque',100,100,1,4),
	(40,'Croque Tomate Mozza','croquetomatemozza','croque',100,100,1,4),
	(51,'Crêpe fruits rouges','crepefruitsrouges','crepe',70,70,1,8),
	(52,'Crêpe abricot','crepeabricot','crepe',70,70,1,8),
	(53,'Crêpe miel','crepemiel','crepe',70,70,1,8),
	(54,'Crêpe sucre','crepesucre','crepe',70,70,1,8),
	(55,'Crêpe nutella','crepenutella','crepe',70,70,1,8),
	(55,'Crêpe citron','crepecitron','crepe',70,70,1,8);