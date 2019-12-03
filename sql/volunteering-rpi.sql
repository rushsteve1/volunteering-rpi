-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 03, 2019 at 06:54 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `volunteering-rpi`
--

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `eventName` varchar(100) DEFAULT NULL,
  `orgID` int(11) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `occupancy` int(11) DEFAULT NULL,
  `eventDuration` int(11) DEFAULT NULL,
  `eventDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `eventName`, `orgID`, `description`, `location`, `occupancy`, `eventDuration`, `eventDate`) VALUES
(1, 'CircleK Annual Food drive', 1, 'Come help us bring food to a food kitchen!', 'Troy, New York', 30, 2, '2019-11-25 10:22:00');

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `id` int(11) NOT NULL,
  `orgName` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `adminID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organizations`
--

INSERT INTO `organizations` (`id`, `orgName`, `description`, `website`, `adminID`) VALUES
(1, 'CircleK International', 'An RPI Volunteer Organiztaion', 'https://union.rpi.edu/clubs/service/216-circle-k-international', 'lazare2'),
(2, 'RPI Ambulance', 'Provides emergency medical services to the Rensselaer community, and provides educational programs in the field of emergency medicine for members of the organization and the Rensselaer community.', 'https://rpiambulance.com/', 'mahmoy'),
(4, 'Student Senate', 'We worth with students and administrators to improve life around campus!', 'https://sg.rpi.edu/about/senate', 'lettkm');

-- --------------------------------------------------------

--
-- Table structure for table `userevent`
--

CREATE TABLE `userevent` (
  `eventID` int(11) NOT NULL,
  `rcsID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userevent`
--

INSERT INTO `userevent` (`eventID`, `rcsID`) VALUES
(1, 'lazare2');

-- --------------------------------------------------------

--
-- Table structure for table `userorganization`
--

CREATE TABLE `userorganization` (
  `orgID` int(11) NOT NULL,
  `rcsID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userorganization`
--

INSERT INTO `userorganization` (`orgID`, `rcsID`) VALUES
(1, 'lazare2');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `rcsID` varchar(20) NOT NULL,
  `fullName` varchar(100) DEFAULT NULL,
  `about` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`rcsID`, `fullName`, `about`) VALUES
('lazare2', 'Evan Lazaro', 'I enjoy volunteering!'),
('lettkm', 'Meagan Lettko', 'I enjoy student government!'),
('mahmoy', 'Yaseen Mahmoud', 'Horns down brother!'),
('smithj4', 'John Smith', 'Here for the fun!');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orgID` (`orgID`);

--
-- Indexes for table `organizations`
--
ALTER TABLE `organizations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminID` (`adminID`);

--
-- Indexes for table `userevent`
--
ALTER TABLE `userevent`
  ADD PRIMARY KEY (`eventID`,`rcsID`),
  ADD KEY `rcsID` (`rcsID`);

--
-- Indexes for table `userorganization`
--
ALTER TABLE `userorganization`
  ADD PRIMARY KEY (`orgID`,`rcsID`),
  ADD KEY `rcsID` (`rcsID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`rcsID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`orgID`) REFERENCES `organizations` (`id`);

--
-- Constraints for table `organizations`
--
ALTER TABLE `organizations`
  ADD CONSTRAINT `organizations_ibfk_1` FOREIGN KEY (`adminID`) REFERENCES `users` (`rcsID`);

--
-- Constraints for table `userevent`
--
ALTER TABLE `userevent`
  ADD CONSTRAINT `userevent_ibfk_1` FOREIGN KEY (`eventID`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `userevent_ibfk_2` FOREIGN KEY (`rcsID`) REFERENCES `users` (`rcsID`);

--
-- Constraints for table `userorganization`
--
ALTER TABLE `userorganization`
  ADD CONSTRAINT `userorganization_ibfk_1` FOREIGN KEY (`orgID`) REFERENCES `organizations` (`id`),
  ADD CONSTRAINT `userorganization_ibfk_2` FOREIGN KEY (`rcsID`) REFERENCES `users` (`rcsID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
