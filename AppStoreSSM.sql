CREATE TABLE `_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` varchar(20) DEFAULT '用户',
  `phone` bigint(20) NOT NULL,
  `password` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE `_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `typeName` (`typeName`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;


CREATE TABLE `_app` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `typeId` bigint(20) NOT NULL,
  `appName` varchar(100) NOT NULL,
  `company` varchar(20) DEFAULT '',
  `description` text,
  `os` varchar(20) DEFAULT '',
  `downloadCount` bigint(20) DEFAULT '0',
  `ratingCount` bigint(20) DEFAULT '0',
  `avgScore` tinyint(4) DEFAULT '5',
  `size` double DEFAULT NULL,
  `version` varchar(20) DEFAULT '',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fileName` varchar(500) DEFAULT NULL,
  `filePath` varchar(100) DEFAULT NULL,
  `state` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

CREATE TABLE `_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appId` bigint(20) NOT NULL,
  `version` varchar(20) DEFAULT NULL,
  `userId` bigint(20) NOT NULL,
  `content` text,
  `score` tinyint(4) DEFAULT NULL,
  `commentTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_assessment_appId` (`appId`),
  KEY `fk_assessment_userId` (`userId`),
  CONSTRAINT `fk_assessment_appId` FOREIGN KEY (`appId`) REFERENCES `_app` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_assessment_userId` FOREIGN KEY (`userId`) REFERENCES `_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `_picture` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appId` bigint(20) NOT NULL,
  `picName` varchar(500) NOT NULL,
  `picPath` varchar(30) NOT NULL,
  `module` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_picture_appId` (`appId`),
  CONSTRAINT `fk_picture_appId` FOREIGN KEY (`appId`) REFERENCES `_app` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

CREATE TABLE `_carousel` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appId` bigint(20) NOT NULL,
  `picName` varchar(100) NOT NULL,
  `picPath` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_carousel_appId` (`appId`),
  CONSTRAINT `fk_carousel_appId` FOREIGN KEY (`appId`) REFERENCES `_app` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

insert _user (phone,password,role) value (13232217305,123,'用户');
insert _user (phone,password,role) value (12345678910,123,'管理员');
