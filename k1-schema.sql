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
-- Table structure for table `ciudad`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciudad` (
  `codigo` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `pais` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `combate`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `combate` (
  `codigo` int NOT NULL,
  `golpes` int DEFAULT NULL,
  `protecciones` varchar(45) DEFAULT NULL,
  `ganador` varchar(45) DEFAULT NULL,
  `modalidad` varchar(45) DEFAULT NULL,
  `peleador_dni` varchar(20) NOT NULL,
  `competicion_codigo` int NOT NULL,
  `juez1_dni` varchar(40) NOT NULL,
  `juez2_dni` varchar(40) NOT NULL,
  `juez3_dni` varchar(40) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_combate_peleador1_idx` (`peleador_dni`),
  KEY `fk_combate_competicion1_idx` (`competicion_codigo`),
  KEY `fk_combate_juez11_idx` (`juez1_dni`),
  KEY `fk_combate_juez21_idx` (`juez2_dni`),
  KEY `fk_combate_juez31_idx` (`juez3_dni`),
  CONSTRAINT `fk_combate_competicion1` FOREIGN KEY (`competicion_codigo`) REFERENCES `competicion` (`codigo`),
  CONSTRAINT `fk_combate_juez11` FOREIGN KEY (`juez1_dni`) REFERENCES `juez1` (`dni`),
  CONSTRAINT `fk_combate_juez21` FOREIGN KEY (`juez2_dni`) REFERENCES `juez2` (`dni`),
  CONSTRAINT `fk_combate_juez31` FOREIGN KEY (`juez3_dni`) REFERENCES `juez3` (`dni`),
  CONSTRAINT `fk_combate_peleador1` FOREIGN KEY (`peleador_dni`) REFERENCES `peleador` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `competicion`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competicion` (
  `codigo` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `ciudad_codigo` int NOT NULL,
  `gimnasio_codigo` int NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_competicion_ciudad1_idx` (`ciudad_codigo`),
  KEY `fk_competicion_gimnasio1_idx` (`gimnasio_codigo`),
  CONSTRAINT `fk_competicion_ciudad1` FOREIGN KEY (`ciudad_codigo`) REFERENCES `ciudad` (`codigo`),
  CONSTRAINT `fk_competicion_gimnasio1` FOREIGN KEY (`gimnasio_codigo`) REFERENCES `gimnasio` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrenador`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrenador` (
  `dni` varchar(20) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  `gimnasio` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gimnasio`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gimnasio` (
  `codigo` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `dueño` varchar(45) DEFAULT NULL,
  `aforo` int DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `juez1`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `juez1` (
  `dni` varchar(40) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  `modalidad` varchar(45) DEFAULT NULL,
  `num_combates_juez` int DEFAULT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `juez2`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `juez2` (
  `dni` varchar(40) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  `modalidad` varchar(45) DEFAULT NULL,
  `num_combates_juez` int DEFAULT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `juez3`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `juez3` (
  `dni` varchar(40) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  `modalidad` varchar(45) DEFAULT NULL,
  `num_combates_juez` int DEFAULT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `peleador`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peleador` (
  `dni` varchar(20) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  `victorias` int DEFAULT NULL,
  `derrotas` int DEFAULT NULL,
  `empates` int DEFAULT NULL,
  `local` varchar(45) DEFAULT NULL,
  `visitante` varchar(45) DEFAULT NULL,
  `entrenador_dni` varchar(20) NOT NULL,
  `gimnasio_codigo` int NOT NULL,
  PRIMARY KEY (`dni`),
  KEY `fk_peleador_entrenador1_idx` (`entrenador_dni`),
  KEY `fk_peleador_gimnasio1_idx` (`gimnasio_codigo`),
  CONSTRAINT `fk_peleador_entrenador1` FOREIGN KEY (`entrenador_dni`) REFERENCES `entrenador` (`dni`),
  CONSTRAINT `fk_peleador_gimnasio1` FOREIGN KEY (`gimnasio_codigo`) REFERENCES `gimnasio` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
