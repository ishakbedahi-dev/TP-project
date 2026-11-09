-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 09 nov. 2026 à 20:24
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `dss_project`
--

-- --------------------------------------------------------

--
-- Structure de la table `criteria`
--

CREATE TABLE `criteria` (
  `id_criteria` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` enum('Maximize','Minimize') NOT NULL,
  `weight` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `criteria`
--

INSERT INTO `criteria` (`id_criteria`, `name`, `type`, `weight`) VALUES
(1, 'Programming', 'Maximize', 0.20),
(2, 'Mathematics', 'Maximize', 0.15),
(3, 'Alignment with competencies', 'Maximize', 0.20),
(4, 'Career opportunities', 'Maximize', 0.20),
(5, 'Difficulty', 'Minimize', 0.10),
(6, 'Personal interest', 'Maximize', 0.15);

-- --------------------------------------------------------

--
-- Structure de la table `evaluation`
--

CREATE TABLE `evaluation` (
  `id_evaluation` int(11) NOT NULL,
  `id_student` int(11) NOT NULL,
  `id_specialization` int(11) NOT NULL,
  `id_criteria` int(11) NOT NULL,
  `value` int(11) NOT NULL
) ;

--
-- Déchargement des données de la table `evaluation`
--

INSERT INTO `evaluation` (`id_evaluation`, `id_student`, `id_specialization`, `id_criteria`, `value`) VALUES
(1, 1, 1, 1, 9),
(2, 1, 1, 2, 8),
(3, 1, 1, 3, 9),
(4, 1, 1, 4, 10),
(5, 1, 1, 5, 8),
(6, 1, 1, 6, 10),
(7, 1, 2, 1, 8),
(8, 1, 2, 2, 7),
(9, 1, 2, 3, 9),
(10, 1, 2, 4, 8),
(11, 1, 2, 5, 7),
(12, 1, 2, 6, 8),
(13, 1, 3, 1, 8),
(14, 1, 3, 2, 10),
(15, 1, 3, 3, 8),
(16, 1, 3, 4, 9),
(17, 1, 3, 5, 9),
(18, 1, 3, 6, 9),
(19, 1, 4, 1, 7),
(20, 1, 4, 2, 7),
(21, 1, 4, 3, 9),
(22, 1, 4, 4, 8),
(23, 1, 4, 5, 6),
(24, 1, 4, 6, 8),
(25, 2, 1, 1, 8),
(26, 2, 1, 2, 9),
(27, 2, 1, 3, 8),
(28, 2, 1, 4, 9),
(29, 2, 1, 5, 8),
(30, 2, 1, 6, 9),
(31, 2, 2, 1, 9),
(32, 2, 2, 2, 7),
(33, 2, 2, 3, 9),
(34, 2, 2, 4, 9),
(35, 2, 2, 5, 7),
(36, 2, 2, 6, 10),
(37, 2, 3, 1, 8),
(38, 2, 3, 2, 10),
(39, 2, 3, 3, 9),
(40, 2, 3, 4, 9),
(41, 2, 3, 5, 9),
(42, 2, 3, 6, 8),
(43, 2, 4, 1, 9),
(44, 2, 4, 2, 8),
(45, 2, 4, 3, 10),
(46, 2, 4, 4, 8),
(47, 2, 4, 5, 6),
(48, 2, 4, 6, 9);

-- --------------------------------------------------------

--
-- Structure de la table `specialization`
--

CREATE TABLE `specialization` (
  `id_specialization` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `specialization`
--

INSERT INTO `specialization` (`id_specialization`, `name`) VALUES
(1, 'Artificial Intelligence'),
(2, 'Cybersecurity'),
(3, 'Data Science'),
(4, 'Information Systems and Software Engineering');

-- --------------------------------------------------------

--
-- Structure de la table `student`
--

CREATE TABLE `student` (
  `id_student` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `student`
--

INSERT INTO `student` (`id_student`, `name`, `email`) VALUES
(1, 'Ahmed', 'ahmed@gmail.com'),
(2, 'Sara', 'sara@gmail.com');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `criteria`
--
ALTER TABLE `criteria`
  ADD PRIMARY KEY (`id_criteria`);

--
-- Index pour la table `evaluation`
--
ALTER TABLE `evaluation`
  ADD PRIMARY KEY (`id_evaluation`),
  ADD UNIQUE KEY `id_student` (`id_student`,`id_specialization`,`id_criteria`),
  ADD KEY `id_specialization` (`id_specialization`),
  ADD KEY `id_criteria` (`id_criteria`);

--
-- Index pour la table `specialization`
--
ALTER TABLE `specialization`
  ADD PRIMARY KEY (`id_specialization`);

--
-- Index pour la table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id_student`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `criteria`
--
ALTER TABLE `criteria`
  MODIFY `id_criteria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `evaluation`
--
ALTER TABLE `evaluation`
  MODIFY `id_evaluation` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `specialization`
--
ALTER TABLE `specialization`
  MODIFY `id_specialization` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `student`
--
ALTER TABLE `student`
  MODIFY `id_student` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `evaluation`
--
ALTER TABLE `evaluation`
  ADD CONSTRAINT `evaluation_ibfk_1` FOREIGN KEY (`id_student`) REFERENCES `student` (`id_student`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluation_ibfk_2` FOREIGN KEY (`id_specialization`) REFERENCES `specialization` (`id_specialization`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluation_ibfk_3` FOREIGN KEY (`id_criteria`) REFERENCES `criteria` (`id_criteria`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
