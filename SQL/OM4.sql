CREATE DATABASE  IF NOT EXISTS `om` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `om`;
-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: localhost    Database: om
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `arma`
--

DROP TABLE IF EXISTS `arma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arma` (
  `id_arma` int NOT NULL,
  `arma_nome` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `arma_sigla` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_arma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arma`
--

LOCK TABLES `arma` WRITE;
/*!40000 ALTER TABLE `arma` DISABLE KEYS */;
INSERT INTO `arma` VALUES (1,'Cavalaria','Cav'),(2,'Infantaria','Inf'),(3,'Artilharia','Art'),(4,'Engenharia','Eng'),(5,'Comunicações','Com');
/*!40000 ALTER TABLE `arma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cautelas`
--

DROP TABLE IF EXISTS `cautelas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cautelas` (
  `id_cautela` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_id_mat_carga` int NOT NULL,
  `qtde_cautela` int NOT NULL,
  `id_operacao` enum('r','d') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fk_id_militar` int NOT NULL,
  `data_operacao` date DEFAULT NULL,
  `fk_id_responsavel` int NOT NULL,
  PRIMARY KEY (`id_cautela`),
  KEY `fkid_militar` (`fk_id_militar`),
  KEY `fkid_mat_carga` (`fk_id_mat_carga`),
  CONSTRAINT `fkid_mat_carga` FOREIGN KEY (`fk_id_mat_carga`) REFERENCES `material_carga` (`id_mat_carga`),
  CONSTRAINT `fkid_militar` FOREIGN KEY (`fk_id_militar`) REFERENCES `militar` (`id_militar`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cautelas`
--

LOCK TABLES `cautelas` WRITE;
/*!40000 ALTER TABLE `cautelas` DISABLE KEYS */;
INSERT INTO `cautelas` VALUES (1,12,2,'r',5,'2024-02-12',1),(2,4,8,'r',11,'2024-02-12',1),(3,11,2,'r',5,'2024-02-12',1),(6,12,1,'d',5,'2024-02-12',1);
/*!40000 ALTER TABLE `cautelas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `material_ret_dev` AFTER INSERT ON `cautelas` FOR EACH ROW BEGIN
	DECLARE total_mat_disponivel INT;
    DECLARE emcautela INT;
    DECLARE totMatDisponivel INT;
    SET emcautela = (select em_cautela from situacao_material_carga where fk_id_mat_carga = new.fk_id_mat_carga);
    SET totMatDisponivel = (SELECT total_disponivel FROM situacao_material_carga where fk_id_mat_carga = new.fk_id_mat_carga);
	
    IF NEW.id_operacao = 'r' THEN
		IF NEW.qtde_cautela > totMatDisponivel THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Erro: Quantidade de material a ser retirada excede a quantidade disponível';
        END IF;
		
			UPDATE situacao_material_carga SET total_disponivel = (total_disponivel - new.qtde_cautela)
			WHERE situacao_material_carga.fk_id_mat_carga = new.fk_id_mat_carga ;
			UPDATE situacao_material_carga SET em_cautela = (em_cautela + new.qtde_cautela)
			WHERE situacao_material_carga.fk_id_mat_carga = new.fk_id_mat_carga ;
		
    END IF;
    
    IF NEW.id_operacao = 'd' THEN
		
		IF NEW.qtde_cautela > emcautela THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Erro: Quantidade de material a ser devolvida excede a quantidade em cautela';
        END IF;
        
		UPDATE situacao_material_carga SET total_disponivel = (total_disponivel + new.qtde_cautela)
        WHERE situacao_material_carga.fk_id_mat_carga = new.fk_id_mat_carga ;
        UPDATE situacao_material_carga SET em_cautela = (em_cautela - new.qtde_cautela)
        WHERE situacao_material_carga.fk_id_mat_carga = new.fk_id_mat_carga ;
        
	END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `cautelas_por_material`
--

DROP TABLE IF EXISTS `cautelas_por_material`;
/*!50001 DROP VIEW IF EXISTS `cautelas_por_material`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `cautelas_por_material` AS SELECT 
 1 AS `nome_mat`,
 1 AS `qtde_cautela`,
 1 AS `nome_completo`,
 1 AS `RET/DEV`,
 1 AS `Data`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `cautelas_por_militar`
--

DROP TABLE IF EXISTS `cautelas_por_militar`;
/*!50001 DROP VIEW IF EXISTS `cautelas_por_militar`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `cautelas_por_militar` AS SELECT 
 1 AS `nome_completo`,
 1 AS `nome_mat`,
 1 AS `qtde_cautela`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `funcao_militar`
--

DROP TABLE IF EXISTS `funcao_militar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcao_militar` (
  `id_funcao_militar` int unsigned NOT NULL AUTO_INCREMENT,
  `funcao_mil` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `subunidade` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_funcao_militar`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcao_militar`
--

LOCK TABLES `funcao_militar` WRITE;
/*!40000 ALTER TABLE `funcao_militar` DISABLE KEYS */;
INSERT INTO `funcao_militar` VALUES (1,'Enc Mat','1ª Cia'),(2,'Enc Mat','2ª Cia'),(3,'S/4','OM'),(4,'Fiscal Adm','OM'),(5,'Cmt Cia','1ª Cia'),(6,'Aux Enc Mat','1ª Cia');
/*!40000 ALTER TABLE `funcao_militar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_carga`
--

DROP TABLE IF EXISTS `material_carga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_carga` (
  `id_mat_carga` int NOT NULL AUTO_INCREMENT,
  `nome_mat` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `descricao_mat` text COLLATE utf8mb4_general_ci NOT NULL,
  `qtde_carga` int DEFAULT NULL,
  `situacao_mat` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `material_codigo` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_mat_carga`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_carga`
--

LOCK TABLES `material_carga` WRITE;
/*!40000 ALTER TABLE `material_carga` DISABLE KEYS */;
INSERT INTO `material_carga` VALUES (1,'Cabo solteiro 4,5m','Corda individual  para escalada cor preta tamanho 4,5 metros 10mm de espessura.',50,'Em estoque','545530'),(2,'Faca MK1','Faca de combate modelo MK1 marca IMBEL.',100,'Em estoque','656312'),(3,'Cantil 1 litro','Cantil de plastico cor verde capacidade 1 litro.',200,'Em uso','983421'),(4,'OVN','Aparelho de visão noturna.',500,'Em estoque','545512'),(5,'Mochila Tática Modular','Mochila resistente com compartimentos modulares para transporte de equipamento militar.',150,'Em uso','876699'),(6,'Lanterna Tática','Lanterna de alta intensidade para uso noturno.',80,'Em estoque','876690'),(7,'Barraca de Campanha','Barraca portátil para abrigo durante operações militares.',20,'Em estoque','453387'),(8,'Kit de Primeiros Socorros','Kit contendo suprimentos médicos básicos para atendimento emergencial.',30,'Em estoque','122265'),(9,'Binóculos','Binóculos com alta capacidade de ampliação para observação de longa distância.',40,'Disponivel','226570'),(10,'Capacete Balístico','Capacete projetado para proteger a cabeça contra impactos balísticos.',100,'Disponivel','115433'),(11,'Porta-carregador Fuzil','Porta carregador para fuzil M4 cor verde.',200,'Disponivel','605598'),(12,'Abrigo parka','Abrigo impermeavel para frio.',100,'Em estoque','235561');
/*!40000 ALTER TABLE `material_carga` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `inclusao_material` AFTER INSERT ON `material_carga` FOR EACH ROW BEGIN
		INSERT INTO situacao_material_carga (
						fk_id_mat_carga,
                        existente,
						indisponivel,
						em_cautela,
						total_disponivel)
		VALUES
			(new.id_mat_carga,
            new.qtde_carga,
			0,
            0,
			new.qtde_carga);
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `militar`
--

DROP TABLE IF EXISTS `militar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `militar` (
  `id_militar` int NOT NULL,
  `nome_completo` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `nome_guerra` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `numero` varchar(6) COLLATE utf8mb4_general_ci NOT NULL,
  `fk_id_posto_grad` int NOT NULL,
  `fk_id_arma` int NOT NULL,
  `tu_formacao` int NOT NULL,
  `fk_id_escola_formacao` int NOT NULL,
  `fk_id_sit_militar` int NOT NULL,
  `fk_id_sit_servico` int NOT NULL,
  `cpf` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `idt_mil` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `data_apresentacao` date NOT NULL,
  `data_desligamento` date NOT NULL,
  PRIMARY KEY (`id_militar`),
  KEY `fkid_arma` (`fk_id_arma`),
  KEY `fkid_sit_serv` (`fk_id_sit_servico`),
  KEY `fkid_posto_grad` (`fk_id_posto_grad`),
  CONSTRAINT `fkid_arma` FOREIGN KEY (`fk_id_arma`) REFERENCES `arma` (`id_arma`),
  CONSTRAINT `fkid_posto_grad` FOREIGN KEY (`fk_id_posto_grad`) REFERENCES `posto_grad` (`id_posto_grad`),
  CONSTRAINT `fkid_sit_serv` FOREIGN KEY (`fk_id_sit_servico`) REFERENCES `situacao_servico` (`id_sit_serv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `militar`
--

LOCK TABLES `militar` WRITE;
/*!40000 ALTER TABLE `militar` DISABLE KEYS */;
INSERT INTO `militar` VALUES (2,'Mario Silva','Silva','123',1,1,1998,1,1,1,'012345678-95','020254544-7','2010-12-02','2021-02-14'),(3,'João Santos','Santos','124',1,2,2008,1,1,1,'012345679-95','020254545-7','2010-12-03','2021-02-15'),(4,'Pedro Oliveira','Oliveira','125',1,1,1998,1,1,1,'012345680-95','020254546-7','2010-12-04','2021-02-16'),(5,'Maria Pereira','Pereira','126',1,1,1998,1,1,1,'012345681-95','020254547-7','2010-12-05','2021-02-17'),(6,'Ana Silva','Silva','127',1,2,1998,1,1,1,'012345682-95','020254548-7','2010-12-06','2021-02-18'),(7,'José Santos','Santos','128',1,1,1998,1,1,1,'012345683-95','020254549-7','2010-12-07','2021-02-19'),(8,'Paulo Oliveira','Oliveira','129',1,1,1998,1,1,1,'012345684-95','020254550-7','2010-12-08','2021-02-20'),(9,'Carla Pereira','Pereira','130',1,1,1998,1,1,1,'012345685-95','020254551-7','2010-12-09','2021-02-21'),(10,'Fernanda Silva','Silva','131',1,1,1998,1,1,1,'012345686-95','020254552-7','2010-12-10','2021-02-22'),(11,'Marcos Santos','Santos','132',1,2,1998,1,1,1,'012345687-95','020254553-7','2010-12-11','2021-02-23'),(12,'Juliana Oliveira','Oliveira','133',1,1,1998,1,1,1,'012345688-95','020254554-7','2010-12-12','2021-02-24'),(13,'Ricardo Pereira','Pereira','134',1,1,1998,1,1,1,'012345689-95','020254555-7','2010-12-13','2021-02-25'),(14,'Camila Silva','Silva','135',1,1,1998,1,1,1,'012345690-95','020254556-7','2015-12-14','2021-02-26'),(15,'Lucas Santos','Santos','136',1,1,1998,1,1,1,'012345691-95','020254557-7','2005-12-15','2021-02-27'),(16,'Amanda Oliveira','Oliveira','137',1,1,2003,1,1,1,'012345692-95','020254558-7','2010-12-16','2021-02-28'),(17,'Gabriel Pereira','Pereira','138',1,1,1998,1,1,1,'012345693-95','020254559-7','2010-12-17','2021-03-01'),(18,'Mariana Silva','Silva','139',1,1,1998,1,1,1,'012345694-95','020254560-7','2010-01-18','2021-03-02'),(19,'Rodrigo Santos','Santos','140',1,1,1998,1,1,1,'012345695-95','020254561-7','2011-12-19','2021-03-03'),(20,'Larissa Oliveira','Oliveira','141',1,1,1998,1,1,1,'012345696-95','020254562-7','2010-12-20','2021-03-04'),(21,'Carlos Pereira','Pereira','142',1,1,1998,1,1,1,'012345697-95','020254563-7','2010-12-21','2021-03-05'),(22,'Vanessa Silva','Silva','143',1,1,1985,1,1,1,'012345698-95','020254564-7','2016-04-22','2021-03-06'),(23,'Gustavo Santos','Santos','144',1,1,2008,1,1,1,'012345699-95','020254565-7','2010-12-23','2021-03-07'),(24,'Tatiane Oliveira','Oliveira','145',1,1,2001,1,1,1,'012345700-95','020254566-7','2012-02-24','2021-03-08'),(25,'Renato Pereira','Pereira','146',1,1,1994,1,1,1,'012345701-95','020254567-7','2009-08-25','2021-03-09'),(26,'Eduarda Silva','Silva','147',1,1,1998,1,1,1,'012345702-95','020254568-7','2010-12-26','2021-03-10'),(27,'Luiz Santos','Santos','148',1,1,1998,1,1,1,'012345703-95','020254569-7','2010-12-27','2021-03-11'),(28,'Fernando Oliveira','Oliveira','149',1,1,1998,1,1,1,'012345704-95','020254570-7','2010-12-28','2021-03-12'),(29,'Tatiana Pereira','Pereira','150',1,1,1998,1,1,1,'012345705-95','020254571-7','2014-11-29','2021-03-13'),(30,'Roberto Silva','Silva','151',1,1,1998,1,1,1,'012345706-95','020254572-7','2017-06-30','2021-03-14');
/*!40000 ALTER TABLE `militar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posto_grad`
--

DROP TABLE IF EXISTS `posto_grad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posto_grad` (
  `id_posto_grad` int NOT NULL,
  `posto_grad` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `posto_grad_extenso` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_posto_grad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posto_grad`
--

LOCK TABLES `posto_grad` WRITE;
/*!40000 ALTER TABLE `posto_grad` DISABLE KEYS */;
INSERT INTO `posto_grad` VALUES (1,'Sd','Soldado'),(2,'Cb','Cabo'),(3,'3º Sgt','3º Sargento'),(4,'2º Sgt','2º Sargento'),(5,'1º Sgt','1º Sargento'),(6,'ST','Sub-Tenente'),(7,'Asp Of','Aspirante'),(8,'2º Ten','2º Tenente'),(9,'1º Ten','1º Tenente'),(10,'Cap','Capitão'),(11,'Maj','Major'),(12,'TC','Tenente-Coronel'),(13,'Cel','Coronel'),(14,'Gen Bda','General de Brigada');
/*!40000 ALTER TABLE `posto_grad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `situacao_material_carga`
--

DROP TABLE IF EXISTS `situacao_material_carga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `situacao_material_carga` (
  `id_sit_mat_carga` int NOT NULL AUTO_INCREMENT,
  `fk_id_mat_carga` int DEFAULT NULL,
  `existente` int DEFAULT NULL,
  `indisponivel` int DEFAULT NULL,
  `em_cautela` int DEFAULT NULL,
  `total_disponivel` int DEFAULT NULL,
  `data_atualizacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_sit_mat_carga`),
  KEY `fkid_mat_carga_sit` (`fk_id_mat_carga`),
  CONSTRAINT `fkid_mat_carga_sit` FOREIGN KEY (`fk_id_mat_carga`) REFERENCES `material_carga` (`id_mat_carga`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situacao_material_carga`
--

LOCK TABLES `situacao_material_carga` WRITE;
/*!40000 ALTER TABLE `situacao_material_carga` DISABLE KEYS */;
INSERT INTO `situacao_material_carga` VALUES (1,1,50,0,0,50,'2024-03-15 13:29:10'),(2,2,100,0,0,100,'2024-03-15 13:29:10'),(3,3,200,0,0,200,'2024-03-15 13:29:10'),(4,4,500,0,8,492,'2024-03-15 13:29:10'),(5,5,150,0,0,150,'2024-03-15 13:29:10'),(6,6,80,0,0,80,'2024-03-15 13:29:10'),(7,7,20,0,0,20,'2024-03-15 13:29:10'),(8,8,30,0,0,30,'2024-03-15 13:29:10'),(9,9,40,0,0,40,'2024-03-15 13:29:10'),(10,10,100,0,0,100,'2024-03-15 13:29:10'),(11,11,200,0,2,198,'2024-03-15 13:29:10'),(12,12,100,0,1,99,'2024-03-15 13:29:10');
/*!40000 ALTER TABLE `situacao_material_carga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `situacao_servico`
--

DROP TABLE IF EXISTS `situacao_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `situacao_servico` (
  `id_sit_serv` int NOT NULL,
  `sit_servico` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_sit_serv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situacao_servico`
--

LOCK TABLES `situacao_servico` WRITE;
/*!40000 ALTER TABLE `situacao_servico` DISABLE KEYS */;
INSERT INTO `situacao_servico` VALUES (1,'Ok'),(2,'Baixado'),(3,'Férias'),(4,'Dispensado'),(5,'Ausente'),(6,'Desertor'),(7,'Em missão');
/*!40000 ALTER TABLE `situacao_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'om'
--

--
-- Dumping routines for database 'om'
--

--
-- Final view structure for view `cautelas_por_material`
--

/*!50001 DROP VIEW IF EXISTS `cautelas_por_material`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cautelas_por_material` AS select `material_carga`.`nome_mat` AS `nome_mat`,`cautelas`.`qtde_cautela` AS `qtde_cautela`,`militar`.`nome_completo` AS `nome_completo`,`cautelas`.`id_operacao` AS `RET/DEV`,`cautelas`.`data_operacao` AS `Data` from ((`cautelas` join `militar` on((`militar`.`id_militar` = `cautelas`.`fk_id_militar`))) join `material_carga` on((`material_carga`.`id_mat_carga` = `cautelas`.`fk_id_mat_carga`))) order by `material_carga`.`nome_mat`,`militar`.`nome_completo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `cautelas_por_militar`
--

/*!50001 DROP VIEW IF EXISTS `cautelas_por_militar`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cautelas_por_militar` AS select `militar`.`nome_completo` AS `nome_completo`,`material_carga`.`nome_mat` AS `nome_mat`,`cautelas`.`qtde_cautela` AS `qtde_cautela` from ((`cautelas` join `militar` on((`cautelas`.`fk_id_militar` = `militar`.`id_militar`))) join `material_carga` on((`cautelas`.`fk_id_mat_carga` = `material_carga`.`id_mat_carga`))) order by `militar`.`nome_completo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-15 18:08:23
