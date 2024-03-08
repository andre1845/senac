SELECT cliente_id, primeiro_nome FROM cliente;

SELECT cliente_id, primeiro_nome FROM cliente WHERE primeiro_nome LIKE '%a__an%';

SELECT cliente_id, primeiro_nome FROM cliente WHERE primeiro_nome IN ('Mary','armando');

DELIMITER //

CREATE PROCEDURE listarClientes()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE id_cliente INT;
    DECLARE cliente_nome VARCHAR(255);

    -- declaração do cursor
    DECLARE cur CURSOR FOR SELECT cliente_id, primeiro_nome FROM cliente WHERE cliente_id BETWEEN 100 and 110;
    
    -- manipulador de continuação
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- abre o cursor
    OPEN cur;

    -- começa a iterar pelos resultados
    read_loop: LOOP
        -- lê os dados do cursor para as variáveis
        FETCH cur INTO id_cliente, cliente_nome;
        
        -- verifica se há mais linhas para ler
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- faz alguma operação com os dados lidos, por exemplo, imprimir
        SELECT CONCAT('ID: ', id_cliente, ', Nome: ', cliente_nome) AS Cliente_Info;
    END LOOP;

    -- fecha o cursor
    CLOSE cur;
END //

DELIMITER ;

CALL listarClientes();

/*drop procedure listarClientes;*/

desc cliente;

DELIMITER //
CREATE PROCEDURE atualizar_email()
BEGIN
DECLARE novo_email VARCHAR(100);
DECLARE antigo_email VARCHAR(100);
DECLARE idcliente INT;
DECLARE mensagemfinal VARCHAR(50);

DECLARE v_cursor CURSOR FOR SELECT cliente_id, email FROM cliente;

OPEN v_cursor;

LOOP
	FETCH v_cursor INTO idcliente, antigo_email;
    set novo_email = lower(antigo_email);
    UPDATE cliente SET email = novo_email WHERE cliente_id = idcliente;

END LOOP;
SET mensagemfinal = 'FIM';
SELECT mensagemfinal as MENSAGEM;
CLOSE v_cursor;

END //

DELIMITER ;

CALL atualizar_email();

SELECT cliente_id, email FROM cliente;

drop procedure atualizar_email;





