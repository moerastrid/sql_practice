-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Sep 10, 2024 at 08:21 AM
-- Server version: 8.0.39
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `testdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `plants`
--

CREATE TABLE `plants` (
  `id` int NOT NULL,
  `name` varchar(32) NOT NULL,
  `color` enum('red','yellow','green','dark_green','purple','light_green') DEFAULT NULL,
  `has_flowers?` tinyint(1) NOT NULL,
  `nickname` varchar(32) DEFAULT NULL,
  `room` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `plants`
--

INSERT INTO `plants` (`id`, `name`, `color`, `has_flowers?`, `nickname`, `room`) VALUES
(1, 'fiddle_leaf_fig_tree', 'dark_green', 0, 'Emanuelle', 1),
(2, 'begonia', 'dark_green', 1, 'Balthazar', 4),
(3, 'pannenkoekplant', 'green', 1, NULL, 4),
(4, 'apple_tree', NULL, 1, NULL, 5);

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int NOT NULL,
  `name` varchar(32) NOT NULL
) ;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `name`) VALUES
(1, 'woonkamer'),
(2, 'slaapkamer'),
(3, 'keuken'),
(4, 'wc'),
(5, 'balkon');

-- --------------------------------------------------------

--
-- Stand-in structure for view `room_with_plant_count`
-- (See below for the actual view)
--
CREATE TABLE `room_with_plant_count` (
`id` int
,`name` varchar(32)
,`plant_count` bigint
);

-- --------------------------------------------------------

--
-- Structure for view `room_with_plant_count`
--
DROP TABLE IF EXISTS `room_with_plant_count`;

CREATE ALGORITHM=UNDEFINED DEFINER=`user`@`%` SQL SECURITY DEFINER VIEW `room_with_plant_count`  AS SELECT `rooms`.`id` AS `id`, `rooms`.`name` AS `name`, count(`plants`.`id`) AS `plant_count` FROM (`rooms` left join `plants` on((`plants`.`room` = `rooms`.`id`))) GROUP BY `rooms`.`id` HAVING (`plant_count` > 0) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `plants`
--
ALTER TABLE `plants`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fk_room` (`room`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `plants`
--
ALTER TABLE `plants`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `plants`
--
ALTER TABLE `plants`
  ADD CONSTRAINT `fk_room` FOREIGN KEY (`room`) REFERENCES `rooms` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
