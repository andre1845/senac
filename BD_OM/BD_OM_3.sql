CREATE DATABASE  IF NOT EXISTS om2;
USE om2;

DROP TABLE IF EXISTS arma;

CREATE TABLE arma (
  id_arma int NOT NULL,
  arma_nome varchar(50)  NOT NULL,
  arma_sigla varchar(10)  DEFAULT NULL,
  PRIMARY KEY (id_arma)
) ;

DROP TABLE IF EXISTS escola_formacao;

CREATE TABLE escola_formacao(
id_escola_formacao INT NOT NULL PRIMARY KEY auto_increment,
nome_escola VARCHAR(60),
sigla_escola VARCHAR(15)
);

DROP TABLE IF EXISTS posto_grad;

CREATE TABLE `posto_grad` (
  id_posto_grad int NOT NULL,
  posto_grad varchar(10)  NOT NULL,
  posto_grad_extenso varchar(30)  NOT NULL,
  PRIMARY KEY (id_posto_grad)
) ;

DROP TABLE IF EXISTS subunidade;

CREATE TABLE subunidade (
  id_subunidade INT NOT NULL AUTO_INCREMENT,
  subunidade_sigla varchar(20)  DEFAULT NULL,
  subunidade varchar(40)  DEFAULT NULL,
  PRIMARY KEY (id_subunidade)
  ) ;
  
  DROP TABLE IF EXISTS fracao;

CREATE TABLE fracao (
  id_fracao INT NOT NULL AUTO_INCREMENT,
  fracao_sigla varchar(20)  DEFAULT NULL,
  fracao varchar(40)  DEFAULT NULL,
  PRIMARY KEY (id_fracao)
  ) ;
  
  DROP TABLE IF EXISTS funcao_militar;

CREATE TABLE funcao_militar (
  id_funcao_militar INT NOT NULL AUTO_INCREMENT,
  funcao_mil varchar(30)  DEFAULT NULL,
  PRIMARY KEY (id_funcao_militar)
  ) ;

DROP TABLE IF EXISTS situacao_servico;

CREATE TABLE situacao_servico (
  id_sit_serv int NOT NULL auto_increment primary key,
  sit_servico varchar(40)  NOT NULL
  );

DROP TABLE IF EXISTS material_carga;

CREATE TABLE material_carga (
  id_mat_carga int NOT NULL AUTO_INCREMENT,
  nome_mat varchar(100)  NOT NULL,
  descricao_mat text  NOT NULL,
  qtde_carga int DEFAULT NULL,
  situacao_mat varchar(30)  NOT NULL,
  material_codigo varchar(30)  DEFAULT NULL,
  PRIMARY KEY (id_mat_carga)
) ;

DROP TABLE IF EXISTS militar;

CREATE TABLE militar (
  id_militar int NOT NULL,
  nome_completo varchar(255)  NOT NULL,
  nome_guerra varchar(100)  NOT NULL,
  numero varchar(6)  NOT NULL,
  fk_id_posto_grad int NOT NULL,
  fk_id_arma int NOT NULL,
  tu_formacao int NOT NULL,
  fk_id_escola_formacao int NOT NULL,
  fk_id_sit_militar int NOT NULL,
  fk_id_sit_servico int NOT NULL,
  cpf varchar(15)  NOT NULL,
  idt_mil varchar(20)  NOT NULL,
  data_apresentacao date NOT NULL,
  data_desligamento date NOT NULL,
  PRIMARY KEY (id_militar),
  KEY fkid_arma (fk_id_arma),
  KEY fkid_sit_serv (fk_id_sit_servico),
  KEY fkid_posto_grad (fk_id_posto_grad),
  CONSTRAINT fkid_arma FOREIGN KEY (fk_id_arma) REFERENCES arma (id_arma),
  CONSTRAINT fkid_posto_grad FOREIGN KEY (fk_id_posto_grad) REFERENCES posto_grad (id_posto_grad),
  CONSTRAINT fkid_sit_serv FOREIGN KEY (fk_id_sit_servico) REFERENCES situacao_servico (id_sit_serv)
) ;

DROP TABLE IF EXISTS cautelas;

CREATE TABLE cautelas (
  id_cautela INT NOT NULL AUTO_INCREMENT,
  fk_id_mat_carga int NOT NULL,
  qtde_cautela int NOT NULL,
  id_operacao enum('r','d')  DEFAULT NULL,
  fk_id_militar int NOT NULL,
  data_operacao date DEFAULT NULL,
  fk_id_responsavel int NOT NULL,
  PRIMARY KEY (id_cautela),
  KEY fkid_militar (fk_id_militar),
  KEY fkid_mat_carga (fk_id_mat_carga),
  CONSTRAINT fkid_mat_carga FOREIGN KEY (fk_id_mat_carga) REFERENCES material_carga (id_mat_carga),
  CONSTRAINT fkid_militar FOREIGN KEY (fk_id_militar) REFERENCES militar (id_militar)
) ;


DROP TABLE IF EXISTS situacao_material_carga;

CREATE TABLE situacao_material_carga (
  id_sit_mat_carga int NOT NULL AUTO_INCREMENT,
  fk_id_mat_carga int DEFAULT NULL,
  existente int DEFAULT NULL,
  indisponivel int DEFAULT NULL,
  em_cautela int DEFAULT NULL,
  total_disponivel int DEFAULT NULL,
  data_atualizacao timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_sit_mat_carga),
  KEY fkid_mat_carga_sit (fk_id_mat_carga),
  CONSTRAINT fkid_mat_carga_sit FOREIGN KEY (fk_id_mat_carga) REFERENCES material_carga (id_mat_carga)
) ;

CREATE TABLE cautelas_situacao(
	fk_id_militar_cs INT,
    fk_id_mat_carga_cs INT,
    qtde_cautela_cs INT,
    data_atlz TIMESTAMP,
    PRIMARY KEY(fk_id_militar_cs, fk_id_mat_carga_cs)
    );
    
ALTER TABLE militar
ADD CONSTRAINT fkid_escola_formacao
FOREIGN KEY (fk_id_escola_formacao)
REFERENCES escola_formacao(id_escola_formacao);

ALTER TABLE cautelas_situacao
ADD CONSTRAINT fkid_mat_carga_cs FOREIGN KEY (fk_id_mat_carga_cs) REFERENCES material_carga (id_mat_carga);

ALTER TABLE cautelas_situacao
ADD CONSTRAINT fkid_militar_cs FOREIGN KEY (fk_id_militar_cs) REFERENCES militar (id_militar);

ALTER TABLE militar ADD COLUMN fk_id_subunidade INT AFTER numero;

ALTER TABLE militar ADD COLUMN fk_id_fracao INT AFTER fk_id_subunidade ;


/*  ---------------------------------------------------
               CRIAÇÃO DE  TRIGGER
   ----------------------------------------------------*/
   
DELIMITER //
CREATE TRIGGER inclusao_material AFTER INSERT ON material_carga 
FOR EACH ROW 
BEGIN
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
	END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER material_ret_dev AFTER INSERT ON cautelas 
FOR EACH ROW 
BEGIN
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
    
END //
DELIMITER ;


/*   ---------------------------------------------------------------------------------------------
CRIACAO DA TRIGGER PARA ATUALIZAR A TABELA SITUACAO_CAUTELAS ANTES DAS INSERCAO DE CAUTELAS NOVAS
-------------------------------------------------------------------------------------------------- */

DELIMITER //

CREATE TRIGGER atualiza_cautelas BEFORE INSERT ON cautelas
FOR EACH ROW
	BEGIN
		DECLARE emCautela INT;
        DECLARE militar_mat INT;
        DECLARE valorCautela INT;
        
       /*  Verifica se o militar já tem cautela do material a ser inserido */
       
        SET militar_mat = (SELECT EXISTS (SELECT 1 FROM cautelas_situacao 
							WHERE fk_id_militar_cs = new.fk_id_militar AND fk_id_mat_carga_cs = new.fk_id_mat_carga));
           
		/* IMPEDE a DEVOLUCAO se o militar nao tiver cautela do material */
        
        IF militar_mat = 0 AND new.id_operacao = 'd' THEN 
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'O militar não possui cautela do material a ser devolvido.';
            
		ELSE
        
        /* Executa a operacao de atualizacao na situacao das cautelas (retirada ou devolucao) */
        
			IF militar_mat = 0 AND new.id_operacao = 'r' THEN
				INSERT INTO cautelas_situacao
				(fk_id_militar_cs, fk_id_mat_carga_cs, qtde_cautela_cs, data_atlz)
				VALUES
				(new.fk_id_militar, new.fk_id_mat_carga, new.qtde_cautela, now());
			
			ELSE  
				SET valorCautela = new.qtde_cautela;
				SET emCautela = (SELECT qtde_cautela_cs FROM cautelas_situacao 
									WHERE fk_id_militar_cs = new.fk_id_militar AND fk_id_mat_carga_cs = new.fk_id_mat_carga);
				IF new.id_operacao = 'd' THEN
					
					IF (emCautela - valorCautela) < 0 THEN
						SIGNAL SQLSTATE '45000' 
						SET MESSAGE_TEXT = 'A quantidade a ser devolvida é maior que a quantidade total em cautela.';
					ELSE
						SET valorCautela = (new.qtde_cautela)*(-1);
					END IF;
				END IF;
                
                /* Faz o UPDATE considerando o valor RETIRADO ou DEVOLVIDO */ 
                
			UPDATE cautelas_situacao 
			SET qtde_cautela_cs = ((qtde_cautela_cs)+(valorCautela))
			WHERE fk_id_militar_cs = new.fk_id_militar AND fk_id_mat_carga_cs = new.fk_id_mat_carga;
				
			END IF;
		END IF;
        
        /* Chama a PROCEDURE para deletar as cautelas ZERADAS da tabela CAUTELAS_SITUACAO */
        
        CALL cautela_zerada();
        
	END //
    
    DELIMITER ;


/* ---------------------------------
         CRIAÇÃO DE PROCEDURE
------------------------------------- */


/* PROCEDURE PARA DELETAR AS CAUTELAS ZERADAS DA TABELA CAUTELAS_SITUACAO  */

DELIMITER //

CREATE PROCEDURE cautela_zerada ()
		BEGIN
			DELETE FROM cautelas_situacao WHERE qtde_cautela_cs = 0;
		END; //
DELIMITER ;

/*CALL cautela_zerada();  */


/* ---------------------------------
         CRIAÇÃO DE VIEWS 
------------------------------------- */

CREATE VIEW cautelas_por_material AS 
SELECT nome_mat, qtde_cautela , nome_completo, id_operacao AS 'RET/DEV', data_operacao AS 'Data' FROM cautelas 
JOIN material_carga ON id_mat_carga = fk_id_mat_carga
JOIN militar ON id_militar = fk_id_militar
ORDER BY nome_mat, nome_completo;


CREATE VIEW cautelas_por_militar AS 
SELECT posto_grad, nome_completo, nome_mat, qtde_cautela, id_operacao, data_operacao AS 'Data' FROM cautelas
JOIN material_carga ON id_mat_carga = fk_id_mat_carga
JOIN militar ON id_militar = fk_id_militar
JOIN posto_grad ON id_posto_grad = fk_id_posto_grad
ORDER BY nome_completo, data_operacao;


CREATE VIEW lista_militar AS SELECT posto_grad,nome_guerra, nome_completo, tu_formacao FROM militar
JOIN posto_grad ON id_posto_grad = fk_id_posto_grad
ORDER BY fk_id_posto_grad;

CREATE VIEW cautelas_ativas AS SELECT posto_grad AS 'P/G',nome_completo AS Nome, nome_mat AS Material, qtde_cautela_cs AS Quantidade FROM cautelas_situacao
JOIN militar ON id_militar = fk_id_militar_cs
JOIN posto_grad ON id_posto_grad = fk_id_posto_grad
JOIN arma ON id_arma = fk_id_arma
JOIN material_carga ON id_mat_carga = fk_id_mat_carga_cs
ORDER BY nome_completo, Material;


CREATE VIEW situacao_mat_carga AS SELECT nome_mat as MATERIAL, existente AS TOTAL_EXISTENTE, em_cautela AS EM_CAUTELA, total_disponivel AS DISPONIVEL, indisponivel FROM situacao_material_carga
JOIN material_carga ON id_mat_carga = fk_id_mat_carga
ORDER BY MATERIAL;



/* -------------------------------------------------------------------
                      INSERÇÃO DE DADOS NAS TABELAS
	--------------------------------------------------------------------*/


INSERT INTO arma 
VALUES 
(1,'Cavalaria','Cav'),
(2,'Infantaria','Inf'),
(3,'Artilharia','Art'),
(4,'Engenharia','Eng'),
(5,'Comunicações','Com'),
(6,'Intendência','Int'),
(7,'Material Bélico','MB'),
(8,'Saúde','Sau'),
(9,'Quadro Complementar de Oficiais','QCO'),
(10,'Veterinária','Vet'),
(11,'Oficial Técnico Temporário','OTT'),
(12,'Sargento Técnico Temporário','SCT'),
(13,'Aviação','Av'),
(14,'Quadro Especial','QE'),

INSERT INTO funcao_militar 
VALUES 
(1,'Enc Mat','1ª Cia'),
(2,'Enc Mat','2ª Cia'),
(3,'S/4','OM'),
(4,'Fiscal Adm','OM'),
(5,'Cmt Cia','1ª Cia'),
(6,'Aux Enc Mat','1ª Cia');

INSERT INTO posto_grad 
VALUES 
(1,'Sd','Soldado'),
(2,'Cb','Cabo'),
(3,'3º Sgt','3º Sargento'),
(4,'2º Sgt','2º Sargento'),
(5,'1º Sgt','1º Sargento'),
(6,'ST','Sub-Tenente'),
(7,'Asp Of','Aspirante'),
(8,'2º Ten','2º Tenente'),
(9,'1º Ten','1º Tenente'),
(10,'Cap','Capitão'),
(11,'Maj','Major'),
(12,'TC','Tenente-Coronel'),
(13,'Cel','Coronel'),
(14,'Gen Bda','General de Brigada');

INSERT INTO situacao_servico 
VALUES 
(1,'Ok'),
(2,'Baixado'),
(3,'Férias'),
(4,'Dispensado'),
(5,'Ausente'),
(6,'Desertor'),
(7,'Em missão');

INSERT INTO escola_formacao(
nome_escola, sigla_escola)
VALUES
('Academia Militar das Agulhas Negras', 'AMAN'),
('Escola de Sargentos das Armas', 'EsSA'),
('Escola de Formação Complementar do Exército', 'EsFCEx'),
('Escola de Sargentos de Logística do Exército', 'EsLog'),
('Escola de Saúde do Exército', 'EsSEx'),
('Centro de Preparação de Oficiais da Reserva', 'CPOR'),
('Núcleo de Preparação de Oficiais da Reserva', 'NPOR'),
('Formação de Oficiais Temporários', 'Of Temp'),
('Formação de Sargentos Temporários', 'Sgt Temp'),
('Quadro Especial', 'QE');

INSERT INTO material_carga
 VALUES
 (1,'Cabo solteiro 4,5m','Corda individual  para escalada cor preta tamanho 4,5 metros 10mm de espessura.',50,'Em estoque','545530'),
 (2,'Faca MK1','Faca de combate modelo MK1 marca IMBEL.',100,'Em estoque','656312'),
 (3,'Cantil 1 litro','Cantil de plastico cor verde capacidade 1 litro.',200,'Em uso','983421'),
 (4,'OVN','Aparelho de visão noturna.',500,'Em estoque','545512'),
 (5,'Mochila Tática Modular','Mochila resistente com compartimentos modulares para transporte de equipamento militar.',150,'Em uso','876699'),
 (6,'Lanterna Tática','Lanterna de alta intensidade para uso noturno.',80,'Em estoque','876690'),
 (7,'Barraca de Campanha','Barraca portátil para abrigo durante operações militares.',20,'Em estoque','453387'),
 (8,'Kit de Primeiros Socorros','Kit contendo suprimentos médicos básicos para atendimento emergencial.',30,'Em estoque','122265'),
 (9,'Binóculos','Binóculos com alta capacidade de ampliação para observação de longa distância.',40,'Disponivel','226570'),
 (10,'Capacete Balístico','Capacete projetado para proteger a cabeça contra impactos balísticos.',100,'Disponivel','115433'),
 (11,'Porta-carregador Fuzil','Porta carregador para fuzil M4 cor verde.',200,'Disponivel','605598'),
 (12,'Abrigo parka','Abrigo impermeavel para frio.',100,'Em estoque','235561');


INSERT INTO militar 
VALUES 
(2,'Mario Silva','Silva','123',1,1,1998,1,1,1,'012345678-95','020254544-7','2010-12-02','2021-02-14'),
(3,'João Santos','Santos','124',1,2,2008,1,1,1,'012345679-95','020254545-7','2010-12-03','2021-02-15'),
(4,'Pedro Oliveira','Oliveira','125',1,1,1998,1,1,1,'012345680-95','020254546-7','2010-12-04','2021-02-16'),
(5,'Maria Pereira','Pereira','126',1,1,1998,1,1,1,'012345681-95','020254547-7','2010-12-05','2021-02-17'),
(6,'Ana Silva','Silva','127',1,2,1998,1,1,1,'012345682-95','020254548-7','2010-12-06','2021-02-18'),
(7,'José Santos','Santos','128',1,1,1998,1,1,1,'012345683-95','020254549-7','2010-12-07','2021-02-19'),
(8,'Paulo Oliveira','Oliveira','129',1,1,1998,1,1,1,'012345684-95','020254550-7','2010-12-08','2021-02-20'),
(9,'Carla Pereira','Pereira','130',1,1,1998,1,1,1,'012345685-95','020254551-7','2010-12-09','2021-02-21'),
(10,'Fernanda Silva','Silva','131',1,1,1998,1,1,1,'012345686-95','020254552-7','2010-12-10','2021-02-22'),
(11,'Marcos Santos','Santos','132',1,2,1998,1,1,1,'012345687-95','020254553-7','2010-12-11','2021-02-23'),
(12,'Juliana Oliveira','Oliveira','133',1,1,1998,1,1,1,'012345688-95','020254554-7','2010-12-12','2021-02-24'),
(13,'Ricardo Pereira','Pereira','134',1,1,1998,1,1,1,'012345689-95','020254555-7','2010-12-13','2021-02-25'),
(14,'Camila Silva','Silva','135',1,1,1998,1,1,1,'012345690-95','020254556-7','2015-12-14','2021-02-26'),
(15,'Lucas Santos','Santos','136',1,1,1998,1,1,1,'012345691-95','020254557-7','2005-12-15','2021-02-27'),
(16,'Amanda Oliveira','Oliveira','137',1,1,2003,1,1,1,'012345692-95','020254558-7','2010-12-16','2021-02-28'),
(17,'Gabriel Pereira','Pereira','138',1,1,1998,1,1,1,'012345693-95','020254559-7','2010-12-17','2021-03-01'),
(18,'Mariana Silva','Silva','139',1,1,1998,1,1,1,'012345694-95','020254560-7','2010-01-18','2021-03-02'),
(19,'Rodrigo Santos','Santos','140',1,1,1998,1,1,1,'012345695-95','020254561-7','2011-12-19','2021-03-03'),
(20,'Larissa Oliveira','Oliveira','141',1,1,1998,1,1,1,'012345696-95','020254562-7','2010-12-20','2021-03-04'),
(21,'Carlos Pereira','Pereira','142',1,1,1998,1,1,1,'012345697-95','020254563-7','2010-12-21','2021-03-05'),
(22,'Vanessa Silva','Silva','143',1,1,1985,1,1,1,'012345698-95','020254564-7','2016-04-22','2021-03-06'),
(23,'Gustavo Santos','Santos','144',1,1,2008,1,1,1,'012345699-95','020254565-7','2010-12-23','2021-03-07'),
(24,'Tatiane Oliveira','Oliveira','145',1,1,2001,1,1,1,'012345700-95','020254566-7','2012-02-24','2021-03-08'),
(25,'Renato Pereira','Pereira','146',1,1,1994,1,1,1,'012345701-95','020254567-7','2009-08-25','2021-03-09'),
(26,'Eduarda Silva','Silva','147',1,1,1998,1,1,1,'012345702-95','020254568-7','2010-12-26','2021-03-10'),
(27,'Luiz Santos','Santos','148',1,1,1998,1,1,1,'012345703-95','020254569-7','2010-12-27','2021-03-11'),
(28,'Fernando Oliveira','Oliveira','149',1,1,1998,1,1,1,'012345704-95','020254570-7','2010-12-28','2021-03-12'),
(29,'Tatiana Pereira','Pereira','150',1,1,1998,1,1,1,'012345705-95','020254571-7','2014-11-29','2021-03-13'),
(30,'Roberto Silva','Silva','151',1,1,1998,1,1,1,'012345706-95','020254572-7','2017-06-30','2021-03-14');



/* ---------------------------------
	   ATUALIZACAO DE TABELAS 
------------------------------------- */


/* ATUALIZACAO DA TABELA MILITAR */

 UPDATE militar 
SET 
    nome_completo = 
        CASE id_militar
            WHEN 8 THEN 'Fernando Azevedo Silva'
            WHEN 9 THEN 'Rafael Oliveira dos Santos'
            WHEN 10 THEN 'Carolina Alves Maia'
            WHEN 12 THEN 'Lucas Berthold Souza'
            WHEN 13 THEN 'Mariana Zuckberg Pereira'
            WHEN 14 THEN 'André Ferreira Lima'
            WHEN 15 THEN 'Juliana Goes Montechio'
            WHEN 16 THEN 'Gabriel Laravel Costa'
            WHEN 17 THEN 'Isabela Rodrigues de Almeida Lima'
            WHEN 18 THEN 'Diego Jalin Rabey'
            WHEN 19 THEN 'Camila Martins Beludo'
            WHEN 20 THEN 'Rodrigo Alvares Barbosa'
            WHEN 21 THEN 'Aline Motinha Oliveira'
            WHEN 22 THEN 'Bruno Marques da Silva'
            WHEN 23 THEN 'Vanessa Olinto Ferreira'
        END,
    nome_guerra = 
        CASE id_militar
            WHEN 8 THEN 'Azevedo'
            WHEN 9 THEN 'Rafael'
            WHEN 10 THEN 'Alves Maia'
            WHEN 12 THEN 'Berthold'
            WHEN 13 THEN 'Zuckberg'
            WHEN 14 THEN 'Ferreira Lima'
            WHEN 15 THEN 'Juliana'
            WHEN 16 THEN 'Laravel'
            WHEN 17 THEN 'Rodrigues'
            WHEN 18 THEN 'Jalin'
            WHEN 19 THEN 'Beludo'
            WHEN 20 THEN 'Alvares'
            WHEN 21 THEN 'Motinha'
            WHEN 22 THEN 'Bruno'
            WHEN 23 THEN 'Olinto'
        END
WHERE id_militar IN (8, 9, 10, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23);

UPDATE militar SET nome_completo = 'Ricardo Tavares Gois', nome_guerra = 'Tavares' WHERE id_militar = 30;

UPDATE militar
SET tu_formacao = 
    CASE 
        WHEN tu_formacao = '1998' THEN 
            CASE ROUND(RAND() * 4)
                WHEN 0 THEN '1999'
                WHEN 1 THEN '2000'
                WHEN 2 THEN '2001'
                WHEN 3 THEN '2004'
                WHEN 4 THEN '2006'
            END
        ELSE tu_formacao
    END
WHERE tu_formacao = '1998';

UPDATE militar
SET  fk_id_escola_formacao = 
    CASE 
        WHEN fk_id_escola_formacao = '1' THEN 
            CASE ROUND(RAND() * 4)
                WHEN 0 THEN '2'
                WHEN 1 THEN '3'
                WHEN 2 THEN '1'
                WHEN 3 THEN '4'
                WHEN 4 THEN '6'
            END
        ELSE fk_id_escola_formacao
    END
WHERE fk_id_escola_formacao = '1';


UPDATE militar
SET fk_id_posto_grad = 
    CASE 
        WHEN fk_id_posto_grad = '1' THEN 
            CASE ROUND(RAND() * 10)
                WHEN 0 THEN '1'
                WHEN 1 THEN '2'
                WHEN 2 THEN '3'
                WHEN 3 THEN '4'
                WHEN 4 THEN '5'
                WHEN 5 THEN '6'
                WHEN 6 THEN '7'
                WHEN 7 THEN '8'
                WHEN 8 THEN '9'
                WHEN 9 THEN '10'
            END
        ELSE fk_id_posto_grad
    END
WHERE fk_id_posto_grad = '1';



/*  -------------------------------------------
          OPERÇÃO DO BD
 -------------------------------------------------*/
 
 SELECT * FROM CAUTELAS_ATIVAS;

SELECT * FROM cautelas_por_militar; 

SELECT * FROM cautelas_por_material;

SELECT * FROM lista_militar;

SELECT * FROM situacao_mat_carga;

/* RETIRADA DE MATERIAL */

INSERT INTO cautelas
        (fk_id_mat_carga, qtde_cautela, id_operacao, fk_id_militar, data_operacao, fk_id_responsavel)
        VALUES                                
        (11,5,'r',20,'2023-09-01',1);
        
        /* DEVOLUÇÃO DE MATERIAL */
        
INSERT INTO cautelas
        (fk_id_mat_carga, qtde_cautela, id_operacao, fk_id_militar, data_operacao, fk_id_responsavel)
        VALUES                                
        (2,5,'d',4,'2024-04-11',1);
	
        
SELECT * FROM cautelas;

TRUNCATE material_carga;

ALTER TABLE cautelas DROP FOREIGN KEY fkid_mat_carga;

ALTER TABLE cautelas_situacao DROP FOREIGN KEY fkid_mat_carga_cs;

ALTER TABLE situacao_material_carga DROP FOREIGN KEY fkid_mat_carga_sit;

ALTER TABLE cautelas
ADD CONSTRAINT fkid_mat_carga
FOREIGN KEY (fk_id_mat_carga)
REFERENCES material_carga (id_mat_carga);

ALTER TABLE cautelas_situacao
ADD CONSTRAINT fkid_mat_carga_cs
FOREIGN KEY (fk_id_mat_carga_cs)
REFERENCES material_carga (id_mat_carga);

ALTER TABLE situacao_material_carga
ADD CONSTRAINT fkid_mat_carga_sit
FOREIGN KEY (fk_id_mat_carga)
REFERENCES material_carga (id_mat_carga);


ALTER TABLE cautelas_situacao DROP FOREIGN KEY fkid_mat_carga_cs;

ALTER TABLE situacao_material_carga DROP FOREIGN KEY fkid_mat_carga_sit;

ALTER TABLE militar DROP FOREIGN KEY fkid_posto_grad;

ALTER TABLE militar
ADD CONSTRAINT fkid_posto_grad
FOREIGN KEY (fk_id_posto_grad)
REFERENCES posto_grad (id_posto_grad);


UPDATE militar SET fk_id_posto_grad = 1 WHERE id_militar = 13;



 



