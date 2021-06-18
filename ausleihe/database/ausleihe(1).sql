-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 18. Jun 2021 um 10:16
-- Server-Version: 10.4.19-MariaDB
-- PHP-Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `ausleihe`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `eventtype`
--

CREATE TABLE `eventtype` (
  `event_type_id` int(11) NOT NULL,
  `name` text NOT NULL DEFAULT 'UNKNOWN',
  `description` text NOT NULL DEFAULT 'UNKNOWN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `eventtype`
--

INSERT INTO `eventtype` (`event_type_id`, `name`, `description`) VALUES
(1, 'RFID_READ', 'Ein Lesezugriff'),
(2, 'RFID_WRITE', 'Schreibzugriff auf RFID-Device');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `geraete`
--

CREATE TABLE `geraete` (
  `id` int(11) NOT NULL,
  `mac` text DEFAULT NULL,
  `name` text NOT NULL DEFAULT 'UNKNOWN',
  `rfid_label` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `klassen`
--

CREATE TABLE `klassen` (
  `id` int(11) NOT NULL,
  `klassen_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `klassen`
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
-- Tabellenstruktur für Tabelle `rfid_devices`
--

CREATE TABLE `rfid_devices` (
  `device_id` int(11) NOT NULL,
  `device_type` int(11) NOT NULL,
  `rfid_code` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `rfid_devices`
--

INSERT INTO `rfid_devices` (`device_id`, `device_type`, `rfid_code`) VALUES
(1, 1, '6815.510528921625'),
(2, 2, '6406.586651137644'),
(3, 2, '6815.510528921111'),
(4, 2, '6815.123412341234'),
(5, 1, '6815.510528922222'),
(6, 3, '6815.123498761543');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rfid_device_type`
--

CREATE TABLE `rfid_device_type` (
  `device_type_id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `rfid_device_type`
--

INSERT INTO `rfid_device_type` (`device_type_id`, `name`) VALUES
(1, 'Ipad'),
(2, 'UserCard'),
(3, 'Surface Book');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rfid_event`
--

CREATE TABLE `rfid_event` (
  `id` int(11) NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `rfid_event`
--

INSERT INTO `rfid_event` (`id`, `event_type_id`, `user_id`, `device_id`, `status`, `time_stamp`) VALUES
(19, 1, 1, 6, 1, '2021-06-18 08:10:46'),
(20, 1, 1, 6, 0, '2021-06-18 08:10:59');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `vorname` text NOT NULL,
  `name` text NOT NULL,
  `klasse` int(11) NOT NULL,
  `rfid_code` int(11) DEFAULT NULL,
  `rfid_device_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `user`
--

INSERT INTO `user` (`user_id`, `vorname`, `name`, `klasse`, `rfid_code`, `rfid_device_id`) VALUES
(1, 'Fred', 'Foodbar', 6, 2, 0),
(2, 'Emil', 'Fischer', 8, 3, 0),
(3, 'Test', 'Test 2 (9a)', 6, 4, 0),
(4, 'Test', 'Test 3', 6, NULL, 0),
(5, 'Test', 'Test 3 (9a)', 6, NULL, 0),
(6, 'test', 'Lehrer', 1, NULL, 0),
(7, 'Maria', 'DB', 7, NULL, 0),
(8, 'test', 'Lehrer2', 1, NULL, 0),
(9, 'Maria2', 'DB2', 7, NULL, 0);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `eventtype`
--
ALTER TABLE `eventtype`
  ADD PRIMARY KEY (`event_type_id`);

--
-- Indizes für die Tabelle `geraete`
--
ALTER TABLE `geraete`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rfid_label` (`rfid_label`);

--
-- Indizes für die Tabelle `klassen`
--
ALTER TABLE `klassen`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `rfid_devices`
--
ALTER TABLE `rfid_devices`
  ADD PRIMARY KEY (`device_id`),
  ADD KEY `device_type` (`device_type`);

--
-- Indizes für die Tabelle `rfid_device_type`
--
ALTER TABLE `rfid_device_type`
  ADD PRIMARY KEY (`device_type_id`);

--
-- Indizes für die Tabelle `rfid_event`
--
ALTER TABLE `rfid_event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_type_id` (`event_type_id`),
  ADD KEY `device_id` (`device_id`);

--
-- Indizes für die Tabelle `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `klasse` (`klasse`),
  ADD KEY `rfid_user_index` (`rfid_code`),
  ADD KEY `rfid_device_id` (`rfid_device_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `eventtype`
--
ALTER TABLE `eventtype`
  MODIFY `event_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `geraete`
--
ALTER TABLE `geraete`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `klassen`
--
ALTER TABLE `klassen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT für Tabelle `rfid_devices`
--
ALTER TABLE `rfid_devices`
  MODIFY `device_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `rfid_device_type`
--
ALTER TABLE `rfid_device_type`
  MODIFY `device_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `rfid_event`
--
ALTER TABLE `rfid_event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT für Tabelle `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `geraete`
--
ALTER TABLE `geraete`
  ADD CONSTRAINT `geraete_ibfk_1` FOREIGN KEY (`rfid_label`) REFERENCES `rfid_devices` (`device_id`);

--
-- Constraints der Tabelle `rfid_devices`
--
ALTER TABLE `rfid_devices`
  ADD CONSTRAINT `rfid_devices_ibfk_1` FOREIGN KEY (`device_type`) REFERENCES `rfid_device_type` (`device_type_id`);

--
-- Constraints der Tabelle `rfid_event`
--
ALTER TABLE `rfid_event`
  ADD CONSTRAINT `rfid_event_ibfk_1` FOREIGN KEY (`event_type_id`) REFERENCES `eventtype` (`event_type_id`),
  ADD CONSTRAINT `rfid_event_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `rfid_devices` (`device_id`);

--
-- Constraints der Tabelle `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`klasse`) REFERENCES `klassen` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`rfid_code`) REFERENCES `rfid_devices` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
