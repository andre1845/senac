ALTER TABLE produtos RENAME TO produto;

SELECT * FROM produto;

DESC produto;

INSERT INTO produto (nomeprod, valor, quantidade) VALUES
('Bola de Futebol', 29.99, 100),
('Raquete de Tênis', 59.99, 50),
('Tênis de Corrida', 99.99, 75),
('Luvas de Boxe', 39.99, 30),
('Bicicleta Mountain Bike', 499.99, 20),
('Shorts de Corrida', 19.99, 150),
('Camisa de Futebol', 34.99, 80),
('Caneleira', 14.99, 120),
('Garrafa de Água Esportiva', 9.99, 200),
('Óculos de Natação', 24.99, 60),
('Chuteira de Futebol', 79.99, 40),
('Rede de Vôlei', 49.99, 25),
('Bastão de Baseball', 29.99, 35),
('Saco de Pancadas', 69.99, 15),
('Corda de Pular', 7.99, 100),
('Taco de Golfe', 89.99, 20),
('Joelheira', 19.99, 80),
('Touca de Natação', 4.99, 150),
('Barras de Pesos', 39.99, 45),
('Sapatilhas de Ballet', 29.99, 55),
('Cinto de Musculação', 14.99, 70),
('Patins Inline', 69.99, 30),
('Skate', 49.99, 40),
('Saco de Dormir para Camping', 99.99, 25),
('Capacete para Ciclismo', 34.99, 60),
('Luvas de Academia', 9.99, 100),
('Tapete de Yoga', 19.99, 80),
('Bastão de Caminhada', 14.99, 90),
('Squeeze Esportivo', 7.99, 150),
('Rede de Futebol', 24.99, 30);

CREATE TABLE `loja`.`tb_produtos` (
  `id_produto` INT NOT NULL AUTO_INCREMENT,
  `Nr_serie` VARCHAR(45) NOT NULL,
  `DE_Produto` VARCHAR(200) NOT NULL,
  `VR_custo` DECIMAL(7,2) NOT NULL,
  `VR_venda` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`id_produto`),
  UNIQUE INDEX `Nr_serie_UNIQUE` (`Nr_serie` ASC)
  );
  
  DESC tb_cliente;
  
  DESC tb_produtos;
      
  CREATE TABLE `loja`.`tb_cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nm_cliente` VARCHAR(145) NOT NULL,
  `nu_CPF` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `nu_CPF_UNIQUE` (`nu_CPF` ASC)
  );
  
  CREATE TABLE TB_endereco (
  id_endereco INT primary key not null auto_increment,
  DE_endereco VARCHAR(256) NOT NULL,
  NU_endereco INT(5),
  DE_bairro VARCHAR(100) NOT NULL,
  DE_cidade VARCHAR(100) NOT NULL,
  uf VARCHAR(2) NOT NULL,
  NU_CEP VARCHAR(9)
  );
  
  DESC tb_endereco;
  
  ALTER TABLE tb_endereco
ADD CONSTRAINT fk_id_cliente FOREIGN KEY (cliente_id)
REFERENCES tb_cliente (id_cliente);


ALTER TABLE `loja`.`tb_cliente` 
ADD COLUMN `id_endereco_cliente` INT NOT NULL AFTER `nu_CPF`,
ADD INDEX `fk_endereco_idx` (`id_endereco_cliente` ASC);
;
ALTER TABLE `loja`.`tb_cliente` 
ADD CONSTRAINT `fk_endereco`
  FOREIGN KEY (`id_endereco_cliente`)
  REFERENCES `loja`.`tb_endereco` (`id_endereco`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;