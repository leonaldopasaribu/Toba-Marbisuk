-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 29, 2018 at 06:50 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cis_production`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`cis_db_admin`@`%` PROCEDURE `create_syllabus_by_komposisi_nilai` ()  BEGIN
DECLARE ta_syllabus VARCHAR(10);
declare _id_kur,_kode_mk,_ta,_sem_ta,_kuliah_id,_ta_id varchar(10);
declare rows_count,i, syllabus_count int;
DECLARE curs1 CURSOR FOR SELECT count(a.ta)
FROM `nlai_komposisi_nilai` a
LEFT OUTER JOIN `prkl_kurikulum_syllabus` b
ON a.`kurikulum_syllabus_id` = b.`kurikulum_syllabus_id`
INNER JOIN `krkm_kuliah` c
ON a.`id_kur`=c.`id_kur` AND a.`kode_mk`=c.`kode_mk`
INNER JOIN `mref_r_ta` d
ON a.`ta`=d.`nama`;
DECLARE curs2 cursor for SELECT b.ta,a.id_kur,a.kode_mk,a.ta,a.sem_ta,c.kuliah_id,d.ta_id
FROM `nlai_komposisi_nilai` a
LEFT OUTER JOIN `prkl_kurikulum_syllabus` b
ON a.`kurikulum_syllabus_id` = b.`kurikulum_syllabus_id`
INNER JOIN `krkm_kuliah` c
ON a.`id_kur`=c.`id_kur` AND a.`kode_mk`=c.`kode_mk`
INNER JOIN `mref_r_ta` d
ON a.`ta`=d.`nama`;
open curs1;
	fetch curs1 into rows_count;
close curs1;
open curs2;
Set i=1;
REPEAT
    FETCH curs2 INTO ta_syllabus,_id_kur,_kode_mk,_ta,_sem_ta,_kuliah_id,_ta_id;
    if ta_syllabus is null then
    
	Select count(*) into syllabus_count FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	if syllabus_count=0 then
		insert into `prkl_kurikulum_syllabus` (`id_kur`,`kode_mk`,`ta`,`sem_ta`,`kuliah_id`,`ta_id`) values(_id_kur,_kode_mk,_ta,_sem_ta,_kuliah_id,_ta_id);
	end if;
		
	update `nlai_komposisi_nilai`
	set `kurikulum_syllabus_id`=(select `kurikulum_syllabus_id` from `prkl_kurikulum_syllabus` where `id_kur`=_id_kur and `kode_mk`=_kode_mk and `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	UPDATE `prkl_materi`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	UPDATE `prkl_praktikum`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	UPDATE `nlai_nilai`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	UPDATE `nlai_nilai_praktikum`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	UPDATE `nlai_nilai_quis`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	UPDATE `nlai_nilai_tugas`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	UPDATE `nlai_nilai_uas`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	UPDATE `nlai_nilai_uts`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	UPDATE `nlai_rentang_nilai`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
    end if;
    set i=i+1;
UNTIL i>rows_count END REPEAT;
close curs2;
END$$

CREATE DEFINER=`cis_db_admin`@`%` PROCEDURE `create_syllabus_by_nilai` ()  BEGIN
DECLARE syllabus_id VARCHAR(10);
DECLARE _id_kur,_kode_mk,_ta,_sem_ta,_kuliah_id,_ta_id VARCHAR(10);
DECLARE rows_count,i, syllabus_count INT;
DECLARE curs1 CURSOR FOR SELECT COUNT(a.ta)
FROM `nlai_nilai` a
LEFT OUTER JOIN `krkm_kuliah` c
ON a.`id_kur`=c.`id_kur` AND a.`kode_mk`=c.`kode_mk`
INNER JOIN `mref_r_ta` d
ON a.`ta`=d.`nama`;
DECLARE curs2 CURSOR FOR SELECT a.kurikulum_syllabus_id,a.id_kur,a.kode_mk,a.ta,a.sem_ta,c.kuliah_id,d.ta_id
FROM `nlai_nilai` a
LEFT OUTER JOIN `krkm_kuliah` c
ON a.`id_kur`=c.`id_kur` AND a.`kode_mk`=c.`kode_mk`
INNER JOIN `mref_r_ta` d
ON a.`ta`=d.`nama`;
OPEN curs1;
	FETCH curs1 INTO rows_count;
CLOSE curs1;
OPEN curs2;
SET i=1;
REPEAT
    FETCH curs2 INTO syllabus_id,_id_kur,_kode_mk,_ta,_sem_ta,_kuliah_id,_ta_id;
    IF syllabus_id IS NULL THEN
    
	SELECT COUNT(*) INTO syllabus_count FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	IF syllabus_count=0 THEN
		INSERT INTO `prkl_kurikulum_syllabus` (`id_kur`,`kode_mk`,`ta`,`sem_ta`,`kuliah_id`,`ta_id`) VALUES(_id_kur,_kode_mk,_ta,_sem_ta,_kuliah_id,_ta_id);
	END IF;
			
	UPDATE `nlai_nilai`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	
	UPDATE `nlai_rentang_nilai`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
    END IF;
    SET i=i+1;
UNTIL i>rows_count END REPEAT;
CLOSE curs2;
END$$

CREATE DEFINER=`cis_db_admin`@`%` PROCEDURE `create_syllabus_by_prkl_materi` ()  BEGIN
DECLARE syllabus_id VARCHAR(10);
DECLARE _id_kur,_kode_mk,_ta,_sem,_kuliah_id,_ta_id VARCHAR(10);
DECLARE rows_count,i, syllabus_count,_sem_ta INT;
DECLARE curs1 CURSOR FOR SELECT COUNT(a.ta)
FROM `prkl_materi` a
LEFT OUTER JOIN `krkm_kuliah` c
ON a.`id_kur`=c.`id_kur` AND a.`kode_mk`=c.`kode_mk`
INNER JOIN `mref_r_ta` d
ON a.`ta`=d.`nama`;
DECLARE curs2 CURSOR FOR SELECT a.`kurikulum_syllabus_id`,a.id_kur,a.kode_mk,a.ta,c.sem,c.kuliah_id,d.ta_id
FROM `prkl_materi` a
LEFT OUTER JOIN `krkm_kuliah` c
ON a.`id_kur`=c.`id_kur` AND a.`kode_mk`=c.`kode_mk`
INNER JOIN `mref_r_ta` d
ON a.`ta`=d.`nama`;
OPEN curs1;
	FETCH curs1 INTO rows_count;
CLOSE curs1;
OPEN curs2;
SET i=1;
REPEAT
    FETCH curs2 INTO syllabus_id,_id_kur,_kode_mk,_ta,_sem,_kuliah_id,_ta_id;
    IF syllabus_id IS NULL THEN
    
	SELECT COUNT(*) INTO syllabus_count FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	IF (_sem MOD 2)=0 THEN
		SET _sem_ta=2;
	ELSE
		SET _sem_ta=1;
	END IF;
	
	
	IF syllabus_count=0 THEN
		INSERT INTO `prkl_kurikulum_syllabus` (`id_kur`,`kode_mk`,`ta`,`sem_ta`,`kuliah_id`,`ta_id`) VALUES(_id_kur,_kode_mk,_ta,_sem_ta,_kuliah_id,_ta_id);
	END IF;
		
	UPDATE `prkl_materi`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
    END IF;
    SET i=i+1;
UNTIL i>rows_count END REPEAT;
CLOSE curs2;
END$$

CREATE DEFINER=`cis_db_admin`@`%` PROCEDURE `create_syllabus_by_prkl_praktikum` ()  BEGIN
DECLARE syllabus_id VARCHAR(10);
DECLARE _id_kur,_kode_mk,_ta,_sem,_kuliah_id,_ta_id VARCHAR(10);
DECLARE rows_count,i, syllabus_count,_sem_ta INT;
DECLARE curs1 CURSOR FOR SELECT COUNT(a.ta)
FROM `prkl_praktikum` a
LEFT OUTER JOIN `krkm_kuliah` c
ON a.`id_kur`=c.`id_kur` AND a.`kode_mk`=c.`kode_mk`
INNER JOIN `mref_r_ta` d
ON a.`ta`=d.`nama`;
DECLARE curs2 CURSOR FOR SELECT a.`kurikulum_syllabus_id`,a.id_kur,a.kode_mk,a.ta,c.sem,c.kuliah_id,d.ta_id
FROM `prkl_praktikum` a
LEFT OUTER JOIN `krkm_kuliah` c
ON a.`id_kur`=c.`id_kur` AND a.`kode_mk`=c.`kode_mk`
INNER JOIN `mref_r_ta` d
ON a.`ta`=d.`nama`;
OPEN curs1;
	FETCH curs1 INTO rows_count;
CLOSE curs1;
OPEN curs2;
SET i=1;
REPEAT
    FETCH curs2 INTO syllabus_id,_id_kur,_kode_mk,_ta,_sem,_kuliah_id,_ta_id;
    IF syllabus_id IS NULL THEN
    
	SELECT COUNT(*) INTO syllabus_count FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
	IF (_sem MOD 2)=0 THEN
		SET _sem_ta=2;
	ELSE
		SET _sem_ta=1;
	END IF;
	
	
	IF syllabus_count=0 THEN
		INSERT INTO `prkl_kurikulum_syllabus` (`id_kur`,`kode_mk`,`ta`,`sem_ta`,`kuliah_id`,`ta_id`) VALUES(_id_kur,_kode_mk,_ta,_sem_ta,_kuliah_id,_ta_id);
	END IF;
		
	UPDATE `prkl_praktikum`
	SET `kurikulum_syllabus_id`=(SELECT `kurikulum_syllabus_id` FROM `prkl_kurikulum_syllabus` WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta)
	WHERE `id_kur`=_id_kur AND `kode_mk`=_kode_mk AND `ta`=_ta;
    END IF;
    SET i=i+1;
UNTIL i>rows_count END REPEAT;
CLOSE curs2;
END$$

CREATE DEFINER=`cis_db_admin`@`%` PROCEDURE `migrate_data_to_kuliah_prodi` ()  BEGIN
DECLARE _kuliah_id, _ref_kbk_id, _sem INT;
DECLARE krkm_kuliah_count, i, j, max_prodi INT;
DECLARE curs_krkm_kuliah CURSOR FOR SELECT `kuliah_id`, `ref_kbk_id`, `sem` FROM `krkm_kuliah`;
DECLARE curs_krkm_kuliah_count CURSOR FOR SELECT COUNT(*) FROM `krkm_kuliah`;
OPEN curs_krkm_kuliah_count;
	FETCH curs_krkm_kuliah_count INTO krkm_kuliah_count;
CLOSE curs_krkm_kuliah_count;
OPEN curs_krkm_kuliah;
	SET i=1;
	REPEAT
	FETCH curs_krkm_kuliah INTO _kuliah_id, _ref_kbk_id, _sem;
	IF _ref_kbk_id=11 THEN
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 1, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 2, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 3, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 4, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 5, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 6, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 7, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 8, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 9, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 10, _sem);
	ELSEIF _ref_kbk_id=12 THEN
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 1, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 2, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 3, _sem);
	ELSEIF _ref_kbk_id=13 THEN
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 4, _sem);
	ELSEIF _ref_kbk_id=14 THEN
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 6, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 7, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 8, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 9, _sem);
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, 10, _sem);
	ELSE
		INSERT INTO `krkm_kuliah_prodi` (`kuliah_id`, `ref_kbk_id`, `sem`) VALUES (_kuliah_id, _ref_kbk_id, _sem);
	END IF;
	SET i=i+1;
	UNTIL i>krkm_kuliah_count END REPEAT;
CLOSE curs_krkm_kuliah;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `absn_absensi`
--

CREATE TABLE `absn_absensi` (
  `absensi_id` int(11) NOT NULL,
  `sesi_kuliah_id` int(11) NOT NULL,
  `dim_id` int(11) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `absn_sesi_kuliah`
--

CREATE TABLE `absn_sesi_kuliah` (
  `sesi_kuliah_id` int(11) NOT NULL,
  `penugasan_pengajaran_id` int(11) NOT NULL,
  `lokasi_id` int(11) NOT NULL,
  `sesi` char(1) NOT NULL,
  `waktu_mulai` datetime DEFAULT NULL,
  `waktu_akhir` datetime DEFAULT NULL,
  `catatan` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adak_kelas`
--

CREATE TABLE `adak_kelas` (
  `kelas_id` int(11) NOT NULL,
  `ta` int(4) NOT NULL DEFAULT '0',
  `nama` varchar(20) NOT NULL DEFAULT '',
  `ket` text,
  `dosen_wali_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adak_mahasiswa_assistant`
--

CREATE TABLE `adak_mahasiswa_assistant` (
  `mahasiswa_assistant_id` int(11) NOT NULL,
  `pengajaran_id` int(11) DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `is_fulltime` tinyint(1) DEFAULT '1',
  `start_date` date DEFAULT '0000-00-00',
  `end_date` date DEFAULT '0000-00-00',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adak_pengajaran`
--

CREATE TABLE `adak_pengajaran` (
  `pengajaran_id` int(11) NOT NULL,
  `kuliah_id` int(11) DEFAULT NULL,
  `ta` int(11) DEFAULT NULL,
  `sem_ta` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adak_penugasan_pengajaran`
--

CREATE TABLE `adak_penugasan_pengajaran` (
  `penugasan_pengajaran_id` int(11) NOT NULL,
  `pengajaran_id` int(11) DEFAULT NULL,
  `pegawai_id` int(11) DEFAULT NULL,
  `role_pengajar_id` int(11) NOT NULL,
  `is_fulltime` tinyint(1) DEFAULT '1',
  `start_date` date DEFAULT '0000-00-00',
  `end_date` date DEFAULT '0000-00-00',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adak_registrasi`
--

CREATE TABLE `adak_registrasi` (
  `registrasi_id` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `status_akhir_registrasi` varchar(50) DEFAULT 'Aktif',
  `ta` varchar(30) NOT NULL DEFAULT '0',
  `sem_ta` int(11) NOT NULL DEFAULT '0',
  `sem` smallint(6) NOT NULL DEFAULT '0',
  `tgl_daftar` date DEFAULT NULL,
  `keuangan` double DEFAULT NULL,
  `kelas` varchar(20) DEFAULT NULL,
  `id` varchar(20) DEFAULT NULL,
  `nr` float DEFAULT NULL,
  `koa_approval` int(11) NOT NULL DEFAULT '0',
  `koa_approval_bp` int(11) NOT NULL DEFAULT '0',
  `kelas_id` int(11) DEFAULT NULL,
  `dosen_wali_id` int(11) DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `arsp_arsip`
--

CREATE TABLE `arsp_arsip` (
  `arsip_id` int(11) NOT NULL,
  `judul` varchar(100) DEFAULT NULL,
  `desc` text,
  `user_id` int(11) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `arsp_arsip_file`
--

CREATE TABLE `arsp_arsip_file` (
  `arsip_file_id` int(11) NOT NULL,
  `nama_file` varchar(100) DEFAULT NULL,
  `kode_file` varchar(50) DEFAULT NULL,
  `desc` text,
  `arsip_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `artk_post`
--

CREATE TABLE `artk_post` (
  `post_id` int(11) NOT NULL,
  `title` varchar(225) DEFAULT NULL,
  `body` text,
  `user_id` int(11) DEFAULT NULL,
  `category` varchar(150) DEFAULT NULL,
  `in_category` varchar(50) DEFAULT 'home',
  `public_status` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `artk_post_attachment`
--

CREATE TABLE `artk_post_attachment` (
  `post_attachment_id` int(11) NOT NULL,
  `post_id` int(11) DEFAULT NULL,
  `id_file` varchar(100) DEFAULT NULL,
  `nama_file` varchar(150) DEFAULT NULL,
  `keterangan` varchar(150) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dimx_alumni`
--

CREATE TABLE `dimx_alumni` (
  `alumni_id` int(11) NOT NULL,
  `ta` int(11) NOT NULL DEFAULT '0',
  `sem` int(11) NOT NULL DEFAULT '0',
  `nim` varchar(8) NOT NULL DEFAULT '',
  `status` varchar(50) NOT NULL DEFAULT '',
  `tanggal_lulus` date DEFAULT NULL,
  `sks_lulus` int(11) DEFAULT NULL,
  `ipk_lulus` float DEFAULT NULL,
  `no_sk_yudisium` varchar(30) DEFAULT NULL,
  `tanggal_sk` date DEFAULT NULL,
  `no_ijazah` varchar(40) DEFAULT NULL,
  `no_transkrip` varchar(255) NOT NULL DEFAULT '',
  `predikat_lulus` varchar(100) NOT NULL DEFAULT '',
  `judul_ta` text NOT NULL,
  `pembimbing1` varchar(20) DEFAULT NULL,
  `pembimbing2` varchar(20) DEFAULT NULL,
  `dosen_id_1` int(11) DEFAULT NULL,
  `dosen_id_2` int(11) DEFAULT NULL,
  `dim_id` int(11) NOT NULL,
  `n_toefl` int(11) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dimx_alumni_data`
--

CREATE TABLE `dimx_alumni_data` (
  `alumni_data_id` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `alamat` varchar(100) NOT NULL DEFAULT '',
  `kota` varchar(255) DEFAULT NULL,
  `propinsi` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL DEFAULT '',
  `hp` varchar(20) NOT NULL DEFAULT '',
  `telepon` varchar(20) DEFAULT NULL,
  `alumni_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dimx_alumni_pekerjaan`
--

CREATE TABLE `dimx_alumni_pekerjaan` (
  `alumni_pekerjaan_id` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `tgl_start` date NOT NULL,
  `tgl_end` date DEFAULT NULL,
  `nama_perusahaan` varchar(200) NOT NULL DEFAULT '',
  `alamat_perusahaan` varchar(255) DEFAULT NULL,
  `bidang_perusahaan` varchar(255) DEFAULT NULL,
  `bidang_pekerjaan` varchar(100) NOT NULL DEFAULT '',
  `gaji` varchar(100) DEFAULT NULL,
  `alumni_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dimx_dim`
--

CREATE TABLE `dimx_dim` (
  `dim_id` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `no_usm` varchar(15) NOT NULL DEFAULT '',
  `jalur` varchar(20) DEFAULT NULL,
  `user_name` varchar(10) DEFAULT NULL,
  `kbk_id` varchar(20) DEFAULT NULL,
  `ref_kbk_id` int(11) DEFAULT NULL,
  `kpt_prodi` varchar(10) DEFAULT NULL,
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `tahun_kurikulum_id` int(11) DEFAULT NULL,
  `nama` varchar(50) NOT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `tempat_lahir` varchar(50) DEFAULT NULL,
  `gol_darah` char(2) DEFAULT NULL,
  `golongan_darah_id` int(11) DEFAULT NULL,
  `jenis_kelamin` char(1) DEFAULT NULL,
  `jenis_kelamin_id` int(11) DEFAULT NULL,
  `agama` varchar(30) DEFAULT NULL,
  `agama_id` int(11) DEFAULT NULL,
  `alamat` text,
  `kabupaten` varchar(50) DEFAULT NULL,
  `kode_pos` varchar(5) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telepon` varchar(50) DEFAULT NULL,
  `hp` varchar(50) DEFAULT NULL,
  `hp2` varchar(50) DEFAULT NULL,
  `no_ijazah_sma` varchar(100) DEFAULT NULL,
  `nama_sma` varchar(50) DEFAULT NULL,
  `asal_sekolah_id` int(11) DEFAULT NULL,
  `alamat_sma` text,
  `kabupaten_sma` varchar(100) DEFAULT NULL,
  `telepon_sma` varchar(50) DEFAULT NULL,
  `kodepos_sma` varchar(8) DEFAULT NULL,
  `thn_masuk` int(11) DEFAULT NULL,
  `status_akhir` varchar(50) DEFAULT 'Aktif',
  `nama_ayah` varchar(50) DEFAULT NULL,
  `nama_ibu` varchar(50) DEFAULT NULL,
  `no_hp_ayah` varchar(50) DEFAULT NULL,
  `no_hp_ibu` varchar(50) DEFAULT NULL,
  `alamat_orangtua` text,
  `pekerjaan_ayah` varchar(100) DEFAULT NULL,
  `pekerjaan_ayah_id` int(11) DEFAULT NULL,
  `keterangan_pekerjaan_ayah` text,
  `penghasilan_ayah` varchar(50) DEFAULT NULL,
  `penghasilan_ayah_id` int(11) DEFAULT NULL,
  `pekerjaan_ibu` varchar(100) DEFAULT NULL,
  `pekerjaan_ibu_id` int(11) DEFAULT NULL,
  `keterangan_pekerjaan_ibu` text,
  `penghasilan_ibu` varchar(50) DEFAULT NULL,
  `penghasilan_ibu_id` int(11) DEFAULT NULL,
  `nama_wali` varchar(50) DEFAULT NULL,
  `pekerjaan_wali` varchar(50) DEFAULT NULL,
  `pekerjaan_wali_id` int(11) DEFAULT NULL,
  `keterangan_pekerjaan_wali` text,
  `penghasilan_wali` varchar(50) DEFAULT NULL,
  `penghasilan_wali_id` int(11) DEFAULT NULL,
  `alamat_wali` text,
  `telepon_wali` varchar(20) DEFAULT NULL,
  `no_hp_wali` varchar(50) DEFAULT NULL,
  `pendapatan` varchar(50) DEFAULT NULL,
  `ipk` float DEFAULT '0',
  `anak_ke` tinyint(4) DEFAULT NULL,
  `dari_jlh_anak` tinyint(4) DEFAULT NULL,
  `jumlah_tanggungan` tinyint(4) DEFAULT NULL,
  `nilai_usm` float DEFAULT NULL,
  `score_iq` tinyint(4) DEFAULT NULL,
  `rekomendasi_psikotest` varchar(4) DEFAULT NULL,
  `foto` varchar(50) DEFAULT NULL,
  `kode_foto` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dimx_dim_pmb`
--

CREATE TABLE `dimx_dim_pmb` (
  `dim_pmb_id` int(11) NOT NULL,
  `no_umpid` varchar(9) NOT NULL DEFAULT '',
  `tahun_ujian` int(11) NOT NULL DEFAULT '2004',
  `nim` varchar(8) DEFAULT NULL,
  `user_name` varchar(7) DEFAULT NULL,
  `kbk_id` varchar(20) DEFAULT 'N/A',
  `nama` varchar(50) NOT NULL DEFAULT '',
  `tgl_lahir` date DEFAULT NULL,
  `tempat_lahir` varchar(50) DEFAULT NULL,
  `gol_darah` char(2) DEFAULT NULL,
  `jenis_kelamin` char(1) DEFAULT NULL,
  `agama` varchar(30) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `kabupaten` varchar(50) DEFAULT NULL,
  `kode_pos` varchar(5) DEFAULT NULL,
  `telepon` varchar(15) DEFAULT NULL,
  `hp` varchar(20) DEFAULT NULL,
  `nama_sma` varchar(50) DEFAULT NULL,
  `no_ijazah_sma` varchar(100) DEFAULT NULL,
  `alamat_sma` varchar(100) DEFAULT NULL,
  `kabupaten_sma` varchar(100) DEFAULT NULL,
  `kodepos_sma` varchar(8) DEFAULT NULL,
  `telepon_sma` varchar(50) DEFAULT NULL,
  `thn_masuk` int(11) DEFAULT NULL,
  `status_akhir` char(1) DEFAULT NULL,
  `nama_ayah` varchar(50) DEFAULT NULL,
  `nama_ibu` varchar(50) DEFAULT NULL,
  `pekerjaan_ayah` varchar(100) DEFAULT NULL,
  `pekerjaan_ibu` varchar(100) DEFAULT NULL,
  `nama_wali` varchar(50) DEFAULT NULL,
  `pekerjaan_wali` varchar(50) DEFAULT NULL,
  `alamat_wali` varchar(200) DEFAULT NULL,
  `telepon_wali` varchar(20) DEFAULT NULL,
  `pendapatan` varchar(50) DEFAULT NULL,
  `ipk` float DEFAULT NULL,
  `foto` longblob,
  `tgl_daftar_s` date DEFAULT NULL,
  `tgl_daftar_e` date DEFAULT NULL,
  `status_daftar` varchar(10) DEFAULT NULL,
  `n_pembangunan` int(11) DEFAULT NULL,
  `jumlah_pembangunan` bigint(20) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dimx_dim_pmb_daftar`
--

CREATE TABLE `dimx_dim_pmb_daftar` (
  `dim_pmb_daftar_id` int(11) NOT NULL,
  `no_umpid` varchar(9) NOT NULL DEFAULT '',
  `nim` varchar(8) DEFAULT NULL,
  `tgl_daftar` datetime DEFAULT NULL,
  `biaya_bayar` double DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` varchar(45) DEFAULT NULL,
  `updated_at` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dimx_dim_trnon_lulus`
--

CREATE TABLE `dimx_dim_trnon_lulus` (
  `dim_trnon_lulus_id` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `sem_ta` tinyint(4) NOT NULL DEFAULT '0',
  `ta` int(11) NOT NULL DEFAULT '0',
  `status_akhir` varchar(50) NOT NULL DEFAULT 'Mengundurkan Diri',
  `periode_start` date DEFAULT NULL,
  `periode_end` date DEFAULT NULL,
  `no_sk` varchar(255) DEFAULT NULL,
  `tanggal_sk` date DEFAULT NULL,
  `keterangan` text,
  `dim_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dimx_dim_update`
--

CREATE TABLE `dimx_dim_update` (
  `dim_id` int(11) NOT NULL,
  `nim` varchar(8) DEFAULT NULL,
  `no_usm` varchar(15) DEFAULT NULL,
  `jalur` varchar(20) DEFAULT NULL,
  `user_name` varchar(10) DEFAULT NULL,
  `kbk_id` varchar(20) DEFAULT NULL,
  `ref_kbk_id` int(11) DEFAULT NULL,
  `kpt_prodi` varchar(10) DEFAULT NULL,
  `id_kur` int(4) DEFAULT '0',
  `tahun_kurikulum_id` int(11) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `tempat_lahir` varchar(50) DEFAULT NULL,
  `gol_darah` char(2) DEFAULT NULL,
  `golongan_darah_id` int(11) DEFAULT NULL,
  `jenis_kelamin` char(1) DEFAULT NULL,
  `jenis_kelamin_id` int(11) DEFAULT NULL,
  `agama` varchar(30) DEFAULT NULL,
  `agama_id` int(11) DEFAULT NULL,
  `alamat` text,
  `kabupaten` varchar(50) DEFAULT NULL,
  `kode_pos` varchar(5) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telepon` varchar(50) DEFAULT NULL,
  `hp` varchar(50) DEFAULT NULL,
  `hp2` varchar(50) DEFAULT NULL,
  `no_ijazah_sma` varchar(100) DEFAULT NULL,
  `nama_sma` varchar(50) DEFAULT NULL,
  `asal_sekolah_id` int(11) DEFAULT NULL,
  `alamat_sma` text,
  `kabupaten_sma` varchar(100) DEFAULT NULL,
  `telepon_sma` varchar(50) DEFAULT NULL,
  `kodepos_sma` varchar(8) DEFAULT NULL,
  `thn_masuk` int(11) DEFAULT NULL,
  `status_akhir` varchar(50) DEFAULT NULL,
  `nama_ayah` varchar(50) DEFAULT NULL,
  `nama_ibu` varchar(50) DEFAULT NULL,
  `no_hp_ayah` varchar(50) DEFAULT NULL,
  `no_hp_ibu` varchar(50) DEFAULT NULL,
  `alamat_orangtua` text,
  `pekerjaan_ayah` varchar(100) DEFAULT NULL,
  `pekerjaan_ayah_id` int(11) DEFAULT NULL,
  `keterangan_pekerjaan_ayah` text,
  `penghasilan_ayah` varchar(50) DEFAULT NULL,
  `penghasilan_ayah_id` int(11) DEFAULT NULL,
  `pekerjaan_ibu` varchar(100) DEFAULT NULL,
  `pekerjaan_ibu_id` int(11) DEFAULT NULL,
  `keterangan_pekerjaan_ibu` text,
  `penghasilan_ibu` varchar(50) DEFAULT NULL,
  `penghasilan_ibu_id` int(11) DEFAULT NULL,
  `nama_wali` varchar(50) DEFAULT NULL,
  `pekerjaan_wali` varchar(50) DEFAULT NULL,
  `pekerjaan_wali_id` int(11) DEFAULT NULL,
  `keterangan_pekerjaan_wali` text,
  `penghasilan_wali` varchar(50) DEFAULT NULL,
  `penghasilan_wali_id` int(11) DEFAULT NULL,
  `alamat_wali` text,
  `telepon_wali` varchar(20) DEFAULT NULL,
  `no_hp_wali` varchar(50) DEFAULT NULL,
  `pendapatan` varchar(50) DEFAULT NULL,
  `ipk` float DEFAULT '0',
  `anak_ke` tinyint(4) DEFAULT NULL,
  `dari_jlh_anak` tinyint(4) DEFAULT NULL,
  `jumlah_tanggungan` tinyint(4) DEFAULT NULL,
  `nilai_usm` float DEFAULT NULL,
  `score_iq` tinyint(4) DEFAULT NULL,
  `rekomendasi_psikotest` varchar(4) DEFAULT NULL,
  `foto` varchar(50) DEFAULT NULL,
  `kode_foto` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dimx_histori_prodi`
--

CREATE TABLE `dimx_histori_prodi` (
  `histori_prodi_id` int(11) NOT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `nim_old` varchar(8) DEFAULT NULL,
  `ref_kbk_id_old` int(11) DEFAULT NULL,
  `username_old` varchar(20) DEFAULT NULL,
  `email_old` varchar(30) DEFAULT NULL,
  `tahun_pindah` varchar(4) NOT NULL,
  `sem_ta_pindah` int(11) NOT NULL,
  `tgl_pindah` date NOT NULL,
  `nim_new` varchar(8) NOT NULL,
  `ref_kbk_id_new` int(11) NOT NULL,
  `username_new` varchar(20) NOT NULL,
  `email_new` varchar(30) NOT NULL,
  `kelas_new` int(11) DEFAULT NULL,
  `wali_new` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hrdx_dosen`
--

CREATE TABLE `hrdx_dosen` (
  `dosen_id` int(11) NOT NULL,
  `pegawai_id` int(11) DEFAULT NULL,
  `nidn` varchar(10) DEFAULT NULL,
  `prodi_id` int(11) DEFAULT NULL,
  `golongan_kepangkatan_id` int(11) DEFAULT NULL,
  `jabatan_akademik_id` int(11) DEFAULT NULL,
  `status_ikatan_kerja_dosen_id` int(11) DEFAULT NULL,
  `gbk_1` int(11) DEFAULT NULL,
  `gbk_2` int(11) DEFAULT NULL,
  `aktif_start` date DEFAULT '0000-00-00',
  `aktif_end` date DEFAULT '0000-00-00',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `temp_id_old` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hrdx_pegawai`
--

CREATE TABLE `hrdx_pegawai` (
  `pegawai_id` int(11) NOT NULL,
  `profile_old_id` varchar(20) DEFAULT NULL,
  `nama` varchar(135) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `nip` varchar(45) DEFAULT NULL,
  `kpt_no` varchar(10) DEFAULT NULL,
  `kbk_id` varchar(20) DEFAULT NULL,
  `ref_kbk_id` int(11) DEFAULT NULL,
  `alias` varchar(9) DEFAULT NULL,
  `posisi` varchar(100) DEFAULT NULL,
  `tempat_lahir` varchar(60) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `agama_id` int(11) DEFAULT NULL,
  `jenis_kelamin_id` int(11) DEFAULT NULL,
  `golongan_darah_id` int(11) DEFAULT NULL,
  `hp` varchar(20) DEFAULT NULL,
  `telepon` varchar(45) DEFAULT NULL,
  `alamat` blob,
  `alamat_libur` varchar(100) DEFAULT NULL,
  `kecamatan` varchar(150) DEFAULT NULL,
  `kota` varchar(50) DEFAULT NULL,
  `kabupaten_id` int(11) DEFAULT NULL,
  `kode_pos` varchar(15) DEFAULT NULL,
  `no_ktp` varchar(255) DEFAULT NULL,
  `email` text,
  `ext_num` char(3) DEFAULT NULL,
  `study_area_1` varchar(50) DEFAULT NULL,
  `study_area_2` varchar(50) DEFAULT NULL,
  `jabatan` char(1) DEFAULT NULL,
  `jabatan_akademik_id` int(11) DEFAULT NULL,
  `gbk_1` int(11) DEFAULT NULL,
  `gbk_2` int(11) DEFAULT NULL,
  `status_ikatan_kerja_pegawai_id` int(11) DEFAULT NULL,
  `status_akhir` char(1) DEFAULT NULL,
  `status_aktif_pegawai_id` int(11) DEFAULT NULL,
  `tanggal_masuk` date DEFAULT '0000-00-00',
  `tanggal_keluar` date DEFAULT '0000-00-00',
  `nama_bapak` varchar(50) DEFAULT NULL,
  `nama_ibu` varchar(50) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `status_marital_id` int(11) DEFAULT NULL,
  `nama_p` varchar(50) DEFAULT NULL,
  `tgl_lahir_p` date DEFAULT NULL,
  `tmp_lahir_p` varchar(50) DEFAULT NULL,
  `pekerjaan_ortu` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hrdx_pendidikan`
--

CREATE TABLE `hrdx_pendidikan` (
  `pendidikan_id` int(11) NOT NULL,
  `id` varchar(20) NOT NULL DEFAULT '',
  `no` int(11) NOT NULL,
  `jenjang` varchar(40) DEFAULT NULL,
  `gelar` varchar(10) DEFAULT NULL,
  `universitas` varchar(100) DEFAULT NULL,
  `progdi` varchar(200) DEFAULT NULL,
  `bidang` varchar(200) DEFAULT NULL,
  `thn_masuk` date DEFAULT NULL,
  `thn_lulus` date DEFAULT NULL,
  `judul_ta` varchar(255) DEFAULT NULL,
  `ipk` float DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hrdx_pengajar`
--

CREATE TABLE `hrdx_pengajar` (
  `pengajar_id` int(11) NOT NULL,
  `ta` int(4) NOT NULL DEFAULT '0',
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `kode_mk` varchar(11) NOT NULL,
  `id` varchar(20) NOT NULL,
  `role` char(1) NOT NULL DEFAULT '',
  `kurikulum_id` int(11) DEFAULT NULL,
  `pegawai_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hrdx_profile`
--

CREATE TABLE `hrdx_profile` (
  `profile_id` int(11) NOT NULL,
  `id` varchar(20) NOT NULL DEFAULT '',
  `nip` varchar(20) NOT NULL DEFAULT '',
  `kpt_no` varchar(10) NOT NULL DEFAULT '',
  `user_name` varchar(20) DEFAULT NULL,
  `nama` varchar(50) NOT NULL DEFAULT '',
  `posisi` varchar(100) DEFAULT NULL,
  `alias` varchar(5) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `tempat_lahir` varchar(50) DEFAULT NULL,
  `jenis_kelamin` char(1) NOT NULL DEFAULT '',
  `gol_darah` char(2) DEFAULT NULL,
  `tgl_masuk` date DEFAULT NULL,
  `tgl_keluar` date NOT NULL,
  `agama` varchar(30) DEFAULT NULL,
  `kbk_id` varchar(20) DEFAULT NULL,
  `ext_num` char(3) DEFAULT NULL,
  `hp` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `alamat_libur` varchar(100) DEFAULT NULL,
  `kota` varchar(50) DEFAULT NULL,
  `kode_pos` varchar(5) DEFAULT NULL,
  `telepon` varchar(15) DEFAULT NULL,
  `ktp` varchar(255) DEFAULT NULL,
  `pendidikan` varchar(255) DEFAULT NULL,
  `jabatan` varchar(20) NOT NULL DEFAULT '',
  `pendidikan_tertinggi` varchar(20) NOT NULL DEFAULT 'S1',
  `study_area1` varchar(50) NOT NULL DEFAULT '',
  `study_area2` varchar(50) NOT NULL DEFAULT '',
  `status` char(1) NOT NULL DEFAULT 'S',
  `nama_bapak` varchar(50) DEFAULT NULL,
  `nama_ibu` varchar(50) DEFAULT NULL,
  `pekerjaan_ortu` varchar(100) DEFAULT NULL,
  `nama_p` varchar(50) DEFAULT NULL,
  `tmp_lahir_p` varchar(50) DEFAULT NULL,
  `tgl_lahir_p` date NOT NULL,
  `ket` text NOT NULL,
  `status_akhir` varchar(5) NOT NULL DEFAULT 'A',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hrdx_riwayat_pendidikan`
--

CREATE TABLE `hrdx_riwayat_pendidikan` (
  `riwayat_pendidikan_id` int(11) NOT NULL,
  `jenjang_id` int(11) DEFAULT NULL,
  `universitas` varchar(100) DEFAULT NULL,
  `jurusan` varchar(200) DEFAULT NULL,
  `thn_mulai` varchar(50) DEFAULT NULL,
  `thn_selesai` varchar(50) DEFAULT NULL,
  `ipk` varchar(15) DEFAULT NULL,
  `gelar` varchar(15) DEFAULT NULL,
  `judul_ta` varchar(255) DEFAULT NULL,
  `pegawai_id` int(11) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `jenjang` varchar(40) DEFAULT NULL,
  `id_old` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hrdx_riwayat_pendidikan_old`
--

CREATE TABLE `hrdx_riwayat_pendidikan_old` (
  `riwayat_pendidikan_id` int(11) DEFAULT NULL,
  `jenjang_id` int(11) DEFAULT NULL,
  `universitas` varchar(180) DEFAULT NULL,
  `jurusan` varchar(150) DEFAULT NULL,
  `thn_mulai` varchar(150) DEFAULT NULL,
  `thn_selesai` varchar(150) DEFAULT NULL,
  `ipk` varchar(15) DEFAULT NULL,
  `gelar` varchar(15) DEFAULT NULL,
  `dosen_id` int(11) DEFAULT NULL,
  `staf_id` int(11) DEFAULT NULL,
  `judul_ta` blob,
  `website` varchar(765) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(96) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(96) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(96) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hrdx_r_staf_role`
--

CREATE TABLE `hrdx_r_staf_role` (
  `staf_role_id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hrdx_staf`
--

CREATE TABLE `hrdx_staf` (
  `staf_id` int(11) NOT NULL,
  `pegawai_id` int(11) DEFAULT NULL,
  `prodi_id` int(11) DEFAULT NULL,
  `staf_role_id` int(11) DEFAULT NULL,
  `aktif_start` date DEFAULT '0000-00-00',
  `aktif_end` date DEFAULT '0000-00-00',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `temp_id_old` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inst_instansi`
--

CREATE TABLE `inst_instansi` (
  `instansi_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `inisial` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varbinary(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inst_pejabat`
--

CREATE TABLE `inst_pejabat` (
  `pejabat_id` int(11) NOT NULL,
  `pegawai_id` int(11) DEFAULT NULL,
  `struktur_jabatan_id` int(11) DEFAULT NULL,
  `awal_masa_kerja` date DEFAULT NULL,
  `akhir_masa_kerja` date DEFAULT NULL,
  `no_sk` varchar(45) DEFAULT NULL,
  `file_sk` text,
  `kode_file` varchar(200) DEFAULT NULL,
  `status_aktif` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varbinary(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inst_prodi`
--

CREATE TABLE `inst_prodi` (
  `ref_kbk_id` int(11) NOT NULL,
  `kbk_id` varchar(20) DEFAULT NULL,
  `kpt_id` varchar(10) DEFAULT NULL,
  `jenjang_id` int(11) DEFAULT NULL,
  `kbk_ind` varchar(100) DEFAULT NULL,
  `singkatan_prodi` varchar(50) DEFAULT NULL,
  `kbk_ing` varchar(100) DEFAULT NULL,
  `nama_kopertis_ind` varchar(255) DEFAULT NULL,
  `nama_kopertis_ing` varchar(255) DEFAULT NULL,
  `short_desc_ind` varchar(255) DEFAULT NULL,
  `short_desc_ing` varchar(255) DEFAULT NULL,
  `desc_ind` text,
  `desc_ing` text,
  `status` tinyint(1) DEFAULT '1',
  `is_jenjang_all` tinyint(1) DEFAULT '1',
  `is_public` tinyint(1) DEFAULT '1',
  `is_hidden` tinyint(1) DEFAULT '0',
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inst_r_jenjang`
--

CREATE TABLE `inst_r_jenjang` (
  `jenjang_id` int(11) NOT NULL,
  `nama` varchar(15) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inst_struktur_jabatan`
--

CREATE TABLE `inst_struktur_jabatan` (
  `struktur_jabatan_id` int(11) NOT NULL,
  `instansi_id` int(11) DEFAULT NULL,
  `jabatan` varchar(255) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `inisial` varchar(45) DEFAULT NULL,
  `is_multi_tenant` tinyint(1) DEFAULT '0',
  `mata_anggaran` tinyint(1) DEFAULT '0',
  `laporan` tinyint(1) DEFAULT '0',
  `unit_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varbinary(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inst_unit`
--

CREATE TABLE `inst_unit` (
  `unit_id` int(11) NOT NULL,
  `instansi_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `inisial` varchar(45) DEFAULT NULL,
  `desc` text,
  `kepala` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varbinary(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_arsip_vendor`
--

CREATE TABLE `invt_arsip_vendor` (
  `arsip_vendor_id` int(11) NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `judul_arsip` varchar(150) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_barang`
--

CREATE TABLE `invt_barang` (
  `barang_id` int(11) NOT NULL,
  `nama_barang` varchar(200) DEFAULT NULL,
  `serial_number` varchar(100) DEFAULT NULL,
  `jenis_barang_id` int(11) DEFAULT NULL,
  `kategori_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT '0',
  `supplier` varchar(150) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `harga_per_barang` decimal(10,0) DEFAULT NULL,
  `total_harga` decimal(10,0) DEFAULT '0',
  `tanggal_masuk` date DEFAULT NULL,
  `satuan_id` int(11) DEFAULT NULL,
  `desc` text,
  `kapasitas` varchar(50) DEFAULT NULL,
  `nama_file` varchar(200) DEFAULT NULL,
  `kode_file` varchar(200) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_detail_peminjaman_barang`
--

CREATE TABLE `invt_detail_peminjaman_barang` (
  `detail_peminjaman_barang_id` int(11) NOT NULL,
  `peminjaman_barang_id` int(11) DEFAULT NULL,
  `barang_id` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `jumlah_rusak` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_file_vendor`
--

CREATE TABLE `invt_file_vendor` (
  `file_vendor_id` int(11) NOT NULL,
  `arsip_vendor_id` int(11) DEFAULT NULL,
  `nama_file` varchar(250) DEFAULT NULL,
  `kode_file` varchar(250) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_keterangan_pengeluaran`
--

CREATE TABLE `invt_keterangan_pengeluaran` (
  `keterangan_pengeluaran_id` int(11) NOT NULL,
  `tgl_keluar` date NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `keterangan` text NOT NULL,
  `total_barang_keluar` int(11) DEFAULT '0',
  `oleh` int(11) DEFAULT NULL,
  `lokasi_distribusi` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_pelaporan_barang_rusak`
--

CREATE TABLE `invt_pelaporan_barang_rusak` (
  `pelaporan_barang_rusak` int(11) NOT NULL,
  `barang_id` int(11) DEFAULT NULL,
  `kode_barang` varchar(150) DEFAULT NULL,
  `pelapor` int(11) DEFAULT NULL,
  `jumlah_rusak` int(11) DEFAULT '0',
  `tgl_lapor` date DEFAULT NULL,
  `deskripsi` text,
  `nama_file` varchar(200) DEFAULT NULL,
  `status_perbaikan` tinyint(1) DEFAULT '0',
  `tgl_perbaikan` date DEFAULT NULL,
  `kode_file` varchar(200) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_pemindahan_barang`
--

CREATE TABLE `invt_pemindahan_barang` (
  `pemindahan_barang_id` int(11) NOT NULL,
  `pengeluaran_barang_id` int(11) DEFAULT NULL,
  `lokasi_awal_id` int(11) DEFAULT NULL,
  `kode_inventori_awal` varchar(50) DEFAULT NULL,
  `lokasi_akhir_id` int(11) DEFAULT NULL,
  `kode_inventori` varchar(50) DEFAULT NULL,
  `tanggal_pindah` date DEFAULT NULL,
  `oleh` int(11) DEFAULT NULL,
  `status_transaksi` varchar(50) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_peminjaman_barang`
--

CREATE TABLE `invt_peminjaman_barang` (
  `peminjaman_barang_id` int(11) NOT NULL,
  `tgl_pinjam` date DEFAULT NULL,
  `tgl_kembali` date DEFAULT NULL,
  `oleh` int(11) DEFAULT NULL,
  `deskripsi` text,
  `unit_id` int(11) DEFAULT NULL,
  `status_approval` int(1) DEFAULT '0' COMMENT '0: belum; 1:sudah; 2:reject',
  `approved_by` int(11) DEFAULT NULL,
  `status_kembali` tinyint(1) DEFAULT '0',
  `tgl_realisasi_kembali` date DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_pengeluaran_barang`
--

CREATE TABLE `invt_pengeluaran_barang` (
  `pengeluaran_barang_id` int(11) NOT NULL,
  `keterangan_pengeluaran_id` int(11) DEFAULT NULL,
  `barang_id` int(11) DEFAULT NULL,
  `kode_inventori` varchar(120) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT '0',
  `lokasi_id` int(11) DEFAULT NULL,
  `tgl_keluar` date DEFAULT NULL,
  `status_akhir` varchar(50) DEFAULT 'DISTRIBUSI' COMMENT '0:distribusi, 1:pindah, 2: pinjam, 3: rusak, 4: musnah',
  `is_has_pic` tinyint(1) DEFAULT '0' COMMENT '0: no, 1: yes',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varbinary(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_pic_barang`
--

CREATE TABLE `invt_pic_barang` (
  `pic_barang_id` int(11) NOT NULL,
  `pengeluaran_barang_id` int(11) DEFAULT NULL COMMENT 'id distribusi barang',
  `pegawai_id` int(11) DEFAULT NULL COMMENT 'pegawai PIC barang',
  `tgl_assign` date DEFAULT NULL,
  `keterangan` text,
  `is_unassign` tinyint(1) DEFAULT '0',
  `tgl_unassign` date DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_pic_barang_file`
--

CREATE TABLE `invt_pic_barang_file` (
  `pic_barang_file_id` int(11) NOT NULL,
  `nama_file` varchar(250) DEFAULT NULL,
  `kode_file` varchar(250) DEFAULT NULL,
  `pic_barang_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_r_brand`
--

CREATE TABLE `invt_r_brand` (
  `brand_id` int(11) NOT NULL,
  `nama` varchar(200) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_r_jenis_barang`
--

CREATE TABLE `invt_r_jenis_barang` (
  `jenis_barang_id` int(11) NOT NULL,
  `nama` varchar(150) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_r_kategori`
--

CREATE TABLE `invt_r_kategori` (
  `kategori_id` int(11) NOT NULL,
  `nama` varchar(150) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_r_lokasi`
--

CREATE TABLE `invt_r_lokasi` (
  `lokasi_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT '0',
  `nama_lokasi` varchar(50) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_r_satuan`
--

CREATE TABLE `invt_r_satuan` (
  `satuan_id` int(11) NOT NULL,
  `nama` varchar(150) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_r_status`
--

CREATE TABLE `invt_r_status` (
  `status_id` int(11) NOT NULL,
  `nama` varchar(150) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_r_unit`
--

CREATE TABLE `invt_r_unit` (
  `unit_id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_r_vendor`
--

CREATE TABLE `invt_r_vendor` (
  `vendor_id` int(11) NOT NULL,
  `nama` varchar(150) DEFAULT NULL,
  `telp` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `alamat` varchar(150) NOT NULL,
  `link` varchar(250) DEFAULT NULL,
  `contact_person` varchar(200) DEFAULT NULL,
  `telp_contact_person` varchar(15) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_summary_jumlah`
--

CREATE TABLE `invt_summary_jumlah` (
  `summary_jumlah_id` int(11) NOT NULL,
  `barang_id` int(11) NOT NULL,
  `kategori_id` int(11) NOT NULL,
  `total_jumlah` int(11) DEFAULT NULL,
  `jumlah_distribusi` int(11) DEFAULT '0',
  `jumlah_gudang` int(11) DEFAULT '0',
  `jumlah_rusak` int(11) DEFAULT '0',
  `jumlah_pinjam` int(11) DEFAULT '0',
  `jumlah_musnah` int(11) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invt_unit_charged`
--

CREATE TABLE `invt_unit_charged` (
  `unit_charged_id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kmhs_detail_kasus`
--

CREATE TABLE `kmhs_detail_kasus` (
  `detail_kasus_id` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `dim_id` int(11) NOT NULL,
  `tgl_kasus` date NOT NULL,
  `jenis_kasus` varchar(20) NOT NULL DEFAULT '',
  `deskripsi` text,
  `no_form` varchar(20) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kmhs_master_kasus`
--

CREATE TABLE `kmhs_master_kasus` (
  `master_kasus` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `no_sp1` varchar(50) NOT NULL DEFAULT '',
  `tgl_sp1` date NOT NULL,
  `uraian_sp1` text,
  `no_sp2` varchar(50) DEFAULT NULL,
  `tgl_sp2` date DEFAULT NULL,
  `uraian_sp2` text,
  `no_sk` varchar(50) DEFAULT NULL,
  `tgl_sk` date DEFAULT NULL,
  `uraian_sk` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `dim_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kmhs_nilai_perilaku`
--

CREATE TABLE `kmhs_nilai_perilaku` (
  `nilai_perilaku_id` int(11) NOT NULL,
  `ta` varchar(30) NOT NULL,
  `sem_ta` int(11) NOT NULL,
  `bulan` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL,
  `kriteria` varchar(4) NOT NULL,
  `nilai` int(11) DEFAULT NULL,
  `kriteria_nilai_perilaku_id` int(11) DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kmhs_nilai_perilaku_arsip`
--

CREATE TABLE `kmhs_nilai_perilaku_arsip` (
  `nilai_perilaku_arsip_id` int(11) NOT NULL,
  `ta` varchar(30) NOT NULL,
  `sem_ta` int(11) NOT NULL,
  `bulan` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `kriteria` varchar(4) NOT NULL,
  `kriteria_nilai_perilaku_id` int(11) DEFAULT NULL,
  `nilai` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kmhs_nilai_perilaku_as`
--

CREATE TABLE `kmhs_nilai_perilaku_as` (
  `nilai_perilaku_as_id` int(11) NOT NULL,
  `ta` varchar(30) NOT NULL,
  `sem_ta` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL,
  `k1` varchar(11) DEFAULT NULL COMMENT 'Kebersihan Kamar TIdur/Tempat Tidur',
  `k2` varchar(11) DEFAULT NULL COMMENT 'Kerapian Kamar/Tempat Tidur',
  `k3` varchar(11) DEFAULT NULL COMMENT 'Kerapian Almari',
  `k4` varchar(11) DEFAULT NULL COMMENT 'Ketepatan Waktu Keluar/Masuk Kampus',
  `k5` varchar(11) DEFAULT NULL COMMENT 'Ketepatan Waktu Hadir Kuliah',
  `K6` varchar(11) DEFAULT NULL COMMENT 'Kehadiran Saat Makan Pagi',
  `k7` varchar(11) DEFAULT NULL COMMENT 'Kehadiran Saat Makan Siang',
  `k8` varchar(11) DEFAULT NULL COMMENT 'Kehadiran Saat Makan Malam',
  `k9` varchar(11) DEFAULT NULL COMMENT 'Kedisiplinan',
  `k10` varchar(11) DEFAULT NULL COMMENT 'Ketertiban',
  `k11` varchar(11) DEFAULT NULL COMMENT 'Intens Pemanggilan Karena Bermasalah',
  `k12` varchar(11) DEFAULT NULL COMMENT 'Perilaku/Sikap',
  `na` varchar(11) DEFAULT NULL,
  `grade` varchar(2) DEFAULT NULL,
  `catatan` text,
  `dim_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Nilai perilaku akhir semester';

-- --------------------------------------------------------

--
-- Table structure for table `kmhs_nilai_perilaku_summary`
--

CREATE TABLE `kmhs_nilai_perilaku_summary` (
  `nilai_perilaku_summary_id` int(11) NOT NULL,
  `ta` varchar(30) NOT NULL,
  `sem_ta` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `na` int(11) DEFAULT NULL,
  `grade` varchar(2) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kmhs_nilai_perilaku_ts`
--

CREATE TABLE `kmhs_nilai_perilaku_ts` (
  `nilai_perilaku_ts` int(11) NOT NULL,
  `ta` varchar(30) NOT NULL,
  `sem_ta` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL,
  `k1` varchar(11) DEFAULT NULL COMMENT 'Kebersihan',
  `k2` varchar(11) DEFAULT NULL COMMENT 'Kerapian Kamar',
  `k3` varchar(11) DEFAULT NULL COMMENT 'Kerapian Almari',
  `k4` varchar(11) DEFAULT NULL COMMENT 'Ketepatan Waktu Keluar/Masuk Kampus',
  `k5` varchar(11) DEFAULT NULL COMMENT 'Kejujuran',
  `k6` varchar(11) DEFAULT NULL COMMENT 'Kehadiran saat makan pagi',
  `k7` varchar(11) DEFAULT NULL COMMENT 'Kehadiran saat makan siang',
  `k8` varchar(11) DEFAULT NULL COMMENT 'Kehadiran saat makan malam',
  `k9` varchar(11) DEFAULT NULL COMMENT 'Kedisiplinan',
  `k10` varchar(11) DEFAULT NULL COMMENT 'Ketertiban',
  `k11` varchar(11) DEFAULT NULL COMMENT 'Intens',
  `k12` varchar(11) DEFAULT NULL COMMENT 'Perilaku/Sikap',
  `na` int(11) DEFAULT NULL,
  `grade` varchar(2) DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Nilai perilaku tengah semester';

-- --------------------------------------------------------

--
-- Table structure for table `kmhs_r_kasus`
--

CREATE TABLE `kmhs_r_kasus` (
  `ref_kasus_id` int(11) NOT NULL,
  `id_kasus` varchar(20) NOT NULL DEFAULT '',
  `deskripsi` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kmhs_r_kriteria_nilai_perilaku`
--

CREATE TABLE `kmhs_r_kriteria_nilai_perilaku` (
  `kriteria_nilai_perilaku_id` int(11) NOT NULL,
  `kriteria` varchar(4) NOT NULL,
  `deskripsi` varchar(50) NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `krkm_course_group`
--

CREATE TABLE `krkm_course_group` (
  `course_group_id` int(11) NOT NULL,
  `id` varchar(20) NOT NULL DEFAULT '',
  `eng` varchar(255) NOT NULL DEFAULT '',
  `ina` varchar(255) DEFAULT NULL,
  `kpt_kode` varchar(10) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `krkm_kuliah`
--

CREATE TABLE `krkm_kuliah` (
  `kuliah_id` int(11) NOT NULL,
  `id_kur` int(4) NOT NULL DEFAULT '2001',
  `kode_mk` varchar(11) NOT NULL,
  `nama_kul_ind` varchar(255) DEFAULT NULL,
  `nama_kul_ing` varchar(255) DEFAULT NULL,
  `short_name` varchar(20) DEFAULT NULL,
  `kbk_id` varchar(20) DEFAULT '0',
  `course_group` varchar(20) DEFAULT NULL,
  `sks` smallint(6) DEFAULT NULL,
  `sem` smallint(6) DEFAULT NULL,
  `urut_dlm_sem` smallint(6) DEFAULT NULL,
  `sifat` smallint(6) DEFAULT NULL,
  `meetings` varchar(100) DEFAULT NULL,
  `tipe` varchar(25) DEFAULT NULL,
  `level` varchar(15) DEFAULT NULL,
  `key_topics_ind` text,
  `key_topics_ing` text,
  `objektif_ind` text,
  `objektif_ing` text,
  `lab_hour` tinyint(4) DEFAULT NULL,
  `tutorial_hour` tinyint(4) DEFAULT NULL,
  `course_hour` tinyint(4) DEFAULT NULL,
  `course_hour_in_week` tinyint(4) DEFAULT NULL,
  `lab_hour_in_week` tinyint(4) DEFAULT NULL,
  `number_week` tinyint(4) DEFAULT NULL,
  `other_activity` varchar(50) DEFAULT '..............',
  `other_activity_hour` tinyint(4) DEFAULT NULL,
  `knowledge` tinyint(4) DEFAULT NULL,
  `skill` tinyint(4) DEFAULT NULL,
  `attitude` tinyint(4) DEFAULT NULL,
  `uts` tinyint(4) DEFAULT NULL,
  `uas` tinyint(4) DEFAULT NULL,
  `tugas` tinyint(4) DEFAULT NULL,
  `quiz` tinyint(4) DEFAULT NULL,
  `whiteboard` char(1) DEFAULT NULL,
  `lcd` char(1) DEFAULT NULL,
  `courseware` char(1) DEFAULT NULL,
  `lab` char(1) DEFAULT NULL,
  `elearning` char(1) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `prerequisites` text,
  `course_description` text,
  `course_objectives` text,
  `learning_outcomes` text,
  `course_format` text,
  `grading_procedure` text,
  `course_content` text,
  `ref_kbk_id` int(11) DEFAULT NULL,
  `course_group_id` int(11) DEFAULT NULL,
  `tahun_kurikulum_id` int(11) DEFAULT NULL,
  `web_page` varchar(150) DEFAULT NULL,
  `ekstrakurikuler` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `krkm_kuliah_prodi`
--

CREATE TABLE `krkm_kuliah_prodi` (
  `krkm_kuliah_prodi_id` int(11) NOT NULL,
  `kuliah_id` int(11) DEFAULT NULL,
  `ref_kbk_id` int(11) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `krkm_kurikulum_prodi`
--

CREATE TABLE `krkm_kurikulum_prodi` (
  `kurikulum_prodi_id` int(11) NOT NULL,
  `id_kur` int(4) NOT NULL DEFAULT '2012',
  `kode_mk` varchar(11) NOT NULL,
  `kbk_id` varchar(255) NOT NULL DEFAULT '',
  `kurikulum_id` int(11) DEFAULT NULL,
  `ref_kbk_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `krkm_prerequisite_courses`
--

CREATE TABLE `krkm_prerequisite_courses` (
  `prerequisite_courses_id` int(11) NOT NULL,
  `id_kur` int(4) DEFAULT '0',
  `kode_mk` varchar(11) DEFAULT NULL,
  `kuliah_id` int(11) DEFAULT NULL,
  `id_kur_pre` int(4) DEFAULT '0',
  `kode_mk_pre` varchar(10) DEFAULT NULL,
  `kuliah_pre_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `krkm_r_tahun_kurikulum`
--

CREATE TABLE `krkm_r_tahun_kurikulum` (
  `tahun_kurikulum_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `krkm_sifat_kuliah`
--

CREATE TABLE `krkm_sifat_kuliah` (
  `sifat_kuliah_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `labx_alat`
--

CREATE TABLE `labx_alat` (
  `alat_id` int(11) NOT NULL,
  `kode_alat` varchar(50) DEFAULT NULL,
  `lab_id` int(11) NOT NULL,
  `lemari_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `merk` varchar(50) DEFAULT NULL,
  `stok_alat` bigint(20) NOT NULL,
  `stok_available` bigint(20) NOT NULL,
  `stok_min` bigint(20) NOT NULL,
  `tahun` year(4) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `labx_alat`
--

INSERT INTO `labx_alat` (`alat_id`, `kode_alat`, `lab_id`, `lemari_id`, `name`, `merk`, `stok_alat`, `stok_available`, `stok_min`, `tahun`, `deleted`, `deleted_at`, `deleted_by`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(9, NULL, 1, 4, 'Gelas Ukur 50ml', 'Ivanovic', 103558, 75, 20, 2016, 0, NULL, NULL, '2018-05-03 09:29:42', 'root', '2018-06-28 09:09:59', 'root'),
(10, NULL, 1, 4, 'Gelas Ukur 20ml', 'Ivanovic', 170, 85, 10, 2016, 0, NULL, NULL, '2018-05-03 09:33:59', 'root', '2018-06-11 12:17:19', 'root'),
(11, NULL, 1, 4, 'Gelas Ukur 10ml', 'Ivanovic', 110, 100, 10, 2016, 0, NULL, NULL, '2018-05-03 09:35:47', 'root', '2018-06-07 13:01:52', 'root'),
(12, NULL, 1, 4, 'Tabung Alakazam', 'Alana', 100, 100, 10, 2017, 0, NULL, NULL, '2018-05-03 10:05:52', 'root', '2018-05-03 10:05:52', 'root'),
(13, NULL, 1, 4, 'Gelas Suns', '', 200, 200, 20, 2018, 0, NULL, NULL, '2018-05-03 10:06:17', 'root', '2018-05-03 10:06:17', 'root'),
(14, NULL, 1, 4, 'Tang Krus', '', 100, 100, 10, 2015, 0, NULL, NULL, '2018-05-03 10:06:53', 'root', '2018-05-03 10:06:53', 'root'),
(15, NULL, 1, 4, 'Penjepit Kayu', '', 20, 20, 20, 2017, 0, NULL, NULL, '2018-05-03 10:07:16', 'root', '2018-05-03 10:07:16', 'root'),
(16, NULL, 1, 4, 'Sikat Tabung', '', 100, 100, 10, 2014, 0, NULL, NULL, '2018-05-03 10:07:37', 'root', '2018-05-03 10:07:37', 'root'),
(17, NULL, 1, 4, 'Botol Sccot 50ml', '', 150, 150, 10, 2015, 0, NULL, NULL, '2018-05-03 10:08:04', 'root', '2018-05-03 10:08:04', 'root'),
(18, NULL, 1, 4, 'Kaki Tiga', '', 100, 100, 10, 2018, 0, NULL, NULL, '2018-05-03 10:08:31', 'root', '2018-05-03 10:08:31', 'root'),
(19, NULL, 1, 4, 'Pipet Ukur 5ml', '', 50, 50, 10, 2012, 0, NULL, NULL, '2018-05-03 10:08:55', 'root', '2018-05-03 10:08:55', 'root'),
(20, NULL, 1, 4, 'Pipet Ukur 2ml', '', 100, 100, 10, 2015, 0, NULL, NULL, '2018-05-03 10:09:52', 'root', '2018-05-03 10:49:48', 'root'),
(21, NULL, 1, 4, 'Sekop', '', 100, 100, 10, 2014, 0, NULL, NULL, '2018-05-08 20:10:40', 'root', '2018-05-08 20:10:40', 'root'),
(22, NULL, 1, 4, 'Alat 1', 'Merk Alat 1', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-09 15:27:23', 'root', '2018-05-09 15:27:23', 'root'),
(23, NULL, 1, 4, 'Alat 2', 'Merk Alat 2', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-09 15:27:23', 'root', '2018-05-09 15:27:23', 'root'),
(24, NULL, 1, 4, 'Alat 3', 'Merk Alat 3', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-09 15:27:23', 'root', '2018-05-09 15:27:23', 'root'),
(25, NULL, 1, 4, 'Alat 4', 'Merk Alat 4', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-09 15:27:23', 'root', '2018-05-09 15:27:23', 'root'),
(26, NULL, 1, 4, 'Alat 5', 'Merk Alat 5', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-09 15:27:23', 'root', '2018-05-09 15:27:23', 'root'),
(27, NULL, 1, 4, 'Alat 6', 'Merk Alat 6', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-09 15:27:23', 'root', '2018-05-09 15:27:23', 'root'),
(28, NULL, 1, 4, 'Alat 7', 'Merk Alat 7', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-09 15:27:23', 'root', '2018-05-09 15:27:23', 'root'),
(29, NULL, 1, 4, 'Alat 8', 'Merk Alat 8', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-09 15:27:23', 'root', '2018-05-09 15:27:23', 'root'),
(30, NULL, 1, 4, 'Alat 1', 'Merk Alat 1', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-14 17:00:09', 'root', '2018-05-14 17:00:09', 'root'),
(31, NULL, 1, 4, 'Alat 2', 'Merk Alat 2', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-14 17:00:09', 'root', '2018-05-14 17:00:09', 'root'),
(32, NULL, 1, 4, 'Alat 3', 'Merk Alat 3', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-14 17:00:09', 'root', '2018-05-14 17:00:09', 'root'),
(33, NULL, 1, 4, 'Alat 4', 'Merk Alat 4', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-14 17:00:09', 'root', '2018-05-14 17:00:09', 'root'),
(34, NULL, 1, 4, 'Alat 5', 'Merk Alat 5', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-14 17:00:09', 'root', '2018-05-14 17:00:09', 'root'),
(35, NULL, 1, 4, 'Alat 6', 'Merk Alat 6', 100, 100, 10, 2016, 0, NULL, NULL, '2018-05-14 17:00:10', 'root', '2018-05-14 17:00:10', 'root'),
(36, NULL, 1, 4, 'Alat 7', 'Merk Alat 7', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-05-14 17:00:10', 'root', '2018-05-14 17:00:10', 'root'),
(37, NULL, 1, 4, 'Alat 8', 'Merk Alat 8', 100, 100, 10, 2016, 1, '2018-06-07 12:43:39', 'root', '2018-05-14 17:00:10', 'root', '2018-05-14 17:00:10', 'root'),
(38, NULL, 1, 4, 'Test 1', '', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-07 12:44:07', 'root', '2018-06-07 12:44:07', 'root'),
(39, NULL, 1, 4, 'Alat 1', 'Merk Alat 1', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:44:39', 'root', '2018-06-07 12:44:39', 'root'),
(40, NULL, 1, 4, 'Alat 2', 'Merk Alat 2', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:44:39', 'root', '2018-06-07 12:44:39', 'root'),
(41, NULL, 1, 4, 'Alat 3', 'Merk Alat 3', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:44:39', 'root', '2018-06-07 12:44:39', 'root'),
(42, NULL, 1, 4, 'Alat 4', 'Merk Alat 4', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:44:39', 'root', '2018-06-07 12:44:39', 'root'),
(43, NULL, 1, 4, 'Alat 5', 'Merk Alat 5', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:44:39', 'root', '2018-06-07 12:44:39', 'root'),
(44, NULL, 1, 4, 'Alat 6', 'Merk Alat 6', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:44:39', 'root', '2018-06-07 12:44:39', 'root'),
(45, NULL, 1, 4, 'Alat 7', 'Merk Alat 7', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:44:39', 'root', '2018-06-07 12:44:39', 'root'),
(46, NULL, 1, 4, 'Alat 8', 'Merk Alat 8', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:44:39', 'root', '2018-06-07 12:44:39', 'root'),
(47, NULL, 1, 4, 'Alat 1', 'Merk Alat 1', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:45:00', 'root', '2018-06-07 12:45:00', 'root'),
(48, NULL, 1, 4, 'Alat 2', 'Merk Alat 2', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:45:00', 'root', '2018-06-07 12:45:00', 'root'),
(49, NULL, 1, 4, 'Alat 3', 'Merk Alat 3', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:45:00', 'root', '2018-06-07 12:45:00', 'root'),
(50, NULL, 1, 4, 'Alat 4', 'Merk Alat 4', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:45:00', 'root', '2018-06-07 12:45:00', 'root'),
(51, NULL, 1, 4, 'Alat 5', 'Merk Alat 5', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:45:01', 'root', '2018-06-07 12:45:01', 'root'),
(52, NULL, 1, 4, 'Alat 6', 'Merk Alat 6', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:45:01', 'root', '2018-06-07 12:45:01', 'root'),
(53, NULL, 1, 4, 'Alat 7', 'Merk Alat 7', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:45:01', 'root', '2018-06-07 12:45:01', 'root'),
(54, NULL, 1, 4, 'Alat 8', 'Merk Alat 8', 100, 100, 10, 2016, NULL, NULL, NULL, '2018-06-07 12:45:01', 'root', '2018-06-07 12:45:01', 'root'),
(55, NULL, 1, 4, 'Alat 1', 'Merk Alat 1', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 08:14:37', 'root', '2018-06-28 08:14:37', 'root'),
(56, NULL, 1, 4, 'Alat 2', 'Merk Alat 2', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 08:14:37', 'root', '2018-06-28 08:14:37', 'root'),
(57, NULL, 1, 4, 'Alat 3', 'Merk Alat 3', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 08:14:37', 'root', '2018-06-28 09:23:02', 'root'),
(58, NULL, 1, 4, 'Alat 4', 'Merk Alat 4', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 08:14:37', 'root', '2018-06-28 08:14:37', 'root'),
(59, NULL, 1, 4, 'Alat 5', 'Merk Alat 5', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 08:14:37', 'root', '2018-06-28 08:20:02', 'root'),
(60, NULL, 1, 4, 'Alat 6', 'Merk Alat 6', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 08:14:37', 'root', '2018-06-28 08:14:37', 'root'),
(61, NULL, 1, 4, 'Alat 7', 'Merk Alat 7', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 08:14:37', 'root', '2018-06-28 08:14:37', 'root'),
(62, NULL, 1, 4, 'Alat 8', 'Merk Alat 8', 200, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 08:14:37', 'root', '2018-06-28 09:11:09', 'root'),
(63, NULL, 1, 4, 'Alat 4', 'test', 200, 200, 100, 2018, 0, NULL, NULL, '2018-06-28 09:13:25', 'root', '2018-06-28 09:13:25', 'root'),
(64, NULL, 1, 4, 'Alat 1', 'Merk Alat 1', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 09:13:53', 'root', '2018-06-28 09:13:53', 'root'),
(65, NULL, 1, 4, 'Alat 2', 'Merk Alat 2', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 09:13:53', 'root', '2018-06-28 09:13:53', 'root'),
(66, NULL, 1, 4, 'Alat 3', 'Merk Alat 3', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 09:13:53', 'root', '2018-06-28 09:13:53', 'root'),
(67, NULL, 1, 4, 'Alat 4', 'Merk Alat 4', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 09:13:53', 'root', '2018-06-28 09:13:53', 'root'),
(68, NULL, 1, 4, 'Alat 5', 'Merk Alat 5', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 09:13:53', 'root', '2018-06-28 09:13:53', 'root'),
(69, NULL, 1, 4, 'Alat 6', 'Merk Alat 6', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 09:13:53', 'root', '2018-06-28 09:13:53', 'root'),
(70, NULL, 1, 4, 'Alat 7', 'Merk Alat 7', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 09:13:53', 'root', '2018-06-28 09:13:53', 'root'),
(71, NULL, 1, 4, 'Alat 8', 'Merk Alat 8', 100, 100, 10, 2016, 0, NULL, NULL, '2018-06-28 09:13:53', 'root', '2018-06-28 09:13:53', 'root'),
(72, NULL, 2, 4, 'Barang Alat', 'Alpha', 1000, 1000, 10, 2018, 0, NULL, NULL, '2018-06-28 13:12:41', 'root', '2018-06-28 13:12:41', 'root');

-- --------------------------------------------------------

--
-- Table structure for table `labx_bahan`
--

CREATE TABLE `labx_bahan` (
  `bahan_id` int(11) NOT NULL,
  `lab_id` int(11) NOT NULL,
  `lemari_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rumus_molekul` varchar(50) DEFAULT NULL,
  `nama_lain` varchar(50) DEFAULT NULL,
  `berat_molekul` varchar(30) DEFAULT NULL,
  `stok_bahan` bigint(20) NOT NULL,
  `stok_available` bigint(20) NOT NULL,
  `satuan_id` int(11) NOT NULL,
  `desc` varchar(250) DEFAULT NULL,
  `expired_date` date NOT NULL,
  `harga` decimal(19,4) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `labx_bahan`
--

INSERT INTO `labx_bahan` (`bahan_id`, `lab_id`, `lemari_id`, `name`, `rumus_molekul`, `nama_lain`, `berat_molekul`, `stok_bahan`, `stok_available`, `satuan_id`, `desc`, `expired_date`, `harga`, `deleted`, `deleted_at`, `deleted_by`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(45, 1, 4, 'Bahan 1', 'C2Cl4', 'Bahan', '86.18 g/mol', 100, 100, 8, 'Cairan', '0000-00-00', '10000.0000', 0, NULL, NULL, '2018-06-29 11:45:00', 'root', '2018-06-29 11:45:00', 'root'),
(46, 1, 4, 'Bahan 2', 'C2Cl5', 'Bahan', '86.18 g/mol', 100, 100, 10, 'Cairan', '0000-00-00', '20000.0000', 0, NULL, NULL, '2018-06-29 11:45:00', 'root', '2018-06-29 11:45:00', 'root'),
(47, 1, 4, 'Bahan 3', 'C2Cl6', 'Bahan', '86.18 g/mol', 100, 100, 11, 'Cairan', '0000-00-00', '30000.0000', 0, NULL, NULL, '2018-06-29 11:45:01', 'root', '2018-06-29 11:45:01', 'root'),
(48, 1, 4, 'Bahan 4', 'C2Cl7', 'Bahan', '86.18 g/mol', 100, 100, 11, 'Cairan', '0000-00-00', '40000.0000', 0, NULL, NULL, '2018-06-29 11:45:01', 'root', '2018-06-29 11:45:01', 'root'),
(49, 1, 4, 'Bahan 5', 'C2Cl8', 'Bahan', '86.18 g/mol', 100, 100, 11, 'Cairan', '0000-00-00', '50000.0000', 0, NULL, NULL, '2018-06-29 11:45:01', 'root', '2018-06-29 11:45:01', 'root'),
(50, 1, 4, 'Bahan 6', 'C2Cl9', 'Bahan', '86.18 g/mol', 100, 100, 11, 'Cairan', '0000-00-00', '60000.0000', 0, NULL, NULL, '2018-06-29 11:45:01', 'root', '2018-06-29 11:45:01', 'root'),
(51, 1, 4, 'Bahan 7', 'C2Cl10', 'Bahan', '86.18 g/mol', 100, 100, 11, 'Cairan', '0000-00-00', '70000.0000', 0, NULL, NULL, '2018-06-29 11:45:01', 'root', '2018-06-29 11:45:01', 'root'),
(52, 1, 4, 'Bahan 8', 'C2Cl11', 'Bahan', '86.18 g/mol', 100, 100, 11, 'Cairan', '0000-00-00', '80000.0000', 0, NULL, NULL, '2018-06-29 11:45:01', 'root', '2018-06-29 11:45:01', 'root');

-- --------------------------------------------------------

--
-- Table structure for table `labx_item_pemesanan`
--

CREATE TABLE `labx_item_pemesanan` (
  `item_pemesanan_id` int(11) NOT NULL,
  `pemesanan_id` int(11) DEFAULT NULL,
  `bahan_id` int(11) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `labx_item_peminjaman`
--

CREATE TABLE `labx_item_peminjaman` (
  `item_peminjaman_id` int(11) NOT NULL,
  `peminjaman_id` int(11) DEFAULT NULL,
  `alat_id` int(11) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `labx_lab`
--

CREATE TABLE `labx_lab` (
  `lab_id` int(11) NOT NULL,
  `kode_lab` varchar(15) NOT NULL,
  `name` varchar(30) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `labx_lab`
--

INSERT INTO `labx_lab` (`lab_id`, `kode_lab`, `name`, `deleted`, `deleted_at`, `deleted_by`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 'KD', 'Kimia Dasar', 0, NULL, NULL, '2018-03-24 09:48:19', 'guest', '2018-03-24 09:48:19', 'guest'),
(2, 'KF', 'Kimia Fisik', 0, NULL, NULL, '2018-03-24 09:49:08', 'guest', '2018-03-24 09:49:08', 'guest'),
(3, 'KO', 'Kimia Organik', 0, NULL, NULL, '2018-03-24 09:49:29', 'guest', '2018-03-24 09:49:29', 'guest'),
(4, 'BU', 'Biologi Umum', 0, NULL, NULL, '2018-03-24 09:49:58', 'guest', '2018-03-24 09:49:58', 'guest'),
(5, 'GB', 'Genetika Biologi Molekuler', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'KM', '943', 1, '2018-06-29 11:54:42', 'root', '2018-06-28 09:12:12', 'root', '2018-06-28 09:12:12', 'root');

-- --------------------------------------------------------

--
-- Table structure for table `labx_lemari`
--

CREATE TABLE `labx_lemari` (
  `lemari_id` int(11) NOT NULL,
  `jenis_lemari` varchar(30) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `labx_lemari`
--

INSERT INTO `labx_lemari` (`lemari_id`, `jenis_lemari`, `deleted`, `deleted_at`, `deleted_by`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(4, 'L1T1', 0, NULL, NULL, '2018-05-03 09:28:08', 'root', '2018-05-03 09:28:08', 'root'),
(5, 'L2T2', 0, NULL, NULL, '2018-06-27 20:40:11', 'root', '2018-06-27 20:40:11', 'root');

-- --------------------------------------------------------

--
-- Table structure for table `labx_pemesanan`
--

CREATE TABLE `labx_pemesanan` (
  `pemesanan_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tujuan_id` int(11) NOT NULL,
  `kuliah_id` int(11) DEFAULT NULL,
  `desc` varchar(100) DEFAULT NULL,
  `tanggal_pemesanan` date DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `labx_peminjaman`
--

CREATE TABLE `labx_peminjaman` (
  `peminjaman_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tujuan_id` int(11) NOT NULL,
  `kuliah_id` int(11) DEFAULT NULL,
  `tanggal_peminjaman` datetime DEFAULT NULL,
  `tanggal_pengembalian` datetime DEFAULT NULL,
  `denda` decimal(19,4) DEFAULT NULL,
  `desc` varchar(100) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `labx_penambahan_stock_alat`
--

CREATE TABLE `labx_penambahan_stock_alat` (
  `penambahan_alat_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `nama_penambah` varchar(32) DEFAULT NULL,
  `alat_id` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `tanggal_penambahan` datetime DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `labx_penambahan_stock_bahan`
--

CREATE TABLE `labx_penambahan_stock_bahan` (
  `penambahan_bahan_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `bahan_id` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `tanggal_penambahan` datetime DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `labx_r_status`
--

CREATE TABLE `labx_r_status` (
  `status_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `labx_r_status`
--

INSERT INTO `labx_r_status` (`status_id`, `name`, `deleted`, `deleted_at`, `deleted_by`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 'Process', 0, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', ''),
(2, 'Accepted', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'Canceled', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Done', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'Rejected', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'Pending', 0, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `labx_r_tujuan`
--

CREATE TABLE `labx_r_tujuan` (
  `tujuan_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `labx_r_tujuan`
--

INSERT INTO `labx_r_tujuan` (`tujuan_id`, `name`, `deleted`, `deleted_at`, `deleted_by`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 'Praktikum', 0, NULL, NULL, NULL, NULL, '2018-06-07 08:46:53', 'root'),
(2, 'Penelitian', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'Tugas Akhir', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Latihan', 0, NULL, NULL, '2018-06-28 09:14:34', 'root', '2018-06-28 09:14:34', 'root');

-- --------------------------------------------------------

--
-- Table structure for table `labx_satuan`
--

CREATE TABLE `labx_satuan` (
  `satuan_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `labx_satuan`
--

INSERT INTO `labx_satuan` (`satuan_id`, `name`, `deleted`, `deleted_at`, `deleted_by`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(8, 'Mililiter', 0, NULL, NULL, '2018-06-29 11:18:59', 'root', '2018-06-29 11:18:59', 'root'),
(10, 'Gram', 0, NULL, NULL, '2018-06-29 11:20:21', 'root', '2018-06-29 11:20:21', 'root'),
(11, 'Unit', 0, NULL, NULL, '2018-06-29 11:20:26', 'root', '2018-06-29 11:20:26', 'root'),
(12, 'test', 1, '2018-06-29 11:46:37', 'root', '2018-06-29 11:46:33', 'root', '2018-06-29 11:46:33', 'root');

-- --------------------------------------------------------

--
-- Table structure for table `lppm_penelitian`
--

CREATE TABLE `lppm_penelitian` (
  `penelitian_id` int(11) NOT NULL,
  `judul_penelitian` varchar(500) DEFAULT NULL,
  `tahun` varchar(10) DEFAULT NULL,
  `biaya` varchar(50) DEFAULT NULL,
  `sumber_dana` varchar(100) DEFAULT NULL,
  `skema` varchar(100) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_penelitian_dosen`
--

CREATE TABLE `lppm_penelitian_dosen` (
  `penelitian_dosen_id` int(11) NOT NULL,
  `penelitian_id` int(11) DEFAULT NULL,
  `dosen_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_r_karyailmiah`
--

CREATE TABLE `lppm_r_karyailmiah` (
  `karyailmiah_id` int(11) NOT NULL,
  `jenis` varchar(20) NOT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_r_subkaryailmiah`
--

CREATE TABLE `lppm_r_subkaryailmiah` (
  `subkaryailmiah_id` int(11) NOT NULL,
  `karyailmiah_id` int(11) NOT NULL,
  `jenis` varchar(50) NOT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_author_publikasi`
--

CREATE TABLE `lppm_t_author_publikasi` (
  `author_publikasi_id` int(11) NOT NULL,
  `publikasi_id` int(11) DEFAULT NULL,
  `nama_author` varchar(255) DEFAULT NULL,
  `institusi` varchar(100) DEFAULT '255',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_ketua_gbk`
--

CREATE TABLE `lppm_t_ketua_gbk` (
  `ketuagbk_id` int(11) NOT NULL,
  `gbk_id` int(11) NOT NULL,
  `dosen_id` int(11) DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_logreview`
--

CREATE TABLE `lppm_t_logreview` (
  `logreview_id` int(11) NOT NULL,
  `publikasi_id` int(11) NOT NULL,
  `pegawai_id` int(11) DEFAULT NULL,
  `catatanperbaikanreview` text,
  `review` int(1) DEFAULT '0',
  `status` int(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_publikasi`
--

CREATE TABLE `lppm_t_publikasi` (
  `publikasi_id` int(11) NOT NULL,
  `pegawai_id` int(11) DEFAULT NULL,
  `subkaryailmiah_id` int(11) DEFAULT NULL,
  `konferensi` varchar(50) DEFAULT NULL,
  `review` int(11) DEFAULT '0',
  `gbk_id` int(11) DEFAULT NULL,
  `judul` varchar(255) DEFAULT NULL,
  `abstrak` text,
  `deadline` date DEFAULT NULL,
  `tanggal_publish` date DEFAULT NULL,
  `keterangan` varchar(1000) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `reward` int(11) DEFAULT '0',
  `approved_ketuagbk` int(11) DEFAULT '0',
  `website` varchar(50) DEFAULT NULL,
  `path_uploaddokumen` varchar(255) DEFAULT NULL,
  `kode_file` varchar(50) DEFAULT NULL,
  `is_published` tinyint(1) DEFAULT '0',
  `pesan` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_registrasipublikasi`
--

CREATE TABLE `lppm_t_registrasipublikasi` (
  `registrasipublikasi_id` int(11) NOT NULL,
  `publikasi_id` int(11) NOT NULL,
  `biaya_pendaftaran` decimal(11,0) DEFAULT NULL,
  `biaya_transport` decimal(11,0) DEFAULT NULL,
  `keterangan_transport` varchar(255) DEFAULT NULL,
  `biaya_transport2` decimal(11,0) DEFAULT NULL,
  `keterangan_transport2` varchar(255) DEFAULT NULL,
  `biaya_penginapan` decimal(11,0) DEFAULT NULL,
  `tanggal_berangkat` date DEFAULT NULL,
  `tanggal_pulang` date DEFAULT NULL,
  `status_approved` int(11) DEFAULT '0',
  `keterangan_approved` varchar(255) DEFAULT NULL,
  `catatan` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_registrasi_file`
--

CREATE TABLE `lppm_t_registrasi_file` (
  `registrasifile_id` int(11) NOT NULL,
  `registrasipublikasi_id` int(11) DEFAULT NULL,
  `nama_file` varchar(255) DEFAULT NULL,
  `kode_file` varchar(255) DEFAULT NULL,
  `index_file` int(11) DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_registrasi_jurnal`
--

CREATE TABLE `lppm_t_registrasi_jurnal` (
  `registrasi_jurnal_id` int(11) NOT NULL,
  `publikasi_id` int(11) DEFAULT NULL,
  `biaya_registrasi` decimal(11,0) DEFAULT NULL,
  `status_approved` int(11) DEFAULT NULL,
  `keterangan_approved` text,
  `catatan` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_registrasi_jurnal_file`
--

CREATE TABLE `lppm_t_registrasi_jurnal_file` (
  `registrasi_jurnal_file_id` int(11) NOT NULL,
  `registrasi_jurnal_id` int(11) DEFAULT NULL,
  `nama_file` varchar(200) DEFAULT NULL,
  `kode_file` varchar(200) DEFAULT NULL,
  `index_file` int(11) DEFAULT NULL,
  `keterangan` text,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_registrasi_prosiding`
--

CREATE TABLE `lppm_t_registrasi_prosiding` (
  `registrasi_prosiding_id` int(11) NOT NULL,
  `publikasi_id` int(11) DEFAULT NULL,
  `waktu_mulai` date DEFAULT NULL,
  `waktu_selesai` date DEFAULT NULL,
  `rute_transport_udara` varchar(255) DEFAULT NULL,
  `rute_transport_laut` varchar(255) DEFAULT NULL,
  `rute_transport_darat` varchar(255) DEFAULT NULL,
  `status_approved` int(11) DEFAULT NULL,
  `keterangan_approved` text,
  `catatan` text,
  `biaya_pendaftaran` decimal(11,0) DEFAULT NULL,
  `biaya_transport_darat` decimal(11,0) DEFAULT NULL,
  `biaya_transport_laut` decimal(11,0) DEFAULT NULL,
  `biaya_transport_udara` decimal(11,0) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_registrasi_prosiding_file`
--

CREATE TABLE `lppm_t_registrasi_prosiding_file` (
  `registrasi_prosiding_file_id` int(11) NOT NULL,
  `registrasi_prosiding_id` int(11) DEFAULT NULL,
  `nama_file` varchar(200) DEFAULT NULL,
  `kode_file` varchar(200) DEFAULT NULL,
  `index_file` int(11) DEFAULT NULL,
  `keterangan` text,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_review_file`
--

CREATE TABLE `lppm_t_review_file` (
  `reviewfile_id` int(11) NOT NULL,
  `logreview_id` int(11) DEFAULT NULL,
  `nama_file` varchar(255) DEFAULT NULL,
  `kode_file` varchar(255) DEFAULT NULL,
  `index_file` int(11) DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_rewardpublikasi`
--

CREATE TABLE `lppm_t_rewardpublikasi` (
  `rewardpublikasi_id` int(11) NOT NULL,
  `publikasi_id` int(11) NOT NULL,
  `status_reward` int(11) DEFAULT NULL,
  `keterangan_reward` varchar(255) DEFAULT NULL,
  `catatan` varchar(255) DEFAULT NULL,
  `jumlah` decimal(10,0) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_reward_file`
--

CREATE TABLE `lppm_t_reward_file` (
  `rewardfile_id` int(11) NOT NULL,
  `rewardpublikasi_id` int(11) DEFAULT NULL,
  `nama_file` varchar(255) DEFAULT NULL,
  `kode_file` varchar(255) DEFAULT NULL,
  `index_file` int(11) DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_reward_jurnal`
--

CREATE TABLE `lppm_t_reward_jurnal` (
  `reward_jurnal_id` int(11) NOT NULL,
  `publikasi_id` int(11) DEFAULT NULL,
  `issn` varchar(50) DEFAULT NULL,
  `volume` varchar(50) DEFAULT NULL,
  `nomor` varchar(50) DEFAULT NULL,
  `halaman_awal` int(11) DEFAULT NULL,
  `halaman_akhir` int(11) DEFAULT NULL,
  `status_reward` int(11) DEFAULT NULL,
  `keterangan_reward` text,
  `jumlah` decimal(11,0) DEFAULT NULL,
  `catatan` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_reward_jurnal_file`
--

CREATE TABLE `lppm_t_reward_jurnal_file` (
  `reward_jurnal_file_id` int(11) NOT NULL,
  `reward_jurnal_id` int(11) DEFAULT NULL,
  `nama_file` varchar(200) DEFAULT NULL,
  `kode_file` varchar(200) DEFAULT NULL,
  `index_file` int(11) DEFAULT NULL,
  `keterangan` text,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_reward_prosiding`
--

CREATE TABLE `lppm_t_reward_prosiding` (
  `reward_prosiding_id` int(11) NOT NULL,
  `publikasi_id` int(11) DEFAULT NULL,
  `institusi_penyelenggara` varchar(150) DEFAULT NULL,
  `tempat_pelaksanaan` varchar(200) DEFAULT NULL,
  `status_reward` int(11) DEFAULT NULL,
  `keterangan_reward` text,
  `catatan` text,
  `jumlah` decimal(11,0) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lppm_t_reward_prosiding_file`
--

CREATE TABLE `lppm_t_reward_prosiding_file` (
  `reward_prosiding_file_id` int(11) NOT NULL,
  `reward_prosiding_id` int(11) DEFAULT NULL,
  `nama_file` varchar(200) DEFAULT NULL,
  `kode_file` varchar(200) DEFAULT NULL,
  `index_file` int(11) DEFAULT NULL,
  `keterangan` text,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `migration`
--

CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `migration`
--

INSERT INTO `migration` (`version`, `apply_time`, `deleted`, `deleted_at`, `deleted_by`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
('m180228_081214_init_cis_lite', 1520498014, 0, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_agama`
--

CREATE TABLE `mref_r_agama` (
  `agama_id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_asal_sekolah`
--

CREATE TABLE `mref_r_asal_sekolah` (
  `asal_sekolah_id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `alamat` text,
  `provinsi_id` int(11) DEFAULT NULL,
  `kabupaten_id` int(11) DEFAULT NULL,
  `kodepos` varchar(8) DEFAULT NULL,
  `telepon` varchar(20) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_bidang_pekerjaan`
--

CREATE TABLE `mref_r_bidang_pekerjaan` (
  `bidang_pekerjaan_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_bidang_perusahaan`
--

CREATE TABLE `mref_r_bidang_perusahaan` (
  `bidang_perusahaan_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_gbk`
--

CREATE TABLE `mref_r_gbk` (
  `gbk_id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_gelombang_pmb`
--

CREATE TABLE `mref_r_gelombang_pmb` (
  `gelombang_pmb_id` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `deskripsi` varchar(150) DEFAULT NULL,
  `lokasi` varchar(25) DEFAULT NULL,
  `tanggal_awal` datetime DEFAULT NULL,
  `tanggal_akhir` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(25) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(25) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_golongan_darah`
--

CREATE TABLE `mref_r_golongan_darah` (
  `golongan_darah_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_golongan_kepangkatan`
--

CREATE TABLE `mref_r_golongan_kepangkatan` (
  `golongan_kepangkatan_id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `desc` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_jabatan_akademik`
--

CREATE TABLE `mref_r_jabatan_akademik` (
  `jabatan_akademik_id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `desc` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_jenis_kelamin`
--

CREATE TABLE `mref_r_jenis_kelamin` (
  `jenis_kelamin_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_jenjang`
--

CREATE TABLE `mref_r_jenjang` (
  `jenjang_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_kabupaten`
--

CREATE TABLE `mref_r_kabupaten` (
  `kabupaten_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_lokasi`
--

CREATE TABLE `mref_r_lokasi` (
  `lokasi_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_pekerjaan`
--

CREATE TABLE `mref_r_pekerjaan` (
  `pekerjaan_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_pendidikan`
--

CREATE TABLE `mref_r_pendidikan` (
  `pendidikan_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_pengali_nilai`
--

CREATE TABLE `mref_r_pengali_nilai` (
  `pengali_nilai_id` int(11) NOT NULL,
  `nilai` varchar(3) DEFAULT NULL,
  `pengali` float DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_penghasilan`
--

CREATE TABLE `mref_r_penghasilan` (
  `penghasilan_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_predikat_lulus`
--

CREATE TABLE `mref_r_predikat_lulus` (
  `predikat_lulus_id` int(11) NOT NULL,
  `ipk_minimum` double DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_provinsi`
--

CREATE TABLE `mref_r_provinsi` (
  `provinsi_id` int(11) NOT NULL,
  `nama` varchar(128) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `cerated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_role_pengajar`
--

CREATE TABLE `mref_r_role_pengajar` (
  `role_pengajar_id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_sem_ta`
--

CREATE TABLE `mref_r_sem_ta` (
  `sem_ta_id` int(11) NOT NULL,
  `sem_ta` int(11) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_sifat_kurikulum`
--

CREATE TABLE `mref_r_sifat_kurikulum` (
  `sifat_kurikulum_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_status_aktif_mahasiswa`
--

CREATE TABLE `mref_r_status_aktif_mahasiswa` (
  `status_aktif_mahasiswa_id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `desc` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_status_aktif_pegawai`
--

CREATE TABLE `mref_r_status_aktif_pegawai` (
  `status_aktif_pegawai_id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `desc` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_status_ikatan_kerja_dosen`
--

CREATE TABLE `mref_r_status_ikatan_kerja_dosen` (
  `status_ikatan_kerja_dosen_id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `desc` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_status_ikatan_kerja_pegawai`
--

CREATE TABLE `mref_r_status_ikatan_kerja_pegawai` (
  `status_ikatan_kerja_pegawai_id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `desc` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_status_marital`
--

CREATE TABLE `mref_r_status_marital` (
  `status_marital_id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mref_r_ta`
--

CREATE TABLE `mref_r_ta` (
  `ta_id` int(11) NOT NULL,
  `nama` int(5) NOT NULL,
  `desc` varchar(100) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_ext_mhs`
--

CREATE TABLE `nlai_ext_mhs` (
  `ext_mhs_id` int(11) NOT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `tgl_test` date DEFAULT NULL,
  `ta` varchar(5) DEFAULT NULL,
  `sem_ta` int(11) DEFAULT '1',
  `ext_id` int(11) DEFAULT NULL,
  `score` varchar(32) DEFAULT NULL,
  `keterangan` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_file_nilai`
--

CREATE TABLE `nlai_file_nilai` (
  `file_nilai_id` int(11) NOT NULL,
  `nama_file` text,
  `kode_file` varchar(100) DEFAULT NULL,
  `ket` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_komponen_tambahan`
--

CREATE TABLE `nlai_komponen_tambahan` (
  `komponen_tambahan_id` int(11) NOT NULL,
  `id_kur` varchar(4) DEFAULT NULL,
  `kode_mk` varchar(11) DEFAULT NULL,
  `ta` varchar(4) DEFAULT NULL,
  `sem_ta` int(11) DEFAULT NULL,
  `nilai_tambahan_1` float DEFAULT NULL,
  `nilai_tambahan_2` float DEFAULT NULL,
  `nilai_tambahan_3` float DEFAULT NULL,
  `nilai_tambahan_4` float DEFAULT NULL,
  `nilai_tambahan_5` float DEFAULT NULL,
  `nm_tambahan_1` varchar(45) DEFAULT 'Nilai Tambahan 1',
  `nm_tambahan_2` varchar(45) DEFAULT 'Nilai Tambahan 2',
  `nm_tambahan_3` varchar(45) DEFAULT 'Nilai Tambahan 3',
  `nm_tambahan_4` varchar(45) DEFAULT 'Nilai Tambahan 4',
  `nm_tambahan_5` varchar(45) DEFAULT 'Nilai Tambahan 5',
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_komposisi_nilai`
--

CREATE TABLE `nlai_komposisi_nilai` (
  `komposisi_nilai_id` int(11) NOT NULL,
  `id_kur` int(4) DEFAULT '0',
  `kode_mk` varchar(11) DEFAULT NULL,
  `ta` varchar(30) DEFAULT '0',
  `sem_ta` int(11) DEFAULT NULL,
  `nilai_praktikum` float DEFAULT NULL,
  `nilai_quis` float DEFAULT NULL,
  `nilai_uts` float DEFAULT NULL,
  `nilai_uas` float DEFAULT NULL,
  `nilai_tugas` float DEFAULT NULL,
  `nm_praktikum` varchar(20) NOT NULL DEFAULT 'Nilai Praktikum',
  `nm_quis` varchar(20) NOT NULL DEFAULT 'Nilai Quis',
  `nm_uts` varchar(20) NOT NULL DEFAULT 'Nilai UTS',
  `nm_uas` varchar(20) NOT NULL DEFAULT 'Nilai UAS',
  `nm_tugas` varchar(20) NOT NULL DEFAULT 'Nilai Tugas',
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_komposisi_nilai_uts_uas`
--

CREATE TABLE `nlai_komposisi_nilai_uts_uas` (
  `komposisi_nilai_uts_uas_id` int(11) NOT NULL,
  `id_kur` int(4) DEFAULT NULL,
  `kode_mk` varchar(11) DEFAULT NULL,
  `ta` varchar(4) DEFAULT NULL,
  `sem_ta` int(11) DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `nilai_uts_teori` float DEFAULT NULL,
  `nilai_uts_praktikum` float DEFAULT NULL,
  `nilai_uas_teori` float DEFAULT NULL,
  `nilai_uas_praktikum` float DEFAULT NULL,
  `nm_uts_teori` varchar(50) DEFAULT 'UTS_TEORI',
  `nm_uts_praktikum` varchar(50) DEFAULT 'UTS_PRAKTIKUM',
  `nm_uas_teori` varchar(50) DEFAULT 'UAS_TEORI',
  `nm_uas_praktikum` varchar(50) DEFAULT 'UAS_PRAKTIKUM',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_nilai`
--

CREATE TABLE `nlai_nilai` (
  `nilai_id` int(11) NOT NULL,
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `kode_mk` varchar(11) NOT NULL,
  `ta` varchar(30) NOT NULL DEFAULT '0',
  `sem_ta` int(11) DEFAULT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `komponen_ke` int(1) DEFAULT '0',
  `na` float DEFAULT '0',
  `nilai` char(3) DEFAULT NULL,
  `na_remedial` float DEFAULT NULL,
  `nilai_remedial` char(3) DEFAULT NULL,
  `kelas` varchar(5) DEFAULT NULL,
  `sks` int(11) NOT NULL COMMENT 'Jumlah SKS',
  `sem` int(11) DEFAULT NULL COMMENT 'Semseter Kurikulum',
  `wali_approval` varchar(100) DEFAULT NULL,
  `dir_approval` varchar(100) DEFAULT NULL,
  `dosen_approval` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `dim_id` int(11) DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `ispublish` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_nilai_komponen_tambahan`
--

CREATE TABLE `nlai_nilai_komponen_tambahan` (
  `nilai_komponen_tambahan_id` int(11) NOT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `id_kur` varchar(4) DEFAULT NULL,
  `kode_mk` varchar(50) DEFAULT NULL,
  `ta` int(11) DEFAULT NULL,
  `sem_ta` int(1) DEFAULT NULL,
  `komponen_ke` int(11) DEFAULT NULL,
  `komponen` varchar(45) DEFAULT NULL,
  `nim` varchar(10) DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `nilai` float DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_nilai_praktikum`
--

CREATE TABLE `nlai_nilai_praktikum` (
  `nilai_praktikum_id` int(11) NOT NULL,
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `kode_mk` varchar(11) NOT NULL,
  `ta` varchar(4) NOT NULL DEFAULT '0',
  `sem_ta` int(11) DEFAULT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `komponen` varchar(30) DEFAULT NULL,
  `dosen_approval` varchar(100) DEFAULT NULL,
  `komponen_ke` smallint(6) DEFAULT NULL,
  `nilai` float NOT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_nilai_quis`
--

CREATE TABLE `nlai_nilai_quis` (
  `nilai_quis_id` int(11) NOT NULL,
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `kode_mk` varchar(11) NOT NULL,
  `ta` varchar(30) NOT NULL DEFAULT '0',
  `sem_ta` int(11) DEFAULT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `komponen` varchar(30) DEFAULT NULL,
  `dosen_approval` varchar(100) DEFAULT NULL,
  `komponen_ke` smallint(6) DEFAULT NULL,
  `nilai` float DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_nilai_tugas`
--

CREATE TABLE `nlai_nilai_tugas` (
  `nilai_tugas_id` int(11) NOT NULL,
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `kode_mk` varchar(11) NOT NULL,
  `ta` varchar(30) NOT NULL DEFAULT '0',
  `sem_ta` int(11) DEFAULT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `komponen` varchar(30) DEFAULT NULL,
  `dosen_approval` varchar(100) DEFAULT NULL,
  `komponen_ke` smallint(6) DEFAULT NULL,
  `nilai` float DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_nilai_uas`
--

CREATE TABLE `nlai_nilai_uas` (
  `nilai_uas_id` int(11) NOT NULL,
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `kode_mk` varchar(11) NOT NULL,
  `ta` varchar(30) NOT NULL DEFAULT '0',
  `sem_ta` int(11) DEFAULT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `komponen` varchar(30) DEFAULT NULL,
  `dosen_approval` varchar(100) DEFAULT NULL,
  `komponen_ke` smallint(6) DEFAULT NULL,
  `nilai` float DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `ispublish` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_nilai_uts`
--

CREATE TABLE `nlai_nilai_uts` (
  `nilai_uts_id` int(11) NOT NULL,
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `kode_mk` varchar(11) NOT NULL,
  `ta` varchar(30) NOT NULL DEFAULT '0',
  `sem_ta` int(11) DEFAULT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `komponen` varchar(30) DEFAULT NULL,
  `dosen_approval` varchar(100) DEFAULT NULL,
  `komponen_ke` smallint(6) DEFAULT NULL,
  `nilai` float DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `ispublish` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` varchar(45) DEFAULT NULL,
  `updated_at` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_rentang_nilai`
--

CREATE TABLE `nlai_rentang_nilai` (
  `rentang_nilai_id` int(11) NOT NULL,
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `kode_mk` varchar(11) NOT NULL,
  `ta` varchar(30) NOT NULL DEFAULT '0',
  `sem_ta` int(11) DEFAULT NULL,
  `a` float DEFAULT NULL,
  `ab` varchar(8) DEFAULT NULL,
  `b` float DEFAULT NULL,
  `bc` varchar(8) DEFAULT NULL,
  `c` float DEFAULT NULL,
  `d` float DEFAULT NULL,
  `e` float DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_r_ext`
--

CREATE TABLE `nlai_r_ext` (
  `ext_id` int(11) NOT NULL,
  `nama` varchar(45) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_uas_detail`
--

CREATE TABLE `nlai_uas_detail` (
  `uas_detail_id` int(11) NOT NULL,
  `id_kur` int(4) DEFAULT NULL,
  `kode_mk` varchar(11) DEFAULT NULL,
  `ta` varchar(30) DEFAULT NULL,
  `sem_ta` int(11) DEFAULT NULL,
  `nim` varchar(8) DEFAULT NULL,
  `komponen` varchar(30) DEFAULT NULL,
  `komponen_ke` int(11) DEFAULT NULL,
  `nilai` float DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `komposisi_nilai_uts_uas_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nlai_uts_detail`
--

CREATE TABLE `nlai_uts_detail` (
  `uts_detail_id` int(11) NOT NULL,
  `id_kur` int(4) DEFAULT NULL,
  `kode_mk` varchar(11) DEFAULT NULL,
  `ta` varchar(30) DEFAULT NULL,
  `sem_ta` int(11) DEFAULT NULL,
  `nim` varchar(8) DEFAULT NULL,
  `komponen` varchar(30) DEFAULT NULL,
  `komponen_ke` int(11) DEFAULT NULL,
  `nilai` float DEFAULT NULL,
  `dim_id` int(11) DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `komposisi_nilai_uts_uas_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_berita_acara_daftar_hadir`
--

CREATE TABLE `prkl_berita_acara_daftar_hadir` (
  `berita_acara_daftar_hadir_id` int(11) NOT NULL,
  `week` smallint(6) NOT NULL DEFAULT '0',
  `session` smallint(6) NOT NULL DEFAULT '0',
  `ta` int(4) NOT NULL DEFAULT '2002',
  `id_kur` int(4) NOT NULL DEFAULT '2002',
  `kurikulum_id` int(11) DEFAULT NULL,
  `kode_mk` varchar(11) NOT NULL,
  `nim` varchar(8) NOT NULL DEFAULT '',
  `dim_id` int(11) DEFAULT NULL,
  `status` varchar(7) DEFAULT 'H',
  `keterangan` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_berita_acara_kuliah`
--

CREATE TABLE `prkl_berita_acara_kuliah` (
  `berita_acara_kuliah_id` int(11) NOT NULL,
  `week` smallint(6) NOT NULL DEFAULT '0',
  `session` smallint(6) NOT NULL DEFAULT '0',
  `ta` int(4) NOT NULL DEFAULT '2002',
  `id_kur` int(4) NOT NULL DEFAULT '2002',
  `kode_mk` varchar(11) NOT NULL,
  `kurikulum_id` int(11) DEFAULT NULL,
  `kelas` varchar(100) NOT NULL,
  `kelas_id` int(11) DEFAULT NULL,
  `tanggal` date NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `topik` text,
  `ruangan` varchar(100) DEFAULT NULL,
  `aktifitas` varchar(15) DEFAULT NULL,
  `pic` varchar(20) DEFAULT NULL,
  `metode` text,
  `alat_bantu` text,
  `catatan` text,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_course_unit`
--

CREATE TABLE `prkl_course_unit` (
  `course_unit_id` int(11) NOT NULL,
  `week` smallint(6) NOT NULL DEFAULT '0',
  `session` smallint(6) NOT NULL DEFAULT '0',
  `status` char(1) NOT NULL DEFAULT '',
  `ta` int(4) DEFAULT '2002',
  `id_kur` int(4) DEFAULT '2002',
  `kode_mk` varchar(11) DEFAULT NULL,
  `topik` varchar(255) DEFAULT NULL,
  `sub_topik` text,
  `objektif` text,
  `aktifitas` varchar(15) DEFAULT NULL,
  `pic` varchar(20) DEFAULT NULL,
  `pegawai_id` int(11) DEFAULT NULL,
  `metode` text,
  `alat_bantu` text,
  `ket` varchar(255) DEFAULT NULL,
  `tanggal` datetime DEFAULT NULL,
  `day` varchar(10) DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_course_unit_material`
--

CREATE TABLE `prkl_course_unit_material` (
  `course_unit_material_id` int(11) NOT NULL,
  `week` smallint(6) NOT NULL DEFAULT '0',
  `session` smallint(6) NOT NULL DEFAULT '0',
  `status` char(1) NOT NULL DEFAULT '',
  `ta` int(4) NOT NULL DEFAULT '2002',
  `id_kur` int(4) NOT NULL DEFAULT '2002',
  `kode_mk` varchar(11) NOT NULL,
  `id_material` varchar(255) NOT NULL DEFAULT '',
  `kurikulum_id` int(11) DEFAULT NULL,
  `material_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_file`
--

CREATE TABLE `prkl_file` (
  `file_id` int(11) NOT NULL,
  `no` varchar(10) NOT NULL DEFAULT '0',
  `ta` int(4) NOT NULL DEFAULT '2002',
  `id_kur` int(4) NOT NULL DEFAULT '2002',
  `kode_mk` varchar(11) NOT NULL,
  `nama_file` varchar(255) NOT NULL DEFAULT '',
  `owner` varchar(30) NOT NULL DEFAULT '',
  `ket` varchar(255) DEFAULT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `no_group_file` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_file_materi`
--

CREATE TABLE `prkl_file_materi` (
  `file_materi_id` int(11) NOT NULL,
  `nama_file` text NOT NULL,
  `kode_file` varchar(50) DEFAULT NULL,
  `ket` text NOT NULL,
  `materi_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_file_praktikum`
--

CREATE TABLE `prkl_file_praktikum` (
  `file_praktikum_id` int(11) NOT NULL,
  `nama_file` text NOT NULL,
  `kode_file` varchar(50) DEFAULT NULL,
  `ket` text NOT NULL,
  `praktikum_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_file_syllabus`
--

CREATE TABLE `prkl_file_syllabus` (
  `file_syllabus_id` int(11) NOT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `nama_file` varchar(200) DEFAULT NULL,
  `ket` text,
  `kode_file` varchar(200) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_group_kuliah`
--

CREATE TABLE `prkl_group_kuliah` (
  `group_kuliah_id` int(11) NOT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_info_ta`
--

CREATE TABLE `prkl_info_ta` (
  `info_ta_id` int(11) NOT NULL,
  `dim_id` int(11) NOT NULL,
  `judul_ta` text NOT NULL,
  `pembimbing_1` int(11) NOT NULL,
  `pembimbing_2` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_jadwal`
--

CREATE TABLE `prkl_jadwal` (
  `jadwal_id` int(11) NOT NULL,
  `week` smallint(6) NOT NULL DEFAULT '0',
  `tanggal` date NOT NULL,
  `session` smallint(6) NOT NULL DEFAULT '0',
  `ta` int(4) NOT NULL DEFAULT '2002',
  `id_kur` int(4) NOT NULL DEFAULT '2002',
  `kode_mk` varchar(11) NOT NULL,
  `kelas` varchar(20) NOT NULL DEFAULT '',
  `ruangan` varchar(20) DEFAULT NULL,
  `topik` varchar(255) DEFAULT NULL,
  `sub_topik` text,
  `objektif` text,
  `aktifitas` varchar(15) DEFAULT NULL,
  `pic` varchar(20) NOT NULL DEFAULT '',
  `metode` text,
  `alat_bantu` text,
  `ket` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `createad_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_krs_detail`
--

CREATE TABLE `prkl_krs_detail` (
  `krs_detail_id` int(11) NOT NULL,
  `krs_mhs_id` int(11) DEFAULT NULL,
  `kuliah_id` int(11) DEFAULT NULL,
  `pengajaran_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_krs_mhs`
--

CREATE TABLE `prkl_krs_mhs` (
  `krs_mhs_id` int(11) NOT NULL,
  `dim_id` int(11) NOT NULL,
  `nim` varchar(8) NOT NULL,
  `sem_ta` varchar(2) NOT NULL,
  `ta` varchar(5) NOT NULL,
  `tahun_kurikulum_id` int(11) NOT NULL,
  `status_approval` tinyint(1) DEFAULT '0',
  `status_periode` varchar(4) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL COMMENT 'dosen_id',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_krs_review`
--

CREATE TABLE `prkl_krs_review` (
  `review_id` int(11) NOT NULL,
  `comment_by` int(11) DEFAULT NULL,
  `krs_mhs_id` int(11) DEFAULT NULL,
  `comment` text,
  `tgl_comment` date DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_kuesioner_materi`
--

CREATE TABLE `prkl_kuesioner_materi` (
  `kuesioner_materi_id` int(11) NOT NULL,
  `id_kuesioner` int(11) NOT NULL,
  `id_kur` int(11) DEFAULT NULL,
  `ta` int(11) DEFAULT NULL,
  `sem` int(11) DEFAULT NULL,
  `kode_mk` varchar(11) DEFAULT NULL,
  `judul` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'NOT ACTIVE',
  `pengajar` varchar(20) DEFAULT NULL,
  `time_activated` datetime DEFAULT NULL,
  `kurikulum_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_id` datetime DEFAULT NULL,
  `updated_id` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_kuesioner_praktikum`
--

CREATE TABLE `prkl_kuesioner_praktikum` (
  `kuesioner_praktikum_id` int(11) NOT NULL,
  `id_kuesioner` int(11) NOT NULL,
  `id_kur` int(11) DEFAULT NULL,
  `ta` int(11) DEFAULT NULL,
  `sem` int(11) DEFAULT NULL,
  `kode_mk` varchar(11) DEFAULT NULL,
  `kuliah_id` int(11) DEFAULT NULL,
  `judul` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'NOT ACTIVE',
  `pengajar` varchar(50) DEFAULT NULL,
  `time_activated` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_kurikulum_syllabus`
--

CREATE TABLE `prkl_kurikulum_syllabus` (
  `kurikulum_syllabus_id` int(11) NOT NULL,
  `id_kur` int(11) DEFAULT '2001',
  `kode_mk` varchar(11) DEFAULT NULL,
  `ta` int(4) DEFAULT '2005',
  `sem_ta` int(11) NOT NULL,
  `map_to_kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `prerequisites` text,
  `corerequisites` text,
  `course_description` text,
  `course_objectives` text,
  `learning_outcomes` text,
  `course_format` text,
  `grading_procedure` text,
  `course_content` text,
  `reference` text,
  `tools` text,
  `kuliah_id` int(11) DEFAULT NULL,
  `ta_id` int(11) NOT NULL,
  `meetings` varchar(100) DEFAULT NULL,
  `tipe` varchar(25) DEFAULT NULL,
  `level` varchar(15) DEFAULT NULL,
  `web_page` varchar(100) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_kurikulum_syllabus_file`
--

CREATE TABLE `prkl_kurikulum_syllabus_file` (
  `kurikulum_syllabus_file_id` int(11) NOT NULL,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `nama_file` varchar(255) DEFAULT NULL,
  `kode_file` varchar(255) DEFAULT NULL,
  `keterangan` text,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_materi`
--

CREATE TABLE `prkl_materi` (
  `materi_id` int(11) NOT NULL,
  `no` smallint(6) NOT NULL DEFAULT '0',
  `ta` int(4) NOT NULL DEFAULT '2002',
  `id_kur` int(4) NOT NULL DEFAULT '2002',
  `kode_mk` varchar(11) NOT NULL,
  `minggu_ke` char(2) DEFAULT NULL,
  `sesi` smallint(6) DEFAULT NULL,
  `judul` varchar(255) DEFAULT NULL,
  `inisial` varchar(15) DEFAULT NULL,
  `isi` longtext,
  `tgl_sesi` datetime DEFAULT NULL,
  `tgl_view` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `counter` int(11) DEFAULT '0',
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `group_kuliah_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_material`
--

CREATE TABLE `prkl_material` (
  `material_id` int(11) NOT NULL,
  `id_material` varchar(30) NOT NULL DEFAULT '',
  `kategori` varchar(255) NOT NULL DEFAULT '',
  `ta` int(4) NOT NULL DEFAULT '0',
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `kode_mk` varchar(11) NOT NULL,
  `judul` varchar(255) DEFAULT NULL,
  `aktifitas` varchar(255) DEFAULT NULL,
  `ket_setoran` varchar(255) DEFAULT NULL,
  `batas_akhir` datetime DEFAULT NULL,
  `metoda_penyerahan` enum('Hardcopy','Email','Web') DEFAULT 'Hardcopy',
  `tujuan` varchar(255) DEFAULT NULL,
  `tanggal` datetime DEFAULT NULL,
  `tgl_view` bigint(20) DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT '1',
  `komentar` char(1) DEFAULT '0',
  `isi` longtext,
  `material_kategori_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_material_files`
--

CREATE TABLE `prkl_material_files` (
  `material_files_id` int(11) NOT NULL,
  `id_material` varchar(30) NOT NULL DEFAULT '0',
  `nama_file` varchar(255) DEFAULT NULL,
  `kode_file` varchar(100) DEFAULT NULL COMMENT 'id file dari puro',
  `data` longblob,
  `ket` varchar(255) DEFAULT NULL,
  `tipe` varchar(50) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `lokasi` enum('DB','FILE') NOT NULL DEFAULT 'DB',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_material_kategori`
--

CREATE TABLE `prkl_material_kategori` (
  `material_kategori_id` int(11) NOT NULL,
  `kategori` varchar(255) NOT NULL DEFAULT '',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_penilaian_materi`
--

CREATE TABLE `prkl_penilaian_materi` (
  `penilaian_materi_id` int(11) NOT NULL,
  `id_kuesioner` int(11) DEFAULT NULL,
  `id_kur` int(11) DEFAULT NULL,
  `ta` int(11) DEFAULT NULL,
  `kode_mk` varchar(20) DEFAULT NULL,
  `peserta` varchar(20) DEFAULT NULL,
  `s1` int(11) DEFAULT NULL,
  `s2` int(11) DEFAULT NULL,
  `s3` int(11) DEFAULT NULL,
  `s4` int(11) DEFAULT NULL,
  `s5` int(11) DEFAULT NULL,
  `s6` int(11) DEFAULT NULL,
  `skor_total` int(11) DEFAULT NULL,
  `kuesioner_materi_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_penilaian_materi_nilai`
--

CREATE TABLE `prkl_penilaian_materi_nilai` (
  `penilaian_materi_nilai_id` int(11) NOT NULL,
  `id_kuesioner` int(11) DEFAULT NULL,
  `peserta` varchar(20) DEFAULT NULL,
  `kesulitan_materi` varchar(10) DEFAULT NULL,
  `pemahaman_mahasiswa` varchar(10) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_penilaian_praktikum`
--

CREATE TABLE `prkl_penilaian_praktikum` (
  `penilaian_praktikum_id` int(11) NOT NULL,
  `id_kuesioner` int(11) DEFAULT NULL,
  `id_kur` int(11) DEFAULT NULL,
  `ta` int(11) DEFAULT NULL,
  `kode_mk` varchar(20) DEFAULT NULL,
  `peserta` varchar(20) DEFAULT NULL,
  `s1` int(11) DEFAULT NULL,
  `s2` int(11) DEFAULT NULL,
  `s3` int(11) DEFAULT NULL,
  `s4` int(11) DEFAULT NULL,
  `s5` int(11) DEFAULT NULL,
  `s6` int(11) DEFAULT NULL,
  `skor_total` int(11) DEFAULT NULL,
  `kuesioner_praktikum_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_penilaian_praktikum_nilai`
--

CREATE TABLE `prkl_penilaian_praktikum_nilai` (
  `penilaian_praktikum_nilai_id` int(11) NOT NULL,
  `id_kuesioner` int(11) DEFAULT NULL,
  `peserta` varchar(20) DEFAULT NULL,
  `penyelesaian` varchar(20) DEFAULT NULL,
  `kesulitan_praktikum` varchar(20) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_penilaian_tim_pengajar`
--

CREATE TABLE `prkl_penilaian_tim_pengajar` (
  `penilaian_tim_pengajar_id` int(11) NOT NULL,
  `id_kuesioner` int(11) DEFAULT NULL,
  `user_id` varchar(20) DEFAULT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `ta` int(11) DEFAULT NULL,
  `kode_mk` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `k1` int(11) DEFAULT NULL,
  `k2` int(11) DEFAULT NULL,
  `k3` int(11) DEFAULT NULL,
  `k4` int(11) DEFAULT NULL,
  `k5` int(11) DEFAULT NULL,
  `k6` int(11) DEFAULT NULL,
  `skor_total` int(11) DEFAULT '0',
  `profile_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_penilaian_tim_pengajar_nilai`
--

CREATE TABLE `prkl_penilaian_tim_pengajar_nilai` (
  `penilaian_tim_pengajar_nilai_id` int(11) NOT NULL,
  `id_kuesioner` int(11) DEFAULT NULL,
  `user` varchar(20) DEFAULT NULL,
  `dosen_id` varchar(20) DEFAULT NULL,
  `ta` int(11) DEFAULT NULL,
  `status` varchar(11) DEFAULT NULL,
  `nilai` varchar(5) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_praktikum`
--

CREATE TABLE `prkl_praktikum` (
  `praktikum_id` int(11) NOT NULL,
  `no` smallint(6) NOT NULL DEFAULT '0',
  `ta` int(4) NOT NULL DEFAULT '0',
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `kode_mk` varchar(11) NOT NULL,
  `minggu_ke` smallint(6) DEFAULT NULL,
  `sesi` smallint(6) DEFAULT NULL,
  `topik` varchar(255) DEFAULT NULL,
  `aktifitas` varchar(255) DEFAULT NULL,
  `waktu_pengerjaan` varchar(50) DEFAULT NULL,
  `setoran` varchar(255) DEFAULT NULL,
  `batas_akhir` varchar(50) DEFAULT NULL,
  `tempat_penyerahan` varchar(50) DEFAULT NULL,
  `tujuan` varchar(255) DEFAULT NULL,
  `tanggal` datetime DEFAULT NULL,
  `tgl_view` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `counter` int(11) DEFAULT '1',
  `isi` longtext,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `group_kuliah_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_rpp`
--

CREATE TABLE `prkl_rpp` (
  `rpp_id` int(11) NOT NULL,
  `minggu` int(2) DEFAULT NULL,
  `sesi` int(2) DEFAULT NULL,
  `topik` text,
  `kurikulum_syllabus_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prkl_ruangan`
--

CREATE TABLE `prkl_ruangan` (
  `ruangan_id` int(11) NOT NULL,
  `kode_ruangan` varchar(20) NOT NULL DEFAULT '',
  `short_name` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(200) DEFAULT NULL,
  `kapasitas` int(11) DEFAULT NULL,
  `ket` text,
  `status` char(1) NOT NULL DEFAULT '1',
  `update_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_detil_program`
--

CREATE TABLE `rakx_detil_program` (
  `detil_program_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `desc` text,
  `jumlah` decimal(19,4) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_mata_anggaran`
--

CREATE TABLE `rakx_mata_anggaran` (
  `mata_anggaran_id` int(11) NOT NULL,
  `standar_id` int(11) DEFAULT NULL,
  `kode_anggaran` varchar(45) NOT NULL,
  `name` varchar(100) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_program`
--

CREATE TABLE `rakx_program` (
  `program_id` int(11) NOT NULL,
  `struktur_jabatan_has_mata_anggaran_id` int(11) NOT NULL,
  `kode_program` varchar(45) NOT NULL,
  `name` text NOT NULL,
  `tujuan` text,
  `sasaran` text,
  `target` text,
  `desc` text,
  `rencana_strategis_id` int(11) DEFAULT NULL,
  `volume` int(11) NOT NULL,
  `satuan_id` int(11) NOT NULL,
  `harga_satuan` decimal(19,4) NOT NULL,
  `jumlah_sebelum_revisi` decimal(19,4) NOT NULL,
  `jumlah` decimal(19,4) DEFAULT NULL,
  `status_program_id` int(11) DEFAULT NULL,
  `diusulkan_oleh` int(11) NOT NULL,
  `tanggal_diusulkan` datetime DEFAULT NULL,
  `dilaksanakan_oleh` int(11) DEFAULT NULL,
  `disetujui_oleh` int(11) DEFAULT NULL,
  `tanggal_disetujui` datetime DEFAULT NULL,
  `ditolak_oleh` int(11) DEFAULT NULL,
  `tanggal_ditolak` datetime DEFAULT NULL,
  `is_revisi` tinyint(1) DEFAULT '0',
  `direvisi_oleh` int(11) DEFAULT NULL,
  `tanggal_direvisi` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_program_has_sumber_dana`
--

CREATE TABLE `rakx_program_has_sumber_dana` (
  `program_has_sumber_dana_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `sumber_dana_id` int(11) NOT NULL,
  `jumlah` decimal(19,4) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_program_has_waktu`
--

CREATE TABLE `rakx_program_has_waktu` (
  `program_has_waktu_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `bulan_id` int(11) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_review_program`
--

CREATE TABLE `rakx_review_program` (
  `review_program_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `pejabat_id` int(11) NOT NULL,
  `review` text NOT NULL,
  `tanggal_review` datetime NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_r_bulan`
--

CREATE TABLE `rakx_r_bulan` (
  `bulan_id` int(11) NOT NULL,
  `bulan` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_r_rencana_strategis`
--

CREATE TABLE `rakx_r_rencana_strategis` (
  `rencana_strategis_id` int(11) NOT NULL,
  `nomor` varchar(11) NOT NULL,
  `name` text NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_r_satuan`
--

CREATE TABLE `rakx_r_satuan` (
  `satuan_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_r_standar`
--

CREATE TABLE `rakx_r_standar` (
  `standar_id` int(11) NOT NULL,
  `nomor` int(11) NOT NULL,
  `name` text NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_r_status_program`
--

CREATE TABLE `rakx_r_status_program` (
  `status_program_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_r_sumber_dana`
--

CREATE TABLE `rakx_r_sumber_dana` (
  `sumber_dana_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_r_tahun_anggaran`
--

CREATE TABLE `rakx_r_tahun_anggaran` (
  `tahun_anggaran_id` int(11) NOT NULL,
  `tahun` year(4) NOT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rakx_struktur_jabatan_has_mata_anggaran`
--

CREATE TABLE `rakx_struktur_jabatan_has_mata_anggaran` (
  `struktur_jabatan_has_mata_anggaran_id` int(11) NOT NULL,
  `struktur_jabatan_id` int(11) NOT NULL,
  `mata_anggaran_id` int(11) NOT NULL,
  `tahun_anggaran_id` int(11) NOT NULL,
  `subtotal` decimal(19,4) DEFAULT '0.0000',
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rprt_complaint`
--

CREATE TABLE `rprt_complaint` (
  `complaint_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `bagian_id` int(11) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `desc` text,
  `status_id` int(11) DEFAULT NULL,
  `estimated_date` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rprt_response`
--

CREATE TABLE `rprt_response` (
  `response_id` int(11) NOT NULL,
  `complaint_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rprt_r_bagian`
--

CREATE TABLE `rprt_r_bagian` (
  `bagian_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rprt_r_status`
--

CREATE TABLE `rprt_r_status` (
  `status_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `desc` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rprt_user_has_bagian`
--

CREATE TABLE `rprt_user_has_bagian` (
  `user_has_bagian_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `bagian_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `schd_event`
--

CREATE TABLE `schd_event` (
  `event_id` int(11) NOT NULL,
  `calender_id` int(11) NOT NULL,
  `event` varchar(150) NOT NULL,
  `desc` text,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `all_day` tinyint(1) DEFAULT '0',
  `lokasi_id` int(11) DEFAULT NULL,
  `lokasi_text` varchar(250) DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `schd_event_invitee`
--

CREATE TABLE `schd_event_invitee` (
  `event_invitee_id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `schd_file_event`
--

CREATE TABLE `schd_file_event` (
  `file_event_id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `nama_file` varchar(200) DEFAULT NULL,
  `kode_file` varchar(200) DEFAULT NULL,
  `ket` text,
  `ta` int(11) DEFAULT NULL,
  `sem_ta` int(11) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `schd_jadwal_kuliah`
--

CREATE TABLE `schd_jadwal_kuliah` (
  `jadwal_kuliah_id` int(11) NOT NULL,
  `kuliah_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `kelas_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `schd_r_calender`
--

CREATE TABLE `schd_r_calender` (
  `calender_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `desc` text,
  `is_public` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `schd_subscriber`
--

CREATE TABLE `schd_subscriber` (
  `subscriber_id` int(11) NOT NULL,
  `calender_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `srvy_kuesioner`
--

CREATE TABLE `srvy_kuesioner` (
  `kuesioner_id` int(11) NOT NULL,
  `sem` int(11) NOT NULL DEFAULT '0',
  `ta` int(11) NOT NULL DEFAULT '0',
  `kode_mk` varchar(11) DEFAULT NULL,
  `nama` varchar(255) NOT NULL DEFAULT '',
  `keterangan` text,
  `instruksi_pengisian` text,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `peserta_kuis` text,
  `is_login` char(1) NOT NULL DEFAULT '1',
  `nilai` float DEFAULT NULL,
  `wajib` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `id_kuesioner` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `srvy_kuesioner_jawaban_peserta`
--

CREATE TABLE `srvy_kuesioner_jawaban_peserta` (
  `kuesioner_jawaban_peserta_id` int(11) NOT NULL,
  `kuesioner_id` int(11) DEFAULT NULL,
  `kuesioner_pertanyaan_id` int(11) DEFAULT NULL,
  `jawaban` text,
  `peserta` varchar(30) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `id_kuesioner` int(11) DEFAULT '0',
  `id_pertanyaan` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `srvy_kuesioner_opsi`
--

CREATE TABLE `srvy_kuesioner_opsi` (
  `kuesioner_opsi_id` int(11) NOT NULL,
  `no_opsi` int(11) NOT NULL,
  `kuesioner_pertanyaan_id` int(11) DEFAULT NULL,
  `ket_opsi` text NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `id_pertanyaan` varchar(20) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `srvy_kuesioner_pertanyaan`
--

CREATE TABLE `srvy_kuesioner_pertanyaan` (
  `kuesioner_pertanyaan_id` int(11) NOT NULL,
  `kuesioner_id` int(11) DEFAULT NULL,
  `nomor` int(11) DEFAULT NULL,
  `pertanyaan` text,
  `tipe_opsi` enum('C','R','T') NOT NULL DEFAULT 'R',
  `kategori` varchar(200) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `id_kuesioner` int(11) DEFAULT '0',
  `id_pertanyaan` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `srvy_polling`
--

CREATE TABLE `srvy_polling` (
  `polling_id` int(11) NOT NULL,
  `poll_id` varchar(20) DEFAULT NULL,
  `kategori` varchar(50) DEFAULT 'All',
  `judul` varchar(255) DEFAULT NULL,
  `pertanyaan` text,
  `ket` text,
  `tgl_exp` datetime DEFAULT NULL,
  `tgl_view` datetime DEFAULT NULL,
  `wajib` tinyint(1) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `srvy_pollopsi`
--

CREATE TABLE `srvy_pollopsi` (
  `pollopsi_id` int(11) NOT NULL,
  `poll_id` varchar(20) DEFAULT NULL,
  `no_opsi` smallint(6) DEFAULT '0',
  `polling_id` int(11) DEFAULT NULL,
  `opsi` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `srvy_pollvote`
--

CREATE TABLE `srvy_pollvote` (
  `pollvote_id` int(11) NOT NULL,
  `poll_id` varchar(20) DEFAULT NULL,
  `polling_id` int(11) DEFAULT NULL,
  `no_opsi` smallint(6) DEFAULT '0',
  `pollopsi_id` int(11) DEFAULT NULL,
  `vote_by` int(11) DEFAULT NULL,
  `vote_by_old` varchar(50) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `srvy_workgroup_kuesioner`
--

CREATE TABLE `srvy_workgroup_kuesioner` (
  `workgroup_id` int(11) DEFAULT NULL,
  `kuesioner_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `srvy_workgroup_polling`
--

CREATE TABLE `srvy_workgroup_polling` (
  `workgroup_id` int(11) DEFAULT NULL,
  `polling_id` int(11) DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_action`
--

CREATE TABLE `sysx_action` (
  `action_id` int(11) NOT NULL,
  `controller_id` int(11) NOT NULL,
  `identifier` varchar(32) NOT NULL COMMENT 'Action Unique ID',
  `desc` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_application`
--

CREATE TABLE `sysx_application` (
  `application_id` int(11) NOT NULL,
  `identifier` varchar(32) NOT NULL COMMENT 'Application Unique ID',
  `desc` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL COMMENT '	',
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_authentication_method`
--

CREATE TABLE `sysx_authentication_method` (
  `authentication_method_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `server_address` varchar(45) DEFAULT NULL,
  `authentication_string` varchar(255) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `redirected` tinyint(1) DEFAULT '0',
  `redirect_to` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sysx_authentication_method`
--

INSERT INTO `sysx_authentication_method` (`authentication_method_id`, `name`, `server_address`, `authentication_string`, `desc`, `redirected`, `redirect_to`, `created_at`, `updated_at`, `created_by`, `updated_by`, `deleted`, `deleted_at`, `deleted_by`) VALUES
(1, 'Local Database', NULL, 'DATABASE', NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sysx_config`
--

CREATE TABLE `sysx_config` (
  `config_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `key` varchar(100) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_controller`
--

CREATE TABLE `sysx_controller` (
  `controller_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `identifier` varchar(32) NOT NULL COMMENT 'Controller Unique ID',
  `desc` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_job_allocation`
--

CREATE TABLE `sysx_job_allocation` (
  `job_allocation_id` int(11) NOT NULL,
  `job_definition_id` int(11) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_job_definition`
--

CREATE TABLE `sysx_job_definition` (
  `job_definition_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_log`
--

CREATE TABLE `sysx_log` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` varchar(500) DEFAULT NULL,
  `host` varchar(45) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_menu_group`
--

CREATE TABLE `sysx_menu_group` (
  `menu_group_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_menu_item`
--

CREATE TABLE `sysx_menu_item` (
  `menu_item_id` int(11) NOT NULL,
  `menu_group_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL,
  `alt` varchar(100) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `is_ajax` tinyint(1) NOT NULL DEFAULT '0',
  `container_id` varchar(45) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT '0',
  `order_number` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_module`
--

CREATE TABLE `sysx_module` (
  `module_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `identifier` varchar(32) NOT NULL COMMENT 'Module Unique ID',
  `desc` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_permission`
--

CREATE TABLE `sysx_permission` (
  `permission_id` int(11) NOT NULL,
  `action_id` int(11) NOT NULL,
  `identifier` varchar(32) NOT NULL COMMENT 'Permission Unique ID',
  `desc` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_profile`
--

CREATE TABLE `sysx_profile` (
  `profile_id` int(11) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `email_2` varchar(100) DEFAULT NULL,
  `mobile_phone_1` varchar(45) DEFAULT NULL,
  `mobile_phone_2` varchar(45) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `twitter` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_role`
--

CREATE TABLE `sysx_role` (
  `role_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_role_has_action`
--

CREATE TABLE `sysx_role_has_action` (
  `role_id` int(11) NOT NULL,
  `action_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_role_has_application`
--

CREATE TABLE `sysx_role_has_application` (
  `role_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_role_has_controller`
--

CREATE TABLE `sysx_role_has_controller` (
  `role_id` int(11) NOT NULL,
  `controller_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_role_has_menu_item`
--

CREATE TABLE `sysx_role_has_menu_item` (
  `menu_item_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_role_has_module`
--

CREATE TABLE `sysx_role_has_module` (
  `role_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_role_has_permission`
--

CREATE TABLE `sysx_role_has_permission` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_role_has_task`
--

CREATE TABLE `sysx_role_has_task` (
  `role_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_task`
--

CREATE TABLE `sysx_task` (
  `task_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `desc` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_telkom_sso_user`
--

CREATE TABLE `sysx_telkom_sso_user` (
  `telkom_sso_user_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `forward_auth` tinyint(1) DEFAULT '0' COMMENT 'Forward authentication to local authentication system, or terminate here with provided password',
  `active` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_telkom_sso_user_log`
--

CREATE TABLE `sysx_telkom_sso_user_log` (
  `telkom_sso_user_log_id` int(11) NOT NULL,
  `telkom_sso_user_id` int(11) NOT NULL,
  `action` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_user`
--

CREATE TABLE `sysx_user` (
  `user_id` int(11) NOT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `sysx_key` varchar(32) DEFAULT NULL,
  `authentication_method_id` int(11) NOT NULL DEFAULT '1',
  `username` varchar(255) NOT NULL,
  `auth_key` varchar(32) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sysx_user`
--

INSERT INTO `sysx_user` (`user_id`, `profile_id`, `sysx_key`, `authentication_method_id`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `status`, `created_at`, `updated_at`, `created_by`, `updated_by`, `deleted`, `deleted_at`, `deleted_by`) VALUES
(1, NULL, 'EWpd9wHy1YZpmGTSsP3_QFW5loktTIPU', 1, 'root', 'fxiViURunAzSxsCjfgbDseq4mFzcHX-L', '$2y$13$HW588THKyGY4JHlNIPbjsuLUQjrLfKB0uWuDA7/eOAdgef/NUeYHa', NULL, 'root@local.host', 1, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(2, NULL, 'MmYRLl4Y99SOTLDN1c1SiPTnt_XJ8X88', 1, 'leo', 'Y8X7ukWKH2jQdGyzJVDbuEORnIFFihCm', '$2y$13$Ce0nBcPRZnj5HhSzdEjmI.MNeRVumSDq.gL4UdDflbcy/Cyg.6BCm', NULL, 'leonaldopasaribu@gmail.com', 1, '2018-03-10 14:34:08', '2018-03-10 14:34:08', 'root', 'root', 0, NULL, NULL),
(3, NULL, 'ql0We2N7G_yxYA9DMRRYMz__cUWvgNZK', 1, 'jhon', 'wBFW46yKlwyPpSnSea6EXMzWlxf5-eKE', '$2y$13$1Uxyt42pBtYjFQv1ZAtELOcYUXxDtRoLqac8sUTihDzt/DxeEuJNG', NULL, 'jhonson@gmail.com', 1, '2018-04-25 14:58:29', '2018-04-25 14:58:29', 'root', 'root', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sysx_user_config`
--

CREATE TABLE `sysx_user_config` (
  `user_config_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `key` varchar(100) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '    ',
  `updated_by` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_user_has_role`
--

CREATE TABLE `sysx_user_has_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL COMMENT '	',
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_user_has_workgroup`
--

CREATE TABLE `sysx_user_has_workgroup` (
  `user_id` int(11) NOT NULL,
  `workgroup_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sysx_workgroup`
--

CREATE TABLE `sysx_workgroup` (
  `workgroup_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `protected` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tmbh_agenda`
--

CREATE TABLE `tmbh_agenda` (
  `agenda_id` int(11) NOT NULL,
  `id_agenda` varchar(20) NOT NULL DEFAULT '',
  `judul` varchar(255) DEFAULT NULL,
  `kategori` varchar(255) DEFAULT NULL,
  `isi` longtext,
  `status` char(1) DEFAULT '1',
  `tgl_start` datetime NOT NULL,
  `tgl_end` datetime NOT NULL,
  `waktu_notifikasi` int(11) DEFAULT NULL,
  `notifikasi_by_email` char(1) NOT NULL DEFAULT '0',
  `notifikasi_by_popup` char(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tmbh_file_pengumuman`
--

CREATE TABLE `tmbh_file_pengumuman` (
  `file_pengumuman_id` int(11) NOT NULL,
  `nama_file` text NOT NULL,
  `kode_file` varchar(50) DEFAULT NULL,
  `ket` text NOT NULL,
  `pengumuman_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` varchar(32) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tmbh_kamus_it`
--

CREATE TABLE `tmbh_kamus_it` (
  `kamus_it_id` int(11) NOT NULL,
  `word` varchar(255) NOT NULL DEFAULT '',
  `keterangan` text,
  `kategori` varchar(30) DEFAULT NULL,
  `status` char(1) DEFAULT '1',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tmbh_kegiatan`
--

CREATE TABLE `tmbh_kegiatan` (
  `kegiatan_id` int(11) NOT NULL,
  `nama_kegiatan` varchar(255) NOT NULL DEFAULT '',
  `penyelengara` varchar(100) DEFAULT NULL,
  `tanggal_mulai` date DEFAULT NULL,
  `tanggal_akhir` date DEFAULT NULL,
  `keterangan` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tmbh_news`
--

CREATE TABLE `tmbh_news` (
  `news_id` int(11) NOT NULL,
  `news_kategori_id` int(11) DEFAULT NULL,
  `id_news` varchar(20) NOT NULL DEFAULT '',
  `judul` varchar(255) DEFAULT NULL,
  `kat_id` varchar(30) DEFAULT NULL,
  `ket_gambar` varchar(255) DEFAULT NULL,
  `pre` text,
  `isi` longtext,
  `sumber` varchar(50) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT '1',
  `listing` char(1) DEFAULT '1',
  `komentar` char(1) DEFAULT '0',
  `language` char(3) NOT NULL DEFAULT 'INA',
  `tgl_start` datetime NOT NULL,
  `tgl_end` datetime NOT NULL,
  `last_post` bigint(20) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tmbh_news_files`
--

CREATE TABLE `tmbh_news_files` (
  `news_files_id` int(11) NOT NULL,
  `id_news` varchar(20) NOT NULL DEFAULT '0',
  `nama_file` varchar(255) NOT NULL DEFAULT '',
  `ket` varchar(255) DEFAULT NULL,
  `tipe` varchar(50) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tmbh_news_kategori`
--

CREATE TABLE `tmbh_news_kategori` (
  `news_kategori_id` int(11) NOT NULL,
  `kat_id` varchar(30) NOT NULL,
  `pkat_id` varchar(30) DEFAULT NULL,
  `kat_nama_ina` varchar(255) NOT NULL DEFAULT '',
  `kat_nama_eng` varchar(255) DEFAULT NULL,
  `kat_ket` varchar(255) DEFAULT NULL,
  `kat_icon` blob,
  `no_urut` smallint(6) NOT NULL DEFAULT '0',
  `kat_list` char(1) NOT NULL DEFAULT '1',
  `tipe` varchar(30) NOT NULL DEFAULT 'konten',
  `menu` varchar(255) DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL,
  `put_as_menu` varchar(30) NOT NULL DEFAULT '',
  `views` char(1) NOT NULL DEFAULT '1',
  `r_akses` varchar(255) DEFAULT NULL,
  `w_akses` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tmbh_news_komentar`
--

CREATE TABLE `tmbh_news_komentar` (
  `news_komentar_id` int(11) NOT NULL,
  `id_komentar` varchar(10) NOT NULL DEFAULT '',
  `id_news` varchar(20) NOT NULL DEFAULT '',
  `id_parent` varchar(10) DEFAULT NULL,
  `judul` varchar(255) DEFAULT NULL,
  `isi` longtext,
  `pengirim` varchar(50) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tmbh_pengumuman`
--

CREATE TABLE `tmbh_pengumuman` (
  `pengumuman_id` int(11) NOT NULL,
  `id` varchar(10) NOT NULL DEFAULT '',
  `kategori` varchar(50) NOT NULL DEFAULT '',
  `judul` varchar(255) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `isi` longtext,
  `tgl_exp` date DEFAULT NULL,
  `post_web` char(1) NOT NULL DEFAULT '1',
  `post_dinding` char(1) NOT NULL DEFAULT '0',
  `post_mail` char(1) NOT NULL DEFAULT '0',
  `done_tempel` char(1) NOT NULL DEFAULT '0',
  `done_cabut` char(1) NOT NULL DEFAULT '0',
  `isSticky` char(1) DEFAULT '0',
  `owner` int(11) DEFAULT NULL,
  `user_old` varchar(45) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tmbh_software_tools`
--

CREATE TABLE `tmbh_software_tools` (
  `software_tools_id` int(11) NOT NULL,
  `id_kur` int(4) NOT NULL DEFAULT '0',
  `kode_mk` varchar(8) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `kurikulum_id` int(11) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL,
  `updated_by` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absn_absensi`
--
ALTER TABLE `absn_absensi`
  ADD PRIMARY KEY (`absensi_id`),
  ADD KEY `FK_absn_absensi_sesi_kuliah_idx` (`sesi_kuliah_id`),
  ADD KEY `FK_absn_absensi_dim` (`dim_id`);

--
-- Indexes for table `absn_sesi_kuliah`
--
ALTER TABLE `absn_sesi_kuliah`
  ADD PRIMARY KEY (`sesi_kuliah_id`),
  ADD KEY `FK_absn_sesi_kuliah_lokasi_idx` (`lokasi_id`),
  ADD KEY `FK_absn_sesi_kuliah_penugasan_pengajaran` (`penugasan_pengajaran_id`);

--
-- Indexes for table `adak_kelas`
--
ALTER TABLE `adak_kelas`
  ADD PRIMARY KEY (`kelas_id`),
  ADD KEY `FK_adak_kelas_wali` (`dosen_wali_id`);

--
-- Indexes for table `adak_mahasiswa_assistant`
--
ALTER TABLE `adak_mahasiswa_assistant`
  ADD PRIMARY KEY (`mahasiswa_assistant_id`),
  ADD KEY `FK_adak_mahasiswa_assistant_pengajaran` (`pengajaran_id`),
  ADD KEY `FK_adak_mahasiswa_assistant_dim` (`dim_id`);

--
-- Indexes for table `adak_pengajaran`
--
ALTER TABLE `adak_pengajaran`
  ADD PRIMARY KEY (`pengajaran_id`),
  ADD KEY `FK_adak_pengajaran_kuliah` (`kuliah_id`);

--
-- Indexes for table `adak_penugasan_pengajaran`
--
ALTER TABLE `adak_penugasan_pengajaran`
  ADD PRIMARY KEY (`penugasan_pengajaran_id`),
  ADD KEY `FK_prkl_pengajaran_role_pengajar` (`role_pengajar_id`),
  ADD KEY `FK_adak_penugasan_pengajaran_pegawai` (`pegawai_id`),
  ADD KEY `FK_adak_penugasan_pengajaran` (`pengajaran_id`);

--
-- Indexes for table `adak_registrasi`
--
ALTER TABLE `adak_registrasi`
  ADD PRIMARY KEY (`registrasi_id`),
  ADD KEY `fk_t_registrasi_t_kelas1_idx` (`kelas_id`),
  ADD KEY `fk_t_registrasi_t_profile1_idx` (`dosen_wali_id`),
  ADD KEY `fk_t_registrasi_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `arsp_arsip`
--
ALTER TABLE `arsp_arsip`
  ADD PRIMARY KEY (`arsip_id`),
  ADD KEY `FK_arsip_user` (`user_id`);

--
-- Indexes for table `arsp_arsip_file`
--
ALTER TABLE `arsp_arsip_file`
  ADD PRIMARY KEY (`arsip_file_id`),
  ADD KEY `FK_arsip_file` (`arsip_id`);

--
-- Indexes for table `artk_post`
--
ALTER TABLE `artk_post`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `FK_artk_post_user` (`user_id`);

--
-- Indexes for table `artk_post_attachment`
--
ALTER TABLE `artk_post_attachment`
  ADD PRIMARY KEY (`post_attachment_id`),
  ADD KEY `FK_artk_post_attachment` (`post_id`);

--
-- Indexes for table `dimx_alumni`
--
ALTER TABLE `dimx_alumni`
  ADD PRIMARY KEY (`alumni_id`),
  ADD KEY `fk_t_alumni_t_dim1_idx` (`dim_id`),
  ADD KEY `FK_dimx_alumni_dosen_1` (`dosen_id_1`),
  ADD KEY `FK_dimx_alumni_dosen_2` (`dosen_id_2`);

--
-- Indexes for table `dimx_alumni_data`
--
ALTER TABLE `dimx_alumni_data`
  ADD PRIMARY KEY (`alumni_data_id`),
  ADD UNIQUE KEY `NIM_UNIQUE` (`nim`),
  ADD KEY `fk_t_alumni_data_t_alumni1_idx` (`alumni_id`);

--
-- Indexes for table `dimx_alumni_pekerjaan`
--
ALTER TABLE `dimx_alumni_pekerjaan`
  ADD PRIMARY KEY (`alumni_pekerjaan_id`),
  ADD KEY `fk_t_ALUMNI_PEKERJAAN_t_ALUMNI_DATA_idx` (`alumni_id`);

--
-- Indexes for table `dimx_dim`
--
ALTER TABLE `dimx_dim`
  ADD PRIMARY KEY (`dim_id`),
  ADD UNIQUE KEY `NIM_UNIQUE` (`nim`),
  ADD KEY `NIM` (`nim`),
  ADD KEY `FK_dimx_dim_thn_krkm` (`tahun_kurikulum_id`),
  ADD KEY `FK_dimx_dim_user` (`user_id`),
  ADD KEY `FK_dimx_dim_ref_kbk` (`ref_kbk_id`),
  ADD KEY `FK_dimx_dim_asal_sekolah` (`asal_sekolah_id`),
  ADD KEY `FK_dimx_dim_golongan_darah` (`golongan_darah_id`),
  ADD KEY `FK_dimx_dim_jenis_kelamin` (`jenis_kelamin_id`),
  ADD KEY `FK_dimx_dim_agama` (`agama_id`),
  ADD KEY `FK_dimx_dim_pekerjaan_ayah` (`pekerjaan_ayah_id`),
  ADD KEY `FK_dimx_dim_penghasilan_ayah` (`penghasilan_ayah_id`),
  ADD KEY `FK_dimx_dim_pekerjaan_ibu` (`pekerjaan_ibu_id`),
  ADD KEY `FK_dimx_dim_penghasilan_ibu` (`penghasilan_ibu_id`),
  ADD KEY `FK_dimx_dim_pekerjaan_wali` (`pekerjaan_wali_id`),
  ADD KEY `FK_dimx_dim_penghasilan_wali_id` (`penghasilan_wali_id`);

--
-- Indexes for table `dimx_dim_pmb`
--
ALTER TABLE `dimx_dim_pmb`
  ADD PRIMARY KEY (`dim_pmb_id`),
  ADD KEY `fk_t_dim_pmb_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `dimx_dim_pmb_daftar`
--
ALTER TABLE `dimx_dim_pmb_daftar`
  ADD PRIMARY KEY (`dim_pmb_daftar_id`),
  ADD UNIQUE KEY `no_umpid_UNIQUE` (`no_umpid`),
  ADD KEY `fk_t_dim_pmb_daftar_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `dimx_dim_trnon_lulus`
--
ALTER TABLE `dimx_dim_trnon_lulus`
  ADD PRIMARY KEY (`dim_trnon_lulus_id`),
  ADD KEY `fk_t_dim_trnon_lulus_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `dimx_dim_update`
--
ALTER TABLE `dimx_dim_update`
  ADD PRIMARY KEY (`dim_id`),
  ADD UNIQUE KEY `NIM_UNIQUE` (`nim`),
  ADD KEY `NIM` (`nim`),
  ADD KEY `FK_dimx_dim_thn_krkm` (`tahun_kurikulum_id`),
  ADD KEY `FK_dimx_dim_user` (`user_id`),
  ADD KEY `FK_dimx_dim_ref_kbk` (`ref_kbk_id`),
  ADD KEY `FK_dimx_dim_asal_sekolah` (`asal_sekolah_id`),
  ADD KEY `FK_dimx_dim_golongan_darah` (`golongan_darah_id`),
  ADD KEY `FK_dimx_dim_jenis_kelamin` (`jenis_kelamin_id`),
  ADD KEY `FK_dimx_dim_agama` (`agama_id`),
  ADD KEY `FK_dimx_dim_pekerjaan_ayah` (`pekerjaan_ayah_id`),
  ADD KEY `FK_dimx_dim_penghasilan_ayah` (`penghasilan_ayah_id`),
  ADD KEY `FK_dimx_dim_pekerjaan_ibu` (`pekerjaan_ibu_id`),
  ADD KEY `FK_dimx_dim_penghasilan_ibu` (`penghasilan_ibu_id`),
  ADD KEY `FK_dimx_dim_pekerjaan_wali` (`pekerjaan_wali_id`),
  ADD KEY `FK_dimx_dim_penghasilan_wali_id` (`penghasilan_wali_id`);

--
-- Indexes for table `dimx_histori_prodi`
--
ALTER TABLE `dimx_histori_prodi`
  ADD PRIMARY KEY (`histori_prodi_id`),
  ADD KEY `FK_dimx_histori_prodi` (`dim_id`);

--
-- Indexes for table `hrdx_dosen`
--
ALTER TABLE `hrdx_dosen`
  ADD PRIMARY KEY (`dosen_id`),
  ADD KEY `FK_hrdx_dosen` (`golongan_kepangkatan_id`),
  ADD KEY `FK_hrdx_dosen_jab` (`jabatan_akademik_id`),
  ADD KEY `FK_hrdx_dosen_stts` (`status_ikatan_kerja_dosen_id`),
  ADD KEY `FK_hrdx_dosen_gbk` (`gbk_1`),
  ADD KEY `FK_hrdx_dosen_pegawai` (`pegawai_id`),
  ADD KEY `FK_hrdx_dosen_gbk2` (`gbk_2`),
  ADD KEY `FK_hrdx_dosen_prodi` (`prodi_id`);

--
-- Indexes for table `hrdx_pegawai`
--
ALTER TABLE `hrdx_pegawai`
  ADD PRIMARY KEY (`pegawai_id`),
  ADD KEY `FK_hrdx_pegawai_JK` (`jenis_kelamin_id`),
  ADD KEY `FK_hrdx_pegawai_agama` (`agama_id`),
  ADD KEY `FK_hrdx_pegawai_golda` (`golongan_darah_id`),
  ADD KEY `FK_hrdx_pegawai_kab` (`kabupaten_id`),
  ADD KEY `FK_hrdx_pegawai_sts_aktf` (`status_aktif_pegawai_id`),
  ADD KEY `FK_hrdx_pegawai_sts_iktn` (`status_ikatan_kerja_pegawai_id`),
  ADD KEY `FK_hrdx_pegawai_sts_martl` (`status_marital_id`),
  ADD KEY `FK_hrdx_pegawai_user` (`user_id`),
  ADD KEY `FK_hrdx_pegawai_jabatan_akademik` (`jabatan_akademik_id`),
  ADD KEY `FK_hrdx_pegawai_kbk` (`ref_kbk_id`);

--
-- Indexes for table `hrdx_pendidikan`
--
ALTER TABLE `hrdx_pendidikan`
  ADD PRIMARY KEY (`pendidikan_id`),
  ADD KEY `fk_t_pendidikan_t_profile1_idx` (`profile_id`);

--
-- Indexes for table `hrdx_pengajar`
--
ALTER TABLE `hrdx_pengajar`
  ADD PRIMARY KEY (`pengajar_id`),
  ADD KEY `fk_t_pengajar_t_kurikulum1_idx` (`kurikulum_id`),
  ADD KEY `FK_hrdx_pengajar` (`pegawai_id`);

--
-- Indexes for table `hrdx_profile`
--
ALTER TABLE `hrdx_profile`
  ADD PRIMARY KEY (`profile_id`),
  ADD KEY `ID` (`profile_id`),
  ADD KEY `NAMA` (`nama`);

--
-- Indexes for table `hrdx_riwayat_pendidikan`
--
ALTER TABLE `hrdx_riwayat_pendidikan`
  ADD PRIMARY KEY (`riwayat_pendidikan_id`),
  ADD KEY `fk_t_pendidikan_t_profile1_idx` (`profile_id`),
  ADD KEY `FK_hrdx_riwayat_pendidikan_new_pegawai` (`pegawai_id`),
  ADD KEY `FK_hrdx_riwayat_pendidikan_new_jenjang` (`jenjang_id`);

--
-- Indexes for table `hrdx_riwayat_pendidikan_old`
--
ALTER TABLE `hrdx_riwayat_pendidikan_old`
  ADD KEY `FK_hrdx_riwayat_pendidikan_dosen` (`dosen_id`),
  ADD KEY `FK_hrdx_riwayat_pendidikan_staf` (`staf_id`),
  ADD KEY `FK_hrdx_riwayat_pendidikan_jenjang` (`jenjang_id`);

--
-- Indexes for table `hrdx_r_staf_role`
--
ALTER TABLE `hrdx_r_staf_role`
  ADD PRIMARY KEY (`staf_role_id`);

--
-- Indexes for table `hrdx_staf`
--
ALTER TABLE `hrdx_staf`
  ADD PRIMARY KEY (`staf_id`),
  ADD KEY `FK_hrdx_staf_pegawai` (`pegawai_id`),
  ADD KEY `FK_hrdx_staf_prodi` (`prodi_id`),
  ADD KEY `FK_hrdx_staf_role` (`staf_role_id`);

--
-- Indexes for table `inst_instansi`
--
ALTER TABLE `inst_instansi`
  ADD PRIMARY KEY (`instansi_id`);

--
-- Indexes for table `inst_pejabat`
--
ALTER TABLE `inst_pejabat`
  ADD PRIMARY KEY (`pejabat_id`),
  ADD KEY `FK_pejabat_struktur_jabatan_idx` (`struktur_jabatan_id`),
  ADD KEY `FK_inst_pejabat_pegawai` (`pegawai_id`);

--
-- Indexes for table `inst_prodi`
--
ALTER TABLE `inst_prodi`
  ADD PRIMARY KEY (`ref_kbk_id`),
  ADD UNIQUE KEY `KBK_ID_UNIQUE` (`kbk_id`),
  ADD KEY `FK_krkm_r_kbk` (`jenjang_id`);

--
-- Indexes for table `inst_r_jenjang`
--
ALTER TABLE `inst_r_jenjang`
  ADD PRIMARY KEY (`jenjang_id`);

--
-- Indexes for table `inst_struktur_jabatan`
--
ALTER TABLE `inst_struktur_jabatan`
  ADD PRIMARY KEY (`struktur_jabatan_id`),
  ADD KEY `FK_struktur_jabatan_instansi_idx` (`instansi_id`),
  ADD KEY `FK_struktur_jabatan_struktur_jabatan_idx` (`parent`),
  ADD KEY `FK_struktur_jabatan_unit_idx` (`unit_id`);

--
-- Indexes for table `inst_unit`
--
ALTER TABLE `inst_unit`
  ADD PRIMARY KEY (`unit_id`),
  ADD KEY `FK_unit_struktur_jabatan_idx` (`kepala`),
  ADD KEY `FK_unit_instansi_idx` (`instansi_id`);

--
-- Indexes for table `invt_arsip_vendor`
--
ALTER TABLE `invt_arsip_vendor`
  ADD PRIMARY KEY (`arsip_vendor_id`),
  ADD KEY `FK_invt_arsip_vendor` (`vendor_id`);

--
-- Indexes for table `invt_barang`
--
ALTER TABLE `invt_barang`
  ADD PRIMARY KEY (`barang_id`),
  ADD KEY `FK_invt_barang` (`jenis_barang_id`),
  ADD KEY `FK_invt_barang_kategori` (`kategori_id`),
  ADD KEY `FK_invt_barang_satuan` (`satuan_id`),
  ADD KEY `FK_invt_barang_unit` (`unit_id`),
  ADD KEY `FK_invt_barang_brand` (`brand_id`),
  ADD KEY `FK_invt_barang_vendor` (`vendor_id`);

--
-- Indexes for table `invt_detail_peminjaman_barang`
--
ALTER TABLE `invt_detail_peminjaman_barang`
  ADD PRIMARY KEY (`detail_peminjaman_barang_id`),
  ADD KEY `FK_invt_detail_peminjaman_barang` (`peminjaman_barang_id`),
  ADD KEY `FK_invt_detail_peminjaman_barang_barang` (`barang_id`);

--
-- Indexes for table `invt_file_vendor`
--
ALTER TABLE `invt_file_vendor`
  ADD PRIMARY KEY (`file_vendor_id`),
  ADD KEY `FK_invt_file_vendor` (`arsip_vendor_id`);

--
-- Indexes for table `invt_keterangan_pengeluaran`
--
ALTER TABLE `invt_keterangan_pengeluaran`
  ADD PRIMARY KEY (`keterangan_pengeluaran_id`);

--
-- Indexes for table `invt_pelaporan_barang_rusak`
--
ALTER TABLE `invt_pelaporan_barang_rusak`
  ADD PRIMARY KEY (`pelaporan_barang_rusak`),
  ADD KEY `FK_invt_barang_rusak` (`barang_id`),
  ADD KEY `FK_invt_barang_rusak_pelapor` (`pelapor`),
  ADD KEY `FK_invt_pelaporan_barang_rusak_unit` (`unit_id`);

--
-- Indexes for table `invt_pemindahan_barang`
--
ALTER TABLE `invt_pemindahan_barang`
  ADD PRIMARY KEY (`pemindahan_barang_id`),
  ADD KEY `FK_invt_pemindahan_barang` (`pengeluaran_barang_id`);

--
-- Indexes for table `invt_peminjaman_barang`
--
ALTER TABLE `invt_peminjaman_barang`
  ADD PRIMARY KEY (`peminjaman_barang_id`),
  ADD KEY `FK_invt_peminjaman_approved_by` (`approved_by`),
  ADD KEY `FK_invt_peminjaman_oleh` (`oleh`),
  ADD KEY `FK_invt_peminjaman_barang_unit` (`unit_id`),
  ADD KEY `FK_invt_peminjaman_barang_status_approval` (`status_approval`);

--
-- Indexes for table `invt_pengeluaran_barang`
--
ALTER TABLE `invt_pengeluaran_barang`
  ADD PRIMARY KEY (`pengeluaran_barang_id`),
  ADD KEY `FK_invt_detail_pengeluaran_barang_barang` (`barang_id`),
  ADD KEY `FK_invt_pengeluaran_barang` (`lokasi_id`),
  ADD KEY `FK_invt_pengeluaran_barang_STATUS` (`status_akhir`),
  ADD KEY `FK_invt_pengeluaran_barang_keterangan` (`keterangan_pengeluaran_id`);

--
-- Indexes for table `invt_pic_barang`
--
ALTER TABLE `invt_pic_barang`
  ADD PRIMARY KEY (`pic_barang_id`),
  ADD KEY `FK_invt_pic_barang` (`pengeluaran_barang_id`),
  ADD KEY `FK_invt_pic_barang_pegawai` (`pegawai_id`);

--
-- Indexes for table `invt_pic_barang_file`
--
ALTER TABLE `invt_pic_barang_file`
  ADD PRIMARY KEY (`pic_barang_file_id`),
  ADD KEY `FK_invt_pic_barang_file` (`pic_barang_id`);

--
-- Indexes for table `invt_r_brand`
--
ALTER TABLE `invt_r_brand`
  ADD PRIMARY KEY (`brand_id`);

--
-- Indexes for table `invt_r_jenis_barang`
--
ALTER TABLE `invt_r_jenis_barang`
  ADD PRIMARY KEY (`jenis_barang_id`);

--
-- Indexes for table `invt_r_kategori`
--
ALTER TABLE `invt_r_kategori`
  ADD PRIMARY KEY (`kategori_id`);

--
-- Indexes for table `invt_r_lokasi`
--
ALTER TABLE `invt_r_lokasi`
  ADD PRIMARY KEY (`lokasi_id`);

--
-- Indexes for table `invt_r_satuan`
--
ALTER TABLE `invt_r_satuan`
  ADD PRIMARY KEY (`satuan_id`);

--
-- Indexes for table `invt_r_status`
--
ALTER TABLE `invt_r_status`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `status_unique` (`nama`);

--
-- Indexes for table `invt_r_unit`
--
ALTER TABLE `invt_r_unit`
  ADD PRIMARY KEY (`unit_id`);

--
-- Indexes for table `invt_r_vendor`
--
ALTER TABLE `invt_r_vendor`
  ADD PRIMARY KEY (`vendor_id`);

--
-- Indexes for table `invt_summary_jumlah`
--
ALTER TABLE `invt_summary_jumlah`
  ADD PRIMARY KEY (`summary_jumlah_id`),
  ADD KEY `FK_invt_summary_jumlah` (`barang_id`);

--
-- Indexes for table `invt_unit_charged`
--
ALTER TABLE `invt_unit_charged`
  ADD PRIMARY KEY (`unit_charged_id`),
  ADD KEY `FK_invt_unit_user_unit` (`unit_id`),
  ADD KEY `FK_invt_unit_user_user` (`user_id`);

--
-- Indexes for table `kmhs_detail_kasus`
--
ALTER TABLE `kmhs_detail_kasus`
  ADD PRIMARY KEY (`detail_kasus_id`),
  ADD KEY `fk_t_detail_kasus_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `kmhs_master_kasus`
--
ALTER TABLE `kmhs_master_kasus`
  ADD PRIMARY KEY (`master_kasus`),
  ADD UNIQUE KEY `NIM_UNIQUE` (`nim`),
  ADD KEY `fk_t_master_kasus_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `kmhs_nilai_perilaku`
--
ALTER TABLE `kmhs_nilai_perilaku`
  ADD PRIMARY KEY (`nilai_perilaku_id`),
  ADD KEY `KRITERIA` (`kriteria`),
  ADD KEY `NIM` (`nim`),
  ADD KEY `fk_t_nilai_perilaku_t_kriteria_nilai_perilaku1_idx` (`kriteria_nilai_perilaku_id`),
  ADD KEY `fk_t_nilai_perilaku_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `kmhs_nilai_perilaku_arsip`
--
ALTER TABLE `kmhs_nilai_perilaku_arsip`
  ADD PRIMARY KEY (`nilai_perilaku_arsip_id`),
  ADD KEY `KRITERIA` (`kriteria`),
  ADD KEY `NIM` (`nim`),
  ADD KEY `fk_t_nilai_perilaku_arsip_t_kriteria_nilai_perilaku1_idx` (`kriteria_nilai_perilaku_id`),
  ADD KEY `fk_t_nilai_perilaku_arsip_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `kmhs_nilai_perilaku_as`
--
ALTER TABLE `kmhs_nilai_perilaku_as`
  ADD PRIMARY KEY (`nilai_perilaku_as_id`),
  ADD KEY `fk_t_nilai_perilaku_as_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `kmhs_nilai_perilaku_summary`
--
ALTER TABLE `kmhs_nilai_perilaku_summary`
  ADD PRIMARY KEY (`nilai_perilaku_summary_id`),
  ADD KEY `fk_t_nilai_perilaku_summary_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `kmhs_nilai_perilaku_ts`
--
ALTER TABLE `kmhs_nilai_perilaku_ts`
  ADD PRIMARY KEY (`nilai_perilaku_ts`),
  ADD KEY `fk_t_nilai_perilaku_ts_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `kmhs_r_kasus`
--
ALTER TABLE `kmhs_r_kasus`
  ADD PRIMARY KEY (`ref_kasus_id`);

--
-- Indexes for table `kmhs_r_kriteria_nilai_perilaku`
--
ALTER TABLE `kmhs_r_kriteria_nilai_perilaku`
  ADD PRIMARY KEY (`kriteria_nilai_perilaku_id`),
  ADD UNIQUE KEY `KRITERIA_UNIQUE` (`kriteria`);

--
-- Indexes for table `krkm_course_group`
--
ALTER TABLE `krkm_course_group`
  ADD PRIMARY KEY (`course_group_id`),
  ADD UNIQUE KEY `ID_UNIQUE` (`id`);

--
-- Indexes for table `krkm_kuliah`
--
ALTER TABLE `krkm_kuliah`
  ADD PRIMARY KEY (`kuliah_id`),
  ADD KEY `KODE_MK_2` (`kode_mk`),
  ADD KEY `NAMA_KUL_IND` (`nama_kul_ind`),
  ADD KEY `NAMA_KUL_ING` (`nama_kul_ing`),
  ADD KEY `fk_t_kurikulum_t_ref_kbk2_idx` (`ref_kbk_id`),
  ADD KEY `FK_krkm_kurikulum` (`tahun_kurikulum_id`),
  ADD KEY `FK_krkm_kurikulum_cg` (`course_group_id`);

--
-- Indexes for table `krkm_kuliah_prodi`
--
ALTER TABLE `krkm_kuliah_prodi`
  ADD PRIMARY KEY (`krkm_kuliah_prodi_id`),
  ADD KEY `FK_krkm_kuliah_prodi` (`kuliah_id`),
  ADD KEY `FK_krkm_kuliah_prodi_ref_kbk` (`ref_kbk_id`);

--
-- Indexes for table `krkm_kurikulum_prodi`
--
ALTER TABLE `krkm_kurikulum_prodi`
  ADD PRIMARY KEY (`kurikulum_prodi_id`),
  ADD KEY `fk_t_kurikulum_prodi_t_kurikulum1_idx` (`kurikulum_id`),
  ADD KEY `fk_t_kurikulum_prodi_t_ref_kbk1_idx` (`ref_kbk_id`);

--
-- Indexes for table `krkm_prerequisite_courses`
--
ALTER TABLE `krkm_prerequisite_courses`
  ADD PRIMARY KEY (`prerequisite_courses_id`),
  ADD KEY `FK_krkm_prerequisite_courses_kuri` (`kuliah_id`),
  ADD KEY `FK_krkm_prerequisite_courses_kuri_pre` (`kuliah_pre_id`);

--
-- Indexes for table `krkm_r_tahun_kurikulum`
--
ALTER TABLE `krkm_r_tahun_kurikulum`
  ADD PRIMARY KEY (`tahun_kurikulum_id`);

--
-- Indexes for table `krkm_sifat_kuliah`
--
ALTER TABLE `krkm_sifat_kuliah`
  ADD PRIMARY KEY (`sifat_kuliah_id`);

--
-- Indexes for table `labx_alat`
--
ALTER TABLE `labx_alat`
  ADD PRIMARY KEY (`alat_id`),
  ADD KEY `fk_lab` (`lab_id`),
  ADD KEY `fk_lemari` (`lemari_id`);

--
-- Indexes for table `labx_bahan`
--
ALTER TABLE `labx_bahan`
  ADD PRIMARY KEY (`bahan_id`),
  ADD KEY `fk_lab_bahan` (`lab_id`),
  ADD KEY `fk_lemari_bahan` (`lemari_id`),
  ADD KEY `fk_satuan` (`satuan_id`);

--
-- Indexes for table `labx_item_pemesanan`
--
ALTER TABLE `labx_item_pemesanan`
  ADD PRIMARY KEY (`item_pemesanan_id`),
  ADD KEY `fk_bahan_oesan` (`bahan_id`),
  ADD KEY `fk_pemesanan_bahan` (`pemesanan_id`);

--
-- Indexes for table `labx_item_peminjaman`
--
ALTER TABLE `labx_item_peminjaman`
  ADD PRIMARY KEY (`item_peminjaman_id`),
  ADD KEY `fk_item_alat` (`alat_id`),
  ADD KEY `fk_item_peminjaman` (`peminjaman_id`);

--
-- Indexes for table `labx_lab`
--
ALTER TABLE `labx_lab`
  ADD PRIMARY KEY (`lab_id`);

--
-- Indexes for table `labx_lemari`
--
ALTER TABLE `labx_lemari`
  ADD PRIMARY KEY (`lemari_id`);

--
-- Indexes for table `labx_pemesanan`
--
ALTER TABLE `labx_pemesanan`
  ADD PRIMARY KEY (`pemesanan_id`),
  ADD KEY `fk_pemesan_bahan` (`user_id`),
  ADD KEY `fk_status` (`status_id`),
  ADD KEY `fk_kuliah2` (`kuliah_id`),
  ADD KEY `fk_tujuan2` (`tujuan_id`);

--
-- Indexes for table `labx_peminjaman`
--
ALTER TABLE `labx_peminjaman`
  ADD PRIMARY KEY (`peminjaman_id`),
  ADD KEY `fk_peminjam_alat` (`user_id`),
  ADD KEY `fk_status_peminjaman` (`status_id`),
  ADD KEY `fk_tujuan_peminjaman` (`tujuan_id`),
  ADD KEY `fk_kuliah` (`kuliah_id`);

--
-- Indexes for table `labx_penambahan_stock_alat`
--
ALTER TABLE `labx_penambahan_stock_alat`
  ADD PRIMARY KEY (`penambahan_alat_id`),
  ADD KEY `alatfk2` (`alat_id`),
  ADD KEY `statusfk` (`status_id`),
  ADD KEY `userfk` (`user_id`);

--
-- Indexes for table `labx_penambahan_stock_bahan`
--
ALTER TABLE `labx_penambahan_stock_bahan`
  ADD PRIMARY KEY (`penambahan_bahan_id`),
  ADD KEY `userfkbahan` (`user_id`),
  ADD KEY `bahanfk2` (`bahan_id`),
  ADD KEY `statusfk` (`status_id`);

--
-- Indexes for table `labx_r_status`
--
ALTER TABLE `labx_r_status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indexes for table `labx_r_tujuan`
--
ALTER TABLE `labx_r_tujuan`
  ADD PRIMARY KEY (`tujuan_id`);

--
-- Indexes for table `labx_satuan`
--
ALTER TABLE `labx_satuan`
  ADD PRIMARY KEY (`satuan_id`);

--
-- Indexes for table `lppm_penelitian`
--
ALTER TABLE `lppm_penelitian`
  ADD PRIMARY KEY (`penelitian_id`);

--
-- Indexes for table `lppm_penelitian_dosen`
--
ALTER TABLE `lppm_penelitian_dosen`
  ADD PRIMARY KEY (`penelitian_dosen_id`),
  ADD KEY `dosen_id` (`dosen_id`),
  ADD KEY `lppm_penelitian_dosen_ibfk_3` (`penelitian_id`);

--
-- Indexes for table `lppm_r_karyailmiah`
--
ALTER TABLE `lppm_r_karyailmiah`
  ADD PRIMARY KEY (`karyailmiah_id`);

--
-- Indexes for table `lppm_r_subkaryailmiah`
--
ALTER TABLE `lppm_r_subkaryailmiah`
  ADD PRIMARY KEY (`subkaryailmiah_id`),
  ADD KEY `FK_lppm_r_subkaryailmiah` (`karyailmiah_id`);

--
-- Indexes for table `lppm_t_author_publikasi`
--
ALTER TABLE `lppm_t_author_publikasi`
  ADD PRIMARY KEY (`author_publikasi_id`),
  ADD KEY `FK_lppm_t_author_publikasi` (`publikasi_id`);

--
-- Indexes for table `lppm_t_ketua_gbk`
--
ALTER TABLE `lppm_t_ketua_gbk`
  ADD PRIMARY KEY (`ketuagbk_id`),
  ADD KEY `FK_lppm_t_ketua_gbk_dosen` (`dosen_id`),
  ADD KEY `FK_lppm_t_ketua_gbk_gbk` (`gbk_id`);

--
-- Indexes for table `lppm_t_logreview`
--
ALTER TABLE `lppm_t_logreview`
  ADD PRIMARY KEY (`logreview_id`),
  ADD KEY `FK_lppm_t_logreview_pegawai` (`pegawai_id`),
  ADD KEY `FK_lppm_t_logreview_publikasi` (`publikasi_id`);

--
-- Indexes for table `lppm_t_publikasi`
--
ALTER TABLE `lppm_t_publikasi`
  ADD PRIMARY KEY (`publikasi_id`),
  ADD KEY `FK_lppm_t_publikasi_pegawai` (`pegawai_id`),
  ADD KEY `FK_lppm_t_publikasi_sub_karya_ilmiah` (`subkaryailmiah_id`),
  ADD KEY `FK_lppm_t_publikasi_gbk` (`gbk_id`);

--
-- Indexes for table `lppm_t_registrasipublikasi`
--
ALTER TABLE `lppm_t_registrasipublikasi`
  ADD PRIMARY KEY (`registrasipublikasi_id`),
  ADD KEY `FK_lppm_t_registrasipublikasi_publikasi` (`publikasi_id`);

--
-- Indexes for table `lppm_t_registrasi_file`
--
ALTER TABLE `lppm_t_registrasi_file`
  ADD PRIMARY KEY (`registrasifile_id`),
  ADD KEY `FK_lppm_t_registrasi_file` (`registrasipublikasi_id`);

--
-- Indexes for table `lppm_t_registrasi_jurnal`
--
ALTER TABLE `lppm_t_registrasi_jurnal`
  ADD PRIMARY KEY (`registrasi_jurnal_id`),
  ADD KEY `FK_lppm_t_registrasi_jurnal` (`publikasi_id`);

--
-- Indexes for table `lppm_t_registrasi_jurnal_file`
--
ALTER TABLE `lppm_t_registrasi_jurnal_file`
  ADD PRIMARY KEY (`registrasi_jurnal_file_id`),
  ADD KEY `FK_lppm_t_registrasi_jurnal_file` (`registrasi_jurnal_id`);

--
-- Indexes for table `lppm_t_registrasi_prosiding`
--
ALTER TABLE `lppm_t_registrasi_prosiding`
  ADD PRIMARY KEY (`registrasi_prosiding_id`),
  ADD KEY `FK_lppm_t_registrasi_prosiding` (`publikasi_id`);

--
-- Indexes for table `lppm_t_registrasi_prosiding_file`
--
ALTER TABLE `lppm_t_registrasi_prosiding_file`
  ADD PRIMARY KEY (`registrasi_prosiding_file_id`),
  ADD KEY `FK_lppm_t_registrasi_prosiding_file` (`registrasi_prosiding_id`);

--
-- Indexes for table `lppm_t_review_file`
--
ALTER TABLE `lppm_t_review_file`
  ADD PRIMARY KEY (`reviewfile_id`),
  ADD KEY `FK_lppm_t_review_file_log_review` (`logreview_id`);

--
-- Indexes for table `lppm_t_rewardpublikasi`
--
ALTER TABLE `lppm_t_rewardpublikasi`
  ADD PRIMARY KEY (`rewardpublikasi_id`),
  ADD KEY `FK_lppm_t_rewardpublikasi` (`publikasi_id`);

--
-- Indexes for table `lppm_t_reward_file`
--
ALTER TABLE `lppm_t_reward_file`
  ADD PRIMARY KEY (`rewardfile_id`),
  ADD KEY `FK_lppm_t_reward_file` (`rewardpublikasi_id`);

--
-- Indexes for table `lppm_t_reward_jurnal`
--
ALTER TABLE `lppm_t_reward_jurnal`
  ADD PRIMARY KEY (`reward_jurnal_id`),
  ADD KEY `FK_lppm_t_reward_jurnal` (`publikasi_id`);

--
-- Indexes for table `lppm_t_reward_jurnal_file`
--
ALTER TABLE `lppm_t_reward_jurnal_file`
  ADD PRIMARY KEY (`reward_jurnal_file_id`),
  ADD KEY `FK_lppm_t_reward_jurnal_file` (`reward_jurnal_id`);

--
-- Indexes for table `lppm_t_reward_prosiding`
--
ALTER TABLE `lppm_t_reward_prosiding`
  ADD PRIMARY KEY (`reward_prosiding_id`),
  ADD KEY `FK_lppm_t_reward_prosiding` (`publikasi_id`);

--
-- Indexes for table `lppm_t_reward_prosiding_file`
--
ALTER TABLE `lppm_t_reward_prosiding_file`
  ADD PRIMARY KEY (`reward_prosiding_file_id`),
  ADD KEY `FK_lppm_t_reward_prosiding_file` (`reward_prosiding_id`);

--
-- Indexes for table `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `mref_r_agama`
--
ALTER TABLE `mref_r_agama`
  ADD PRIMARY KEY (`agama_id`);

--
-- Indexes for table `mref_r_asal_sekolah`
--
ALTER TABLE `mref_r_asal_sekolah`
  ADD PRIMARY KEY (`asal_sekolah_id`),
  ADD KEY `FK_mref_r_asal_sekolah` (`kabupaten_id`),
  ADD KEY `FK_mref_r_asal_sekolah_provinsi` (`provinsi_id`);

--
-- Indexes for table `mref_r_bidang_pekerjaan`
--
ALTER TABLE `mref_r_bidang_pekerjaan`
  ADD PRIMARY KEY (`bidang_pekerjaan_id`);

--
-- Indexes for table `mref_r_bidang_perusahaan`
--
ALTER TABLE `mref_r_bidang_perusahaan`
  ADD PRIMARY KEY (`bidang_perusahaan_id`);

--
-- Indexes for table `mref_r_gbk`
--
ALTER TABLE `mref_r_gbk`
  ADD PRIMARY KEY (`gbk_id`);

--
-- Indexes for table `mref_r_gelombang_pmb`
--
ALTER TABLE `mref_r_gelombang_pmb`
  ADD PRIMARY KEY (`gelombang_pmb_id`);

--
-- Indexes for table `mref_r_golongan_darah`
--
ALTER TABLE `mref_r_golongan_darah`
  ADD PRIMARY KEY (`golongan_darah_id`);

--
-- Indexes for table `mref_r_golongan_kepangkatan`
--
ALTER TABLE `mref_r_golongan_kepangkatan`
  ADD PRIMARY KEY (`golongan_kepangkatan_id`);

--
-- Indexes for table `mref_r_jabatan_akademik`
--
ALTER TABLE `mref_r_jabatan_akademik`
  ADD PRIMARY KEY (`jabatan_akademik_id`);

--
-- Indexes for table `mref_r_jenis_kelamin`
--
ALTER TABLE `mref_r_jenis_kelamin`
  ADD PRIMARY KEY (`jenis_kelamin_id`);

--
-- Indexes for table `mref_r_jenjang`
--
ALTER TABLE `mref_r_jenjang`
  ADD PRIMARY KEY (`jenjang_id`);

--
-- Indexes for table `mref_r_kabupaten`
--
ALTER TABLE `mref_r_kabupaten`
  ADD PRIMARY KEY (`kabupaten_id`);

--
-- Indexes for table `mref_r_lokasi`
--
ALTER TABLE `mref_r_lokasi`
  ADD PRIMARY KEY (`lokasi_id`);

--
-- Indexes for table `mref_r_pekerjaan`
--
ALTER TABLE `mref_r_pekerjaan`
  ADD PRIMARY KEY (`pekerjaan_id`);

--
-- Indexes for table `mref_r_pendidikan`
--
ALTER TABLE `mref_r_pendidikan`
  ADD PRIMARY KEY (`pendidikan_id`);

--
-- Indexes for table `mref_r_pengali_nilai`
--
ALTER TABLE `mref_r_pengali_nilai`
  ADD PRIMARY KEY (`pengali_nilai_id`);

--
-- Indexes for table `mref_r_penghasilan`
--
ALTER TABLE `mref_r_penghasilan`
  ADD PRIMARY KEY (`penghasilan_id`);

--
-- Indexes for table `mref_r_predikat_lulus`
--
ALTER TABLE `mref_r_predikat_lulus`
  ADD PRIMARY KEY (`predikat_lulus_id`);

--
-- Indexes for table `mref_r_provinsi`
--
ALTER TABLE `mref_r_provinsi`
  ADD PRIMARY KEY (`provinsi_id`);

--
-- Indexes for table `mref_r_role_pengajar`
--
ALTER TABLE `mref_r_role_pengajar`
  ADD PRIMARY KEY (`role_pengajar_id`);

--
-- Indexes for table `mref_r_sem_ta`
--
ALTER TABLE `mref_r_sem_ta`
  ADD PRIMARY KEY (`sem_ta_id`);

--
-- Indexes for table `mref_r_sifat_kurikulum`
--
ALTER TABLE `mref_r_sifat_kurikulum`
  ADD PRIMARY KEY (`sifat_kurikulum_id`);

--
-- Indexes for table `mref_r_status_aktif_mahasiswa`
--
ALTER TABLE `mref_r_status_aktif_mahasiswa`
  ADD PRIMARY KEY (`status_aktif_mahasiswa_id`);

--
-- Indexes for table `mref_r_status_aktif_pegawai`
--
ALTER TABLE `mref_r_status_aktif_pegawai`
  ADD PRIMARY KEY (`status_aktif_pegawai_id`);

--
-- Indexes for table `mref_r_status_ikatan_kerja_dosen`
--
ALTER TABLE `mref_r_status_ikatan_kerja_dosen`
  ADD PRIMARY KEY (`status_ikatan_kerja_dosen_id`);

--
-- Indexes for table `mref_r_status_ikatan_kerja_pegawai`
--
ALTER TABLE `mref_r_status_ikatan_kerja_pegawai`
  ADD PRIMARY KEY (`status_ikatan_kerja_pegawai_id`);

--
-- Indexes for table `mref_r_status_marital`
--
ALTER TABLE `mref_r_status_marital`
  ADD PRIMARY KEY (`status_marital_id`);

--
-- Indexes for table `mref_r_ta`
--
ALTER TABLE `mref_r_ta`
  ADD PRIMARY KEY (`ta_id`);

--
-- Indexes for table `nlai_ext_mhs`
--
ALTER TABLE `nlai_ext_mhs`
  ADD PRIMARY KEY (`ext_mhs_id`),
  ADD KEY `FK_nlai_ext_mhs` (`ext_id`),
  ADD KEY `FK_nlai_ext_mhs_dim` (`dim_id`);

--
-- Indexes for table `nlai_file_nilai`
--
ALTER TABLE `nlai_file_nilai`
  ADD PRIMARY KEY (`file_nilai_id`);

--
-- Indexes for table `nlai_komponen_tambahan`
--
ALTER TABLE `nlai_komponen_tambahan`
  ADD PRIMARY KEY (`komponen_tambahan_id`),
  ADD KEY `FK_nlai_komponen_tambahan_syllabus` (`kurikulum_syllabus_id`);

--
-- Indexes for table `nlai_komposisi_nilai`
--
ALTER TABLE `nlai_komposisi_nilai`
  ADD PRIMARY KEY (`komposisi_nilai_id`),
  ADD KEY `fk_t_komposisi_nilai_t_kurikulum1_idx` (`kurikulum_syllabus_id`);

--
-- Indexes for table `nlai_komposisi_nilai_uts_uas`
--
ALTER TABLE `nlai_komposisi_nilai_uts_uas`
  ADD PRIMARY KEY (`komposisi_nilai_uts_uas_id`),
  ADD KEY `FK_nlai_komposisi_nilai_uts_uas` (`kurikulum_syllabus_id`);

--
-- Indexes for table `nlai_nilai`
--
ALTER TABLE `nlai_nilai`
  ADD PRIMARY KEY (`nilai_id`),
  ADD KEY `NIM` (`nim`),
  ADD KEY `fk_t_nilai_t_dim1_idx` (`dim_id`),
  ADD KEY `fk_t_nilai_t_kurikulum1_idx` (`kurikulum_syllabus_id`);

--
-- Indexes for table `nlai_nilai_komponen_tambahan`
--
ALTER TABLE `nlai_nilai_komponen_tambahan`
  ADD PRIMARY KEY (`nilai_komponen_tambahan_id`),
  ADD KEY `FK_nlai_nilai_komponen_tambahan_syllabus` (`kurikulum_syllabus_id`),
  ADD KEY `FK_nlai_nilai_komponen_tambahan-dim` (`dim_id`);

--
-- Indexes for table `nlai_nilai_praktikum`
--
ALTER TABLE `nlai_nilai_praktikum`
  ADD PRIMARY KEY (`nilai_praktikum_id`),
  ADD KEY `fk_t_nilai_praktikum_t_dim1_idx` (`dim_id`),
  ADD KEY `fk_t_nilai_praktikum_t_kurikulum1_idx` (`kurikulum_syllabus_id`);

--
-- Indexes for table `nlai_nilai_quis`
--
ALTER TABLE `nlai_nilai_quis`
  ADD PRIMARY KEY (`nilai_quis_id`),
  ADD KEY `fk_t_nilai_quis_t_dim1_idx` (`dim_id`),
  ADD KEY `fk_t_nilai_quis_t_kurikulum1_idx` (`kurikulum_syllabus_id`);

--
-- Indexes for table `nlai_nilai_tugas`
--
ALTER TABLE `nlai_nilai_tugas`
  ADD PRIMARY KEY (`nilai_tugas_id`),
  ADD KEY `fk_t_nilai_tugas_t_dim1_idx` (`dim_id`),
  ADD KEY `fk_t_nilai_tugas_t_kurikulum1_idx` (`kurikulum_syllabus_id`);

--
-- Indexes for table `nlai_nilai_uas`
--
ALTER TABLE `nlai_nilai_uas`
  ADD PRIMARY KEY (`nilai_uas_id`),
  ADD KEY `fk_t_nilai_uas_t_dim1_idx` (`dim_id`),
  ADD KEY `fk_t_nilai_uas_t_kurikulum1_idx` (`kurikulum_syllabus_id`);

--
-- Indexes for table `nlai_nilai_uts`
--
ALTER TABLE `nlai_nilai_uts`
  ADD PRIMARY KEY (`nilai_uts_id`),
  ADD KEY `fk_t_nilai_uts_t_dim1_idx` (`dim_id`),
  ADD KEY `fk_t_nilai_uts_t_kurikulum1_idx` (`kurikulum_syllabus_id`);

--
-- Indexes for table `nlai_rentang_nilai`
--
ALTER TABLE `nlai_rentang_nilai`
  ADD PRIMARY KEY (`rentang_nilai_id`),
  ADD KEY `fk_t_rentang_nilai_t_kurikulum1_idx` (`kurikulum_syllabus_id`);

--
-- Indexes for table `nlai_r_ext`
--
ALTER TABLE `nlai_r_ext`
  ADD PRIMARY KEY (`ext_id`);

--
-- Indexes for table `nlai_uas_detail`
--
ALTER TABLE `nlai_uas_detail`
  ADD PRIMARY KEY (`uas_detail_id`),
  ADD KEY `FK_nlai_uas_detail` (`kurikulum_syllabus_id`),
  ADD KEY `FK_nlai_uas_detail_komposisi` (`komposisi_nilai_uts_uas_id`),
  ADD KEY `FK_nlai_uas_detail_dim` (`dim_id`);

--
-- Indexes for table `nlai_uts_detail`
--
ALTER TABLE `nlai_uts_detail`
  ADD PRIMARY KEY (`uts_detail_id`),
  ADD KEY `FK_nlai_uts_detail` (`kurikulum_syllabus_id`),
  ADD KEY `FK_nlai_uts_detail_komposisi` (`komposisi_nilai_uts_uas_id`),
  ADD KEY `FK_nlai_uts_detail_dim` (`dim_id`);

--
-- Indexes for table `prkl_berita_acara_daftar_hadir`
--
ALTER TABLE `prkl_berita_acara_daftar_hadir`
  ADD PRIMARY KEY (`berita_acara_daftar_hadir_id`),
  ADD KEY `fk_t_berita_acara_daftar_hadir_t_kurikulum1_idx` (`kurikulum_id`),
  ADD KEY `fk_t_berita_acara_daftar_hadir_t_dim1_idx` (`dim_id`);

--
-- Indexes for table `prkl_berita_acara_kuliah`
--
ALTER TABLE `prkl_berita_acara_kuliah`
  ADD PRIMARY KEY (`berita_acara_kuliah_id`),
  ADD KEY `fk_t_berita_acara_kuliah_t_kurikulum1_idx` (`kurikulum_id`),
  ADD KEY `fk_t_berita_acara_kuliah_t_kelas1_idx` (`kelas_id`);

--
-- Indexes for table `prkl_course_unit`
--
ALTER TABLE `prkl_course_unit`
  ADD PRIMARY KEY (`course_unit_id`),
  ADD KEY `WEEK` (`week`),
  ADD KEY `SESSION` (`session`),
  ADD KEY `TOPIK` (`topik`),
  ADD KEY `fk_t_course_unit_t_kurikulum1_idx` (`kurikulum_syllabus_id`),
  ADD KEY `FK_prkl_course_unit_pic` (`pegawai_id`);

--
-- Indexes for table `prkl_course_unit_material`
--
ALTER TABLE `prkl_course_unit_material`
  ADD PRIMARY KEY (`course_unit_material_id`),
  ADD KEY `fk_t_course_unit_material_t_kurikulum1_idx` (`kurikulum_id`),
  ADD KEY `fk_t_course_unit_material_t_material1_idx` (`material_id`);

--
-- Indexes for table `prkl_file`
--
ALTER TABLE `prkl_file`
  ADD PRIMARY KEY (`file_id`),
  ADD KEY `fk_t_file_t_kurikulum1_idx` (`kurikulum_syllabus_id`);

--
-- Indexes for table `prkl_file_materi`
--
ALTER TABLE `prkl_file_materi`
  ADD PRIMARY KEY (`file_materi_id`),
  ADD KEY `FK_prkl_file_materi` (`materi_id`);

--
-- Indexes for table `prkl_file_praktikum`
--
ALTER TABLE `prkl_file_praktikum`
  ADD PRIMARY KEY (`file_praktikum_id`),
  ADD KEY `FK_prkl_file_praktikum` (`praktikum_id`);

--
-- Indexes for table `prkl_file_syllabus`
--
ALTER TABLE `prkl_file_syllabus`
  ADD PRIMARY KEY (`file_syllabus_id`),
  ADD KEY `FK_prkl_file_syllabus` (`kurikulum_syllabus_id`);

--
-- Indexes for table `prkl_group_kuliah`
--
ALTER TABLE `prkl_group_kuliah`
  ADD PRIMARY KEY (`group_kuliah_id`),
  ADD KEY `FK_prkl_group_kuliah_syllabus` (`kurikulum_syllabus_id`);

--
-- Indexes for table `prkl_info_ta`
--
ALTER TABLE `prkl_info_ta`
  ADD PRIMARY KEY (`info_ta_id`),
  ADD KEY `FK_prkl_info_ta_dim` (`dim_id`),
  ADD KEY `FK_prkl_info_ta_pembimbing1` (`pembimbing_1`),
  ADD KEY `FK_prkl_info_ta_pembimbing2` (`pembimbing_2`);

--
-- Indexes for table `prkl_jadwal`
--
ALTER TABLE `prkl_jadwal`
  ADD PRIMARY KEY (`jadwal_id`);

--
-- Indexes for table `prkl_krs_detail`
--
ALTER TABLE `prkl_krs_detail`
  ADD PRIMARY KEY (`krs_detail_id`),
  ADD KEY `FK_prkl_krs_detail` (`krs_mhs_id`),
  ADD KEY `FK_prkl_krs_detail_kuliah` (`kuliah_id`),
  ADD KEY `FK_prkl_krs_detail_pengajaran` (`pengajaran_id`);

--
-- Indexes for table `prkl_krs_mhs`
--
ALTER TABLE `prkl_krs_mhs`
  ADD PRIMARY KEY (`krs_mhs_id`),
  ADD KEY `FK_prkl_krs_mhs_ta_kur` (`tahun_kurikulum_id`),
  ADD KEY `FK_prkl_krs_mhs_ta` (`ta`),
  ADD KEY `FK_prkl_krs_mhs-dim` (`dim_id`),
  ADD KEY `FK_prkl_krs_mhs_wali` (`approved_by`);

--
-- Indexes for table `prkl_krs_review`
--
ALTER TABLE `prkl_krs_review`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `FK_prkl_krs_review_dosen` (`comment_by`),
  ADD KEY `FK_prkl_krs_review` (`krs_mhs_id`);

--
-- Indexes for table `prkl_kuesioner_materi`
--
ALTER TABLE `prkl_kuesioner_materi`
  ADD PRIMARY KEY (`kuesioner_materi_id`),
  ADD KEY `FK_t_kuesioner_materi` (`kurikulum_id`);

--
-- Indexes for table `prkl_kuesioner_praktikum`
--
ALTER TABLE `prkl_kuesioner_praktikum`
  ADD PRIMARY KEY (`kuesioner_praktikum_id`),
  ADD KEY `FK_t_kuesioner_praktikum` (`kuliah_id`);

--
-- Indexes for table `prkl_kurikulum_syllabus`
--
ALTER TABLE `prkl_kurikulum_syllabus`
  ADD PRIMARY KEY (`kurikulum_syllabus_id`),
  ADD KEY `KODE_MK_2` (`kode_mk`),
  ADD KEY `ID_KUR` (`id_kur`),
  ADD KEY `KODE_MK_3` (`kode_mk`),
  ADD KEY `TA` (`ta`),
  ADD KEY `fk_t_kurikulum_syllabus_t_kurikulum1_idx` (`kuliah_id`),
  ADD KEY `FK_prkl_kurikulum_syllabus_ta` (`ta_id`);

--
-- Indexes for table `prkl_kurikulum_syllabus_file`
--
ALTER TABLE `prkl_kurikulum_syllabus_file`
  ADD PRIMARY KEY (`kurikulum_syllabus_file_id`),
  ADD KEY `FK_prkl_kurikulum_syllabus_file` (`kurikulum_syllabus_id`);

--
-- Indexes for table `prkl_materi`
--
ALTER TABLE `prkl_materi`
  ADD PRIMARY KEY (`materi_id`),
  ADD KEY `FK_prkl_materi_syllabus` (`kurikulum_syllabus_id`),
  ADD KEY `FK_prkl_materi_group_kuliah` (`group_kuliah_id`);

--
-- Indexes for table `prkl_material`
--
ALTER TABLE `prkl_material`
  ADD PRIMARY KEY (`material_id`),
  ADD KEY `ID_MATERIAL` (`material_id`),
  ADD KEY `fk_t_material_t_material_kategori1_idx` (`material_kategori_id`);

--
-- Indexes for table `prkl_material_files`
--
ALTER TABLE `prkl_material_files`
  ADD PRIMARY KEY (`material_files_id`),
  ADD KEY `ID_MATERIAL` (`id_material`),
  ADD KEY `NAMA_FILE` (`nama_file`);

--
-- Indexes for table `prkl_material_kategori`
--
ALTER TABLE `prkl_material_kategori`
  ADD PRIMARY KEY (`material_kategori_id`),
  ADD UNIQUE KEY `KATEGORI_UNIQUE` (`kategori`);

--
-- Indexes for table `prkl_penilaian_materi`
--
ALTER TABLE `prkl_penilaian_materi`
  ADD PRIMARY KEY (`penilaian_materi_id`),
  ADD KEY `fk_t_penilaian_materi_t_kuesioner_materi1_idx` (`kuesioner_materi_id`);

--
-- Indexes for table `prkl_penilaian_materi_nilai`
--
ALTER TABLE `prkl_penilaian_materi_nilai`
  ADD PRIMARY KEY (`penilaian_materi_nilai_id`);

--
-- Indexes for table `prkl_penilaian_praktikum`
--
ALTER TABLE `prkl_penilaian_praktikum`
  ADD PRIMARY KEY (`penilaian_praktikum_id`),
  ADD KEY `fk_t_penilaian_praktikum_t_kuesioner_praktikum1_idx` (`kuesioner_praktikum_id`);

--
-- Indexes for table `prkl_penilaian_praktikum_nilai`
--
ALTER TABLE `prkl_penilaian_praktikum_nilai`
  ADD PRIMARY KEY (`penilaian_praktikum_nilai_id`);

--
-- Indexes for table `prkl_penilaian_tim_pengajar`
--
ALTER TABLE `prkl_penilaian_tim_pengajar`
  ADD PRIMARY KEY (`penilaian_tim_pengajar_id`),
  ADD KEY `FK_prkl_penilaian_tim_pengajar_profile` (`profile_id`);

--
-- Indexes for table `prkl_penilaian_tim_pengajar_nilai`
--
ALTER TABLE `prkl_penilaian_tim_pengajar_nilai`
  ADD PRIMARY KEY (`penilaian_tim_pengajar_nilai_id`);

--
-- Indexes for table `prkl_praktikum`
--
ALTER TABLE `prkl_praktikum`
  ADD PRIMARY KEY (`praktikum_id`),
  ADD KEY `NO` (`no`),
  ADD KEY `TOPIK` (`topik`),
  ADD KEY `fk_t_praktikum_t_kurikulum1_idx` (`kurikulum_syllabus_id`),
  ADD KEY `FK_prkl_praktikum_group_kuliah` (`group_kuliah_id`);

--
-- Indexes for table `prkl_rpp`
--
ALTER TABLE `prkl_rpp`
  ADD PRIMARY KEY (`rpp_id`),
  ADD KEY `FK_prkl_rpp_kurikulum_syllabus` (`kurikulum_syllabus_id`);

--
-- Indexes for table `prkl_ruangan`
--
ALTER TABLE `prkl_ruangan`
  ADD PRIMARY KEY (`ruangan_id`),
  ADD UNIQUE KEY `KODE_RUANGAN_UNIQUE` (`kode_ruangan`);

--
-- Indexes for table `rakx_detil_program`
--
ALTER TABLE `rakx_detil_program`
  ADD PRIMARY KEY (`detil_program_id`),
  ADD KEY `fk_detil_program_program_idx` (`program_id`);

--
-- Indexes for table `rakx_mata_anggaran`
--
ALTER TABLE `rakx_mata_anggaran`
  ADD PRIMARY KEY (`mata_anggaran_id`),
  ADD KEY `fk_mata_anggaran_standar_idx` (`standar_id`),
  ADD KEY `KODE_ANGGARAN` (`kode_anggaran`),
  ADD KEY `NAME` (`name`);

--
-- Indexes for table `rakx_program`
--
ALTER TABLE `rakx_program`
  ADD PRIMARY KEY (`program_id`),
  ADD KEY `fk_program_satuan_idx` (`satuan_id`),
  ADD KEY `fk_program_rencana_strategis_idx` (`rencana_strategis_id`),
  ADD KEY `fk_program_struktur_jabatan_has_mata_anggaran_idx` (`struktur_jabatan_has_mata_anggaran_id`),
  ADD KEY `fk_program_status_program_idx` (`status_program_id`),
  ADD KEY `fk_program_pengusul_idx` (`diusulkan_oleh`),
  ADD KEY `fk_program_pelaksana_idx` (`dilaksanakan_oleh`),
  ADD KEY `fk_program_perevisi_idx` (`direvisi_oleh`),
  ADD KEY `fk_program_disetujui_idx` (`disetujui_oleh`),
  ADD KEY `fk_program_ditolak_idx` (`ditolak_oleh`),
  ADD KEY `KODE_PROGRAM` (`kode_program`);

--
-- Indexes for table `rakx_program_has_sumber_dana`
--
ALTER TABLE `rakx_program_has_sumber_dana`
  ADD PRIMARY KEY (`program_has_sumber_dana_id`),
  ADD KEY `fk_program_has_sumber_dana_program_idx` (`program_id`),
  ADD KEY `fk_program_has_sumber_dana_sumber_dana_idx` (`sumber_dana_id`);

--
-- Indexes for table `rakx_program_has_waktu`
--
ALTER TABLE `rakx_program_has_waktu`
  ADD PRIMARY KEY (`program_has_waktu_id`),
  ADD KEY `fk_program_has_waktu_program_idx` (`program_id`),
  ADD KEY `fk_program_has_waktu_bulan_idx` (`bulan_id`);

--
-- Indexes for table `rakx_review_program`
--
ALTER TABLE `rakx_review_program`
  ADD PRIMARY KEY (`review_program_id`),
  ADD KEY `fk_review_anggaran_program_idx` (`program_id`),
  ADD KEY `TANGGAL_REVIEW` (`tanggal_review`),
  ADD KEY `fk_review_anggaran_pejabat_idx` (`pejabat_id`);

--
-- Indexes for table `rakx_r_bulan`
--
ALTER TABLE `rakx_r_bulan`
  ADD PRIMARY KEY (`bulan_id`);

--
-- Indexes for table `rakx_r_rencana_strategis`
--
ALTER TABLE `rakx_r_rencana_strategis`
  ADD PRIMARY KEY (`rencana_strategis_id`);

--
-- Indexes for table `rakx_r_satuan`
--
ALTER TABLE `rakx_r_satuan`
  ADD PRIMARY KEY (`satuan_id`);

--
-- Indexes for table `rakx_r_standar`
--
ALTER TABLE `rakx_r_standar`
  ADD PRIMARY KEY (`standar_id`);

--
-- Indexes for table `rakx_r_status_program`
--
ALTER TABLE `rakx_r_status_program`
  ADD PRIMARY KEY (`status_program_id`);

--
-- Indexes for table `rakx_r_sumber_dana`
--
ALTER TABLE `rakx_r_sumber_dana`
  ADD PRIMARY KEY (`sumber_dana_id`);

--
-- Indexes for table `rakx_r_tahun_anggaran`
--
ALTER TABLE `rakx_r_tahun_anggaran`
  ADD PRIMARY KEY (`tahun_anggaran_id`);

--
-- Indexes for table `rakx_struktur_jabatan_has_mata_anggaran`
--
ALTER TABLE `rakx_struktur_jabatan_has_mata_anggaran`
  ADD PRIMARY KEY (`struktur_jabatan_has_mata_anggaran_id`),
  ADD KEY `fk_struktur_jabatan_has_mata_anggaran_struktur_jabatan_idx` (`struktur_jabatan_id`),
  ADD KEY `fk_struktur_jabatan_has_mata_anggaran_mata_anggaran_idx` (`mata_anggaran_id`),
  ADD KEY `fk_struktur_jabatan_has_mata_anggaran_tahun_anggaran_idx` (`tahun_anggaran_id`);

--
-- Indexes for table `rprt_complaint`
--
ALTER TABLE `rprt_complaint`
  ADD PRIMARY KEY (`complaint_id`),
  ADD KEY `FK_rprt_complaint_status` (`status_id`),
  ADD KEY `FK_rprt_complaint_user` (`user_id`),
  ADD KEY `FK_rprt_complaint_bagian` (`bagian_id`);

--
-- Indexes for table `rprt_response`
--
ALTER TABLE `rprt_response`
  ADD PRIMARY KEY (`response_id`),
  ADD KEY `FK_rprt_response_complaint` (`complaint_id`),
  ADD KEY `FK_rprt_response_user` (`user_id`);

--
-- Indexes for table `rprt_r_bagian`
--
ALTER TABLE `rprt_r_bagian`
  ADD PRIMARY KEY (`bagian_id`);

--
-- Indexes for table `rprt_r_status`
--
ALTER TABLE `rprt_r_status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indexes for table `rprt_user_has_bagian`
--
ALTER TABLE `rprt_user_has_bagian`
  ADD PRIMARY KEY (`user_has_bagian_id`),
  ADD KEY `FK_rprt_user_has_bagian_user` (`user_id`),
  ADD KEY `FK_rprt_user_has_bagian_bagian` (`bagian_id`);

--
-- Indexes for table `schd_event`
--
ALTER TABLE `schd_event`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `FK_schd_event` (`lokasi_id`),
  ADD KEY `FK_schd_event_calender` (`calender_id`);

--
-- Indexes for table `schd_event_invitee`
--
ALTER TABLE `schd_event_invitee`
  ADD PRIMARY KEY (`event_invitee_id`),
  ADD KEY `FK_schd_event_invitee` (`event_id`),
  ADD KEY `FK_schd_event_invitee-user` (`user_id`);

--
-- Indexes for table `schd_file_event`
--
ALTER TABLE `schd_file_event`
  ADD PRIMARY KEY (`file_event_id`),
  ADD KEY `FK_schd_file_event_file` (`event_id`);

--
-- Indexes for table `schd_jadwal_kuliah`
--
ALTER TABLE `schd_jadwal_kuliah`
  ADD PRIMARY KEY (`jadwal_kuliah_id`),
  ADD KEY `FK_schd_jadwal_kuliah` (`event_id`),
  ADD KEY `FK_schd_jadwal_kuliah_kuliah` (`kuliah_id`),
  ADD KEY `FK_schd_jadwal_kuliah_kelas` (`kelas_id`);

--
-- Indexes for table `schd_r_calender`
--
ALTER TABLE `schd_r_calender`
  ADD PRIMARY KEY (`calender_id`);

--
-- Indexes for table `schd_subscriber`
--
ALTER TABLE `schd_subscriber`
  ADD PRIMARY KEY (`subscriber_id`),
  ADD KEY `FK_schd_subscriber` (`calender_id`);

--
-- Indexes for table `srvy_kuesioner`
--
ALTER TABLE `srvy_kuesioner`
  ADD PRIMARY KEY (`kuesioner_id`),
  ADD KEY `ID_KUESIONER` (`kuesioner_id`);

--
-- Indexes for table `srvy_kuesioner_jawaban_peserta`
--
ALTER TABLE `srvy_kuesioner_jawaban_peserta`
  ADD PRIMARY KEY (`kuesioner_jawaban_peserta_id`),
  ADD KEY `FK_srvy_kuesioner_jawaban_peserta` (`kuesioner_pertanyaan_id`),
  ADD KEY `FK_srvy_kuesioner_jawaban_peserta_kuesioner` (`kuesioner_id`),
  ADD KEY `FK_srvy_kuesioner_jawaban_peserta_user` (`user_id`);

--
-- Indexes for table `srvy_kuesioner_opsi`
--
ALTER TABLE `srvy_kuesioner_opsi`
  ADD PRIMARY KEY (`kuesioner_opsi_id`),
  ADD KEY `NO_OPSI` (`kuesioner_opsi_id`),
  ADD KEY `FK_srvy_kuesioner_opsi_pertanyaan` (`kuesioner_pertanyaan_id`);

--
-- Indexes for table `srvy_kuesioner_pertanyaan`
--
ALTER TABLE `srvy_kuesioner_pertanyaan`
  ADD PRIMARY KEY (`kuesioner_pertanyaan_id`),
  ADD KEY `ID_KUESIONER` (`id_kuesioner`),
  ADD KEY `ID_PERTANYAAN` (`id_pertanyaan`),
  ADD KEY `fk_t_kuesioner_pertanyaan_t_kuesioner1_idx` (`kuesioner_id`);

--
-- Indexes for table `srvy_polling`
--
ALTER TABLE `srvy_polling`
  ADD PRIMARY KEY (`polling_id`),
  ADD UNIQUE KEY `POLL_ID_UNIQUE` (`poll_id`);

--
-- Indexes for table `srvy_pollopsi`
--
ALTER TABLE `srvy_pollopsi`
  ADD PRIMARY KEY (`pollopsi_id`),
  ADD KEY `fk_t_POLLOPSI_t_POLLING1_idx` (`polling_id`);

--
-- Indexes for table `srvy_pollvote`
--
ALTER TABLE `srvy_pollvote`
  ADD PRIMARY KEY (`pollvote_id`),
  ADD KEY `FK_t_pollvote` (`pollopsi_id`),
  ADD KEY `FK_srvy_pollvote_polling_id` (`polling_id`);

--
-- Indexes for table `srvy_workgroup_kuesioner`
--
ALTER TABLE `srvy_workgroup_kuesioner`
  ADD KEY `FK_srvy_workgroup_kuesioner_wg` (`workgroup_id`),
  ADD KEY `FK_srvy_workgroup_kuesioner_kuesioner` (`kuesioner_id`);

--
-- Indexes for table `srvy_workgroup_polling`
--
ALTER TABLE `srvy_workgroup_polling`
  ADD KEY `FK_srvy_workgroup_polling_wk` (`workgroup_id`),
  ADD KEY `FK_srvy_workgroup_polling_poll` (`polling_id`);

--
-- Indexes for table `sysx_action`
--
ALTER TABLE `sysx_action`
  ADD PRIMARY KEY (`action_id`),
  ADD KEY `fk_action_controller1_idx` (`controller_id`);

--
-- Indexes for table `sysx_application`
--
ALTER TABLE `sysx_application`
  ADD PRIMARY KEY (`application_id`);

--
-- Indexes for table `sysx_authentication_method`
--
ALTER TABLE `sysx_authentication_method`
  ADD PRIMARY KEY (`authentication_method_id`);

--
-- Indexes for table `sysx_config`
--
ALTER TABLE `sysx_config`
  ADD PRIMARY KEY (`config_id`),
  ADD KEY `fk_config_application1_idx` (`application_id`);

--
-- Indexes for table `sysx_controller`
--
ALTER TABLE `sysx_controller`
  ADD PRIMARY KEY (`controller_id`),
  ADD KEY `fk_controller_module1_idx` (`module_id`);

--
-- Indexes for table `sysx_job_allocation`
--
ALTER TABLE `sysx_job_allocation`
  ADD PRIMARY KEY (`job_allocation_id`),
  ADD KEY `fk_job_allocation_job_definition1_idx` (`job_definition_id`);

--
-- Indexes for table `sysx_job_definition`
--
ALTER TABLE `sysx_job_definition`
  ADD PRIMARY KEY (`job_definition_id`);

--
-- Indexes for table `sysx_log`
--
ALTER TABLE `sysx_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `fk_Log_user1_idx` (`user_id`);

--
-- Indexes for table `sysx_menu_group`
--
ALTER TABLE `sysx_menu_group`
  ADD PRIMARY KEY (`menu_group_id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Indexes for table `sysx_menu_item`
--
ALTER TABLE `sysx_menu_item`
  ADD PRIMARY KEY (`menu_item_id`),
  ADD KEY `fk_menu_item_menu_group1_idx` (`menu_group_id`);

--
-- Indexes for table `sysx_module`
--
ALTER TABLE `sysx_module`
  ADD PRIMARY KEY (`module_id`),
  ADD KEY `fk_module_application1_idx` (`application_id`);

--
-- Indexes for table `sysx_permission`
--
ALTER TABLE `sysx_permission`
  ADD PRIMARY KEY (`permission_id`),
  ADD KEY `fk_permission_action1_idx` (`action_id`);

--
-- Indexes for table `sysx_profile`
--
ALTER TABLE `sysx_profile`
  ADD PRIMARY KEY (`profile_id`);

--
-- Indexes for table `sysx_role`
--
ALTER TABLE `sysx_role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `sysx_role_has_action`
--
ALTER TABLE `sysx_role_has_action`
  ADD PRIMARY KEY (`role_id`,`action_id`),
  ADD KEY `fk_role_has_action_action1_idx` (`action_id`),
  ADD KEY `fk_role_has_action_role1_idx` (`role_id`);

--
-- Indexes for table `sysx_role_has_application`
--
ALTER TABLE `sysx_role_has_application`
  ADD PRIMARY KEY (`role_id`,`application_id`),
  ADD KEY `fk_role_has_application_application1_idx` (`application_id`),
  ADD KEY `fk_role_has_application_role1_idx` (`role_id`);

--
-- Indexes for table `sysx_role_has_controller`
--
ALTER TABLE `sysx_role_has_controller`
  ADD PRIMARY KEY (`role_id`,`controller_id`),
  ADD KEY `fk_role_has_controller_controller1_idx` (`controller_id`),
  ADD KEY `fk_role_has_controller_role1_idx` (`role_id`);

--
-- Indexes for table `sysx_role_has_menu_item`
--
ALTER TABLE `sysx_role_has_menu_item`
  ADD PRIMARY KEY (`menu_item_id`,`role_id`),
  ADD KEY `fk_menu_item_has_role_role1_idx` (`role_id`),
  ADD KEY `fk_menu_item_has_role_menu_item1_idx` (`menu_item_id`);

--
-- Indexes for table `sysx_role_has_module`
--
ALTER TABLE `sysx_role_has_module`
  ADD PRIMARY KEY (`role_id`,`module_id`),
  ADD KEY `fk_role_has_module_module1_idx` (`module_id`),
  ADD KEY `fk_role_has_module_role1_idx` (`role_id`);

--
-- Indexes for table `sysx_role_has_permission`
--
ALTER TABLE `sysx_role_has_permission`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `fk_role_has_permission_permission2_idx` (`permission_id`),
  ADD KEY `fk_role_has_permission_role2_idx` (`role_id`);

--
-- Indexes for table `sysx_role_has_task`
--
ALTER TABLE `sysx_role_has_task`
  ADD PRIMARY KEY (`role_id`,`task_id`),
  ADD KEY `fk_role_has_permission_permission1_idx` (`task_id`),
  ADD KEY `fk_role_has_permission_role1_idx` (`role_id`);

--
-- Indexes for table `sysx_task`
--
ALTER TABLE `sysx_task`
  ADD PRIMARY KEY (`task_id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Indexes for table `sysx_telkom_sso_user`
--
ALTER TABLE `sysx_telkom_sso_user`
  ADD PRIMARY KEY (`telkom_sso_user_id`),
  ADD KEY `FK_sysx_telkom_sso_user` (`user_id`);

--
-- Indexes for table `sysx_telkom_sso_user_log`
--
ALTER TABLE `sysx_telkom_sso_user_log`
  ADD PRIMARY KEY (`telkom_sso_user_log_id`),
  ADD KEY `FK_sysx_telkom_sso_user_log` (`telkom_sso_user_id`);

--
-- Indexes for table `sysx_user`
--
ALTER TABLE `sysx_user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `fk_user_profile1_idx` (`profile_id`),
  ADD KEY `fk_user_authentication_method1_idx` (`authentication_method_id`);

--
-- Indexes for table `sysx_user_config`
--
ALTER TABLE `sysx_user_config`
  ADD PRIMARY KEY (`user_config_id`),
  ADD KEY `fk_sysx_user_config_sysx_application1_idx` (`application_id`),
  ADD KEY `fk_sysx_user_config_sysx_user1_idx` (`user_id`);

--
-- Indexes for table `sysx_user_has_role`
--
ALTER TABLE `sysx_user_has_role`
  ADD PRIMARY KEY (`role_id`,`user_id`),
  ADD KEY `fk_user_has_role_role1_idx` (`role_id`),
  ADD KEY `fk_user_has_role_user_idx` (`user_id`);

--
-- Indexes for table `sysx_user_has_workgroup`
--
ALTER TABLE `sysx_user_has_workgroup`
  ADD PRIMARY KEY (`user_id`,`workgroup_id`),
  ADD KEY `fk_user_has_workgroup_workgroup1_idx` (`workgroup_id`);

--
-- Indexes for table `sysx_workgroup`
--
ALTER TABLE `sysx_workgroup`
  ADD PRIMARY KEY (`workgroup_id`);

--
-- Indexes for table `tmbh_agenda`
--
ALTER TABLE `tmbh_agenda`
  ADD PRIMARY KEY (`agenda_id`),
  ADD UNIQUE KEY `AGENDA_ID_UNIQUE` (`id_agenda`);

--
-- Indexes for table `tmbh_file_pengumuman`
--
ALTER TABLE `tmbh_file_pengumuman`
  ADD PRIMARY KEY (`file_pengumuman_id`),
  ADD KEY `FK_tmbh_file_pengumuman` (`pengumuman_id`);

--
-- Indexes for table `tmbh_kamus_it`
--
ALTER TABLE `tmbh_kamus_it`
  ADD PRIMARY KEY (`kamus_it_id`),
  ADD UNIQUE KEY `WORD_UNIQUE` (`word`),
  ADD KEY `WORD` (`word`);

--
-- Indexes for table `tmbh_kegiatan`
--
ALTER TABLE `tmbh_kegiatan`
  ADD PRIMARY KEY (`kegiatan_id`);

--
-- Indexes for table `tmbh_news`
--
ALTER TABLE `tmbh_news`
  ADD PRIMARY KEY (`news_id`),
  ADD KEY `JUDUL` (`judul`),
  ADD KEY `fk_t_NEWS_t_NEWS_KATEGORI1_idx` (`news_kategori_id`);

--
-- Indexes for table `tmbh_news_files`
--
ALTER TABLE `tmbh_news_files`
  ADD PRIMARY KEY (`news_files_id`);

--
-- Indexes for table `tmbh_news_kategori`
--
ALTER TABLE `tmbh_news_kategori`
  ADD PRIMARY KEY (`news_kategori_id`),
  ADD UNIQUE KEY `KAT_ID_UNIQUE` (`kat_id`),
  ADD KEY `KAT_ID` (`kat_id`),
  ADD KEY `PKAT_ID` (`pkat_id`),
  ADD KEY `KAT_NAMA_INA` (`kat_nama_ina`),
  ADD KEY `KAT_NAMA_ENG` (`kat_nama_eng`);

--
-- Indexes for table `tmbh_news_komentar`
--
ALTER TABLE `tmbh_news_komentar`
  ADD PRIMARY KEY (`news_komentar_id`),
  ADD KEY `ID_KOMENTAR` (`id_komentar`),
  ADD KEY `JUDUL` (`judul`);

--
-- Indexes for table `tmbh_pengumuman`
--
ALTER TABLE `tmbh_pengumuman`
  ADD PRIMARY KEY (`pengumuman_id`),
  ADD KEY `FK_tmbh_pengumuman` (`owner`);

--
-- Indexes for table `tmbh_software_tools`
--
ALTER TABLE `tmbh_software_tools`
  ADD PRIMARY KEY (`software_tools_id`),
  ADD KEY `fk_t_software_tools_t_kurikulum1_idx` (`kurikulum_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absn_absensi`
--
ALTER TABLE `absn_absensi`
  MODIFY `absensi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `absn_sesi_kuliah`
--
ALTER TABLE `absn_sesi_kuliah`
  MODIFY `sesi_kuliah_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `adak_kelas`
--
ALTER TABLE `adak_kelas`
  MODIFY `kelas_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `adak_mahasiswa_assistant`
--
ALTER TABLE `adak_mahasiswa_assistant`
  MODIFY `mahasiswa_assistant_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `adak_pengajaran`
--
ALTER TABLE `adak_pengajaran`
  MODIFY `pengajaran_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `adak_penugasan_pengajaran`
--
ALTER TABLE `adak_penugasan_pengajaran`
  MODIFY `penugasan_pengajaran_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `adak_registrasi`
--
ALTER TABLE `adak_registrasi`
  MODIFY `registrasi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `arsp_arsip`
--
ALTER TABLE `arsp_arsip`
  MODIFY `arsip_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `arsp_arsip_file`
--
ALTER TABLE `arsp_arsip_file`
  MODIFY `arsip_file_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `artk_post`
--
ALTER TABLE `artk_post`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `artk_post_attachment`
--
ALTER TABLE `artk_post_attachment`
  MODIFY `post_attachment_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dimx_alumni`
--
ALTER TABLE `dimx_alumni`
  MODIFY `alumni_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dimx_alumni_data`
--
ALTER TABLE `dimx_alumni_data`
  MODIFY `alumni_data_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dimx_alumni_pekerjaan`
--
ALTER TABLE `dimx_alumni_pekerjaan`
  MODIFY `alumni_pekerjaan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dimx_dim`
--
ALTER TABLE `dimx_dim`
  MODIFY `dim_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dimx_dim_pmb`
--
ALTER TABLE `dimx_dim_pmb`
  MODIFY `dim_pmb_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dimx_dim_pmb_daftar`
--
ALTER TABLE `dimx_dim_pmb_daftar`
  MODIFY `dim_pmb_daftar_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dimx_dim_trnon_lulus`
--
ALTER TABLE `dimx_dim_trnon_lulus`
  MODIFY `dim_trnon_lulus_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dimx_dim_update`
--
ALTER TABLE `dimx_dim_update`
  MODIFY `dim_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dimx_histori_prodi`
--
ALTER TABLE `dimx_histori_prodi`
  MODIFY `histori_prodi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hrdx_dosen`
--
ALTER TABLE `hrdx_dosen`
  MODIFY `dosen_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hrdx_pegawai`
--
ALTER TABLE `hrdx_pegawai`
  MODIFY `pegawai_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hrdx_pendidikan`
--
ALTER TABLE `hrdx_pendidikan`
  MODIFY `pendidikan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hrdx_pengajar`
--
ALTER TABLE `hrdx_pengajar`
  MODIFY `pengajar_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hrdx_profile`
--
ALTER TABLE `hrdx_profile`
  MODIFY `profile_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hrdx_riwayat_pendidikan`
--
ALTER TABLE `hrdx_riwayat_pendidikan`
  MODIFY `riwayat_pendidikan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hrdx_r_staf_role`
--
ALTER TABLE `hrdx_r_staf_role`
  MODIFY `staf_role_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hrdx_staf`
--
ALTER TABLE `hrdx_staf`
  MODIFY `staf_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `inst_instansi`
--
ALTER TABLE `inst_instansi`
  MODIFY `instansi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `inst_pejabat`
--
ALTER TABLE `inst_pejabat`
  MODIFY `pejabat_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `inst_prodi`
--
ALTER TABLE `inst_prodi`
  MODIFY `ref_kbk_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `inst_r_jenjang`
--
ALTER TABLE `inst_r_jenjang`
  MODIFY `jenjang_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `inst_struktur_jabatan`
--
ALTER TABLE `inst_struktur_jabatan`
  MODIFY `struktur_jabatan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `inst_unit`
--
ALTER TABLE `inst_unit`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_arsip_vendor`
--
ALTER TABLE `invt_arsip_vendor`
  MODIFY `arsip_vendor_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_barang`
--
ALTER TABLE `invt_barang`
  MODIFY `barang_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_detail_peminjaman_barang`
--
ALTER TABLE `invt_detail_peminjaman_barang`
  MODIFY `detail_peminjaman_barang_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_file_vendor`
--
ALTER TABLE `invt_file_vendor`
  MODIFY `file_vendor_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_keterangan_pengeluaran`
--
ALTER TABLE `invt_keterangan_pengeluaran`
  MODIFY `keterangan_pengeluaran_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_pelaporan_barang_rusak`
--
ALTER TABLE `invt_pelaporan_barang_rusak`
  MODIFY `pelaporan_barang_rusak` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_pemindahan_barang`
--
ALTER TABLE `invt_pemindahan_barang`
  MODIFY `pemindahan_barang_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_peminjaman_barang`
--
ALTER TABLE `invt_peminjaman_barang`
  MODIFY `peminjaman_barang_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_pengeluaran_barang`
--
ALTER TABLE `invt_pengeluaran_barang`
  MODIFY `pengeluaran_barang_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_pic_barang`
--
ALTER TABLE `invt_pic_barang`
  MODIFY `pic_barang_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_pic_barang_file`
--
ALTER TABLE `invt_pic_barang_file`
  MODIFY `pic_barang_file_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_r_brand`
--
ALTER TABLE `invt_r_brand`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_r_jenis_barang`
--
ALTER TABLE `invt_r_jenis_barang`
  MODIFY `jenis_barang_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_r_kategori`
--
ALTER TABLE `invt_r_kategori`
  MODIFY `kategori_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_r_lokasi`
--
ALTER TABLE `invt_r_lokasi`
  MODIFY `lokasi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_r_satuan`
--
ALTER TABLE `invt_r_satuan`
  MODIFY `satuan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_r_status`
--
ALTER TABLE `invt_r_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_r_unit`
--
ALTER TABLE `invt_r_unit`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_r_vendor`
--
ALTER TABLE `invt_r_vendor`
  MODIFY `vendor_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_summary_jumlah`
--
ALTER TABLE `invt_summary_jumlah`
  MODIFY `summary_jumlah_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invt_unit_charged`
--
ALTER TABLE `invt_unit_charged`
  MODIFY `unit_charged_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kmhs_detail_kasus`
--
ALTER TABLE `kmhs_detail_kasus`
  MODIFY `detail_kasus_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kmhs_master_kasus`
--
ALTER TABLE `kmhs_master_kasus`
  MODIFY `master_kasus` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kmhs_nilai_perilaku`
--
ALTER TABLE `kmhs_nilai_perilaku`
  MODIFY `nilai_perilaku_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kmhs_nilai_perilaku_arsip`
--
ALTER TABLE `kmhs_nilai_perilaku_arsip`
  MODIFY `nilai_perilaku_arsip_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kmhs_nilai_perilaku_as`
--
ALTER TABLE `kmhs_nilai_perilaku_as`
  MODIFY `nilai_perilaku_as_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kmhs_nilai_perilaku_summary`
--
ALTER TABLE `kmhs_nilai_perilaku_summary`
  MODIFY `nilai_perilaku_summary_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kmhs_nilai_perilaku_ts`
--
ALTER TABLE `kmhs_nilai_perilaku_ts`
  MODIFY `nilai_perilaku_ts` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kmhs_r_kasus`
--
ALTER TABLE `kmhs_r_kasus`
  MODIFY `ref_kasus_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kmhs_r_kriteria_nilai_perilaku`
--
ALTER TABLE `kmhs_r_kriteria_nilai_perilaku`
  MODIFY `kriteria_nilai_perilaku_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `krkm_course_group`
--
ALTER TABLE `krkm_course_group`
  MODIFY `course_group_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `krkm_kuliah`
--
ALTER TABLE `krkm_kuliah`
  MODIFY `kuliah_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `krkm_kuliah_prodi`
--
ALTER TABLE `krkm_kuliah_prodi`
  MODIFY `krkm_kuliah_prodi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `krkm_kurikulum_prodi`
--
ALTER TABLE `krkm_kurikulum_prodi`
  MODIFY `kurikulum_prodi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `krkm_prerequisite_courses`
--
ALTER TABLE `krkm_prerequisite_courses`
  MODIFY `prerequisite_courses_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `krkm_r_tahun_kurikulum`
--
ALTER TABLE `krkm_r_tahun_kurikulum`
  MODIFY `tahun_kurikulum_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `krkm_sifat_kuliah`
--
ALTER TABLE `krkm_sifat_kuliah`
  MODIFY `sifat_kuliah_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `labx_alat`
--
ALTER TABLE `labx_alat`
  MODIFY `alat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;
--
-- AUTO_INCREMENT for table `labx_bahan`
--
ALTER TABLE `labx_bahan`
  MODIFY `bahan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT for table `labx_item_pemesanan`
--
ALTER TABLE `labx_item_pemesanan`
  MODIFY `item_pemesanan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `labx_item_peminjaman`
--
ALTER TABLE `labx_item_peminjaman`
  MODIFY `item_peminjaman_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `labx_lab`
--
ALTER TABLE `labx_lab`
  MODIFY `lab_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `labx_lemari`
--
ALTER TABLE `labx_lemari`
  MODIFY `lemari_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `labx_pemesanan`
--
ALTER TABLE `labx_pemesanan`
  MODIFY `pemesanan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `labx_peminjaman`
--
ALTER TABLE `labx_peminjaman`
  MODIFY `peminjaman_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `labx_penambahan_stock_alat`
--
ALTER TABLE `labx_penambahan_stock_alat`
  MODIFY `penambahan_alat_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `labx_penambahan_stock_bahan`
--
ALTER TABLE `labx_penambahan_stock_bahan`
  MODIFY `penambahan_bahan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `labx_r_status`
--
ALTER TABLE `labx_r_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `labx_r_tujuan`
--
ALTER TABLE `labx_r_tujuan`
  MODIFY `tujuan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `labx_satuan`
--
ALTER TABLE `labx_satuan`
  MODIFY `satuan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `lppm_penelitian`
--
ALTER TABLE `lppm_penelitian`
  MODIFY `penelitian_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_penelitian_dosen`
--
ALTER TABLE `lppm_penelitian_dosen`
  MODIFY `penelitian_dosen_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_r_karyailmiah`
--
ALTER TABLE `lppm_r_karyailmiah`
  MODIFY `karyailmiah_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_r_subkaryailmiah`
--
ALTER TABLE `lppm_r_subkaryailmiah`
  MODIFY `subkaryailmiah_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_author_publikasi`
--
ALTER TABLE `lppm_t_author_publikasi`
  MODIFY `author_publikasi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_ketua_gbk`
--
ALTER TABLE `lppm_t_ketua_gbk`
  MODIFY `ketuagbk_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_logreview`
--
ALTER TABLE `lppm_t_logreview`
  MODIFY `logreview_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_publikasi`
--
ALTER TABLE `lppm_t_publikasi`
  MODIFY `publikasi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_registrasipublikasi`
--
ALTER TABLE `lppm_t_registrasipublikasi`
  MODIFY `registrasipublikasi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_registrasi_file`
--
ALTER TABLE `lppm_t_registrasi_file`
  MODIFY `registrasifile_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_registrasi_jurnal`
--
ALTER TABLE `lppm_t_registrasi_jurnal`
  MODIFY `registrasi_jurnal_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_registrasi_jurnal_file`
--
ALTER TABLE `lppm_t_registrasi_jurnal_file`
  MODIFY `registrasi_jurnal_file_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_registrasi_prosiding`
--
ALTER TABLE `lppm_t_registrasi_prosiding`
  MODIFY `registrasi_prosiding_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_registrasi_prosiding_file`
--
ALTER TABLE `lppm_t_registrasi_prosiding_file`
  MODIFY `registrasi_prosiding_file_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_review_file`
--
ALTER TABLE `lppm_t_review_file`
  MODIFY `reviewfile_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_rewardpublikasi`
--
ALTER TABLE `lppm_t_rewardpublikasi`
  MODIFY `rewardpublikasi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_reward_file`
--
ALTER TABLE `lppm_t_reward_file`
  MODIFY `rewardfile_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_reward_jurnal`
--
ALTER TABLE `lppm_t_reward_jurnal`
  MODIFY `reward_jurnal_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_reward_jurnal_file`
--
ALTER TABLE `lppm_t_reward_jurnal_file`
  MODIFY `reward_jurnal_file_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_reward_prosiding`
--
ALTER TABLE `lppm_t_reward_prosiding`
  MODIFY `reward_prosiding_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lppm_t_reward_prosiding_file`
--
ALTER TABLE `lppm_t_reward_prosiding_file`
  MODIFY `reward_prosiding_file_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_agama`
--
ALTER TABLE `mref_r_agama`
  MODIFY `agama_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_asal_sekolah`
--
ALTER TABLE `mref_r_asal_sekolah`
  MODIFY `asal_sekolah_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_bidang_pekerjaan`
--
ALTER TABLE `mref_r_bidang_pekerjaan`
  MODIFY `bidang_pekerjaan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_bidang_perusahaan`
--
ALTER TABLE `mref_r_bidang_perusahaan`
  MODIFY `bidang_perusahaan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_gbk`
--
ALTER TABLE `mref_r_gbk`
  MODIFY `gbk_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_gelombang_pmb`
--
ALTER TABLE `mref_r_gelombang_pmb`
  MODIFY `gelombang_pmb_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_golongan_darah`
--
ALTER TABLE `mref_r_golongan_darah`
  MODIFY `golongan_darah_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_golongan_kepangkatan`
--
ALTER TABLE `mref_r_golongan_kepangkatan`
  MODIFY `golongan_kepangkatan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_jabatan_akademik`
--
ALTER TABLE `mref_r_jabatan_akademik`
  MODIFY `jabatan_akademik_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_jenis_kelamin`
--
ALTER TABLE `mref_r_jenis_kelamin`
  MODIFY `jenis_kelamin_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_jenjang`
--
ALTER TABLE `mref_r_jenjang`
  MODIFY `jenjang_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_kabupaten`
--
ALTER TABLE `mref_r_kabupaten`
  MODIFY `kabupaten_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_lokasi`
--
ALTER TABLE `mref_r_lokasi`
  MODIFY `lokasi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_pekerjaan`
--
ALTER TABLE `mref_r_pekerjaan`
  MODIFY `pekerjaan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_pendidikan`
--
ALTER TABLE `mref_r_pendidikan`
  MODIFY `pendidikan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_pengali_nilai`
--
ALTER TABLE `mref_r_pengali_nilai`
  MODIFY `pengali_nilai_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_penghasilan`
--
ALTER TABLE `mref_r_penghasilan`
  MODIFY `penghasilan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_predikat_lulus`
--
ALTER TABLE `mref_r_predikat_lulus`
  MODIFY `predikat_lulus_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_provinsi`
--
ALTER TABLE `mref_r_provinsi`
  MODIFY `provinsi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_role_pengajar`
--
ALTER TABLE `mref_r_role_pengajar`
  MODIFY `role_pengajar_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_sem_ta`
--
ALTER TABLE `mref_r_sem_ta`
  MODIFY `sem_ta_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_sifat_kurikulum`
--
ALTER TABLE `mref_r_sifat_kurikulum`
  MODIFY `sifat_kurikulum_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_status_aktif_mahasiswa`
--
ALTER TABLE `mref_r_status_aktif_mahasiswa`
  MODIFY `status_aktif_mahasiswa_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_status_aktif_pegawai`
--
ALTER TABLE `mref_r_status_aktif_pegawai`
  MODIFY `status_aktif_pegawai_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_status_ikatan_kerja_dosen`
--
ALTER TABLE `mref_r_status_ikatan_kerja_dosen`
  MODIFY `status_ikatan_kerja_dosen_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_status_ikatan_kerja_pegawai`
--
ALTER TABLE `mref_r_status_ikatan_kerja_pegawai`
  MODIFY `status_ikatan_kerja_pegawai_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_status_marital`
--
ALTER TABLE `mref_r_status_marital`
  MODIFY `status_marital_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mref_r_ta`
--
ALTER TABLE `mref_r_ta`
  MODIFY `ta_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_ext_mhs`
--
ALTER TABLE `nlai_ext_mhs`
  MODIFY `ext_mhs_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_file_nilai`
--
ALTER TABLE `nlai_file_nilai`
  MODIFY `file_nilai_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_komponen_tambahan`
--
ALTER TABLE `nlai_komponen_tambahan`
  MODIFY `komponen_tambahan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_komposisi_nilai`
--
ALTER TABLE `nlai_komposisi_nilai`
  MODIFY `komposisi_nilai_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_komposisi_nilai_uts_uas`
--
ALTER TABLE `nlai_komposisi_nilai_uts_uas`
  MODIFY `komposisi_nilai_uts_uas_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_nilai`
--
ALTER TABLE `nlai_nilai`
  MODIFY `nilai_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_nilai_komponen_tambahan`
--
ALTER TABLE `nlai_nilai_komponen_tambahan`
  MODIFY `nilai_komponen_tambahan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_nilai_praktikum`
--
ALTER TABLE `nlai_nilai_praktikum`
  MODIFY `nilai_praktikum_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_nilai_quis`
--
ALTER TABLE `nlai_nilai_quis`
  MODIFY `nilai_quis_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_nilai_tugas`
--
ALTER TABLE `nlai_nilai_tugas`
  MODIFY `nilai_tugas_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_nilai_uas`
--
ALTER TABLE `nlai_nilai_uas`
  MODIFY `nilai_uas_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_nilai_uts`
--
ALTER TABLE `nlai_nilai_uts`
  MODIFY `nilai_uts_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_rentang_nilai`
--
ALTER TABLE `nlai_rentang_nilai`
  MODIFY `rentang_nilai_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_r_ext`
--
ALTER TABLE `nlai_r_ext`
  MODIFY `ext_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_uas_detail`
--
ALTER TABLE `nlai_uas_detail`
  MODIFY `uas_detail_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nlai_uts_detail`
--
ALTER TABLE `nlai_uts_detail`
  MODIFY `uts_detail_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_berita_acara_daftar_hadir`
--
ALTER TABLE `prkl_berita_acara_daftar_hadir`
  MODIFY `berita_acara_daftar_hadir_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_berita_acara_kuliah`
--
ALTER TABLE `prkl_berita_acara_kuliah`
  MODIFY `berita_acara_kuliah_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_course_unit`
--
ALTER TABLE `prkl_course_unit`
  MODIFY `course_unit_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_course_unit_material`
--
ALTER TABLE `prkl_course_unit_material`
  MODIFY `course_unit_material_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_file`
--
ALTER TABLE `prkl_file`
  MODIFY `file_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_file_materi`
--
ALTER TABLE `prkl_file_materi`
  MODIFY `file_materi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_file_praktikum`
--
ALTER TABLE `prkl_file_praktikum`
  MODIFY `file_praktikum_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_file_syllabus`
--
ALTER TABLE `prkl_file_syllabus`
  MODIFY `file_syllabus_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_group_kuliah`
--
ALTER TABLE `prkl_group_kuliah`
  MODIFY `group_kuliah_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_info_ta`
--
ALTER TABLE `prkl_info_ta`
  MODIFY `info_ta_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_jadwal`
--
ALTER TABLE `prkl_jadwal`
  MODIFY `jadwal_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_krs_detail`
--
ALTER TABLE `prkl_krs_detail`
  MODIFY `krs_detail_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_krs_mhs`
--
ALTER TABLE `prkl_krs_mhs`
  MODIFY `krs_mhs_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_krs_review`
--
ALTER TABLE `prkl_krs_review`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_kuesioner_materi`
--
ALTER TABLE `prkl_kuesioner_materi`
  MODIFY `kuesioner_materi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_kuesioner_praktikum`
--
ALTER TABLE `prkl_kuesioner_praktikum`
  MODIFY `kuesioner_praktikum_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_kurikulum_syllabus`
--
ALTER TABLE `prkl_kurikulum_syllabus`
  MODIFY `kurikulum_syllabus_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_kurikulum_syllabus_file`
--
ALTER TABLE `prkl_kurikulum_syllabus_file`
  MODIFY `kurikulum_syllabus_file_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_materi`
--
ALTER TABLE `prkl_materi`
  MODIFY `materi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_material`
--
ALTER TABLE `prkl_material`
  MODIFY `material_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_material_files`
--
ALTER TABLE `prkl_material_files`
  MODIFY `material_files_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_material_kategori`
--
ALTER TABLE `prkl_material_kategori`
  MODIFY `material_kategori_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_penilaian_materi`
--
ALTER TABLE `prkl_penilaian_materi`
  MODIFY `penilaian_materi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_penilaian_materi_nilai`
--
ALTER TABLE `prkl_penilaian_materi_nilai`
  MODIFY `penilaian_materi_nilai_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_penilaian_praktikum`
--
ALTER TABLE `prkl_penilaian_praktikum`
  MODIFY `penilaian_praktikum_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_penilaian_praktikum_nilai`
--
ALTER TABLE `prkl_penilaian_praktikum_nilai`
  MODIFY `penilaian_praktikum_nilai_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_penilaian_tim_pengajar`
--
ALTER TABLE `prkl_penilaian_tim_pengajar`
  MODIFY `penilaian_tim_pengajar_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_penilaian_tim_pengajar_nilai`
--
ALTER TABLE `prkl_penilaian_tim_pengajar_nilai`
  MODIFY `penilaian_tim_pengajar_nilai_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_praktikum`
--
ALTER TABLE `prkl_praktikum`
  MODIFY `praktikum_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_rpp`
--
ALTER TABLE `prkl_rpp`
  MODIFY `rpp_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prkl_ruangan`
--
ALTER TABLE `prkl_ruangan`
  MODIFY `ruangan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_detil_program`
--
ALTER TABLE `rakx_detil_program`
  MODIFY `detil_program_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_mata_anggaran`
--
ALTER TABLE `rakx_mata_anggaran`
  MODIFY `mata_anggaran_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_program`
--
ALTER TABLE `rakx_program`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_program_has_sumber_dana`
--
ALTER TABLE `rakx_program_has_sumber_dana`
  MODIFY `program_has_sumber_dana_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_program_has_waktu`
--
ALTER TABLE `rakx_program_has_waktu`
  MODIFY `program_has_waktu_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_review_program`
--
ALTER TABLE `rakx_review_program`
  MODIFY `review_program_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_r_bulan`
--
ALTER TABLE `rakx_r_bulan`
  MODIFY `bulan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_r_rencana_strategis`
--
ALTER TABLE `rakx_r_rencana_strategis`
  MODIFY `rencana_strategis_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_r_satuan`
--
ALTER TABLE `rakx_r_satuan`
  MODIFY `satuan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_r_standar`
--
ALTER TABLE `rakx_r_standar`
  MODIFY `standar_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_r_status_program`
--
ALTER TABLE `rakx_r_status_program`
  MODIFY `status_program_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_r_sumber_dana`
--
ALTER TABLE `rakx_r_sumber_dana`
  MODIFY `sumber_dana_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_r_tahun_anggaran`
--
ALTER TABLE `rakx_r_tahun_anggaran`
  MODIFY `tahun_anggaran_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rakx_struktur_jabatan_has_mata_anggaran`
--
ALTER TABLE `rakx_struktur_jabatan_has_mata_anggaran`
  MODIFY `struktur_jabatan_has_mata_anggaran_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rprt_complaint`
--
ALTER TABLE `rprt_complaint`
  MODIFY `complaint_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rprt_response`
--
ALTER TABLE `rprt_response`
  MODIFY `response_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rprt_r_bagian`
--
ALTER TABLE `rprt_r_bagian`
  MODIFY `bagian_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rprt_r_status`
--
ALTER TABLE `rprt_r_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rprt_user_has_bagian`
--
ALTER TABLE `rprt_user_has_bagian`
  MODIFY `user_has_bagian_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `schd_event`
--
ALTER TABLE `schd_event`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `schd_event_invitee`
--
ALTER TABLE `schd_event_invitee`
  MODIFY `event_invitee_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `schd_file_event`
--
ALTER TABLE `schd_file_event`
  MODIFY `file_event_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `schd_jadwal_kuliah`
--
ALTER TABLE `schd_jadwal_kuliah`
  MODIFY `jadwal_kuliah_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `schd_r_calender`
--
ALTER TABLE `schd_r_calender`
  MODIFY `calender_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `schd_subscriber`
--
ALTER TABLE `schd_subscriber`
  MODIFY `subscriber_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `srvy_kuesioner`
--
ALTER TABLE `srvy_kuesioner`
  MODIFY `kuesioner_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `srvy_kuesioner_jawaban_peserta`
--
ALTER TABLE `srvy_kuesioner_jawaban_peserta`
  MODIFY `kuesioner_jawaban_peserta_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `srvy_kuesioner_opsi`
--
ALTER TABLE `srvy_kuesioner_opsi`
  MODIFY `kuesioner_opsi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `srvy_kuesioner_pertanyaan`
--
ALTER TABLE `srvy_kuesioner_pertanyaan`
  MODIFY `kuesioner_pertanyaan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `srvy_polling`
--
ALTER TABLE `srvy_polling`
  MODIFY `polling_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `srvy_pollopsi`
--
ALTER TABLE `srvy_pollopsi`
  MODIFY `pollopsi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `srvy_pollvote`
--
ALTER TABLE `srvy_pollvote`
  MODIFY `pollvote_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_action`
--
ALTER TABLE `sysx_action`
  MODIFY `action_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_application`
--
ALTER TABLE `sysx_application`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_authentication_method`
--
ALTER TABLE `sysx_authentication_method`
  MODIFY `authentication_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sysx_config`
--
ALTER TABLE `sysx_config`
  MODIFY `config_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_controller`
--
ALTER TABLE `sysx_controller`
  MODIFY `controller_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_job_allocation`
--
ALTER TABLE `sysx_job_allocation`
  MODIFY `job_allocation_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_job_definition`
--
ALTER TABLE `sysx_job_definition`
  MODIFY `job_definition_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_log`
--
ALTER TABLE `sysx_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_menu_group`
--
ALTER TABLE `sysx_menu_group`
  MODIFY `menu_group_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_menu_item`
--
ALTER TABLE `sysx_menu_item`
  MODIFY `menu_item_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_module`
--
ALTER TABLE `sysx_module`
  MODIFY `module_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_permission`
--
ALTER TABLE `sysx_permission`
  MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_profile`
--
ALTER TABLE `sysx_profile`
  MODIFY `profile_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_role`
--
ALTER TABLE `sysx_role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_task`
--
ALTER TABLE `sysx_task`
  MODIFY `task_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_telkom_sso_user`
--
ALTER TABLE `sysx_telkom_sso_user`
  MODIFY `telkom_sso_user_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_telkom_sso_user_log`
--
ALTER TABLE `sysx_telkom_sso_user_log`
  MODIFY `telkom_sso_user_log_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_user`
--
ALTER TABLE `sysx_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `sysx_user_config`
--
ALTER TABLE `sysx_user_config`
  MODIFY `user_config_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sysx_workgroup`
--
ALTER TABLE `sysx_workgroup`
  MODIFY `workgroup_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tmbh_agenda`
--
ALTER TABLE `tmbh_agenda`
  MODIFY `agenda_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tmbh_file_pengumuman`
--
ALTER TABLE `tmbh_file_pengumuman`
  MODIFY `file_pengumuman_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tmbh_kamus_it`
--
ALTER TABLE `tmbh_kamus_it`
  MODIFY `kamus_it_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tmbh_kegiatan`
--
ALTER TABLE `tmbh_kegiatan`
  MODIFY `kegiatan_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tmbh_news`
--
ALTER TABLE `tmbh_news`
  MODIFY `news_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tmbh_news_files`
--
ALTER TABLE `tmbh_news_files`
  MODIFY `news_files_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tmbh_news_kategori`
--
ALTER TABLE `tmbh_news_kategori`
  MODIFY `news_kategori_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tmbh_news_komentar`
--
ALTER TABLE `tmbh_news_komentar`
  MODIFY `news_komentar_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tmbh_pengumuman`
--
ALTER TABLE `tmbh_pengumuman`
  MODIFY `pengumuman_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tmbh_software_tools`
--
ALTER TABLE `tmbh_software_tools`
  MODIFY `software_tools_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `absn_absensi`
--
ALTER TABLE `absn_absensi`
  ADD CONSTRAINT `FK_absn_absensi_dim` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_absn_absensi_sesi_kuliah` FOREIGN KEY (`sesi_kuliah_id`) REFERENCES `absn_sesi_kuliah` (`sesi_kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `absn_sesi_kuliah`
--
ALTER TABLE `absn_sesi_kuliah`
  ADD CONSTRAINT `FK_absn_sesi_kuliah_lokasi` FOREIGN KEY (`lokasi_id`) REFERENCES `mref_r_lokasi` (`lokasi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_absn_sesi_kuliah_penugasan_pengajaran` FOREIGN KEY (`penugasan_pengajaran_id`) REFERENCES `adak_penugasan_pengajaran` (`penugasan_pengajaran_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `adak_kelas`
--
ALTER TABLE `adak_kelas`
  ADD CONSTRAINT `FK_adak_kelas_wali` FOREIGN KEY (`dosen_wali_id`) REFERENCES `hrdx_dosen` (`dosen_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `adak_mahasiswa_assistant`
--
ALTER TABLE `adak_mahasiswa_assistant`
  ADD CONSTRAINT `FK_adak_mahasiswa_assistant_dim` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_adak_mahasiswa_assistant_pengajaran` FOREIGN KEY (`pengajaran_id`) REFERENCES `adak_pengajaran` (`pengajaran_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `adak_pengajaran`
--
ALTER TABLE `adak_pengajaran`
  ADD CONSTRAINT `FK_adak_pengajaran_kuliah` FOREIGN KEY (`kuliah_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `adak_penugasan_pengajaran`
--
ALTER TABLE `adak_penugasan_pengajaran`
  ADD CONSTRAINT `FK_adak_penugasan_pengajaran` FOREIGN KEY (`pengajaran_id`) REFERENCES `adak_pengajaran` (`pengajaran_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_adak_penugasan_pengajaran_pegawai` FOREIGN KEY (`pegawai_id`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_pengajaran_role_pengajar` FOREIGN KEY (`role_pengajar_id`) REFERENCES `mref_r_role_pengajar` (`role_pengajar_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `adak_registrasi`
--
ALTER TABLE `adak_registrasi`
  ADD CONSTRAINT `FK_adak_registrasi_dosen_wali` FOREIGN KEY (`dosen_wali_id`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_registrasi_kelas` FOREIGN KEY (`kelas_id`) REFERENCES `adak_kelas` (`kelas_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_registrasi_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `arsp_arsip`
--
ALTER TABLE `arsp_arsip`
  ADD CONSTRAINT `FK_arsip_user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `arsp_arsip_file`
--
ALTER TABLE `arsp_arsip_file`
  ADD CONSTRAINT `FK_arsip_file` FOREIGN KEY (`arsip_id`) REFERENCES `arsp_arsip` (`arsip_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `artk_post`
--
ALTER TABLE `artk_post`
  ADD CONSTRAINT `FK_artk_post_user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `artk_post_attachment`
--
ALTER TABLE `artk_post_attachment`
  ADD CONSTRAINT `FK_artk_post_attachment` FOREIGN KEY (`post_id`) REFERENCES `artk_post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dimx_alumni`
--
ALTER TABLE `dimx_alumni`
  ADD CONSTRAINT `FK_dimx_alumni_dosen_1` FOREIGN KEY (`dosen_id_1`) REFERENCES `hrdx_dosen` (`dosen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_alumni_dosen_2` FOREIGN KEY (`dosen_id_2`) REFERENCES `hrdx_dosen` (`dosen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_alumni_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dimx_alumni_data`
--
ALTER TABLE `dimx_alumni_data`
  ADD CONSTRAINT `fk_t_alumni_data_t_alumni1` FOREIGN KEY (`alumni_id`) REFERENCES `dimx_alumni` (`alumni_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dimx_alumni_pekerjaan`
--
ALTER TABLE `dimx_alumni_pekerjaan`
  ADD CONSTRAINT `FK_dimx_alumni_pekerjaan` FOREIGN KEY (`alumni_id`) REFERENCES `dimx_alumni` (`alumni_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dimx_dim`
--
ALTER TABLE `dimx_dim`
  ADD CONSTRAINT `FK_dimx_dim_agama` FOREIGN KEY (`agama_id`) REFERENCES `mref_r_agama` (`agama_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_asal_sekolah` FOREIGN KEY (`asal_sekolah_id`) REFERENCES `mref_r_asal_sekolah` (`asal_sekolah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_golongan_darah` FOREIGN KEY (`golongan_darah_id`) REFERENCES `mref_r_golongan_darah` (`golongan_darah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_jenis_kelamin` FOREIGN KEY (`jenis_kelamin_id`) REFERENCES `mref_r_jenis_kelamin` (`jenis_kelamin_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_pekerjaan_ayah` FOREIGN KEY (`pekerjaan_ayah_id`) REFERENCES `mref_r_pekerjaan` (`pekerjaan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_pekerjaan_ibu` FOREIGN KEY (`pekerjaan_ibu_id`) REFERENCES `mref_r_pekerjaan` (`pekerjaan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_pekerjaan_wali` FOREIGN KEY (`pekerjaan_wali_id`) REFERENCES `mref_r_pekerjaan` (`pekerjaan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_penghasilan_ayah` FOREIGN KEY (`penghasilan_ayah_id`) REFERENCES `mref_r_penghasilan` (`penghasilan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_penghasilan_ibu` FOREIGN KEY (`penghasilan_ibu_id`) REFERENCES `mref_r_penghasilan` (`penghasilan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_penghasilan_wali_id` FOREIGN KEY (`penghasilan_wali_id`) REFERENCES `mref_r_penghasilan` (`penghasilan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_ref_kbk` FOREIGN KEY (`ref_kbk_id`) REFERENCES `inst_prodi` (`ref_kbk_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_thn_krkm` FOREIGN KEY (`tahun_kurikulum_id`) REFERENCES `krkm_r_tahun_kurikulum` (`tahun_kurikulum_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dimx_dim_user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`);

--
-- Constraints for table `dimx_dim_pmb`
--
ALTER TABLE `dimx_dim_pmb`
  ADD CONSTRAINT `fk_t_dim_pmb_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dimx_dim_pmb_daftar`
--
ALTER TABLE `dimx_dim_pmb_daftar`
  ADD CONSTRAINT `fk_t_dim_pmb_daftar_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dimx_dim_trnon_lulus`
--
ALTER TABLE `dimx_dim_trnon_lulus`
  ADD CONSTRAINT `fk_t_dim_trnon_lulus_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dimx_histori_prodi`
--
ALTER TABLE `dimx_histori_prodi`
  ADD CONSTRAINT `FK_dimx_histori_prodi` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hrdx_dosen`
--
ALTER TABLE `hrdx_dosen`
  ADD CONSTRAINT `FK_hrdx_dosen` FOREIGN KEY (`golongan_kepangkatan_id`) REFERENCES `mref_r_golongan_kepangkatan` (`golongan_kepangkatan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_dosen_gbk` FOREIGN KEY (`gbk_1`) REFERENCES `mref_r_gbk` (`gbk_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_dosen_gbk2` FOREIGN KEY (`gbk_2`) REFERENCES `mref_r_gbk` (`gbk_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_dosen_jab` FOREIGN KEY (`jabatan_akademik_id`) REFERENCES `mref_r_jabatan_akademik` (`jabatan_akademik_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_dosen_pegawai` FOREIGN KEY (`pegawai_id`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_dosen_prodi` FOREIGN KEY (`prodi_id`) REFERENCES `inst_prodi` (`ref_kbk_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_dosen_stts` FOREIGN KEY (`status_ikatan_kerja_dosen_id`) REFERENCES `mref_r_status_ikatan_kerja_dosen` (`status_ikatan_kerja_dosen_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hrdx_pegawai`
--
ALTER TABLE `hrdx_pegawai`
  ADD CONSTRAINT `FK_hrdx_pegawai_JK` FOREIGN KEY (`jenis_kelamin_id`) REFERENCES `mref_r_jenis_kelamin` (`jenis_kelamin_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_pegawai_agama` FOREIGN KEY (`agama_id`) REFERENCES `mref_r_agama` (`agama_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_pegawai_golda` FOREIGN KEY (`golongan_darah_id`) REFERENCES `mref_r_golongan_darah` (`golongan_darah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_pegawai_jabatan_akademik` FOREIGN KEY (`jabatan_akademik_id`) REFERENCES `mref_r_jabatan_akademik` (`jabatan_akademik_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_pegawai_kab` FOREIGN KEY (`kabupaten_id`) REFERENCES `mref_r_kabupaten` (`kabupaten_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_pegawai_kbk` FOREIGN KEY (`ref_kbk_id`) REFERENCES `inst_prodi` (`ref_kbk_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_pegawai_sts_aktf` FOREIGN KEY (`status_aktif_pegawai_id`) REFERENCES `mref_r_status_aktif_pegawai` (`status_aktif_pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_pegawai_sts_iktn` FOREIGN KEY (`status_ikatan_kerja_pegawai_id`) REFERENCES `mref_r_status_ikatan_kerja_pegawai` (`status_ikatan_kerja_pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_pegawai_sts_martl` FOREIGN KEY (`status_marital_id`) REFERENCES `mref_r_status_marital` (`status_marital_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_pegawai_user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`);

--
-- Constraints for table `hrdx_pendidikan`
--
ALTER TABLE `hrdx_pendidikan`
  ADD CONSTRAINT `fk_t_pendidikan_t_profile1` FOREIGN KEY (`profile_id`) REFERENCES `hrdx_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hrdx_pengajar`
--
ALTER TABLE `hrdx_pengajar`
  ADD CONSTRAINT `FK_hrdx_pengajar_pegawai` FOREIGN KEY (`pegawai_id`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_pengajar_t_kurikulum1` FOREIGN KEY (`kurikulum_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hrdx_riwayat_pendidikan`
--
ALTER TABLE `hrdx_riwayat_pendidikan`
  ADD CONSTRAINT `FK_hrdx_riwayat_pendidikan_new_jenjang` FOREIGN KEY (`jenjang_id`) REFERENCES `mref_r_jenjang` (`jenjang_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_riwayat_pendidikan_new_pegawai` FOREIGN KEY (`pegawai_id`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hrdx_riwayat_pendidikan_old`
--
ALTER TABLE `hrdx_riwayat_pendidikan_old`
  ADD CONSTRAINT `FK_hrdx_riwayat_pendidikan_dosen` FOREIGN KEY (`dosen_id`) REFERENCES `hrdx_dosen` (`dosen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_riwayat_pendidikan_jenjang` FOREIGN KEY (`jenjang_id`) REFERENCES `mref_r_jenjang` (`jenjang_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_riwayat_pendidikan_staf` FOREIGN KEY (`staf_id`) REFERENCES `hrdx_staf` (`staf_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hrdx_staf`
--
ALTER TABLE `hrdx_staf`
  ADD CONSTRAINT `FK_hrdx_staf_pegawai` FOREIGN KEY (`pegawai_id`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_staf_prodi` FOREIGN KEY (`prodi_id`) REFERENCES `inst_prodi` (`ref_kbk_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_hrdx_staf_role` FOREIGN KEY (`staf_role_id`) REFERENCES `hrdx_r_staf_role` (`staf_role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inst_pejabat`
--
ALTER TABLE `inst_pejabat`
  ADD CONSTRAINT `FK_inst_pejabat_pegawai` FOREIGN KEY (`pegawai_id`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_pejabat_struktur_jabatan` FOREIGN KEY (`struktur_jabatan_id`) REFERENCES `inst_struktur_jabatan` (`struktur_jabatan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inst_prodi`
--
ALTER TABLE `inst_prodi`
  ADD CONSTRAINT `FK_krkm_r_kbk` FOREIGN KEY (`jenjang_id`) REFERENCES `inst_r_jenjang` (`jenjang_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inst_struktur_jabatan`
--
ALTER TABLE `inst_struktur_jabatan`
  ADD CONSTRAINT `FK_struktur_jabatan_instansi` FOREIGN KEY (`instansi_id`) REFERENCES `inst_instansi` (`instansi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_struktur_jabatan_struktur_jabatan` FOREIGN KEY (`parent`) REFERENCES `inst_struktur_jabatan` (`struktur_jabatan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_struktur_jabatan_unit` FOREIGN KEY (`unit_id`) REFERENCES `inst_unit` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inst_unit`
--
ALTER TABLE `inst_unit`
  ADD CONSTRAINT `FK_unit_instansi` FOREIGN KEY (`instansi_id`) REFERENCES `inst_instansi` (`instansi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_unit_struktur_jabatan` FOREIGN KEY (`kepala`) REFERENCES `inst_struktur_jabatan` (`struktur_jabatan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_arsip_vendor`
--
ALTER TABLE `invt_arsip_vendor`
  ADD CONSTRAINT `FK_invt_arsip_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `invt_r_vendor` (`vendor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_barang`
--
ALTER TABLE `invt_barang`
  ADD CONSTRAINT `FK_invt_barang` FOREIGN KEY (`jenis_barang_id`) REFERENCES `invt_r_jenis_barang` (`jenis_barang_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_barang_brand` FOREIGN KEY (`brand_id`) REFERENCES `invt_r_brand` (`brand_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_barang_kategori` FOREIGN KEY (`kategori_id`) REFERENCES `invt_r_kategori` (`kategori_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_barang_satuan` FOREIGN KEY (`satuan_id`) REFERENCES `invt_r_satuan` (`satuan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_barang_unit` FOREIGN KEY (`unit_id`) REFERENCES `invt_r_unit` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_barang_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `invt_r_vendor` (`vendor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_detail_peminjaman_barang`
--
ALTER TABLE `invt_detail_peminjaman_barang`
  ADD CONSTRAINT `FK_invt_detail_peminjaman_barang` FOREIGN KEY (`peminjaman_barang_id`) REFERENCES `invt_peminjaman_barang` (`peminjaman_barang_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_detail_peminjaman_barang_barang` FOREIGN KEY (`barang_id`) REFERENCES `invt_barang` (`barang_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_file_vendor`
--
ALTER TABLE `invt_file_vendor`
  ADD CONSTRAINT `FK_invt_file_vendor` FOREIGN KEY (`arsip_vendor_id`) REFERENCES `invt_arsip_vendor` (`arsip_vendor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_pelaporan_barang_rusak`
--
ALTER TABLE `invt_pelaporan_barang_rusak`
  ADD CONSTRAINT `FK_invt_barang_rusak` FOREIGN KEY (`barang_id`) REFERENCES `invt_barang` (`barang_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_barang_rusak_pelapor` FOREIGN KEY (`pelapor`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_pelaporan_barang_rusak_unit` FOREIGN KEY (`unit_id`) REFERENCES `invt_r_unit` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_pemindahan_barang`
--
ALTER TABLE `invt_pemindahan_barang`
  ADD CONSTRAINT `FK_invt_pemindahan_barang` FOREIGN KEY (`pengeluaran_barang_id`) REFERENCES `invt_pengeluaran_barang` (`pengeluaran_barang_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_peminjaman_barang`
--
ALTER TABLE `invt_peminjaman_barang`
  ADD CONSTRAINT `FK_invt_peminjaman_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_peminjaman_barang_unit` FOREIGN KEY (`unit_id`) REFERENCES `invt_r_unit` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_peminjaman_oleh` FOREIGN KEY (`oleh`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_pengeluaran_barang`
--
ALTER TABLE `invt_pengeluaran_barang`
  ADD CONSTRAINT `FK_invt_detail_pengeluaran_barang_barang` FOREIGN KEY (`barang_id`) REFERENCES `invt_barang` (`barang_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_pengeluaran_barang` FOREIGN KEY (`lokasi_id`) REFERENCES `invt_r_lokasi` (`lokasi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_pengeluaran_barang_STATUS` FOREIGN KEY (`status_akhir`) REFERENCES `invt_r_status` (`nama`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_pengeluaran_barang_keterangan` FOREIGN KEY (`keterangan_pengeluaran_id`) REFERENCES `invt_keterangan_pengeluaran` (`keterangan_pengeluaran_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_pic_barang`
--
ALTER TABLE `invt_pic_barang`
  ADD CONSTRAINT `FK_invt_pic_barang` FOREIGN KEY (`pengeluaran_barang_id`) REFERENCES `invt_pengeluaran_barang` (`pengeluaran_barang_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_pic_barang_pegawai` FOREIGN KEY (`pegawai_id`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_pic_barang_file`
--
ALTER TABLE `invt_pic_barang_file`
  ADD CONSTRAINT `FK_invt_pic_barang_file` FOREIGN KEY (`pic_barang_id`) REFERENCES `invt_pic_barang` (`pic_barang_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_summary_jumlah`
--
ALTER TABLE `invt_summary_jumlah`
  ADD CONSTRAINT `FK_invt_summary_jumlah` FOREIGN KEY (`barang_id`) REFERENCES `invt_barang` (`barang_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invt_unit_charged`
--
ALTER TABLE `invt_unit_charged`
  ADD CONSTRAINT `FK_invt_unit_user_unit` FOREIGN KEY (`unit_id`) REFERENCES `invt_r_unit` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invt_unit_user_user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kmhs_detail_kasus`
--
ALTER TABLE `kmhs_detail_kasus`
  ADD CONSTRAINT `fk_t_detail_kasus_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `kmhs_master_kasus`
--
ALTER TABLE `kmhs_master_kasus`
  ADD CONSTRAINT `fk_t_master_kasus_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `kmhs_nilai_perilaku`
--
ALTER TABLE `kmhs_nilai_perilaku`
  ADD CONSTRAINT `fk_t_nilai_perilaku_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_nilai_perilaku_t_kriteria_nilai_perilaku1` FOREIGN KEY (`kriteria_nilai_perilaku_id`) REFERENCES `kmhs_r_kriteria_nilai_perilaku` (`kriteria_nilai_perilaku_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kmhs_nilai_perilaku_arsip`
--
ALTER TABLE `kmhs_nilai_perilaku_arsip`
  ADD CONSTRAINT `fk_t_nilai_perilaku_arsip_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_nilai_perilaku_arsip_t_kriteria_nilai_perilaku1` FOREIGN KEY (`kriteria_nilai_perilaku_id`) REFERENCES `kmhs_r_kriteria_nilai_perilaku` (`kriteria_nilai_perilaku_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `kmhs_nilai_perilaku_as`
--
ALTER TABLE `kmhs_nilai_perilaku_as`
  ADD CONSTRAINT `fk_t_nilai_perilaku_as_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kmhs_nilai_perilaku_summary`
--
ALTER TABLE `kmhs_nilai_perilaku_summary`
  ADD CONSTRAINT `fk_t_nilai_perilaku_summary_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `kmhs_nilai_perilaku_ts`
--
ALTER TABLE `kmhs_nilai_perilaku_ts`
  ADD CONSTRAINT `fk_t_nilai_perilaku_ts_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `krkm_kuliah`
--
ALTER TABLE `krkm_kuliah`
  ADD CONSTRAINT `FK_krkm_kurikulum` FOREIGN KEY (`tahun_kurikulum_id`) REFERENCES `krkm_r_tahun_kurikulum` (`tahun_kurikulum_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_krkm_kurikulum_cg` FOREIGN KEY (`course_group_id`) REFERENCES `krkm_course_group` (`course_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_kurikulum_t_ref_kbk2` FOREIGN KEY (`ref_kbk_id`) REFERENCES `inst_prodi` (`ref_kbk_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `krkm_kuliah_prodi`
--
ALTER TABLE `krkm_kuliah_prodi`
  ADD CONSTRAINT `FK_krkm_kuliah_prodi` FOREIGN KEY (`kuliah_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_krkm_kuliah_prodi_ref_kbk` FOREIGN KEY (`ref_kbk_id`) REFERENCES `inst_prodi` (`ref_kbk_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `krkm_kurikulum_prodi`
--
ALTER TABLE `krkm_kurikulum_prodi`
  ADD CONSTRAINT `fk_t_kurikulum_prodi_t_kurikulum1` FOREIGN KEY (`kurikulum_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_kurikulum_prodi_t_ref_kbk1` FOREIGN KEY (`ref_kbk_id`) REFERENCES `inst_prodi` (`ref_kbk_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `krkm_prerequisite_courses`
--
ALTER TABLE `krkm_prerequisite_courses`
  ADD CONSTRAINT `FK_krkm_prerequisite_courses_kuri` FOREIGN KEY (`kuliah_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_krkm_prerequisite_courses_kuri_pre` FOREIGN KEY (`kuliah_pre_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `labx_alat`
--
ALTER TABLE `labx_alat`
  ADD CONSTRAINT `fk_lab` FOREIGN KEY (`lab_id`) REFERENCES `labx_lab` (`lab_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_lemari` FOREIGN KEY (`lemari_id`) REFERENCES `labx_lemari` (`lemari_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `labx_bahan`
--
ALTER TABLE `labx_bahan`
  ADD CONSTRAINT `fk_lab_bahan` FOREIGN KEY (`lab_id`) REFERENCES `labx_lab` (`lab_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_lemari_bahan` FOREIGN KEY (`lemari_id`) REFERENCES `labx_lemari` (`lemari_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_satuan` FOREIGN KEY (`satuan_id`) REFERENCES `labx_satuan` (`satuan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `labx_item_pemesanan`
--
ALTER TABLE `labx_item_pemesanan`
  ADD CONSTRAINT `fk_bahan_oesan` FOREIGN KEY (`bahan_id`) REFERENCES `labx_bahan` (`bahan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pemesanan_bahan` FOREIGN KEY (`pemesanan_id`) REFERENCES `labx_pemesanan` (`pemesanan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `labx_item_peminjaman`
--
ALTER TABLE `labx_item_peminjaman`
  ADD CONSTRAINT `fk_item_alat` FOREIGN KEY (`alat_id`) REFERENCES `labx_alat` (`alat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_item_peminjaman` FOREIGN KEY (`peminjaman_id`) REFERENCES `labx_peminjaman` (`peminjaman_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `labx_pemesanan`
--
ALTER TABLE `labx_pemesanan`
  ADD CONSTRAINT `fk_kuliah2` FOREIGN KEY (`kuliah_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pemesan` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pemesan_bahan` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_status` FOREIGN KEY (`status_id`) REFERENCES `labx_r_status` (`status_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tujuan2` FOREIGN KEY (`tujuan_id`) REFERENCES `labx_r_tujuan` (`tujuan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `labx_peminjaman`
--
ALTER TABLE `labx_peminjaman`
  ADD CONSTRAINT `fk_kuliah` FOREIGN KEY (`kuliah_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_peminjam_alat` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_status_peminjaman` FOREIGN KEY (`status_id`) REFERENCES `labx_r_status` (`status_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tujuan_peminjaman` FOREIGN KEY (`tujuan_id`) REFERENCES `labx_r_tujuan` (`tujuan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `labx_penambahan_stock_alat`
--
ALTER TABLE `labx_penambahan_stock_alat`
  ADD CONSTRAINT `alatfk2` FOREIGN KEY (`alat_id`) REFERENCES `labx_alat` (`alat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statusfk` FOREIGN KEY (`status_id`) REFERENCES `labx_r_status` (`status_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `userfk` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `labx_penambahan_stock_bahan`
--
ALTER TABLE `labx_penambahan_stock_bahan`
  ADD CONSTRAINT `bahanfk2` FOREIGN KEY (`bahan_id`) REFERENCES `labx_bahan` (`bahan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statusfk2` FOREIGN KEY (`status_id`) REFERENCES `labx_r_status` (`status_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `userfk2` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_penelitian_dosen`
--
ALTER TABLE `lppm_penelitian_dosen`
  ADD CONSTRAINT `lppm_penelitian_dosen_ibfk_2` FOREIGN KEY (`dosen_id`) REFERENCES `hrdx_dosen` (`dosen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lppm_penelitian_dosen_ibfk_3` FOREIGN KEY (`penelitian_id`) REFERENCES `lppm_penelitian` (`penelitian_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_r_subkaryailmiah`
--
ALTER TABLE `lppm_r_subkaryailmiah`
  ADD CONSTRAINT `FK_lppm_r_subkaryailmiah` FOREIGN KEY (`karyailmiah_id`) REFERENCES `lppm_r_karyailmiah` (`karyailmiah_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_author_publikasi`
--
ALTER TABLE `lppm_t_author_publikasi`
  ADD CONSTRAINT `FK_lppm_t_author_publikasi` FOREIGN KEY (`publikasi_id`) REFERENCES `lppm_t_publikasi` (`publikasi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_ketua_gbk`
--
ALTER TABLE `lppm_t_ketua_gbk`
  ADD CONSTRAINT `FK_lppm_t_ketua_gbk_dosen` FOREIGN KEY (`dosen_id`) REFERENCES `hrdx_dosen` (`dosen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_lppm_t_ketua_gbk_gbk` FOREIGN KEY (`gbk_id`) REFERENCES `mref_r_gbk` (`gbk_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_logreview`
--
ALTER TABLE `lppm_t_logreview`
  ADD CONSTRAINT `FK_lppm_t_logreview_pegawai` FOREIGN KEY (`pegawai_id`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_lppm_t_logreview_publikasi` FOREIGN KEY (`publikasi_id`) REFERENCES `lppm_t_publikasi` (`publikasi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_publikasi`
--
ALTER TABLE `lppm_t_publikasi`
  ADD CONSTRAINT `FK_lppm_t_publikasi_gbk` FOREIGN KEY (`gbk_id`) REFERENCES `mref_r_gbk` (`gbk_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_lppm_t_publikasi_pegawai` FOREIGN KEY (`pegawai_id`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_lppm_t_publikasi_sub_karya_ilmiah` FOREIGN KEY (`subkaryailmiah_id`) REFERENCES `lppm_r_subkaryailmiah` (`subkaryailmiah_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_registrasipublikasi`
--
ALTER TABLE `lppm_t_registrasipublikasi`
  ADD CONSTRAINT `FK_lppm_t_registrasipublikasi_publikasi` FOREIGN KEY (`publikasi_id`) REFERENCES `lppm_t_publikasi` (`publikasi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_registrasi_file`
--
ALTER TABLE `lppm_t_registrasi_file`
  ADD CONSTRAINT `FK_lppm_t_registrasi_file` FOREIGN KEY (`registrasipublikasi_id`) REFERENCES `lppm_t_registrasipublikasi` (`registrasipublikasi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_registrasi_jurnal`
--
ALTER TABLE `lppm_t_registrasi_jurnal`
  ADD CONSTRAINT `FK_lppm_t_registrasi_jurnal` FOREIGN KEY (`publikasi_id`) REFERENCES `lppm_t_publikasi` (`publikasi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_registrasi_jurnal_file`
--
ALTER TABLE `lppm_t_registrasi_jurnal_file`
  ADD CONSTRAINT `FK_lppm_t_registrasi_jurnal_file` FOREIGN KEY (`registrasi_jurnal_id`) REFERENCES `lppm_t_registrasi_jurnal` (`registrasi_jurnal_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_registrasi_prosiding`
--
ALTER TABLE `lppm_t_registrasi_prosiding`
  ADD CONSTRAINT `FK_lppm_t_registrasi_prosiding` FOREIGN KEY (`publikasi_id`) REFERENCES `lppm_t_publikasi` (`publikasi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_registrasi_prosiding_file`
--
ALTER TABLE `lppm_t_registrasi_prosiding_file`
  ADD CONSTRAINT `FK_lppm_t_registrasi_prosiding_file` FOREIGN KEY (`registrasi_prosiding_id`) REFERENCES `lppm_t_registrasi_prosiding` (`registrasi_prosiding_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_review_file`
--
ALTER TABLE `lppm_t_review_file`
  ADD CONSTRAINT `FK_lppm_t_review_file_log_review` FOREIGN KEY (`logreview_id`) REFERENCES `lppm_t_logreview` (`logreview_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_rewardpublikasi`
--
ALTER TABLE `lppm_t_rewardpublikasi`
  ADD CONSTRAINT `FK_lppm_t_rewardpublikasi` FOREIGN KEY (`publikasi_id`) REFERENCES `lppm_t_publikasi` (`publikasi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_reward_file`
--
ALTER TABLE `lppm_t_reward_file`
  ADD CONSTRAINT `FK_lppm_t_reward_file` FOREIGN KEY (`rewardpublikasi_id`) REFERENCES `lppm_t_rewardpublikasi` (`rewardpublikasi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_reward_jurnal`
--
ALTER TABLE `lppm_t_reward_jurnal`
  ADD CONSTRAINT `FK_lppm_t_reward_jurnal` FOREIGN KEY (`publikasi_id`) REFERENCES `lppm_t_publikasi` (`publikasi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_reward_jurnal_file`
--
ALTER TABLE `lppm_t_reward_jurnal_file`
  ADD CONSTRAINT `FK_lppm_t_reward_jurnal_file` FOREIGN KEY (`reward_jurnal_id`) REFERENCES `lppm_t_reward_jurnal` (`reward_jurnal_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_reward_prosiding`
--
ALTER TABLE `lppm_t_reward_prosiding`
  ADD CONSTRAINT `FK_lppm_t_reward_prosiding` FOREIGN KEY (`publikasi_id`) REFERENCES `lppm_t_publikasi` (`publikasi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lppm_t_reward_prosiding_file`
--
ALTER TABLE `lppm_t_reward_prosiding_file`
  ADD CONSTRAINT `FK_lppm_t_reward_prosiding_file` FOREIGN KEY (`reward_prosiding_id`) REFERENCES `lppm_t_reward_prosiding` (`reward_prosiding_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mref_r_asal_sekolah`
--
ALTER TABLE `mref_r_asal_sekolah`
  ADD CONSTRAINT `FK_mref_r_asal_sekolah` FOREIGN KEY (`kabupaten_id`) REFERENCES `mref_r_kabupaten` (`kabupaten_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_mref_r_asal_sekolah_provinsi` FOREIGN KEY (`provinsi_id`) REFERENCES `mref_r_provinsi` (`provinsi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_ext_mhs`
--
ALTER TABLE `nlai_ext_mhs`
  ADD CONSTRAINT `FK_nlai_ext_mhs` FOREIGN KEY (`ext_id`) REFERENCES `nlai_r_ext` (`ext_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_nlai_ext_mhs_dim` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_komponen_tambahan`
--
ALTER TABLE `nlai_komponen_tambahan`
  ADD CONSTRAINT `FK_nlai_komponen_tambahan_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_komposisi_nilai`
--
ALTER TABLE `nlai_komposisi_nilai`
  ADD CONSTRAINT `FK_nlai_komposisi_nilai_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_komposisi_nilai_uts_uas`
--
ALTER TABLE `nlai_komposisi_nilai_uts_uas`
  ADD CONSTRAINT `FK_nlai_komposisi_nilai_uts_uas` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_nilai`
--
ALTER TABLE `nlai_nilai`
  ADD CONSTRAINT `FK_nlai_nilai` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_nilai_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_nilai_komponen_tambahan`
--
ALTER TABLE `nlai_nilai_komponen_tambahan`
  ADD CONSTRAINT `FK_nlai_nilai_komponen_tambahan-dim` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_nlai_nilai_komponen_tambahan_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_nilai_praktikum`
--
ALTER TABLE `nlai_nilai_praktikum`
  ADD CONSTRAINT `FK_nlai_nilai_praktikum_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_nilai_praktikum_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_nilai_quis`
--
ALTER TABLE `nlai_nilai_quis`
  ADD CONSTRAINT `FK_nlai_nilai_quis_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_nilai_quis_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_nilai_tugas`
--
ALTER TABLE `nlai_nilai_tugas`
  ADD CONSTRAINT `FK_nlai_nilai_tugas_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_nilai_tugas_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_nilai_uas`
--
ALTER TABLE `nlai_nilai_uas`
  ADD CONSTRAINT `FK_nlai_nilai_uas_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_nilai_uas_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_nilai_uts`
--
ALTER TABLE `nlai_nilai_uts`
  ADD CONSTRAINT `FK_nlai_nilai_uts_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_nilai_uts_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_rentang_nilai`
--
ALTER TABLE `nlai_rentang_nilai`
  ADD CONSTRAINT `FK_nlai_rentang_nilai_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_uas_detail`
--
ALTER TABLE `nlai_uas_detail`
  ADD CONSTRAINT `FK_nlai_uas_detail` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_nlai_uas_detail_dim` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_nlai_uas_detail_komposisi` FOREIGN KEY (`komposisi_nilai_uts_uas_id`) REFERENCES `nlai_komposisi_nilai_uts_uas` (`komposisi_nilai_uts_uas_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nlai_uts_detail`
--
ALTER TABLE `nlai_uts_detail`
  ADD CONSTRAINT `FK_nlai_uts_detail` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_nlai_uts_detail_dim` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_nlai_uts_detail_komposisi` FOREIGN KEY (`komposisi_nilai_uts_uas_id`) REFERENCES `nlai_komposisi_nilai_uts_uas` (`komposisi_nilai_uts_uas_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_berita_acara_daftar_hadir`
--
ALTER TABLE `prkl_berita_acara_daftar_hadir`
  ADD CONSTRAINT `fk_t_berita_acara_daftar_hadir_t_dim1` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_berita_acara_daftar_hadir_t_kurikulum1` FOREIGN KEY (`kurikulum_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `prkl_berita_acara_kuliah`
--
ALTER TABLE `prkl_berita_acara_kuliah`
  ADD CONSTRAINT `FK_t_berita_acara_kuliah` FOREIGN KEY (`kelas_id`) REFERENCES `adak_kelas` (`kelas_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_berita_acara_kuliah_t_kurikulum1` FOREIGN KEY (`kurikulum_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `prkl_course_unit`
--
ALTER TABLE `prkl_course_unit`
  ADD CONSTRAINT `FK_prkl_course_unit_kurikulum_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_course_unit_pic` FOREIGN KEY (`pegawai_id`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_course_unit_material`
--
ALTER TABLE `prkl_course_unit_material`
  ADD CONSTRAINT `fk_t_course_unit_material_t_kurikulum1` FOREIGN KEY (`kurikulum_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_t_course_unit_material_t_material1` FOREIGN KEY (`material_id`) REFERENCES `prkl_material` (`material_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_file`
--
ALTER TABLE `prkl_file`
  ADD CONSTRAINT `FK_prkl_file_kuri_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_file_materi`
--
ALTER TABLE `prkl_file_materi`
  ADD CONSTRAINT `FK_prkl_file_materi` FOREIGN KEY (`materi_id`) REFERENCES `prkl_materi` (`materi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_file_praktikum`
--
ALTER TABLE `prkl_file_praktikum`
  ADD CONSTRAINT `FK_prkl_file_praktikum` FOREIGN KEY (`praktikum_id`) REFERENCES `prkl_praktikum` (`praktikum_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_file_syllabus`
--
ALTER TABLE `prkl_file_syllabus`
  ADD CONSTRAINT `FK_prkl_file_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_group_kuliah`
--
ALTER TABLE `prkl_group_kuliah`
  ADD CONSTRAINT `FK_prkl_group_kuliah_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_info_ta`
--
ALTER TABLE `prkl_info_ta`
  ADD CONSTRAINT `FK_prkl_info_ta_dim` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_info_ta_pembimbing1` FOREIGN KEY (`pembimbing_1`) REFERENCES `hrdx_dosen` (`dosen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_info_ta_pembimbing2` FOREIGN KEY (`pembimbing_2`) REFERENCES `hrdx_dosen` (`dosen_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_krs_detail`
--
ALTER TABLE `prkl_krs_detail`
  ADD CONSTRAINT `FK_prkl_krs_detail` FOREIGN KEY (`krs_mhs_id`) REFERENCES `prkl_krs_mhs` (`krs_mhs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_krs_detail_kuliah` FOREIGN KEY (`kuliah_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_krs_detail_pengajaran` FOREIGN KEY (`pengajaran_id`) REFERENCES `adak_pengajaran` (`pengajaran_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_krs_mhs`
--
ALTER TABLE `prkl_krs_mhs`
  ADD CONSTRAINT `FK_prkl_krs_mhs-dim` FOREIGN KEY (`dim_id`) REFERENCES `dimx_dim` (`dim_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_krs_mhs_pegawai_id` FOREIGN KEY (`approved_by`) REFERENCES `hrdx_pegawai` (`pegawai_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_krs_mhs_ta_kur` FOREIGN KEY (`tahun_kurikulum_id`) REFERENCES `krkm_r_tahun_kurikulum` (`tahun_kurikulum_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_krs_review`
--
ALTER TABLE `prkl_krs_review`
  ADD CONSTRAINT `FK_prkl_krs_review` FOREIGN KEY (`krs_mhs_id`) REFERENCES `prkl_krs_mhs` (`krs_mhs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_krs_review_dosen` FOREIGN KEY (`comment_by`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_kuesioner_materi`
--
ALTER TABLE `prkl_kuesioner_materi`
  ADD CONSTRAINT `FK_t_kuesioner_materi` FOREIGN KEY (`kurikulum_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_kuesioner_praktikum`
--
ALTER TABLE `prkl_kuesioner_praktikum`
  ADD CONSTRAINT `FK_t_kuesioner_praktikum` FOREIGN KEY (`kuliah_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_kurikulum_syllabus`
--
ALTER TABLE `prkl_kurikulum_syllabus`
  ADD CONSTRAINT `FK_prkl_kurikulum_syllabus` FOREIGN KEY (`kuliah_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_kurikulum_syllabus_ta` FOREIGN KEY (`ta_id`) REFERENCES `mref_r_ta` (`ta_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_kurikulum_syllabus_file`
--
ALTER TABLE `prkl_kurikulum_syllabus_file`
  ADD CONSTRAINT `FK_prkl_kurikulum_syllabus_file` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_materi`
--
ALTER TABLE `prkl_materi`
  ADD CONSTRAINT `FK_prkl_materi_group_kuliah` FOREIGN KEY (`group_kuliah_id`) REFERENCES `prkl_group_kuliah` (`group_kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_materi_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_material`
--
ALTER TABLE `prkl_material`
  ADD CONSTRAINT `fk_t_material_t_material_kategori1` FOREIGN KEY (`material_kategori_id`) REFERENCES `prkl_material_kategori` (`material_kategori_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_penilaian_materi`
--
ALTER TABLE `prkl_penilaian_materi`
  ADD CONSTRAINT `fk_t_penilaian_materi_t_kuesioner_materi1` FOREIGN KEY (`kuesioner_materi_id`) REFERENCES `prkl_kuesioner_materi` (`kuesioner_materi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_penilaian_praktikum`
--
ALTER TABLE `prkl_penilaian_praktikum`
  ADD CONSTRAINT `fk_t_penilaian_praktikum_t_kuesioner_praktikum1` FOREIGN KEY (`kuesioner_praktikum_id`) REFERENCES `prkl_kuesioner_praktikum` (`kuesioner_praktikum_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_penilaian_tim_pengajar`
--
ALTER TABLE `prkl_penilaian_tim_pengajar`
  ADD CONSTRAINT `FK_prkl_penilaian_tim_pengajar_profile` FOREIGN KEY (`profile_id`) REFERENCES `hrdx_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_praktikum`
--
ALTER TABLE `prkl_praktikum`
  ADD CONSTRAINT `FK_prkl_praktikum_group_kuliah` FOREIGN KEY (`group_kuliah_id`) REFERENCES `prkl_group_kuliah` (`group_kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prkl_praktikum_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prkl_rpp`
--
ALTER TABLE `prkl_rpp`
  ADD CONSTRAINT `FK_prkl_rpp_kurikulum_syllabus` FOREIGN KEY (`kurikulum_syllabus_id`) REFERENCES `prkl_kurikulum_syllabus` (`kurikulum_syllabus_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rakx_detil_program`
--
ALTER TABLE `rakx_detil_program`
  ADD CONSTRAINT `fk_detil_program_program` FOREIGN KEY (`program_id`) REFERENCES `rakx_program` (`program_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rakx_mata_anggaran`
--
ALTER TABLE `rakx_mata_anggaran`
  ADD CONSTRAINT `fk_mata_anggaran_standar` FOREIGN KEY (`standar_id`) REFERENCES `rakx_r_standar` (`standar_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rakx_program`
--
ALTER TABLE `rakx_program`
  ADD CONSTRAINT `fk_program_dilaksanakan` FOREIGN KEY (`dilaksanakan_oleh`) REFERENCES `inst_struktur_jabatan` (`struktur_jabatan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_program_direvisi` FOREIGN KEY (`direvisi_oleh`) REFERENCES `inst_pejabat` (`pejabat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_program_disetujui` FOREIGN KEY (`disetujui_oleh`) REFERENCES `inst_pejabat` (`pejabat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_program_ditolak` FOREIGN KEY (`ditolak_oleh`) REFERENCES `inst_pejabat` (`pejabat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_program_diusulkan` FOREIGN KEY (`diusulkan_oleh`) REFERENCES `inst_pejabat` (`pejabat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_program_rencana_strategis` FOREIGN KEY (`rencana_strategis_id`) REFERENCES `rakx_r_rencana_strategis` (`rencana_strategis_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_program_satuan` FOREIGN KEY (`satuan_id`) REFERENCES `rakx_r_satuan` (`satuan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_program_status_program` FOREIGN KEY (`status_program_id`) REFERENCES `rakx_r_status_program` (`status_program_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_program_struktur_jabatan_has_mata_anggaran` FOREIGN KEY (`struktur_jabatan_has_mata_anggaran_id`) REFERENCES `rakx_struktur_jabatan_has_mata_anggaran` (`struktur_jabatan_has_mata_anggaran_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rakx_program_has_sumber_dana`
--
ALTER TABLE `rakx_program_has_sumber_dana`
  ADD CONSTRAINT `fk_program_has_sumber_dana_program` FOREIGN KEY (`program_id`) REFERENCES `rakx_program` (`program_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_program_has_sumber_dana_sumber_dana` FOREIGN KEY (`sumber_dana_id`) REFERENCES `rakx_r_sumber_dana` (`sumber_dana_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rakx_program_has_waktu`
--
ALTER TABLE `rakx_program_has_waktu`
  ADD CONSTRAINT `fk_program_has_waktu_bulan` FOREIGN KEY (`bulan_id`) REFERENCES `rakx_r_bulan` (`bulan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_program_has_waktu_program` FOREIGN KEY (`program_id`) REFERENCES `rakx_program` (`program_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rakx_review_program`
--
ALTER TABLE `rakx_review_program`
  ADD CONSTRAINT `fk_review_anggaran_pejabat` FOREIGN KEY (`pejabat_id`) REFERENCES `inst_pejabat` (`pejabat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_review_anggaran_program` FOREIGN KEY (`program_id`) REFERENCES `rakx_program` (`program_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rakx_struktur_jabatan_has_mata_anggaran`
--
ALTER TABLE `rakx_struktur_jabatan_has_mata_anggaran`
  ADD CONSTRAINT `fk_struktur_jabatan_has_mata_anggaran_mata_anggaran` FOREIGN KEY (`mata_anggaran_id`) REFERENCES `rakx_mata_anggaran` (`mata_anggaran_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_struktur_jabatan_has_mata_anggaran_struktur_jabatan` FOREIGN KEY (`struktur_jabatan_id`) REFERENCES `inst_struktur_jabatan` (`struktur_jabatan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_struktur_jabatan_has_mata_anggaran_tahun_anggaran` FOREIGN KEY (`tahun_anggaran_id`) REFERENCES `rakx_r_tahun_anggaran` (`tahun_anggaran_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rprt_complaint`
--
ALTER TABLE `rprt_complaint`
  ADD CONSTRAINT `FK_rprt_complaint_bagian` FOREIGN KEY (`bagian_id`) REFERENCES `rprt_r_bagian` (`bagian_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_rprt_complaint_status` FOREIGN KEY (`status_id`) REFERENCES `rprt_r_status` (`status_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_rprt_complaint_user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rprt_response`
--
ALTER TABLE `rprt_response`
  ADD CONSTRAINT `FK_rprt_response_complaint` FOREIGN KEY (`complaint_id`) REFERENCES `rprt_complaint` (`complaint_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_rprt_response_user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rprt_user_has_bagian`
--
ALTER TABLE `rprt_user_has_bagian`
  ADD CONSTRAINT `FK_rprt_user_has_bagian_bagian` FOREIGN KEY (`bagian_id`) REFERENCES `rprt_r_bagian` (`bagian_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_rprt_user_has_bagian_user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `schd_event`
--
ALTER TABLE `schd_event`
  ADD CONSTRAINT `FK_schd_event` FOREIGN KEY (`lokasi_id`) REFERENCES `invt_r_lokasi` (`lokasi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_schd_event_calender` FOREIGN KEY (`calender_id`) REFERENCES `schd_r_calender` (`calender_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `schd_event_invitee`
--
ALTER TABLE `schd_event_invitee`
  ADD CONSTRAINT `FK_schd_event_invitee` FOREIGN KEY (`event_id`) REFERENCES `schd_event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_schd_event_invitee-user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `schd_file_event`
--
ALTER TABLE `schd_file_event`
  ADD CONSTRAINT `FK_schd_file_event_file` FOREIGN KEY (`event_id`) REFERENCES `schd_event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `schd_jadwal_kuliah`
--
ALTER TABLE `schd_jadwal_kuliah`
  ADD CONSTRAINT `FK_schd_jadwal_kuliah` FOREIGN KEY (`event_id`) REFERENCES `schd_event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_schd_jadwal_kuliah_kelas` FOREIGN KEY (`kelas_id`) REFERENCES `adak_kelas` (`kelas_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_schd_jadwal_kuliah_kuliah` FOREIGN KEY (`kuliah_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `schd_subscriber`
--
ALTER TABLE `schd_subscriber`
  ADD CONSTRAINT `FK_schd_subscriber` FOREIGN KEY (`calender_id`) REFERENCES `schd_r_calender` (`calender_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `srvy_kuesioner_jawaban_peserta`
--
ALTER TABLE `srvy_kuesioner_jawaban_peserta`
  ADD CONSTRAINT `FK_srvy_kuesioner_jawaban_peserta` FOREIGN KEY (`kuesioner_pertanyaan_id`) REFERENCES `srvy_kuesioner_pertanyaan` (`kuesioner_pertanyaan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_srvy_kuesioner_jawaban_peserta_kuesioner` FOREIGN KEY (`kuesioner_id`) REFERENCES `srvy_kuesioner` (`kuesioner_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_srvy_kuesioner_jawaban_peserta_user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `srvy_kuesioner_opsi`
--
ALTER TABLE `srvy_kuesioner_opsi`
  ADD CONSTRAINT `FK_srvy_kuesioner_opsi_pertanyaan` FOREIGN KEY (`kuesioner_pertanyaan_id`) REFERENCES `srvy_kuesioner_pertanyaan` (`kuesioner_pertanyaan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `srvy_kuesioner_pertanyaan`
--
ALTER TABLE `srvy_kuesioner_pertanyaan`
  ADD CONSTRAINT `fk_t_kuesioner_pertanyaan_t_kuesioner1` FOREIGN KEY (`kuesioner_id`) REFERENCES `srvy_kuesioner` (`kuesioner_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `srvy_pollopsi`
--
ALTER TABLE `srvy_pollopsi`
  ADD CONSTRAINT `fk_t_POLLOPSI_t_POLLING1` FOREIGN KEY (`polling_id`) REFERENCES `srvy_polling` (`polling_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `srvy_pollvote`
--
ALTER TABLE `srvy_pollvote`
  ADD CONSTRAINT `FK_srvy_pollvote_polling_id` FOREIGN KEY (`polling_id`) REFERENCES `srvy_polling` (`polling_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_pollvote` FOREIGN KEY (`pollopsi_id`) REFERENCES `srvy_pollopsi` (`pollopsi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `srvy_workgroup_kuesioner`
--
ALTER TABLE `srvy_workgroup_kuesioner`
  ADD CONSTRAINT `FK_srvy_workgroup_kuesioner_kuesioner` FOREIGN KEY (`kuesioner_id`) REFERENCES `srvy_kuesioner` (`kuesioner_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_srvy_workgroup_kuesioner_wg` FOREIGN KEY (`workgroup_id`) REFERENCES `sysx_workgroup` (`workgroup_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `srvy_workgroup_polling`
--
ALTER TABLE `srvy_workgroup_polling`
  ADD CONSTRAINT `FK_srvy_workgroup_polling_poll` FOREIGN KEY (`polling_id`) REFERENCES `srvy_polling` (`polling_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_srvy_workgroup_polling_wk` FOREIGN KEY (`workgroup_id`) REFERENCES `sysx_workgroup` (`workgroup_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_action`
--
ALTER TABLE `sysx_action`
  ADD CONSTRAINT `fk_action_controller1` FOREIGN KEY (`controller_id`) REFERENCES `sysx_controller` (`controller_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_config`
--
ALTER TABLE `sysx_config`
  ADD CONSTRAINT `fk_config_application1` FOREIGN KEY (`application_id`) REFERENCES `sysx_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_controller`
--
ALTER TABLE `sysx_controller`
  ADD CONSTRAINT `fk_controller_module1` FOREIGN KEY (`module_id`) REFERENCES `sysx_module` (`module_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_job_allocation`
--
ALTER TABLE `sysx_job_allocation`
  ADD CONSTRAINT `fk_job_allocation_job_definition1` FOREIGN KEY (`job_definition_id`) REFERENCES `sysx_job_definition` (`job_definition_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `sysx_log`
--
ALTER TABLE `sysx_log`
  ADD CONSTRAINT `fk_Log_user1` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_menu_item`
--
ALTER TABLE `sysx_menu_item`
  ADD CONSTRAINT `fk_menu_item_menu_group1` FOREIGN KEY (`menu_group_id`) REFERENCES `sysx_menu_group` (`menu_group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_module`
--
ALTER TABLE `sysx_module`
  ADD CONSTRAINT `fk_module_application1` FOREIGN KEY (`application_id`) REFERENCES `sysx_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_permission`
--
ALTER TABLE `sysx_permission`
  ADD CONSTRAINT `fk_permission_action1` FOREIGN KEY (`action_id`) REFERENCES `sysx_action` (`action_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_role_has_action`
--
ALTER TABLE `sysx_role_has_action`
  ADD CONSTRAINT `fk_role_has_action_action1` FOREIGN KEY (`action_id`) REFERENCES `sysx_action` (`action_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_role_has_action_role1` FOREIGN KEY (`role_id`) REFERENCES `sysx_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_role_has_application`
--
ALTER TABLE `sysx_role_has_application`
  ADD CONSTRAINT `fk_role_has_application_application1` FOREIGN KEY (`application_id`) REFERENCES `sysx_application` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_role_has_application_role1` FOREIGN KEY (`role_id`) REFERENCES `sysx_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_role_has_controller`
--
ALTER TABLE `sysx_role_has_controller`
  ADD CONSTRAINT `fk_role_has_controller_controller1` FOREIGN KEY (`controller_id`) REFERENCES `sysx_controller` (`controller_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_role_has_controller_role1` FOREIGN KEY (`role_id`) REFERENCES `sysx_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_role_has_menu_item`
--
ALTER TABLE `sysx_role_has_menu_item`
  ADD CONSTRAINT `fk_menu_item_has_role_menu_item1` FOREIGN KEY (`menu_item_id`) REFERENCES `sysx_menu_item` (`menu_item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_menu_item_has_role_role1` FOREIGN KEY (`role_id`) REFERENCES `sysx_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_role_has_module`
--
ALTER TABLE `sysx_role_has_module`
  ADD CONSTRAINT `fk_role_has_module_module1` FOREIGN KEY (`module_id`) REFERENCES `sysx_module` (`module_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_role_has_module_role1` FOREIGN KEY (`role_id`) REFERENCES `sysx_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_role_has_permission`
--
ALTER TABLE `sysx_role_has_permission`
  ADD CONSTRAINT `fk_role_has_permission_permission2` FOREIGN KEY (`permission_id`) REFERENCES `sysx_permission` (`permission_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_role_has_permission_role2` FOREIGN KEY (`role_id`) REFERENCES `sysx_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_role_has_task`
--
ALTER TABLE `sysx_role_has_task`
  ADD CONSTRAINT `fk_role_has_permission_permission1` FOREIGN KEY (`task_id`) REFERENCES `sysx_task` (`task_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_role_has_permission_role1` FOREIGN KEY (`role_id`) REFERENCES `sysx_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_telkom_sso_user`
--
ALTER TABLE `sysx_telkom_sso_user`
  ADD CONSTRAINT `FK_sysx_telkom_sso_user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_telkom_sso_user_log`
--
ALTER TABLE `sysx_telkom_sso_user_log`
  ADD CONSTRAINT `FK_sysx_telkom_sso_user_log` FOREIGN KEY (`telkom_sso_user_id`) REFERENCES `sysx_telkom_sso_user` (`telkom_sso_user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_user`
--
ALTER TABLE `sysx_user`
  ADD CONSTRAINT `fk_user_authentication_method1` FOREIGN KEY (`authentication_method_id`) REFERENCES `sysx_authentication_method` (`authentication_method_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_profile1` FOREIGN KEY (`profile_id`) REFERENCES `sysx_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_user_config`
--
ALTER TABLE `sysx_user_config`
  ADD CONSTRAINT `fk_sysx_user_config_sysx_application1` FOREIGN KEY (`application_id`) REFERENCES `sysx_application` (`application_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sysx_user_config_sysx_user1` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sysx_user_has_role`
--
ALTER TABLE `sysx_user_has_role`
  ADD CONSTRAINT `fk_user_has_role_role1` FOREIGN KEY (`role_id`) REFERENCES `sysx_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_has_role_user` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sysx_user_has_workgroup`
--
ALTER TABLE `sysx_user_has_workgroup`
  ADD CONSTRAINT `fk_user_has_workgroup_user1` FOREIGN KEY (`user_id`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_has_workgroup_workgroup1` FOREIGN KEY (`workgroup_id`) REFERENCES `sysx_workgroup` (`workgroup_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `tmbh_file_pengumuman`
--
ALTER TABLE `tmbh_file_pengumuman`
  ADD CONSTRAINT `FK_tmbh_file_pengumuman` FOREIGN KEY (`pengumuman_id`) REFERENCES `tmbh_pengumuman` (`pengumuman_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tmbh_news`
--
ALTER TABLE `tmbh_news`
  ADD CONSTRAINT `fk_t_NEWS_t_NEWS_KATEGORI1` FOREIGN KEY (`news_kategori_id`) REFERENCES `tmbh_news_kategori` (`news_kategori_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tmbh_pengumuman`
--
ALTER TABLE `tmbh_pengumuman`
  ADD CONSTRAINT `FK_tmbh_pengumuman` FOREIGN KEY (`owner`) REFERENCES `sysx_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tmbh_software_tools`
--
ALTER TABLE `tmbh_software_tools`
  ADD CONSTRAINT `fk_t_software_tools_t_kurikulum1` FOREIGN KEY (`kurikulum_id`) REFERENCES `krkm_kuliah` (`kuliah_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
