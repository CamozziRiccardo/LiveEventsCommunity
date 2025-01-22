-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Gen 22, 2025 alle 23:48
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wce`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `wce_categoria`
--

CREATE TABLE `wce_categoria` (
  `ID_categoria` int(11) NOT NULL,
  `nome_cat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `wce_categoria`
--

INSERT INTO `wce_categoria` (`ID_categoria`, `nome_cat`) VALUES
(3, 'culturale'),
(4, 'artistico'),
(5, 'sportivo'),
(6, 'religioso');

-- --------------------------------------------------------

--
-- Struttura della tabella `wce_commento`
--

CREATE TABLE `wce_commento` (
  `ID_comm` int(11) NOT NULL,
  `ID_user` int(11) NOT NULL,
  `ID_evento` int(11) NOT NULL,
  `testo` varchar(50) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `wce_eventi`
--

CREATE TABLE `wce_eventi` (
  `ID_evento` int(11) NOT NULL,
  `ID_categoria` int(11) NOT NULL,
  `ID_luogo` int(11) NOT NULL,
  `ID_user` int(11) NOT NULL,
  `titolo` varchar(50) NOT NULL,
  `data` date NOT NULL,
  `indirizzo` varchar(50) NOT NULL,
  `descrizione` text NOT NULL,
  `approvazione` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `wce_interessi`
--

CREATE TABLE `wce_interessi` (
  `ID_user` int(11) NOT NULL,
  `ID_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `wce_luogo`
--

CREATE TABLE `wce_luogo` (
  `ID_luogo` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `sigla` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `wce_luogo`
--

INSERT INTO `wce_luogo` (`ID_luogo`, `nome`, `sigla`) VALUES
(111, 'Agrigento', 'AG'),
(112, 'Alessandria', 'AL'),
(113, 'Ancona', 'AN'),
(114, 'Aosta', 'AO'),
(115, 'Arezzo', 'AR'),
(116, 'Ascoli Piceno', 'AP'),
(117, 'Asti', 'AT'),
(118, 'Avellino', 'AV'),
(119, 'Bari', 'BA'),
(120, 'Barletta-Andria-Trani', 'BT'),
(121, 'Belluno', 'BL'),
(122, 'Benevento', 'BN'),
(123, 'Bergamo', 'BG'),
(124, 'Biella', 'BI'),
(125, 'Bologna', 'BO'),
(126, 'Bolzano', 'BZ'),
(127, 'Brescia', 'BS'),
(128, 'Brindisi', 'BR'),
(129, 'Cagliari', 'CA'),
(130, 'Caltanissetta', 'CL'),
(131, 'Campobasso', 'CB'),
(132, 'Carbonia-Iglesias', 'CI'),
(133, 'Caserta', 'CE'),
(134, 'Catania', 'CT'),
(135, 'Catanzaro', 'CZ'),
(136, 'Chieti', 'CH'),
(137, 'Como', 'CO'),
(138, 'Cosenza', 'CS'),
(139, 'Cremona', 'CR'),
(140, 'Crotone', 'KR'),
(141, 'Cuneo', 'CN'),
(142, 'Enna', 'EN'),
(143, 'Fermo', 'FM'),
(144, 'Ferrara', 'FE'),
(145, 'Firenze', 'FI'),
(146, 'Foggia', 'FG'),
(147, 'Forlì-Cesena', 'FC'),
(148, 'Frosinone', 'FR'),
(149, 'Genova', 'GE'),
(150, 'Gorizia', 'GO'),
(151, 'Grosseto', 'GR'),
(152, 'Imperia', 'IM'),
(153, 'Isernia', 'IS'),
(154, 'L\'Aquila', 'AQ'),
(155, 'Latina', 'LT'),
(156, 'Lecce', 'LE'),
(157, 'Lecco', 'LC'),
(158, 'Livorno', 'LI'),
(159, 'Lodi', 'LO'),
(160, 'Lucca', 'LU'),
(161, 'Macerata', 'MC'),
(162, 'Mantova', 'MN'),
(163, 'Massa-Carrara', 'MS'),
(164, 'Matera', 'MT'),
(165, 'Messina', 'ME'),
(166, 'Milano', 'MI'),
(167, 'Modena', 'MO'),
(168, 'Monza e della Brianza', 'MB'),
(169, 'Napoli', 'NA'),
(170, 'Novara', 'NO'),
(171, 'Nuoro', 'NU'),
(172, 'Oristano', 'OR'),
(173, 'Padova', 'PD'),
(174, 'Palermo', 'PA'),
(175, 'Parma', 'PR'),
(176, 'Pavia', 'PV'),
(177, 'Perugia', 'PG'),
(178, 'Pesaro e Urbino', 'PU'),
(179, 'Pescara', 'PE'),
(180, 'Piacenza', 'PC'),
(181, 'Pisa', 'PI'),
(182, 'Pistoia', 'PT'),
(183, 'Pordenone', 'PN'),
(184, 'Potenza', 'PZ'),
(185, 'Prato', 'PO'),
(186, 'Ragusa', 'RG'),
(187, 'Ravenna', 'RA'),
(188, 'Reggio Calabria', 'RC'),
(189, 'Reggio Emilia', 'RE'),
(190, 'Rieti', 'RI'),
(191, 'Rimini', 'RN'),
(192, 'Roma', 'RM'),
(193, 'Rovigo', 'RO'),
(194, 'Salerno', 'SA'),
(195, 'Sassari', 'SS'),
(196, 'Savona', 'SV'),
(197, 'Siena', 'SI'),
(198, 'Siracusa', 'SR'),
(199, 'Sondrio', 'SO'),
(200, 'Sud Sardegna', 'SU'),
(201, 'Taranto', 'TA'),
(202, 'Teramo', 'TE'),
(203, 'Terni', 'TR'),
(204, 'Torino', 'TO'),
(205, 'Trapani', 'TP'),
(206, 'Trento', 'TN'),
(207, 'Treviso', 'TV'),
(208, 'Trieste', 'TS'),
(209, 'Udine', 'UD'),
(210, 'Varese', 'VA'),
(211, 'Venezia', 'VE'),
(212, 'Verbano-Cusio-Ossola', 'VB'),
(213, 'Vercelli', 'VC'),
(214, 'Verona', 'VR'),
(215, 'Vibo Valentia', 'VV'),
(216, 'Vicenza', 'VI'),
(217, 'Viterbo', 'VT');

-- --------------------------------------------------------

--
-- Struttura della tabella `wce_partecipazione`
--

CREATE TABLE `wce_partecipazione` (
  `ID_utente` int(11) NOT NULL,
  `ID_evento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `wce_utenti`
--

CREATE TABLE `wce_utenti` (
  `ID_user` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `email` varchar(1000) NOT NULL,
  `password` varchar(1000) NOT NULL,
  `residenza` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `wce_categoria`
--
ALTER TABLE `wce_categoria`
  ADD PRIMARY KEY (`ID_categoria`);

--
-- Indici per le tabelle `wce_commento`
--
ALTER TABLE `wce_commento`
  ADD PRIMARY KEY (`ID_comm`),
  ADD KEY `ibfk_comm` (`ID_evento`),
  ADD KEY `ibfk_commentor` (`ID_user`);

--
-- Indici per le tabelle `wce_eventi`
--
ALTER TABLE `wce_eventi`
  ADD PRIMARY KEY (`ID_evento`),
  ADD KEY `ibfk_luogo` (`ID_luogo`),
  ADD KEY `ibfk_cat` (`ID_categoria`),
  ADD KEY `ibfk_creator` (`ID_user`);

--
-- Indici per le tabelle `wce_interessi`
--
ALTER TABLE `wce_interessi`
  ADD PRIMARY KEY (`ID_user`,`ID_categoria`),
  ADD KEY `ibfk_cat2` (`ID_categoria`);

--
-- Indici per le tabelle `wce_luogo`
--
ALTER TABLE `wce_luogo`
  ADD PRIMARY KEY (`ID_luogo`);

--
-- Indici per le tabelle `wce_partecipazione`
--
ALTER TABLE `wce_partecipazione`
  ADD PRIMARY KEY (`ID_utente`,`ID_evento`),
  ADD KEY `ibfk_evento2` (`ID_evento`);

--
-- Indici per le tabelle `wce_utenti`
--
ALTER TABLE `wce_utenti`
  ADD PRIMARY KEY (`ID_user`),
  ADD UNIQUE KEY `email` (`email`) USING HASH,
  ADD KEY `residenza` (`residenza`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `wce_categoria`
--
ALTER TABLE `wce_categoria`
  MODIFY `ID_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `wce_commento`
--
ALTER TABLE `wce_commento`
  MODIFY `ID_comm` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `wce_eventi`
--
ALTER TABLE `wce_eventi`
  MODIFY `ID_evento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `wce_luogo`
--
ALTER TABLE `wce_luogo`
  MODIFY `ID_luogo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=218;

--
-- AUTO_INCREMENT per la tabella `wce_utenti`
--
ALTER TABLE `wce_utenti`
  MODIFY `ID_user` int(11) NOT NULL AUTO_INCREMENT;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `wce_commento`
--
ALTER TABLE `wce_commento`
  ADD CONSTRAINT `ibfk_comm` FOREIGN KEY (`ID_evento`) REFERENCES `wce_eventi` (`ID_evento`),
  ADD CONSTRAINT `ibfk_commentor` FOREIGN KEY (`ID_user`) REFERENCES `wce_utenti` (`ID_user`);

--
-- Limiti per la tabella `wce_eventi`
--
ALTER TABLE `wce_eventi`
  ADD CONSTRAINT `ibfk_cat` FOREIGN KEY (`ID_categoria`) REFERENCES `wce_categoria` (`ID_categoria`),
  ADD CONSTRAINT `ibfk_creator` FOREIGN KEY (`ID_user`) REFERENCES `wce_utenti` (`ID_user`),
  ADD CONSTRAINT `ibfk_luogo` FOREIGN KEY (`ID_luogo`) REFERENCES `wce_luogo` (`ID_luogo`);

--
-- Limiti per la tabella `wce_interessi`
--
ALTER TABLE `wce_interessi`
  ADD CONSTRAINT `ibfk_cat2` FOREIGN KEY (`ID_categoria`) REFERENCES `wce_categoria` (`ID_categoria`),
  ADD CONSTRAINT `ibfk_utente3` FOREIGN KEY (`ID_user`) REFERENCES `wce_utenti` (`ID_user`);

--
-- Limiti per la tabella `wce_partecipazione`
--
ALTER TABLE `wce_partecipazione`
  ADD CONSTRAINT `ibfk_evento2` FOREIGN KEY (`ID_evento`) REFERENCES `wce_eventi` (`ID_evento`),
  ADD CONSTRAINT `ibfk_utente` FOREIGN KEY (`ID_utente`) REFERENCES `wce_utenti` (`ID_user`);

--
-- Limiti per la tabella `wce_utenti`
--
ALTER TABLE `wce_utenti`
  ADD CONSTRAINT `wce_utenti_ibfk_1` FOREIGN KEY (`residenza`) REFERENCES `wce_luogo` (`ID_luogo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
