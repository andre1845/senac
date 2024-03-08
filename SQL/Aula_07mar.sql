
/*os 10 filmes mais alugados em todas as lojas
Quais clientes  alugaram mais filmes e quais os filmes eles alugaram
Qual o melhor funcionário por loja*/

SELECT aluguel.inventario_id, titulo, COUNT(aluguel.inventario_id) as aluguel
FROM aluguel
JOIN inventario ON aluguel.inventario_id = inventario.inventario_id
JOIN filme ON filme.filme_id = inventario.filme_id
GROUP BY titulo
ORDER BY aluguel DESC, titulo ASC;

SELECT aluguel_id, aluguel.inventario_id, COUNT(titulo) as aluguel, titulo  FROM aluguel
JOIN inventario ON aluguel.inventario_id = inventario.inventario_id
JOIN filme ON filme.filme_id = inventario.filme_id
GROUP BY titulo
ORDER BY aluguel DESC;

select * from loja;

select *, count(aluguel_id) from aluguel 
group by funcionario_id;

