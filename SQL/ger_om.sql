CREATE TABLE `arma`(
    `id_arma` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `arma_nome` VARCHAR(50) NOT NULL
);
CREATE TABLE `funcao_militar`(
    `id_funcao_militar` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `funcao_militar` VARCHAR(50) NOT NULL,
    `fk_id_militar_func` INT NOT NULL
);
CREATE TABLE `militar`(
    `id_militar` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome_completo` VARCHAR(255) NOT NULL,
    `nome_guerra` VARCHAR(100) NOT NULL,
    `numero` VARCHAR(6) NOT NULL,
    `fk_id_posto_grad` INT NOT NULL,
    `fk_id_arma` INT NOT NULL,
    `tu_formacao` INT NOT NULL,
    `fk_id_escola_formacao` INT NOT NULL,
    `fk_id_sit_militar` INT NOT NULL,
    `fk_id_sit_servico` INT NOT NULL,
    `cpf` VARCHAR(15) NOT NULL,
    `idt_mil` VARCHAR(20) NOT NULL,
    `data_apresentacao` DATE NOT NULL,
    `data_desligamento` DATE NOT NULL
);
CREATE TABLE `posto_grad`(
    `id_posto_grad` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `posto_grad` VARCHAR(10) NOT NULL,
    `posto_grad_extenso` VARCHAR(30) NOT NULL
);
CREATE TABLE `situacao_servico`(
    `id_sit_serv` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `sit_servico` VARCHAR(40) NOT NULL
);
CREATE TABLE `cautelas`(
    `id_cautela` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `fk_id_mat_carga` INT NOT NULL,
    `qtde_cautela` INT NOT NULL,
    `fk_id_militar` INT NOT NULL,
    `data_retirada` DATE NOT NULL,
    `data_devolucao` DATE NOT NULL,
    `fk_id_responsavel` INT NOT NULL
);
CREATE TABLE `material_carga`(
    `id_mat_carga` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome_mat` VARCHAR(100) NOT NULL,
    `descricao_mat` TEXT NOT NULL,
    `qtde_carga` INT NOT NULL,
    `situacao_mat` VARCHAR(30) NOT NULL
);
ALTER TABLE
    `funcao_militar` ADD CONSTRAINT `funcao_militar_fk_id_militar_func_foreign` FOREIGN KEY(`fk_id_militar_func`) REFERENCES `militar`(`id_militar`);
ALTER TABLE
    `cautelas` ADD CONSTRAINT `cautelas_fk_id_mat_carga_foreign` FOREIGN KEY(`fk_id_mat_carga`) REFERENCES `material_carga`(`id_mat_carga`);
ALTER TABLE
    `militar` ADD CONSTRAINT `militar_fk_id_sit_servico_foreign` FOREIGN KEY(`fk_id_sit_servico`) REFERENCES `situacao_servico`(`id_sit_serv`);
ALTER TABLE
    `militar` ADD CONSTRAINT `militar_fk_id_posto_grad_foreign` FOREIGN KEY(`fk_id_posto_grad`) REFERENCES `posto_grad`(`id_posto_grad`);
ALTER TABLE
    `militar` ADD CONSTRAINT `militar_fk_id_arma_foreign` FOREIGN KEY(`fk_id_arma`) REFERENCES `arma`(`id_arma`);
ALTER TABLE
    `cautelas` ADD CONSTRAINT `cautelas_fk_id_militar_foreign` FOREIGN KEY(`fk_id_militar`) REFERENCES `militar`(`id_militar`);