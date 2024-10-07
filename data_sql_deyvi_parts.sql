CREATE DATABASE  IF NOT EXISTS `db_deybiparts` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_deybiparts`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: db_deybiparts
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aplicacion`
--

DROP TABLE IF EXISTS `aplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aplicacion` (
  `id_aplicacion` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `id_modelo_auto` int NOT NULL,
  PRIMARY KEY (`id_aplicacion`),
  KEY `modelo_auto_aplicacion_fk` (`id_modelo_auto`),
  KEY `producto_aplicacion_fk` (`id_producto`),
  CONSTRAINT `modelo_auto_aplicacion_fk` FOREIGN KEY (`id_modelo_auto`) REFERENCES `modelo_auto` (`id_modelo_auto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `producto_aplicacion_fk` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aplicacion`
--

LOCK TABLES `aplicacion` WRITE;
/*!40000 ALTER TABLE `aplicacion` DISABLE KEYS */;
INSERT INTO `aplicacion` VALUES (1,1,2),(2,1,1),(3,3,2),(4,2,1);
/*!40000 ALTER TABLE `aplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auto`
--

DROP TABLE IF EXISTS `auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auto` (
  `id_auto` int NOT NULL AUTO_INCREMENT,
  `placa` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serie_vin` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_auto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto`
--

LOCK TABLES `auto` WRITE;
/*!40000 ALTER TABLE `auto` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `campo_medicion` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url_campo_medicion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'ALTENADORES','VOLTAJE - AMPERAJE','https://b2b.refax.pe:9043/MEDIDA/ALTERNADORES.jpg','Prueba2'),(2,'ACEITES','VISCOSIDAD - TIPO DE EMBASE','https://b2b.refax.pe:9043/MEDIDA/ACEITES.jpg','Prueba1');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `id_compra` int NOT NULL AUTO_INCREMENT,
  `numero_factura` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `proveedor` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_inicio_vencimiento` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `img_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_compra`),
  CONSTRAINT `compra_chk_1` CHECK ((`estado` in (1,0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `img_producto`
--

DROP TABLE IF EXISTS `img_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `img_producto` (
  `id_img_producto` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `img_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_img_producto`),
  KEY `producto_img_producto_fk` (`id_producto`),
  CONSTRAINT `producto_img_producto_fk` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `img_producto`
--

LOCK TABLES `img_producto` WRITE;
/*!40000 ALTER TABLE `img_producto` DISABLE KEYS */;
INSERT INTO `img_producto` VALUES (1,1,'https://b2b.refax.pe:9043/MARCASDEVEHICULOS/imagennodisponible.png'),(2,2,'https://b2b.refax.pe:9043/FOTOGRAFIAS/P018821/P018821A.jpg'),(3,2,'https://b2b.refax.pe:9043/FOTOGRAFIAS/P018821/P018821B.jpg');
/*!40000 ALTER TABLE `img_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingreso`
--

DROP TABLE IF EXISTS `ingreso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingreso` (
  `id_ingreso` int NOT NULL AUTO_INCREMENT,
  `cantidad` int NOT NULL,
  `fecha_hora` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_tienda_producto` int NOT NULL,
  PRIMARY KEY (`id_ingreso`),
  KEY `tienda_producto_ingreso_fk` (`id_tienda_producto`),
  CONSTRAINT `tienda_producto_ingreso_fk` FOREIGN KEY (`id_tienda_producto`) REFERENCES `tienda_producto` (`id_tienda_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingreso`
--

LOCK TABLES `ingreso` WRITE;
/*!40000 ALTER TABLE `ingreso` DISABLE KEYS */;
INSERT INTO `ingreso` VALUES (1,3,'2024-01-03T21:10:00',1),(2,2,'2024-02-04T10:15:00',1),(3,0,'2024-01-03T21:10:00',2),(4,5,'2024-02-04T10:15:00',3),(5,7,'2024-03-08T21:10:10',4),(6,5,'2024-03-08T22:15:00',5),(8,5,'2024-02-08T22:15:00',7),(9,1,'2024-01-08T09:45:00',4);
/*!40000 ALTER TABLE `ingreso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marca_auto`
--

DROP TABLE IF EXISTS `marca_auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marca_auto` (
  `id_marca_auto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_marca_auto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marca_auto`
--

LOCK TABLES `marca_auto` WRITE;
/*!40000 ALTER TABLE `marca_auto` DISABLE KEYS */;
INSERT INTO `marca_auto` VALUES (1,'CHANGAN','https://b2b.refax.pe:9043/MARCASDEVEHICULOS/changan.png'),(2,'ASIA','https://b2b.refax.pe:9043/MARCASDEVEHICULOS/asia.png');
/*!40000 ALTER TABLE `marca_auto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modelo_auto`
--

DROP TABLE IF EXISTS `modelo_auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modelo_auto` (
  `id_modelo_auto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `anio_inicio_termino` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `motor` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `img_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_marca_auto` int NOT NULL,
  PRIMARY KEY (`id_modelo_auto`),
  KEY `marca_auto_modelo_auto_fk` (`id_marca_auto`),
  CONSTRAINT `marca_auto_modelo_auto_fk` FOREIGN KEY (`id_marca_auto`) REFERENCES `marca_auto` (`id_marca_auto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelo_auto`
--

LOCK TABLES `modelo_auto` WRITE;
/*!40000 ALTER TABLE `modelo_auto` DISABLE KEYS */;
INSERT INTO `modelo_auto` VALUES (1,'COSMOS AM818 6500 EH700 SOHC','1988 - 1998','Motor de cilindro opuesto','https://b2b.refax.pe:9043/MODELOS/050679.png',1),(2,'COMBI 4100 ZB L6 AM815 SOHC 12 VALV DIESEL','1990 - 1998','Motor tipo W','https://b2b.refax.pe:9043/MODELOS/050678.png',1);
/*!40000 ALTER TABLE `modelo_auto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oferta`
--

DROP TABLE IF EXISTS `oferta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oferta` (
  `id_oferta` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `descripcion` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priorizacion` char(2) COLLATE utf8mb4_unicode_ci DEFAULT 'no',
  `descuento` double NOT NULL,
  PRIMARY KEY (`id_oferta`),
  KEY `producto_oferta_fk` (`id_producto`),
  CONSTRAINT `producto_oferta_fk` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `oferta_chk_1` CHECK ((`priorizacion` in (_utf8mb4'no',_utf8mb4'si')))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oferta`
--

LOCK TABLES `oferta` WRITE;
/*!40000 ALTER TABLE `oferta` DISABLE KEYS */;
INSERT INTO `oferta` VALUES (1,1,'Oferta de Navidad','no',2.99),(2,2,'Oferta de Año Nuevo','si',5.99);
/*!40000 ALTER TABLE `oferta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL,
  `medidas` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int DEFAULT NULL,
  `img_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `codigo_OEM` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_interno` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_fabricante` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `origen` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marca_fabricante` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `multiplos` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `consultas` int DEFAULT '0',
  `medida` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_categoria` int NOT NULL,
  `precio_compra` double NOT NULL,
  `precio_venta` double NOT NULL,
  `precio_minimo` double NOT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `categoria_produco_fk` (`id_categoria`),
  CONSTRAINT `categoria_produco_fk` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'1221m212-a','9961171','43434343k3-21','CHINA','DCROER','00 VOLTS CO AMPERES POLEA OPK','no se que va aqui',8,'155 X 179',1,106.5,116,114.5),(2,'232343-3243232-a','0009553','2132-2121-121-21','MULTI-ORIGEN','STP','LARGO 7E.OOMV1 DIAMETRO 80.00MM HILO 20.COMM W818/8 STP 10588','no se que va aqui',9,'14 X 16',2,106.5,115,113.5),(3,'9382823-3243232-a','0309753','82142-2121-121-21','MULTI-ORIGEN','STP','LARGO 7E.OOMV1 DIAMETRO 80.00MM HILO 20.COMM W818/8 STP 10588','no se que va aqui',3,'15 X 16',2,102.5,117,110),(4,'b943js-asa','0233456','02142-66521-011-54','MULTI-ORIGEN','STP','HILO 20.COMM W818/8 STP 10588','no se que va aqui',0,'18 X 6',1,79.5,100,90);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reduccion_inventario`
--

DROP TABLE IF EXISTS `reduccion_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reduccion_inventario` (
  `id_reduccion_inventario` int NOT NULL AUTO_INCREMENT,
  `codigo_producto` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sede` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int DEFAULT NULL,
  `usuario` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  PRIMARY KEY (`id_reduccion_inventario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reduccion_inventario`
--

LOCK TABLES `reduccion_inventario` WRITE;
/*!40000 ALTER TABLE `reduccion_inventario` DISABLE KEYS */;
/*!40000 ALTER TABLE `reduccion_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reemplazo`
--

DROP TABLE IF EXISTS `reemplazo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reemplazo` (
  `id_reemplazo` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `producto_reemplazo` int NOT NULL,
  `variacion` double NOT NULL,
  `notas` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_reemplazo`),
  KEY `producto_reemplazo_fk` (`id_producto`),
  KEY `producto_reemplazo_fk1` (`producto_reemplazo`),
  CONSTRAINT `producto_reemplazo_fk` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `producto_reemplazo_fk1` FOREIGN KEY (`producto_reemplazo`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reemplazo`
--

LOCK TABLES `reemplazo` WRITE;
/*!40000 ALTER TABLE `reemplazo` DISABLE KEYS */;
INSERT INTO `reemplazo` VALUES (1,2,1,0.7,'esta variación no esta supervisada'),(2,1,2,0.8,'esta variación esta supervisada por tal');
/*!40000 ALTER TABLE `reemplazo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tienda`
--

DROP TABLE IF EXISTS `tienda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tienda` (
  `id_tienda` int NOT NULL AUTO_INCREMENT,
  `ruc` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon_social` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encargado` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `celular` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_tienda`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tienda`
--

LOCK TABLES `tienda` WRITE;
/*!40000 ALTER TABLE `tienda` DISABLE KEYS */;
INSERT INTO `tienda` VALUES (1,'20600434668','deybi parts sac 1','Jr. Ayacucho N° 5654','Ronald Calla','966554331'),(2,'20600434668','deybi parts sac','Jr. La mar n° 456','Janeth R.','966554332');
/*!40000 ALTER TABLE `tienda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tienda_producto`
--

DROP TABLE IF EXISTS `tienda_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tienda_producto` (
  `id_tienda_producto` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `id_tienda` int NOT NULL,
  `stock` int DEFAULT '0',
  PRIMARY KEY (`id_tienda_producto`),
  KEY `producto_tienda_producto_fk` (`id_producto`),
  KEY `tienda_tienda_producto_fk` (`id_tienda`),
  CONSTRAINT `producto_tienda_producto_fk` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tienda_tienda_producto_fk` FOREIGN KEY (`id_tienda`) REFERENCES `tienda` (`id_tienda`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tienda_producto`
--

LOCK TABLES `tienda_producto` WRITE;
/*!40000 ALTER TABLE `tienda_producto` DISABLE KEYS */;
INSERT INTO `tienda_producto` VALUES (1,2,1,30),(2,1,1,20),(3,1,2,15),(4,3,2,30),(5,4,2,40),(7,4,1,25);
/*!40000 ALTER TABLE `tienda_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tienda_usuario`
--

DROP TABLE IF EXISTS `tienda_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tienda_usuario` (
  `id_tienda_usuario` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_tienda` int NOT NULL,
  PRIMARY KEY (`id_tienda_usuario`),
  KEY `usuario_tienda_usuario_fk` (`id_usuario`),
  KEY `tienda_tienda_usuario_fk` (`id_tienda`),
  CONSTRAINT `tienda_tienda_usuario_fk` FOREIGN KEY (`id_tienda`) REFERENCES `tienda` (`id_tienda`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuario_tienda_usuario_fk` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tienda_usuario`
--

LOCK TABLES `tienda_usuario` WRITE;
/*!40000 ALTER TABLE `tienda_usuario` DISABLE KEYS */;
INSERT INTO `tienda_usuario` VALUES (1,2,2),(2,1,1);
/*!40000 ALTER TABLE `tienda_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traspaso`
--

DROP TABLE IF EXISTS `traspaso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traspaso` (
  `id_traspaso` int NOT NULL AUTO_INCREMENT,
  `codigo_producto` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int DEFAULT NULL,
  `usuario` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_hora` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tienda_origen` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tienda_destino` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_traspaso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traspaso`
--

LOCK TABLES `traspaso` WRITE;
/*!40000 ALTER TABLE `traspaso` DISABLE KEYS */;
/*!40000 ALTER TABLE `traspaso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `username` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `usuario_chk_1` CHECK ((`rol` in (_utf8mb4'administrador',_utf8mb4'trabajador',_utf8mb4'admin')))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'trabajador1','$2b$10$O9gCeNPcJ0aKfBy8i0eaJuLW01pA8tku9NHJ/wRma7lT4oOE0Ja/.','trabajador'),(2,'adminDM','$2b$10$Nk4C73OwGZY5IvKe4YLq2.Of9j1GeiVVROYlOephTsGaavugj2FCO','administrador');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-08 19:32:18
