-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 06 Jan 2024 pada 20.25
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ulbi2024db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `mstdosen`
--

CREATE TABLE `mstdosen` (
  `nidn` char(10) DEFAULT NULL,
  `nama_dosen` varchar(100) DEFAULT NULL,
  `alamat` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mstdosen`
--

INSERT INTO `mstdosen` (`nidn`, `nama_dosen`, `alamat`) VALUES
('0407117405', ' M. Yusril Helmi Setyawan', 'Bandung'),
('0410118609', ' Rolly Maulana Awangga', 'Bandung'),
('0402058005', ' Mohamad Nurkamal Fauzan', 'Bandung'),
('0427078401', ' Cahyo Prianto', 'Bandung'),
('0416048803', 'Syafrial Fachri Pane', 'Bandung'),
('0402047205', 'Rd. Nuraini Siti Fatonah', 'Bandung'),
('0415048901', 'Nisa Hanum Harani', 'Bandung'),
('0423127804', 'Roni Habibi', 'Bandung');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mstmahasiswa`
--

CREATE TABLE `mstmahasiswa` (
  `npm` char(10) DEFAULT NULL,
  `nama_lengkap` varchar(100) DEFAULT NULL,
  `alamat` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mstmahasiswa`
--

INSERT INTO `mstmahasiswa` (`npm`, `nama_lengkap`, `alamat`) VALUES
('1214079', 'Aulia Maharani', 'Lubuklinggau'),
('12140110', 'Andrian Mukhtadin', 'Lubuklinggau'),
('1214085', 'Fitrah Ali Akbar Setiawan', 'Bandung'),
('13121037', 'Ferry Kurniawan', 'Medan'),
('13121004', 'Zaru Alghifari', 'Bukit Tinggi'),
('1214057', 'Maylinda Christy Yosefina Talan', 'Bandung'),
('1214081', 'Ibrohim Mubarok', 'Jambi'),
('1214064', 'Adam Ghafara', 'Bandung');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mstmatakuliah`
--

CREATE TABLE `mstmatakuliah` (
  `kode_matkul` char(10) DEFAULT NULL,
  `nama_matkul` varchar(100) DEFAULT NULL,
  `sks` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mstmatakuliah`
--

INSERT INTO `mstmatakuliah` (`kode_matkul`, `nama_matkul`, `sks`) VALUES
('12345', 'Literasi Digital', '4'),
('09876', 'Literasi Data', '4'),
('65432', 'Basis Data I', '3'),
('11225', 'Basis Data II', '3'),
('1223', 'SAP Advanced', '4'),
('55784', 'Keamanan Sistem Informasi', '4'),
('87654', 'Proyek I', '4');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mstruangan`
--

CREATE TABLE `mstruangan` (
  `kode_ruangan` char(10) DEFAULT NULL,
  `nama_ruangan` varchar(100) DEFAULT NULL,
  `kapasitas` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mstruangan`
--

INSERT INTO `mstruangan` (`kode_ruangan`, `nama_ruangan`, `kapasitas`) VALUES
('113', 'Lab', '50'),
('112', 'Lab', '40'),
('114', 'Lab', '15'),
('115', 'Lab', '22'),
('116', 'Lab', '25'),
('315', 'Lab', '30');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
