CREATE TABLE IF NOT EXISTS `firearms` (
  `police_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `serial` char(128) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `scratched` tinyint(1) NOT NULL DEFAULT 0,
  `purchased` datetime NOT NULL DEFAULT current_timestamp(),
  `model` varchar(128) NOT NULL,
  `item` char(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `owner_sid` int(11) unsigned DEFAULT NULL,
  `owner_name` varchar(512) DEFAULT NULL,
  `police_filed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`police_id`),
  KEY `owner_sid` (`owner_sid`) USING BTREE,
  KEY `police_filed` (`police_filed`) USING BTREE,
  KEY `serial` (`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

CREATE TABLE IF NOT EXISTS `firearms_flags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `serial` char(128) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `type` char(32) NOT NULL DEFAULT 'seized',
  `title` varchar(64) DEFAULT NULL,
  `description` longtext NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `author_sid` int(11) unsigned NOT NULL,
  `author_first` varchar(128) NOT NULL,
  `author_last` varchar(128) NOT NULL,
  `author_callsign` varchar(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `serial` (`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;