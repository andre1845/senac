
/*os 10 filmes mais alugados em todas as lojas
Quais clientes  alugaram mais filmes e quais os filmes eles alugaram
Qual o melhor funcionário por loja*/

CREATE VIEW filmes_mais_alugados AS SELECT  titulo, COUNT(filme.filme_id) as aluguel
FROM aluguel
JOIN inventario ON aluguel.inventario_id = inventario.inventario_id
JOIN filme ON filme.filme_id = inventario.filme_id
GROUP BY titulo
ORDER BY aluguel DESC, titulo ASC
LIMIT 10;

/*drop view filmes_mais_alugados;*/

SELECT * FROM filmes_mais_alugados;


SELECT aluguel_id, aluguel.inventario_id, COUNT(titulo) as aluguel, titulo  FROM aluguel
JOIN inventario ON aluguel.inventario_id = inventario.inventario_id
JOIN filme ON filme.filme_id = inventario.filme_id
GROUP BY
ORDER BY aluguel DESC;

select * from loja;

select *, count(aluguel_id) from aluguel 
group by funcionario_id;

select count(aluguel_id) from aluguel;

select * from funcionario;

select * from filmes_mais_alugados;

SELECT aluguel_id, aluguel.inventario_id, titulo  FROM aluguel
JOIN inventario ON aluguel.inventario_id = inventario.inventario_id
JOIN filme ON filme.filme_id = inventario.filme_id
WHERE titulo like '%bucket bro%';

SELECT cliente_id, COUNT(cliente_id) as qtde_filmes  FROM aluguel
JOIN inventario ON aluguel.inventario_id = inventario.inventario_id
JOIN filme ON filme.filme_id = inventario.filme_id
GROUP BY cliente_id
ORDER BY qtde_filmes DESC
LIMIT 5;

SELECT titulo, cliente_id  FROM filme
JOIN inventario ON filme.filme_id = inventario.filme_id
JOIN aluguel ON aluguel.inventario_id = inventario.inventario_id
WHERE cliente_id = 148;


SELECT  titulo,aluguel.inventario_id as aluguel
FROM aluguel
JOIN inventario ON aluguel.inventario_id = inventario.inventario_id
JOIN filme ON filme.filme_id = inventario.filme_id

ORDER BY aluguel DESC, titulo ASC;


SELECT  titulo, COUNT(filme.filme_id) as qtde, aluguel_id
FROM aluguel
JOIN inventario ON aluguel.inventario_id = inventario.inventario_id
JOIN filme ON filme.filme_id = inventario.filme_id
GROUP BY filme.filme_id
ORDER BY qtde desc, titulo ASC;

select * from aluguel;


select * from filme where titulo like '%rock%';

DELIMITER $$
CREATE PROCEDURE clientes_top(qtde INT)

BEGIN
DECLARE finalizar INT; /* FLAG DO LOOP */
DECLARE id_cliente_top int;
DECLARE aluguel_top int;

DECLARE v_cursor CURSOR FOR SELECT cliente_id, COUNT(cliente_id) as qtde_filmes FROM aluguel
JOIN inventario ON aluguel.inventario_id = inventario.inventario_id
JOIN filme ON filme.filme_id = inventario.filme_id
GROUP BY cliente_id
ORDER BY qtde_filmes DESC;

OPEN v_cursor;

buscaCliente: LOOP

FETCH v_cursor INTO id_cliente_top, aluguel_top;
SET finalizar = finalizar +1;

 IF finalizar = qtde THEN
		LEAVE buscaCliente;
    END IF;
buscaFilme : LOOP
SELECT distinct titulo, cliente_id  FROM filme
JOIN inventario ON filme.filme_id = inventario.filme_id
JOIN aluguel ON aluguel.inventario_id = inventario.inventario_id
WHERE cliente_id = id_cliente_top;

 END LOOP;

END LOOP;

CLOSE v_cursor;
END $$

DELIMITER ;

CALL clientes_top(5);

DROP PROCEDURE clientes_top;

DELIMITER //

CREATE PROCEDURE copy_movies_client(IN cliente_x INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE movie_id INT;
    DECLARE cur CURSOR FOR 
		SELECT inventario.filme_id, aluguel.cliente_id FROM filme
		JOIN inventario ON filme.filme_id = inventario.filme_id
		JOIN aluguel ON aluguel.inventario_id = inventario.inventario_id
		WHERE cliente_id = cliente_x;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Criação da tabela de destino, se ela não existir
    CREATE TABLE IF NOT EXISTS client_movies (
        id INT AUTO_INCREMENT PRIMARY KEY,
        client_id INT,
        movie_id INT
    );

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO movie_id, cliente_x;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Insere o filme alugado pelo cliente na tabela de filmes do cliente
        INSERT INTO client_movies (client_id, movie_id) VALUES (cliente_x, movie_id);
    END LOOP;

    CLOSE cur;
END//

DELIMITER ;

call copy_movies_client (18);

drop procedure copy_movies_client;

select * from client_movies;

truncate table client_movies;
