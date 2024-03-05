SELECT COUNT(titulo), primeiro_nome, ultimo_nome
FROM filme
JOIN filme_ator on filme.filme_id = filme_ator.filme_id
JOIN ator on ator.ator_id = filme_ator.ator_id
WHERE primeiro_nome = "jennifer"
ORDER BY titulo;

SELECT COUNT(aluguel_id) AS ALUGUEL, cidade FROM aluguel
JOIN inventario ON inventario.inventario_id = aluguel.inventario_id
JOIN loja ON loja.loja_id = inventario.loja_id
JOIN endereco ON endereco.endereco_id = loja.endereco_id
JOIN cidade ON cidade.cidade_id = endereco.cidade_id
GROUP BY cidade;

SELECT COUNT(titulo), primeiro_nome, ultimo_nome
FROM filme
JOIN filme_ator on filme.filme_id = filme_ator.filme_id
JOIN ator on ator.ator_id = filme_ator.ator_id
GROUP BY ultimo_nome, primeiro_nome;

SELECT COUNT(DISTINCT (ultimo_nome)) FROM ator;




