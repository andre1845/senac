SELECT pais, count(nome_cliente) as QTDE FROM cliente GROUP BY pais HAVING COUNT(pais) > 1 ORDER BY QTDE DESC, pais ;

SELECT COUNT(DISTINCT(pais)) FROM cliente;

SELECT  altura, COUNT(altura) AS Maior_que_60kg FROM cliente 
WHERE peso > 60 
GROUP BY altura 
HAVING altura > (select (AVG(altura)) FROM cliente);