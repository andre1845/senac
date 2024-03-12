create table produto(
	id_produto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    de_produto varchar(200) NOT NULL,
    vr_produto decimal(10,2),
    vr_prod_desconto decimal (10,2)
    );
    
    DROP TABLE PRODUTO;
    
    DELIMITER @@
    CREATE TRIGGER TR_INSERE_DESCONTO BEFORE INSERT ON PRODUTO
        FOR EACH ROW
        BEGIN
            IF NEW.VR_PRODUTO_DESCONTO >= NEW.VR_PRODUTO THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'VALOR DO DESCONTO NÃO PODE SER MAIOR QUE O VALOR DO PRODUTO';
            END IF;

            SET NEW.VR_PRODUTO_DESCONTO = NEW.VR_PRODUTO - (NEW.VR_PRODUTO * 0.10);
        end;
        
@@ DELIMITER ;


DELIMITER @@
    CREATE TRIGGER TR_CHECAR_AUMENTO BEFORE UPDATE ON PRODUTO
        FOR EACH ROW
        BEGIN
            IF NEW.VR_PRODUTO < OLD.VR_PRODUTO THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'O VALOR DO PRODUTO NAO PODE SER REDUZIDO, APLIQUE A DIMINUIÇÃO DO PREÇO NO CAMPO DE DESCONTO';
            END IF;
        end;
@@ DELIMITER ;


CREATE TABLE PRODUTO (
        ID_PRDUTO INT AUTO_INCREMENT PRIMARY KEY,
        DE_PRODUTO VARCHAR(100),
        VR_PRODUTO DECIMAL(10,2),
        VR_PRODUTO_DESCONTO DECIMAL(10,2)
);

DELIMITER @@
	CREATE TRIGGER ALTERAR_VALOR BEFORE UPDATE ON produto
		FOR EACH ROW
        BEGIN   
			IF NEW.VR_PRODUTO_DESCONTO >= NEW.VR_PRODUTO THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'VALOR DO DESCONTO NÃO PODE SER MAIOR QUE O VALOR DO PRODUTO';
			END IF;     
            SET new.VR_PRODUTO_DESCONTO = new.VR_produto - (new.vr_produto * 0.1);
                     END   
            @@
            DELIMITER ;
            
            INSERT INTO produto (de_produto,Vr_produto) 
            VALUES 
					('produto 12', 1000),
                    ('produto 45', 2000)
                    ;
                    
SELECT * FROM produto;

create table historico_produto(
id_historico INT AUTO_INCREMENT PRIMARY KEY,
id_produto INT,
de_produto VARCHAR(100),
vr_produto_antigo DECIMAL(10,2),
vr_produto_novo DECIMAL(10,2),
dt_alteracao TIMESTAMP DEFAULT current_timestamp,
id_operacao CHAR(1)
);

UPDATE produto SET VR_produto = 150, vr_produto_desconto = 180 WHERE ID_PRoDUTO = 4;

UPDATE produto SET VR_produto = 55 WHERE ID_PRoDUTO = 2;

drop trigger ALTERAR_VALOR;

ALTER TABLE produto CHANGE COLUMN ID_PRoDUTO id_produto int not null auto_increment;

DELIMITER @@

create trigger historico_update AFTER UPDATE ON PRODUTO
FOR EACH ROW
	BEGIN
		INSERT INTO historico_produto (
						id_produto,
						de_produto,
						vr_produto_antigo,
						vr_produto_novo,
						id_operacao)
		VALUES
			(new.id_produto,
			new.de_produto,
			old.vr_produto,
			new.vr_produto,
			'a');
	END
    
    @@ 
    DELIMITER ; 
    
    UPDATE produto SET VR_produto = 4500 WHERE ID_PRoDUTO = 1;
    
    SELECT * FROM historico_produto;
    
    DELIMITER @@

create trigger historico_delete AFTER DELETE ON PRODUTO
FOR EACH ROW
	BEGIN
		INSERT INTO historico_produto (
						id_produto,
						de_produto,
						vr_produto_antigo,
						vr_produto_novo,
						id_operacao)
		VALUES
			(old.id_produto,
			old.de_produto,
			old.vr_produto,
			null,
			'd');
	END
    
    @@ 
    DELIMITER ; 
    
    UPDATE produto SET VR_produto = 4500 WHERE ID_PRoDUTO = 2;
    
    SELECT * FROM historico_produto;
    
    SELECT * FROM produto;
    
    DELETE from produto WHERE id_produto = 2;



