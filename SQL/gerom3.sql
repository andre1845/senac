ALTER TABLE militar ADD CONSTRAINT fkid_arma
FOREIGN KEY (fk_id_arma)
REFERENCES  arma(id_arma);

ALTER TABLE arma MODIFY COLUMN id_arma int(11);

ALTER TABLE situacao_servico MODIFY COLUMN id_sit_serv int(11);

ALTER TABLE material_carga MODIFY COLUMN id_mat_carga int(11);

ALTER TABLE posto_grad MODIFY COLUMN id_posto_grad INT(11);

ALTER TABLE militar MODIFY COLUMN id_militar int(11);

ALTER TABLE militar ADD CONSTRAINT fkid_posto_grad
FOREIGN KEY (fk_id_posto_grad)
REFERENCES posto_grad(id_posto_grad);

ALTER TABLE militar ADD CONSTRAINT fkid_sit_serv
FOREIGN KEY (fk_id_sit_servico)
REFERENCES  situacao_servico(id_sit_serv);

ALTER TABLE funcao_militar DROP COLUMN fk_id_militar_func;

ALTER TABLE funcao_militar ADD COLUMN subunidade VARCHAR(20);

ALTER TABLE funcao_militar CHANGE COLUMN funcao_militar funcao_mil VARCHAR(30);

INSERT INTO funcao_militar (funcao_mil, subunidade) VALUES
('Enc Mat', '1ª Cia'),
('Enc Mat','2ª Cia'),
('S/4','OM'),
('Fiscal Adm', 'OM'),
('Cmt Cia', '1ª Cia'),
('Aux Enc Mat','1ª Cia');

desc posto_grad;

desc militar;

SELECT id_militar,nome_completo, posto_grad, posto_grad_extenso, nome_guerra, sit_servico FROM militar
JOIN posto_grad ON id_posto_grad = fk_id_posto_grad
JOIN arma ON id_arma = fk_id_arma
JOIN situacao_servico ON id_sit_serv = fk_id_sit_servico
ORDER BY nome_guerra;

UPDATE militar SET fk_id_arma = 2 WHERE id_militar IN (3,6,11 );

ALTER TABLE material_carga ADD COLUMN em_cautela INT(5) AFTER qtde_carga;

ALTER TABLE material_carga ADD COLUMN indisponivel INT(5) AFTER qtde_carga;

ALTER TABLE material_carga ADD COLUMN total_disponivel INT(5) AFTER em_cautela;

ALTER TABLE cautelas ADD CONSTRAINT fkid_mat_carga FOREIGN KEY (fk_id_mat_carga) REFERENCES material_carga(id_mat_carga);

ALTER TABLE cautelas ADD CONSTRAINT fkid_militar FOREIGN KEY (fk_id_militar) REFERENCES militar(id_militar);

desc cautelas;

SELECT nome_guerra, nome_mat, qtde_cautela, data_retirada FROM cautelas
JOIN militar ON id_militar = fk_id_militar
JOIN material_carga ON id_mat_carga = fk_id_mat_carga
ORDER BY data_retirada ;

SELECT * FROM material_carga;

INSERT INTO cautelas (fk_id_mat_carga, qtde_cautela, fk_id_militar, data_retirada, data_devolucao, fk_id_responsavel) VALUES
(2,1,5,'2024-01-05', '2024-03-01',1),
(4,1,6,'2024-01-05', '2024-03-01',1),
(2,2,4,'2023-01-15', '2024-02-01',12),
(4,1,5,'2023-08-15', '2024-03-15',1);

desc militar;

desc material_carga;
