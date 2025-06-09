-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 28, 2025 at 05:59 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `kinneret_yoman`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
                           `id` int(11) NOT NULL,
                           `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `name`) VALUES
                                         (1, 'oop'),
                                         (2, 'JS'),
                                         (4, 'to deLete'),
                                         (5, 'rrrrr'),
                                         (6, '<script>alert(\'amir\')</script>');

-- --------------------------------------------------------

--
-- Table structure for table `crs2user`
--

CREATE TABLE `crs2user` (
                            `id` int(11) NOT NULL,
                            `crs_id` int(11) NOT NULL,
                            `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `students_to_teachers`
--

CREATE TABLE `students_to_teachers` (
                                        `student_id` int(11) NOT NULL,
                                        `teacher_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `study_data`
--

CREATE TABLE `study_data` (
                              `id` int(11) NOT NULL,
                              `user_id` int(11) NOT NULL,
                              `study_date` date NOT NULL,
                              `course` int(11) NOT NULL,
                              `start_time` time NOT NULL,
                              `end_time` time NOT NULL,
                              `is_plan` int(11) NOT NULL,
                              `notes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
                         `id` int(11) NOT NULL,
                         `name` varchar(100) NOT NULL,
                         `uname` varchar(100) NOT NULL,
                         `passwd` varchar(100) NOT NULL,
                         `email` varchar(100) NOT NULL,
                         `type_id` int(11) NOT NULL,
                         `tz` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `uname`, `passwd`, `email`, `type_id`, `tz`) VALUES
                                                                                    (5, 'aa', 'aa', 'aa', 'aa', 1, '22'),
                                                                                    (6, 'amir', 'amir', 'c3c2bd601f0ec6a02ed4a4e55cc15b0b', 'a@a.a', 1, '77'),
                                                                                    (7, 'www', '', '', '', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `user_types`
--

CREATE TABLE `user_types` (
                              `id` int(11) NOT NULL,
                              `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_types`
--

INSERT INTO `user_types` (`id`, `name`) VALUES
                                            (1, 'מנהל'),
                                            (2, 'מרצה'),
                                            (3, 'תלמיד');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `crs2user`
--
ALTER TABLE `crs2user`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students_to_teachers`
--
ALTER TABLE `students_to_teachers`
    ADD PRIMARY KEY (`student_id`,`teacher_id`),
  ADD KEY `students_to_teachers_fk1` (`teacher_id`);

--
-- Indexes for table `study_data`
--
ALTER TABLE `study_data`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `study_data_fk1` (`user_id`),
  ADD KEY `study_data_fk3` (`course`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `user_types`
--
ALTER TABLE `user_types`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `crs2user`
--
ALTER TABLE `crs2user`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `study_data`
--
ALTER TABLE `study_data`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_types`
--
ALTER TABLE `user_types`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `students_to_teachers`
--
ALTER TABLE `students_to_teachers`
    ADD CONSTRAINT `students_to_teachers_fk0` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `students_to_teachers_fk1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `study_data`
--
ALTER TABLE `study_data`
    ADD CONSTRAINT `study_data_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `study_data_fk3` FOREIGN KEY (`course`) REFERENCES `courses` (`id`);
