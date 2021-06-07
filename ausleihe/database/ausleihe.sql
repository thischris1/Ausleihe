-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 30, 2021 at 10:55 AM
-- Server version: 10.4.19-MariaDB 
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ausleihe`
--

-- --------------------------------------------------------

--
-- Table structure for table `eventType`
--

CREATE TABLE `eventType` (
  `event_type_id` int(11) NOT NULL,
  `name` text NOT NULL DEFAULT 'UNKNOWN',
  `description` text NOT NULL DEFAULT 'UNKNOWN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `eventType`
--

INSERT INTO `eventType` (`event_type_id`, `name`, `description`) VALUES
(1, 'RFID_READ', 'Ein Lesezugriff'),
(2, 'RFID_WRITE', 'Schreibzugriff auf RFID-Device');

-- --------------------------------------------------------

--
-- Table structure for table `geraete`
--

CREATE TABLE `geraete` (
  `id` int(11) NOT NULL,
  `mac` text DEFAULT NULL,
  `name` text NOT NULL DEFAULT 'UNKNOWN',
  `rfid_label` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `klassen`
--

CREATE TABLE `klassen` (
  `id` int(11) NOT NULL,
  `klassen_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `klassen`
--

INSERT INTO `klassen` (`id`, `klassen_name`) VALUES
(1, 'Lehrer'),
(2, '5a'),
(3, '5b'),
(4, '5c'),
(5, '5d'),
(6, '9a'),
(7, '9b'),
(8, '9c'),
(9, '10b');

-- --------------------------------------------------------

--
-- Table structure for table `rfid_devices`
--

CREATE TABLE `rfid_devices` (
  `device_id` int(11) NOT NULL,
  `device_type` int(11) NOT NULL,
  `rfid_code` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rfid_devices`
--

INSERT INTO `rfid_devices` (`device_id`, `device_type`, `rfid_code`) VALUES
(1, 1, '6815.510528921625'),
(2, 2, '6406.586651137644');

-- --------------------------------------------------------

--
-- Table structure for table `rfid_device_type`
--

CREATE TABLE `rfid_device_type` (
  `device_type_id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rfid_device_type`
--

INSERT INTO `rfid_device_type` (`device_type_id`, `name`) VALUES
(1, 'Device'),
(2, 'UserCard');

-- --------------------------------------------------------

--
-- Table structure for table `rfid_event`
--

CREATE TABLE `rfid_event` (
  `id` int(11) NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rfid_event`
--

INSERT INTO `rfid_event` (`id`, `event_type_id`, `device_id`) VALUES
(1, 1, 1),
(2, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `vorname` text NOT NULL,
  `name` text NOT NULL,
  `klasse` int(11) NOT NULL,
  `rfid_code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `vorname`, `name`, `klasse`, `rfid_code`) VALUES
(1, 'Fred', 'Foobar', 6, 2),
(2, 'Test', 'Test 1', 8, NULL),
(3, 'Test', 'Test 2 (9a)', 6, NULL),
(4, 'Test', 'Test 3', 6, NULL),
(5, 'Test', 'Test 3 (9a)', 6, NULL),
(6, 'test', 'Lehrer', 1, NULL),
(7, 'Maria', 'DB', 7, NULL),
(8, 'test', 'Lehrer2', 1, NULL),
(9, 'Maria2', 'DB2', 7, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `eventType`
--
ALTER TABLE `eventType`
  ADD PRIMARY KEY (`event_type_id`);

--
-- Indexes for table `geraete`
--
ALTER TABLE `geraete`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rfid_label` (`rfid_label`);

--
-- Indexes for table `klassen`
--
ALTER TABLE `klassen`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rfid_devices`
--
ALTER TABLE `rfid_devices`
  ADD PRIMARY KEY (`device_id`),
  ADD KEY `device_type` (`device_type`);

--
-- Indexes for table `rfid_device_type`
--
ALTER TABLE `rfid_device_type`
  ADD PRIMARY KEY (`device_type_id`);

--
-- Indexes for table `rfid_event`
--
ALTER TABLE `rfid_event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_type_id` (`event_type_id`),
  ADD KEY `device_id` (`device_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `klasse` (`klasse`),
  ADD KEY `rfid_user_index` (`rfid_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `eventType`
--
ALTER TABLE `eventType`
  MODIFY `event_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `geraete`
--
ALTER TABLE `geraete`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `klassen`
--
ALTER TABLE `klassen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `rfid_devices`
--
ALTER TABLE `rfid_devices`
  MODIFY `device_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rfid_device_type`
--
ALTER TABLE `rfid_device_type`
  MODIFY `device_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rfid_event`
--
ALTER TABLE `rfid_event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `geraete`
--
ALTER TABLE `geraete`
  ADD CONSTRAINT `geraete_ibfk_1` FOREIGN KEY (`rfid_label`) REFERENCES `rfid_devices` (`device_id`);

--
-- Constraints for table `rfid_devices`
--
ALTER TABLE `rfid_devices`
  ADD CONSTRAINT `rfid_devices_ibfk_1` FOREIGN KEY (`device_type`) REFERENCES `rfid_device_type` (`device_type_id`);

--
-- Constraints for table `rfid_event`
--
ALTER TABLE `rfid_event`
  ADD CONSTRAINT `rfid_event_ibfk_1` FOREIGN KEY (`event_type_id`) REFERENCES `eventType` (`event_type_id`),
  ADD CONSTRAINT `rfid_event_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `rfid_devices` (`device_id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`klasse`) REFERENCES `klassen` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`rfid_code`) REFERENCES `rfid_devices` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
