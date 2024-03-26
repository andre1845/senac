CREATE DATABASE  IF NOT EXISTS om3;
USE om3;

/*  -------- TABELA ARMA --------------  */

DROP TABLE IF EXISTS arma;

CREATE TABLE arma (
  id_arma int NOT NULL,
  arma_nome varchar(50)  NOT NULL,
  arma_sigla varchar(10)  DEFAULT NULL,
  PRIMARY KEY (id_arma)
) ;

/*  -------- TABELA ESCOLA_FORMACAO --------------  */

DROP TABLE IF EXISTS escola_formacao;

CREATE TABLE escola_formacao(
id_escola_formacao INT NOT NULL PRIMARY KEY auto_increment,
nome_escola VARCHAR(60),
sigla_escola VARCHAR(15)
);

/*  -------- TABELA POSTO_GRAD --------------  */

DROP TABLE IF EXISTS posto_grad;

CREATE TABLE posto_grad (
  id_posto_grad int NOT NULL,
  posto_grad varchar(10)  NOT NULL,
  posto_grad_extenso varchar(30)  NOT NULL,
  PRIMARY KEY (id_posto_grad)
) ;

/*  -------- TABELA SUBUNIDADE --------------  */

DROP TABLE IF EXISTS subunidade;

CREATE TABLE subunidade (
  id_subunidade INT NOT NULL AUTO_INCREMENT,
  subunidade_sigla varchar(20)  DEFAULT NULL,
  subunidade varchar(40)  DEFAULT NULL,
  PRIMARY KEY (id_subunidade)
  ) ;
  
  /*  -------- TABELA FRACAO --------------  */
  
  DROP TABLE IF EXISTS fracao;

CREATE TABLE fracao (
  id_fracao INT NOT NULL AUTO_INCREMENT,
  fracao_sigla varchar(20)  DEFAULT NULL,
  fracao varchar(40)  DEFAULT NULL,
  PRIMARY KEY (id_fracao)
  ) ;
  
  /*  -------- TABELA FUNCAO_MILITAR --------------  */
  
  DROP TABLE IF EXISTS funcao_militar;

CREATE TABLE funcao_militar (
  id_funcao_militar INT NOT NULL AUTO_INCREMENT,
  funcao_mil varchar(30)  DEFAULT NULL,
  PRIMARY KEY (id_funcao_militar)
  ) ;
  
  /*  -------- TABELA SITUACAO_SERVICO  --------------  */

DROP TABLE IF EXISTS situacao_servico;

CREATE TABLE situacao_servico (
  id_sit_serv int NOT NULL auto_increment primary key,
  sit_servico varchar(40)  NOT NULL
  );

/*  -------- TABELA MATERIAL_CARGA --------------  */

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

/*  -------- TABELA MILITAR --------------  */
/*  -------- com Foreing key de outras tabelas --------------  */

DROP TABLE IF EXISTS militar;

CREATE TABLE militar (
  id_militar int NOT NULL,
  nome_completo varchar(255)  NOT NULL,
  nome_guerra varchar(100)  NOT NULL,
  numero varchar(6)  NOT NULL,
  fk_id_subunidade INT,
  fk_id_fracao INT,
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
  KEY fkid_subunidade (fk_id_subunidade),
  KEY fkid_fracao (fk_id_fracao),
  CONSTRAINT fkid_arma FOREIGN KEY (fk_id_arma) REFERENCES arma (id_arma),
  CONSTRAINT fkid_posto_grad FOREIGN KEY (fk_id_posto_grad) REFERENCES posto_grad (id_posto_grad),
  CONSTRAINT fkid_sit_serv FOREIGN KEY (fk_id_sit_servico) REFERENCES situacao_servico (id_sit_serv),
  CONSTRAINT fkid_subunidade FOREIGN KEY (fk_id_subunidade) REFERENCES subunidade (id_subunidade),
  CONSTRAINT fkid_fracao FOREIGN KEY (fk_id_fracao) REFERENCES fracao (id_fracao)
) ;

/*  -------- TABELA CAUTELAS --------------  */

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

/*  -------- TABELA SITUACAO_MATERIAL_CARGA  --------------  */


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

/*  -------- TABELA CAUTELAS_SITUACAO --------------  */

CREATE TABLE cautelas_situacao(
	fk_id_militar_cs INT,
    fk_id_mat_carga_cs INT,
    qtde_cautela_cs INT,
    data_atlz TIMESTAMP,
    PRIMARY KEY(fk_id_militar_cs, fk_id_mat_carga_cs),
    KEY fkid_mat_carga_cs (fk_id_mat_carga_cs),
    KEY fkid_militar_cs (fk_id_militar_cs),
    CONSTRAINT fkid_mat_carga_cs FOREIGN KEY (fk_id_mat_carga_cs) REFERENCES material_carga (id_mat_carga),
    CONSTRAINT fkid_militar_cs FOREIGN KEY (fk_id_militar_cs) REFERENCES militar (id_militar)
    );
    
    
    /*  -------- ADICIONANDO FOREIGN KEYS --------------  */
    
    /*  ->>>>  FK PARA TABELA MILITAR - ESCOLA_FORMACAO  <<<<-  */
    
ALTER TABLE militar
ADD CONSTRAINT fkid_escola_formacao
FOREIGN KEY (fk_id_escola_formacao)
REFERENCES escola_formacao(id_escola_formacao);

/* ALTER TABLE cautelas_situacao
ADD CONSTRAINT fkid_mat_carga_cs FOREIGN KEY (fk_id_mat_carga_cs) REFERENCES material_carga (id_mat_carga);*/

/*ALTER TABLE cautelas_situacao
ADD CONSTRAINT fkid_militar_cs FOREIGN KEY (fk_id_militar_cs) REFERENCES militar (id_militar);*/

/*ALTER TABLE militar ADD COLUMN fk_id_subunidade INT AFTER numero;

ALTER TABLE militar ADD COLUMN fk_id_fracao INT AFTER fk_id_subunidade ;
*/


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

