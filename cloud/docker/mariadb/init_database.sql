CREATE DATABASE IF NOT EXISTS my_db;

use my_db;

CREATE TABLE `list_B` (
  `aid` bigint(20) NOT NULL AUTO_INCREMENT,
  `name_l` varchar(100) DEFAULT NULL,
  `id_l` varchar(20) DEFAULT NULL,
  `phone_l` varchar(13) DEFAULT NULL,
  `com` varchar(255) DEFAULT NULL,
  `list_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`aid`),
  KEY `id_i` (`id_l`)
) ENGINE=InnoDB AUTO_INCREMENT=49617048 DEFAULT CHARSET=utf8;
