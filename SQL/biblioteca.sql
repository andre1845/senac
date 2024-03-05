CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE tb_nacionalidade (
id_nacionalidade INT NOT NULL AUTO_INCREMENT,
nacionalidade VARCHAR(100) NOT NULL,
PRIMARY KEY (id_nacionalidade)
);

CREATE TABLE tb_categoria (
id_categoria INT NOT NULL AUTO_INCREMENT,
categoria VARCHAR(100),
PRIMARY KEY (id_categoria)
);

CREATE TABLE tb_leitor (
id_leitor INT NOT NULL AUTO_INCREMENT,
nome_leitor VARCHAR(200) NOT NULL,
rg_leitor VARCHAR(20) NOT NULL,
PRIMARY KEY (id_leitor)
);

CREATE TABLE tb_autor (
id_autor INT NOT NULL AUTO_INCREMENT,
nome_autor VARCHAR(200) NOT NULL,
fk_id_nacionalidade INT NOT NULL,
PRIMARY KEY (id_autor),
FOREIGN KEY (fk_id_nacionalidade) REFERENCES tb_nacionalidade (id_nacionalidade)
);

CREATE TABLE tb_livro (
id_livro INT NOT NULL AUTO_INCREMENT,
titulo VARCHAR(200),
fk_id_categoria INT NOT NULL,
data_publicacao DATE,
ISBN VARCHAR(40),
fk_id_autor INT,
PRIMARY KEY (id_livro),
FOREIGN KEY (fk_id_autor) REFERENCES tb_autor (id_autor),
FOREIGN KEY (fk_id_categoria) REFERENCES tb_categoria (id_categoria)
);

CREATE TABLE tb_emprestimo (
id_emprestimo INT NOT NULL AUTO_INCREMENT,
data_emprestimo DATE NOT NULL,
data_devolucao DATE,
fk_id_leitor INT,
fk_id_livro INT,
PRIMARY KEY (id_emprestimo),
FOREIGN KEY (fk_id_leitor) REFERENCES tb_leitor (id_leitor),
FOREIGN KEY (fk_id_livro) REFERENCES tb_livro (id_livro)
);





