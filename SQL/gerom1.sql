desc funcao_militar;

ALTER TABLE arma ADD COLUMN arma_sigla VARCHAR(10);

desc arma;

INSERT INTO arma (arma_nome, arma_sigla) VALUES 
("Cavalaria", "Cav"),
("Infantaria", "Inf"),
("Artilharia","Art"),
("Engenharia", "Eng"),
("Comunicações", "Com");

select * from arma;

INSERT INTO militar (nome_completo, nome_guerra, numero, fk_id_posto_grad, fk_id_arma, tu_formacao, fk_id_escola_formacao,fk_id_sit_militar, fk_id_sit_servico,cpf, idt_mil, data_apresentacao,data_desligamento) VALUES
("Mario Silva", "Silva", 123,1,1,1998, 1,1,1,"012345678-95","020254544-7", "2010-12-02", "2021-02-14");  

SELECT * FROM militar;

delete from militar where id_militar = 1;

INSERT INTO militar (nome_completo, nome_guerra, numero, fk_id_posto_grad, fk_id_arma, tu_formacao, fk_id_escola_formacao,fk_id_sit_militar, fk_id_sit_servico,cpf, idt_mil, data_apresentacao,data_desligamento) VALUES

("João Santos", "Santos", 124,1,1,2008, 1,1,1,"012345679-95","020254545-7", "2010-12-03", "2021-02-15"),
("Pedro Oliveira", "Oliveira", 125,1,1,1998, 1,1,1,"012345680-95","020254546-7", "2010-12-04", "2021-02-16"),
("Maria Pereira", "Pereira", 126,1,1,1998, 1,1,1,"012345681-95","020254547-7", "2010-12-05", "2021-02-17"),
("Ana Silva", "Silva", 127,1,1,1998, 1,1,1,"012345682-95","020254548-7", "2010-12-06", "2021-02-18"),
("José Santos", "Santos", 128,1,1,1998, 1,1,1,"012345683-95","020254549-7", "2010-12-07", "2021-02-19"),
("Paulo Oliveira", "Oliveira", 129,1,1,1998, 1,1,1,"012345684-95","020254550-7", "2010-12-08", "2021-02-20"),
("Carla Pereira", "Pereira", 130,1,1,1998, 1,1,1,"012345685-95","020254551-7", "2010-12-09", "2021-02-21"),
("Fernanda Silva", "Silva", 131,1,1,1998, 1,1,1,"012345686-95","020254552-7", "2010-12-10", "2021-02-22"),
("Marcos Santos", "Santos", 132,1,1,1998, 1,1,1,"012345687-95","020254553-7", "2010-12-11", "2021-02-23"),
("Juliana Oliveira", "Oliveira", 133,1,1,1998, 1,1,1,"012345688-95","020254554-7", "2010-12-12", "2021-02-24"),
("Ricardo Pereira", "Pereira", 134,1,1,1998, 1,1,1,"012345689-95","020254555-7", "2010-12-13", "2021-02-25"),
("Camila Silva", "Silva", 135,1,1,1998, 1,1,1,"012345690-95","020254556-7", "2015-12-14", "2021-02-26"),
("Lucas Santos", "Santos", 136,1,1,1998, 1,1,1,"012345691-95","020254557-7", "2005-12-15", "2021-02-27"),
("Amanda Oliveira", "Oliveira", 137,1,1,2003, 1,1,1,"012345692-95","020254558-7", "2010-12-16", "2021-02-28"),
("Gabriel Pereira", "Pereira", 138,1,1,1998, 1,1,1,"012345693-95","020254559-7", "2010-12-17", "2021-03-01"),
("Mariana Silva", "Silva", 139,1,1,1998, 1,1,1,"012345694-95","020254560-7", "2010-01-18", "2021-03-02"),
("Rodrigo Santos", "Santos", 140,1,1,1998, 1,1,1,"012345695-95","020254561-7", "2011-12-19", "2021-03-03"),
("Larissa Oliveira", "Oliveira", 141,1,1,1998, 1,1,1,"012345696-95","020254562-7", "2010-12-20", "2021-03-04"),
("Carlos Pereira", "Pereira", 142,1,1,1998, 1,1,1,"012345697-95","020254563-7", "2010-12-21", "2021-03-05"),
("Vanessa Silva", "Silva", 143,1,1,1985, 1,1,1,"012345698-95","020254564-7", "2016-04-22", "2021-03-06"),
("Gustavo Santos", "Santos", 144,1,1,2008, 1,1,1,"012345699-95","020254565-7", "2010-12-23", "2021-03-07"),
("Tatiane Oliveira", "Oliveira", 145,1,1,2001, 1,1,1,"012345700-95","020254566-7", "2012-02-24", "2021-03-08"),
("Renato Pereira", "Pereira", 146,1,1,1994, 1,1,1,"012345701-95","020254567-7", "2009-08-25", "2021-03-09"),
("Eduarda Silva", "Silva", 147,1,1,1998, 1,1,1,"012345702-95","020254568-7", "2010-12-26", "2021-03-10"),
("Luiz Santos", "Santos", 148,1,1,1998, 1,1,1,"012345703-95","020254569-7", "2010-12-27", "2021-03-11"),
("Fernando Oliveira", "Oliveira", 149,1,1,1998, 1,1,1,"012345704-95","020254570-7", "2010-12-28", "2021-03-12"),
("Tatiana Pereira", "Pereira", 150,1,1,1998, 1,1,1,"012345705-95","020254571-7", "2014-11-29", "2021-03-13"),
("Roberto Silva", "Silva", 151,1,1,1998, 1,1,1,"012345706-95","020254572-7", "2017-06-30", "2021-03-14");

INSERT INTO posto_grad (posto_grad, posto_grad_extenso) VALUES
("Sd", "Soldado"),
("Cb", "Cabo"),
("3º Sgt", "3º Sargento"),
("2º Sgt", "2º Sargento"),
("1º Sgt", "1º Sargento"),
("ST", "Sub-Tenente"),
("Asp Of", "Aspirante"),
("2º Ten", "2º Tenente"),
("1º Ten", "1º Tenente"),
("Cap", "Capitão"),
("Maj", "Major"),
("TC", "Tenente-Coronel"),
("Cel", "Coronel"),
("Gen Bda", "General de Brigada");

SELECT * FROM posto_grad;

INSERT INTO situacao_servico (sit_servico) VALUES ("Ok"),("Baixado"), ("Férias"), ("Dispensado"),("Ausente"), ("Desertor"),("Em missão");

SELECT * FROM situacao_servico;

INSERT INTO funcao_militar (funcao_militar,fk_id_militar_func) VALUES
("Ok"),
("Baixado"), 
("Férias"), 
("Dispensado"),("Ausente"), ("Desertor"),("Em missão");


