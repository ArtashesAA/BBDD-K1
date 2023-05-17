-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: k1
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `peso_minimo` int NOT NULL,
  `peso_maximo` int NOT NULL,
  `modalidad` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `combate`
--

DROP TABLE IF EXISTS `combate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `combate` (
  `id` varchar(50) NOT NULL,
  `fecha` date DEFAULT NULL,
  `id_peleador1` int NOT NULL,
  `id_peleador2` int NOT NULL,
  `id_ganador` int NOT NULL,
  `id_promotor` int NOT NULL,
  `id_categoria` int NOT NULL,
  `id_puntuacion` int DEFAULT NULL,
  `nombre_competicion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_peleador1` (`id_peleador1`),
  KEY `id_peleador2` (`id_peleador2`),
  KEY `id_ganador` (`id_ganador`),
  KEY `id_promotor` (`id_promotor`),
  KEY `id_categoria` (`id_categoria`),
  KEY `combate_FK` (`id_puntuacion`),
  KEY `nombre_competicion` (`nombre_competicion`),
  CONSTRAINT `combate_FK` FOREIGN KEY (`id_puntuacion`) REFERENCES `puntuacion_jueces` (`id_puntuacion`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `combate_ibfk_1` FOREIGN KEY (`id_peleador1`) REFERENCES `peleador` (`id`),
  CONSTRAINT `combate_ibfk_2` FOREIGN KEY (`id_peleador2`) REFERENCES `peleador` (`id`),
  CONSTRAINT `combate_ibfk_3` FOREIGN KEY (`id_ganador`) REFERENCES `peleador` (`id`),
  CONSTRAINT `combate_ibfk_4` FOREIGN KEY (`id_promotor`) REFERENCES `promotor` (`id`),
  CONSTRAINT `combate_ibfk_5` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`),
  CONSTRAINT `combate_ibfk_6` FOREIGN KEY (`nombre_competicion`) REFERENCES `competicion` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `competicion`
--

DROP TABLE IF EXISTS `competicion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competicion` (
  `nombre` varchar(50) NOT NULL,
  `lugar` varchar(50) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `id` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `dirección` varchar(100) NOT NULL,
  `gimansio` varchar(50) NOT NULL,
  `entrenador` varchar(50) NOT NULL,
  `pais` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `juez`
--

DROP TABLE IF EXISTS `juez`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `juez` (
  `id` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `modalidad` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `peleador`
--

DROP TABLE IF EXISTS `peleador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peleador` (
  `id` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `edad` int NOT NULL,
  `apellidos` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `victorias` int NOT NULL,
  `derrotas` int NOT NULL,
  `empates` int NOT NULL,
  `id_equipo` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_equipo` (`id_equipo`),
  CONSTRAINT `peleador_ibfk_1` FOREIGN KEY (`id_equipo`) REFERENCES `equipo` (`id`),
  CONSTRAINT `peleador_chk_1` CHECK ((`victorias` >= 0)),
  CONSTRAINT `peleador_chk_2` CHECK ((`derrotas` >= 0)),
  CONSTRAINT `peleador_chk_3` CHECK ((`empates` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `promotor`
--

DROP TABLE IF EXISTS `promotor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotor` (
  `id` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `pais` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `puntuacion_jueces`
--

DROP TABLE IF EXISTS `puntuacion_jueces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `puntuacion_jueces` (
  `id_puntuacion` int NOT NULL,
  `puntuacion_total` int NOT NULL,
  `id_juez1` int NOT NULL,
  `id_juez2` int NOT NULL,
  `id_juez3` int NOT NULL,
  PRIMARY KEY (`id_puntuacion`),
  KEY `id_juez1` (`id_juez1`),
  KEY `id_juez2` (`id_juez2`),
  KEY `id_juez3` (`id_juez3`),
  CONSTRAINT `puntuacion_jueces_ibfk_2` FOREIGN KEY (`id_juez1`) REFERENCES `juez` (`id`),
  CONSTRAINT `puntuacion_jueces_ibfk_3` FOREIGN KEY (`id_juez2`) REFERENCES `juez` (`id`),
  CONSTRAINT `puntuacion_jueces_ibfk_4` FOREIGN KEY (`id_juez3`) REFERENCES `juez` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
