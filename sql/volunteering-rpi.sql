-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 03, 2019 at 07:21 PM
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
(1, 'CircleK Annual Food drive', 1, 'Come help us bring food to a food kitchen!', 'Troy, New York', 30, 2, '2019-11-25 10:22:00'),
(2, 'RPI Ambulance Info Session', 2, 'Come learn more about joining RPI Ambulance!', 'RPI Union 15th Street Lobby', 50, 3, NULL);
(3, 'Biomedical Engineering Seminar', 3, 'Interstitial fluid flow in the brain: contributions to disease', 'Jonsson Engineering Center 3117 JEC', 50, 3, '2019-05-19 1:30:00');
(4, 'Calling All Crafters, Bakers, and Artists!', 4, 'The United Way is once again holding the Community Fair and Bake Sale in conjunction with Procurement’s Supplier Showcase!', 'Armory', 50, 3, '2019-05-19 11:00:00');
(5, 'Feature Webinar Invitation: Data Analytics, Machine Learning & AI', 5, 'Dean Aric Krause will be hosting a feature webinar to review Rensselaers digitally delivered, project-based graduate certificate programs in Business Intelligence and Machine Learning & AI.', 'Online', 50, .5, '2019-06-19 12:00:00');
(6, 'Troy Compost seeks Volunteers', 6, 'Troy Compost has been organizing a number of big composting initiatives in Troy, such as the Farmers Market foodscraps collection, a project that diverts food waste from landfills to get composted at local farms instead.', 'Campus-wide', 50, 4, '2019-25-19 8:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `id` int(11) NOT NULL,
  `orgName` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `adminID` varchar(20) DEFAULT NULL,
  `imageURL` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organizations`
--

INSERT INTO `organizations` (`id`, `orgName`, `description`, `website`, `adminID`, `imageURL`) VALUES
(1, 'CircleK International', 'An RPI Volunteer Organization', 'https://union.rpi.edu/clubs/service/216-circle-k-international', 'lazare2', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSb2-47ZX0RPgqaC6Dx_ubR8YRqdiuUw-kiZW7_lIVV6h-B-511&s'),
(2, 'RPI Ambulance', 'Provides emergency medical services to the Rensselaer community, and provides educational programs in the field of emergency medicine for members of the organization and the Rensselaer community.', 'https://rpiambulance.com/', 'mahmoy', 'https://media.licdn.com/dms/image/C4E0BAQF_dQeXKIuvIQ/company-logo_200_200/0?e=2159024400&v=beta&t=WAhQUY_rwjl1HOxVcLxypR-Ixx0LBFKiJV0Ei5T1tYU'),
(4, 'Student Senate', 'We work with students and administrators to improve life around campus!', 'https://sg.rpi.edu/about/senate', 'lettkm', NULL);
(5, 'Web Seminars', 'We work to host webinars!', 'https://sg.rpi.edu/about/senate', '', NULL);
(6, 'Troy Compost', 'Troy Compost has been organizing a number of big composting initiatives in Troy!', 'http://troycompost.wikispaces.com/Troy+Compost', 'schafe', NULL);

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
(1, 'lazare2'),
(2, 'lettkm');
(3, 'mahmoy');
(4, 'smithj4');
(5, 'suraps3');
(6, 'liangs5');
(7, 'vanzys');


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
  `about` varchar(500) DEFAULT NULL,
  `hours` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`rcsID`, `fullName`, `about`, `hours`) VALUES
('lazare2', 'Evan Lazaro', 'I enjoy volunteering!', 10),
('lettkm', 'Meagan Lettko', 'I enjoy student government!', 5),
('mahmoy', 'Yaseen Mahmoud', 'Horns down brother!', 0),
('smithj4', 'John Smith', 'Here for the fun!', 200);
('suraps3', 'Sanjana Surapaneni', 'Live Love Laugh!', 20);
('liangs5', 'SJ Liang', 'Love to cook!', 2000);
('vanzys', 'Steven vanZyl', 'Love php!', 300);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
