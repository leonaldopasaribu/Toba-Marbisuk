/*
SQLyog Ultimate v8.6 Beta2
MySQL - 5.5.5-10.1.21-MariaDB : Database - webpkm2018
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`webpkm2018` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `webpkm2018`;

/*Table structure for table `detail_kuis` */

DROP TABLE IF EXISTS `detail_kuis`;

CREATE TABLE `detail_kuis` (
  `detail_kuis_id` int(11) NOT NULL AUTO_INCREMENT,
  `kuis_id` int(11) NOT NULL,
  `status` int(6) DEFAULT NULL,
  `pertanyaan` text,
  `jawaban_user` varchar(200) DEFAULT NULL,
  `jawaban_benar` varchar(100) DEFAULT NULL,
  `opsi_a` varchar(100) DEFAULT NULL,
  `opsi_b` varchar(100) DEFAULT NULL,
  `opsi_c` varchar(100) DEFAULT NULL,
  `opsi_d` varchar(100) DEFAULT NULL,
  `opsi_e` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`detail_kuis_id`),
  KEY `FK_detail_kuis` (`kuis_id`),
  CONSTRAINT `FK_detail_kuis` FOREIGN KEY (`kuis_id`) REFERENCES `kuis` (`kuis_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `detail_kuis` */

insert  into `detail_kuis`(`detail_kuis_id`,`kuis_id`,`status`,`pertanyaan`,`jawaban_user`,`jawaban_benar`,`opsi_a`,`opsi_b`,`opsi_c`,`opsi_d`,`opsi_e`,`created_at`,`created_by`,`updated_at`,`updated_by`) values (5,30,NULL,'aaa',NULL,'1','','','','','','2018-12-06 08:55:18','16','2018-12-06 08:55:18','16'),(6,30,NULL,'abc',NULL,'5','','','','','','2018-12-06 08:55:18','16','2018-12-06 08:55:18','16'),(8,29,NULL,'test','1','1','1','2','3','4','5','2018-12-06 08:55:18','16','2018-12-06 17:35:57','15'),(9,29,NULL,'Ke','1','','we','','','','','2018-12-06 17:25:08','16','2018-12-06 17:35:58','15'),(10,29,NULL,'wqe','1','','','','','','','2018-12-06 17:25:18','16','2018-12-06 17:35:58','15'),(11,29,NULL,'',NULL,'','','','','','','2018-12-10 02:39:00','16','2018-12-10 02:39:00','16'),(12,33,NULL,'aaaaaaa',NULL,'5','a','a','a','a','aaa','2018-12-15 10:17:07','16','2018-12-15 11:10:37','16'),(13,33,NULL,'a',NULL,'','aaaaaaaa','','','','','2018-12-15 10:54:28','16','2018-12-15 11:10:48','16');

/*Table structure for table `detail_latihan` */

DROP TABLE IF EXISTS `detail_latihan`;

CREATE TABLE `detail_latihan` (
  `latihan_id` int(11) NOT NULL AUTO_INCREMENT,
  `kuis_id` int(11) DEFAULT NULL,
  `pertanyaan` varchar(200) DEFAULT NULL,
  `jawaban_benar` varchar(200) DEFAULT NULL,
  `opsi_a` varchar(200) DEFAULT NULL,
  `opsi_b` varchar(200) DEFAULT NULL,
  `opsi_c` varchar(200) DEFAULT NULL,
  `opsi_d` varchar(200) DEFAULT NULL,
  `opsi_e` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`latihan_id`),
  KEY `FK_detail_latihan` (`kuis_id`),
  CONSTRAINT `FK_detail_latihan` FOREIGN KEY (`kuis_id`) REFERENCES `kuis` (`kuis_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `detail_latihan` */

insert  into `detail_latihan`(`latihan_id`,`kuis_id`,`pertanyaan`,`jawaban_benar`,`opsi_a`,`opsi_b`,`opsi_c`,`opsi_d`,`opsi_e`,`created_at`,`updated_at`) values (17,29,'Massa sebuah elektron kira-kira 0,000.000.000.000.000.000.000.000.000.000.911 kg. Jika dituliskan dalm bentuk notasi ilmiah maka massa elektron dapat dituliskan sebagai….',NULL,'0,91×10?30kg','bb','bbb','bbbb','bbbbb',NULL,NULL),(18,33,'a',NULL,'a','a','a','a','a',NULL,NULL);

/*Table structure for table `komentar` */

DROP TABLE IF EXISTS `komentar`;

CREATE TABLE `komentar` (
  `komentar_id` int(11) NOT NULL AUTO_INCREMENT,
  `kuis_id` int(11) DEFAULT NULL,
  `komentar` varchar(200) DEFAULT NULL,
  `username` varchar(200) DEFAULT NULL,
  `gambar` varchar(200) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`komentar_id`),
  KEY `FK_komentar` (`kuis_id`),
  CONSTRAINT `FK_komentar` FOREIGN KEY (`kuis_id`) REFERENCES `kuis` (`kuis_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `komentar` */

insert  into `komentar`(`komentar_id`,`kuis_id`,`komentar`,`username`,`gambar`,`created_by`,`created_at`,`updated_by`,`updated_at`) values (6,29,'Materi nya bagus bermanfaat bagi siswa SD','Herbin Togatorop','img/2.jpg','16','2018-12-05 14:57:37','16','2018-12-05 14:57:37'),(7,29,'Terimakasih buat guru','Herbin Togatorop','img/2.jpg','16','2018-12-05 15:06:55','16','2018-12-05 15:06:55'),(8,29,'Kirim lagi dong','Herbin Togatorop','img/2.jpg','16','2018-12-05 15:08:27','16','2018-12-05 15:08:27'),(10,29,'','Herbin Togatorop','img/2.jpg','16','2018-12-06 02:06:11','16','2018-12-06 02:06:11'),(11,29,'','Leonaldo Pasaribu',NULL,'15','2018-12-06 14:11:33','15','2018-12-06 14:11:33'),(12,29,'oke\r\n','Leonaldo Pasaribu','img/avatar.jpg','15','2018-12-15 08:49:15','15','2018-12-15 08:49:15');

/*Table structure for table `kuis` */

DROP TABLE IF EXISTS `kuis`;

CREATE TABLE `kuis` (
  `kuis_id` int(11) NOT NULL AUTO_INCREMENT,
  `mapel_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `kuis_name` varchar(200) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `sandi_kuis` varchar(200) DEFAULT NULL,
  `waktu_kuis` datetime DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `deskripsi` text,
  `penyelesaian_file` varchar(100) DEFAULT NULL,
  `penyelesaian_video` varchar(100) DEFAULT NULL,
  `materi_file` varchar(200) DEFAULT NULL,
  `materi_video` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`kuis_id`),
  KEY `FK_kuis` (`mapel_id`),
  KEY `FK_kuis_user` (`user_id`),
  CONSTRAINT `FK_kuis` FOREIGN KEY (`mapel_id`) REFERENCES `mapel` (`mapel_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_kuis_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

/*Data for the table `kuis` */

insert  into `kuis`(`kuis_id`,`mapel_id`,`user_id`,`kuis_name`,`status`,`sandi_kuis`,`waktu_kuis`,`score`,`deskripsi`,`penyelesaian_file`,`penyelesaian_video`,`materi_file`,`materi_video`,`created_at`,`created_by`,`updated_at`,`updated_by`) values (29,3,16,'Trigonometri',1,'leonaldop','2018-12-06 05:00:00',33,'<p>Trigonometri adalah sebuah cabang matematika yang mempelajari hubungan yang meliputi panjang dan sudut segitiga. Bidang ini muncul di masa Hellenistik pada abad ke-3 SM dari penggunaan geometri untuk mempelajari astronomi. </p>','uploads/penyelesaian/11416031.png','https://www.youtube.com/watch?v=lOGMsEXqULo','uploads/penyelesaian/presentation_IT_Del_dan_PMB_2017-RoadShow-final(1).ppt','44YPSRLn9MU','2018-12-05 08:53:59','16','2018-12-15 10:09:18','16'),(30,3,16,'Kalkulus',NULL,'leonaldop','2018-12-01 11:55:00',NULL,'<p>Kalkulus adalah cabang ilmu matematika yang mencakup limit, turunan, integral, dan deret takterhingga. Kalkulus adalah ilmu yang mempelajari perubahan, sebagaimana geometri yang mempelajari bentuk dan aljabar yang mempelajari operasi dan penerapannya untuk memecahkan persamaan. Kalkulus memiliki aplikasi yang luas dalam bidang-bidang sains, ekonomi, dan teknik; serta dapat memecahkan berbagai masalah yang tidak dapat dipecahkan dengan aljabar elementer.</p>','uploads/penyelesaian/166-329-2-PB.pdf',NULL,'uploads/penyelesaian/11416031.png','44YPSRLn9MU','2018-12-05 08:55:27','15','2018-12-07 03:15:59','16'),(31,3,16,'Aljabar',NULL,NULL,NULL,NULL,'<p>Aljabar adalah salah satu bagian dari bidang matematika yang luas, bersama-sama dengan teori bilangan, geometri dan analisis. Dalam bentuk paling umum, aljabar adalah ilmu yang mempelajari simbol-simbol matematika dan aturan untuk memanipulasi simbol-simbol ini</p>','uploads/penyelesaian/166-329-2-PB.pdf',NULL,'uploads/penyelesaian/11416031.png','44YPSRLn9MU','2018-12-05 08:56:25','16','2018-12-05 08:56:25','16'),(33,3,16,'aaasdsadf',NULL,'d','2018-12-15 16:35:00',NULL,'<p>a</p>','uploads/penyelesaian/11416031.png','https://www.youtube.com/watch?v=lOGMsEXqULo','uploads/penyelesaian/cis_production.sql','a','2018-12-15 09:55:07','16','2018-12-15 10:40:43','16');

/*Table structure for table `mapel` */

DROP TABLE IF EXISTS `mapel`;

CREATE TABLE `mapel` (
  `mapel_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `nama_mapel` varchar(45) DEFAULT NULL,
  `deskripsi` text,
  PRIMARY KEY (`mapel_id`),
  KEY `FK_mapel` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `mapel` */

insert  into `mapel`(`mapel_id`,`user_id`,`nama_mapel`,`deskripsi`) values (3,16,'Matematika',''),(4,16,'Biologi',''),(5,16,'Fisika',''),(6,16,'Kimia',''),(7,16,'Sejarah',''),(8,16,'Geografi',''),(9,16,'Ekonomi',''),(10,16,'Bahasa Inggris',''),(11,16,'Sosiologi',''),(12,16,'Bahasa Indonesia','');

/*Table structure for table `materi` */

DROP TABLE IF EXISTS `materi`;

CREATE TABLE `materi` (
  `materi_id` int(11) NOT NULL AUTO_INCREMENT,
  `mapel_id` int(11) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `deskripsi` varchar(300) DEFAULT NULL,
  `file_materi` varchar(100) NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`materi_id`),
  KEY `FK_materi` (`mapel_id`),
  CONSTRAINT `FK_materi` FOREIGN KEY (`mapel_id`) REFERENCES `mapel` (`mapel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `materi` */

/*Table structure for table `migration` */

DROP TABLE IF EXISTS `migration`;

CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `migration` */

insert  into `migration`(`version`,`apply_time`) values ('m000000_000000_base',1541427457),('m130524_201442_init',1541427476);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nama_lengkap` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `file_foto` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'img/avatar.jpg',
  `nama_sekolah` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status_aktif` tinyint(4) DEFAULT '1',
  `status` smallint(6) NOT NULL DEFAULT '10',
  `role` int(6) NOT NULL DEFAULT '1',
  `no_hp` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `password_reset_token` (`password_reset_token`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`auth_key`,`password_hash`,`password_reset_token`,`nama_lengkap`,`file_foto`,`nama_sekolah`,`email`,`status_aktif`,`status`,`role`,`no_hp`,`created_at`,`updated_at`) values (15,'siswa','_B7XZciGaDgP3GMtFaV8wtOeEy8W2KE2','$2y$13$QJNkiD3hSYnrFJKsNoaaPeRvCvg5YvBL2TfZj7kBCziJ6iGgrlD5.',NULL,'Leonaldo Pasaribu','img/avatar.jpg','SMA NEGERI 1 TARUTUNG','siswa@gmail.com',1,10,2,'08132858238','2018-11-28 18:48:39','2018-11-28 18:48:39'),(16,'guru','iG5yPGi41CXlbw1yMt6kXlEHU-HS7FRp','$2y$13$yBr6cGN8pcRRCu.WNM6Psuw5khiAAwNQ6p5BQoXamoCC.zwBNACAW','d-vCif53vfM5AD9QeuHPIsGX4o_Y5q8w_1543638387','Herbin Togatorop','img/11416031.png','SMA NEGERI 1 TARUTUNG','guru@gmail.com',1,10,1,'123456789','2018-11-28 18:48:39','2018-11-28 18:48:39'),(23,'Andre','iupR6HIBM-xB_uFNQLB6eiA9ukBa-1NH','$2y$13$dMjtfLdW7ldmPBh92.Zb5uR2XgjBTkdNDxELrmIazL3vPQk6sa8d.',NULL,'',NULL,NULL,'andre@gmail.com',1,0,1,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(24,'admin','WoQCd2B9bG6vNU2V9oVJB4FaAeV5o9ds','$2y$13$e5K95xkLM/yfiXfxjn69J.xJwi2o6159M9OlpKP29anBi5qvpKXzC',NULL,'','img/avatar.jpg',NULL,'admin@gmail.com',1,10,3,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(25,'super','fLaIUjvVkBLC6jXWgJm_1OCcbfWuVJtd','$2y$13$STa22XfRAlXZk8ZWLviz4u8lCr0hMvnxqno70Ct5oiVy6rrpMtA.u',NULL,'','img/avatar.jpg',NULL,'',1,10,3,'','0000-00-00 00:00:00','0000-00-00 00:00:00');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
