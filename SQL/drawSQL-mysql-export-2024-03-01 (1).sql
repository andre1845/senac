CREATE TABLE `tb_autor`(
    `id_autor` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome_autor` BIGINT NOT NULL,
    `fk_id_nacionalidade` BIGINT NOT NULL
);
CREATE TABLE `tb_livro`(
    `id_livro` BIGINT NOT NULL,
    `titulo` VARCHAR(255) NOT NULL,
    `fk_id_categoria` BIGINT NOT NULL,
    `data_publicacao` DATE NOT NULL,
    `ISBN` VARCHAR(255) NOT NULL,
    `fk_id_autor` BIGINT NOT NULL,
    PRIMARY KEY(`id_livro`)
);
CREATE TABLE `tb_leitor`(
    `id_leitor` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome_leitor` VARCHAR(255) NOT NULL,
    `rg_leitor` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `tb_leitor` ADD INDEX `tb_leitor_rg_leitor_index`(`rg_leitor`);
CREATE TABLE `tb_nacionalidade`(
    `id_nac` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nacionalidade` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `tb_nacionalidade` ADD INDEX `tb_nacionalidade_nacionalidade_index`(`nacionalidade`);
CREATE TABLE `tb_categoria`(
    `id_categoria` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `categoria` VARCHAR(255) NOT NULL
);
CREATE TABLE `tb_emprestimo`(
    `id_emprestimo` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `data_emprestimo` DATE NOT NULL,
    `data_devolucao` DATE NOT NULL,
    `fk_id_leitor` BIGINT NOT NULL,
    `fk_id_livro` BIGINT NOT NULL
);
ALTER TABLE
    `tb_autor` ADD CONSTRAINT `tb_autor_fk_id_nacionalidade_foreign` FOREIGN KEY(`fk_id_nacionalidade`) REFERENCES `tb_nacionalidade`(`id_nac`);
ALTER TABLE
    `tb_emprestimo` ADD CONSTRAINT `tb_emprestimo_fk_id_livro_foreign` FOREIGN KEY(`fk_id_livro`) REFERENCES `tb_livro`(`id_livro`);
ALTER TABLE
    `tb_emprestimo` ADD CONSTRAINT `tb_emprestimo_fk_id_leitor_foreign` FOREIGN KEY(`fk_id_leitor`) REFERENCES `tb_leitor`(`id_leitor`);
ALTER TABLE
    `tb_livro` ADD CONSTRAINT `tb_livro_fk_id_autor_foreign` FOREIGN KEY(`fk_id_autor`) REFERENCES `tb_autor`(`id_autor`);
ALTER TABLE
    `tb_livro` ADD CONSTRAINT `tb_livro_fk_id_categoria_foreign` FOREIGN KEY(`fk_id_categoria`) REFERENCES `tb_categoria`(`id_categoria`);