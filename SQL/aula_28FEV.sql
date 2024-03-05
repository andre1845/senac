DESC tb_cliente;
DESC tb_venda_produto;
DESC tb_produto;
DESC tb_venda;
DESC tb_endereco;

SELECT * FROM  tb_cliente;
SELECT * FROM  tb_venda_produto;
SELECT * FROM  tb_produto;
SELECT * FROM tb_venda;
SELECT * FROM  tb_endereco;

SELECT tb_venda.ID_VENDA as ID_VENDA, tb_cliente.Nm_Cliente AS CLIENTE, tb_endereco.uf AS ESTADO, tb_produto.De_Produto AS PRODUTO, tb_venda.VR_TOTAL as 'VALOR TOTAL', tb_venda_produto.QTD_PRODUTO as QUANTIDADE, tb_venda_produto.VR_PRODUTO as VALOR_UNIT
FROM tb_venda
JOIN tb_venda_produto ON tb_venda.id_venda = tb_venda_produto.ID_VENDA
join tb_cliente on tb_venda.id_cliente = tb_cliente.id_Cliente
join tb_endereco on tb_cliente.id_Cliente = tb_endereco.Id_Cliente
join tb_produto on tb_produto.id_Produto = tb_venda_produto.ID_PRODUTO;



/*
INSERT INTO tb_cliente (nm_cliente, cpf) VALUES ('João Silva', '12345678901');
INSERT INTO tb_cliente (nm_cliente, cpf) VALUES ('Maria Oliveira', '23456789012');
INSERT INTO tb_cliente (nm_cliente, cpf) VALUES ('Carlos Santos', '34567890123');
INSERT INTO tb_cliente (nm_cliente, cpf) VALUES ('Ana Costa', '45678901234');
INSERT INTO tb_cliente (nm_cliente, cpf) VALUES ('Pedro Rocha', '56789012345');

INSERT INTO tb_endereco (nu_cep, de_endereco, de_bairro, de_cidade, uf, id_cliente) VALUES ('70000000', 'Rua das Flores 123', 'Centro', 'Brasília', 'DF', 1);
INSERT INTO tb_endereco (nu_cep, de_endereco, de_bairro, de_cidade, uf, id_cliente) VALUES ('71000000', 'Avenida Brasil 456', 'Sul', 'São Paulo', 'SP', 2);
INSERT INTO tb_endereco (nu_cep, de_endereco, de_bairro, de_cidade, uf, id_cliente) VALUES ('72000000', 'Praça da Sé 789', 'Leste', 'Salvador', 'BA', 3);
INSERT INTO tb_endereco (nu_cep, de_endereco, de_bairro, de_cidade, uf, id_cliente) VALUES ('73000000', 'Travessa dos Artistas 101', 'Oeste', 'Rio de Janeiro', 'RJ', 4);
INSERT INTO tb_endereco (nu_cep, de_endereco, de_bairro, de_cidade, uf, id_cliente) VALUES ('74000000', 'Alameda dos Anjos 202', 'Norte', 'Curitiba', 'PR', 5);


INSERT INTO tb_venda (vr_total, id_cliente) VALUES (500.00, 1);
INSERT INTO tb_venda (vr_total, id_cliente) VALUES (750.50, 2);
INSERT INTO tb_venda (vr_total, id_cliente) VALUES (1200.00, 3);
INSERT INTO tb_venda (vr_total, id_cliente) VALUES (300.75, 4);
INSERT INTO tb_venda (vr_total, id_cliente) VALUES (450.00, 5);

INSERT INTO tb_produto (nr_serie, de_produto, vr_custo, vr_venda) VALUES ('A1', 'Teclado Gamer', 100.00, 150.00);
INSERT INTO tb_produto (nr_serie, de_produto, vr_custo, vr_venda) VALUES ('B2', 'Monitor 24 polegadas', 700.00, 900.00);
INSERT INTO tb_produto (nr_serie, de_produto, vr_custo, vr_venda) VALUES ('C3', 'Mouse sem fio', 50.00, 80.00);
INSERT INTO tb_produto (nr_serie, de_produto, vr_custo, vr_venda) VALUES ('D4', 'Headset Bluetooth', 200.00, 300.00);
INSERT INTO tb_produto (nr_serie, de_produto, vr_custo, vr_venda) VALUES ('E5', 'Cadeira Gamer', 400.00, 600.00);


INSERT INTO tb_venda_produto (id_produto, id_venda, qtd_produto, vr_produto) VALUES (1, 1, 2, 150.00);
INSERT INTO tb_venda_produto (id_produto, id_venda, qtd_produto, vr_produto) VALUES (2, 2, 1, 900.00);
INSERT INTO tb_venda_produto (id_produto, id_venda, qtd_produto, vr_produto) VALUES (3, 3, 3, 80.00);
INSERT INTO tb_venda_produto (id_produto, id_venda, qtd_produto, vr_produto) VALUES (4, 4, 1, 300.00);
INSERT INTO tb_venda_produto (id_produto, id_venda, qtd_produto, vr_produto) VALUES (5, 5, 1, 600.00);
*/
