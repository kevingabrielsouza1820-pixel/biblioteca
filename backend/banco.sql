-- DROP DATABASE IF EXISTS biblioteca;
-- CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

-- CRIAÇÃO DAS TABELAS

-- 1. USUARIOS
-- CREATE TABLE IF NOT EXISTS usuario (
--     id_usuario INT AUTO_INCREMENT PRIMARY KEY,
--     nome_usuario VARCHAR(500) NOT NULL,
--     email_usuario VARCHAR(500) NOT NULL UNIQUE,
--     senha_usuario VARCHAR(255) NOT NULL,
--     status_usuario BOOLEAN NOT NULL DEFAULT TRUE,
--     data_cadastro_usuario DATE NOT NULL,
--     cargo_admin BOOLEAN NOT NULL DEFAULT FALSE
-- );

-- -- 3. LIVROS
-- CREATE TABLE IF NOT EXISTS livro (
--     id_livro INT AUTO_INCREMENT PRIMARY KEY,
--     nivel_dano_livro INT,
--     sinopse_livro VARCHAR(500) NOT NULL,
--     titulo_livro VARCHAR(255) NOT NULL,
--     autor_livro VARCHAR(255) NOT NULL,
--     data_publicacao DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     localizacao_livro VARCHAR(255) NOT NULL,
--     categoria_livro INT NOT NULL,
--     status_livro BOOLEAN NOT NULL DEFAULT TRUE,
--     id_cadastrador INT,

--     CONSTRAINT chk_dano_livro
--         CHECK (nivel_dano_livro IN (1, 2, 3)),

--     FOREIGN KEY (id_cadastrador)
--         REFERENCES usuario(id_usuario)
-- );


-- -- 4. RETIRADAS
-- CREATE TABLE IF NOT EXISTS retirada (
--     id_retirada INT AUTO_INCREMENT PRIMARY KEY,
--     data_retirada DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     data_limite_retirada DATE NOT NULL,
--     id_cliete INT NOT NULL,
--     id_permitidor INT NOT NULL,
--     id_livro INT NOT NULL,

--     FOREIGN KEY (id_cliete)
--         REFERENCES usuario(id_usuario),

--     FOREIGN KEY (id_permitidor)
--         REFERENCES usuario(id_usuario),

--     FOREIGN KEY (id_livro)
--         REFERENCES livro(id_livro)
-- );


-- -- 5. DOACOES
-- CREATE TABLE IF NOT EXISTS doacao (
--     id_doacao INT AUTO_INCREMENT PRIMARY KEY,
--     data_doacao DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     id_livro INT,
--     id_doador INT,
--     id_checador INT,

--     FOREIGN KEY (id_doador)
--         REFERENCES usuario(id_usuario),

--     FOREIGN KEY (id_livro)
--         REFERENCES livro(id_livro),

--     FOREIGN KEY (id_checador)
--         REFERENCES usuario(id_usuario)
-- );


-- 6. DEVOLUCOES
-- CREATE TABLE IF NOT EXISTS devolucao (
--     id_devolucao INT AUTO_INCREMENT PRIMARY KEY,
--     dano_devolucao ENUM("1", "2", "3"),
--     data_devolucao DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     multas_devolucao DECIMAL(10,2) NOT NULL DEFAULT 0.00,
--     id_retirada INT NOT NULL UNIQUE,
--     id_funcionario INT NOT NULL,
--     id_cliente INT NOT NULL,
    
--     -- CONSTRAINT chk_dano_devolucao
--     -- CHECK (dano_devolucao_devolucao IN (1, 2, 3)),

--     FOREIGN KEY (id_cliente)
--         REFERENCES usuario(id_usuario),

--     FOREIGN KEY (id_funcionario)
--         REFERENCES usuario(id_usuario),

--     FOREIGN KEY (id_retirada)
--         REFERENCES retirada(id_retirada)
-- );

-- -- CRAIÇÃO DAS VIEWS 

-- CREATE VIEW vw_historico AS
-- SELECT
--     u.nome_usuario,
--     r.data_retirada,
--     l.titulo_livro
-- FROM usuario u
-- INNER JOIN retirada r ON u.id_usuario = r.id_usuario
-- INNER JOIN livro l ON r.id_livro = l.id_livro;

-- SELECT * FROM vw_historico;


-- CREATE VIEW vw_historico_doacao AS
-- SELECT
--     d.data_doacao,
--     l.titulo_livro,
--     l.categoria_livro
-- FROM doacao d
-- INNER JOIN livro l ON d.id_livro = l.id_livro;

-- SELECT * FROM vw_historico_doacao;


-- CREATE VIEW vw_autorizacao AS
-- SELECT
--     u.nome_usuario,
--     d.data_doacao,
--     dev.dano_devolucao,
--     l.titulo_livro
-- FROM usuario u
-- INNER JOIN doacao d ON u.id_usuario = d.id_usuario
-- INNER JOIN devolucao dev ON u.id_usuario = dev.id_usuario
-- INNER JOIN livro l ON dev.id_livro = l.id_livro;

-- SELECT * FROM vw_autorizacao;


-- CREATE ROLE IF NOT EXISTS 'usuarios';
-- GRANT USAGE ON biblioteca.usuario TO 'usuarios';
-- GRANT USAGE ON biblioteca.livro TO 'usuarios';
-- GRANT SELECT ON biblioteca.usuario TO 'usuarios';
-- GRANT SELECT ON biblioteca.livro TO 'usuarios';
-- GRANT SELECT ON biblioteca.vw_histotico TO 'usuarios';


-- CREATE USER IF NOT EXISTS 'usuario'@'%' IDENTIFIED BY 'user1';
-- GRANT 'usuarios' TO 'usuario'@'%';
-- SET DEFAULT ROLE usuarios FOR 'usuario'@'%';

-- -- CRIAÇÃO DE USUARIO PARA TESTE

-- INSERT INTO usuario (nome_usuario, email_usuario, senha_usuario) value
-- ("ze_teste1", "ze_teste1@gmail.com", "123456ab"),
-- ("ze_teste2", "ze_teste2@gmail.com", "123456ab"),
-- ("ze_teste3", "ze_teste3@gmail.com", "123456ab"),
-- ("ze_teste4", "ze_teste4@gmail.com", "123456ab"),
-- ("ze_teste9", "ze_teste5@gmail.com", "123456ab"),
-- ("ze_teste5", "ze_teste6@gmail.com", "123456ab"),
-- ("ze_teste6", "ze_teste7@gmail.com", "123456ab"),
-- ("ze_teste7", "ze_teste8@gmail.com", "123456ab"),
-- ("ze_teste8", "ze_teste9@gmail.com", "123456ab"),
-- ("ze_teste10", "ze_teste10@gmail.com", "123456ab");

-- INSERT INTO usuario (nome_usuario, email_usuario, senha_usuario, cargo_admin) value
-- ("func11", "func11@gmail.com", "funcab12", TRUE),
-- ("func12", "func12@gmail.com", "funccd12", TRUE),
-- ("func13", "func13@gmail.com", "funcef12", TRUE),
-- ("func14", "func14@gmail.com", "funcgh12", TRUE),
-- ("func15", "func15@gmail.com", "funcij12", TRUE),
-- ("func16", "func16@gmail.com", "funckl12", TRUE),
-- ("func17", "func17@gmail.com", "funcmn12", TRUE),
-- ("func18", "func18@gmail.com", "funcop12", TRUE),
-- ("func19", "func19@gmail.com", "funcrs12", TRUE),
-- ("func20", "func20@gmail.com", "funcwy10", TRUE);

-- INSERT INTO livro (status_livro, nivel_dano_livro, sinopse_livro, titulo_livro, autor_livro, localizacao_livro, categoria_livro) value
-- (TRUE, 1, "Exemplo do livro1", "Nome_do_livro1", "alguem1", "Na_prateleira_1", 1),
-- (TRUE, 1, "Exemplo do livro2", "Nome_do_livro2", "alguem2", "Na_prateleira_2", 1),
-- (TRUE, 2, "Exemplo do livro3", "Nome_do_livro3", "alguem3", "Na_prateleira_3", 1),
-- (TRUE, 2, "Exemplo do livro4", "Nome_do_livro4", "alguem4", "Na_prateleira_4", 1),
-- (TRUE, 2, "Exemplo do livro5", "Nome_do_livro5", "alguem5", "Na_prateleira_5", 1),
-- (TRUE, 3, "Exemplo do livro6", "Nome_do_livro6", "alguem6", "Na_prateleira_6", 1),
-- (TRUE, 3, "Exemplo do livro7", "Nome_do_livro7", "alguem7", "Na_prateleira_7", 1),
-- (TRUE, 3, "Exemplo do livro8", "Nome_do_livro8", "alguem8", "Na_prateleira_8", 1),
-- (TRUE, 1, "Exemplo do livro9", "Nome_do_livro9", "alguem9", "Na_prateleira_9", 1),
-- (TRUE, 2, "Exemplo do livro10", "Nome_do_livro10", "alguem10", "Na_prateleira_10", 1);


-- INSERT INTO doacao(id_livro, id_doador, id_checador) value
-- (1, 1, 11),
-- (2, 2, 12),
-- (3, 3, 13),
-- (4, 4, 14),
-- (5, 5, 15),
-- (6, 6, 16),
-- (7, 7, 17),
-- (8, 8, 18),
-- (9, 9, 19),
-- (10, 10, 20);

-- INSERT INTO retirada (data_limite_retirada, id_cliete, id_permitidor, id_livro) value
-- (DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY), 1, 11, 1),
-- (DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY), 2, 12, 2),
-- (DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY), 3, 13, 3),
-- (DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY), 4, 14, 4),
-- (DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY), 5, 15, 5),
-- (DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY), 6, 16, 6),
-- (DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY), 7, 17, 7),
-- (DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY), 8, 18, 8),
-- (DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY), 9, 19, 9),
-- (DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY), 10, 20, 10);

-- INSERT INTO devolucao (dano_devolucao, id_retirada, id_funcionario, id_cliente) value
-- (1, 1, 11, 1) ,
-- (1, 2, 12, 2) ,
-- (1, 3, 13, 3) ,
-- (1, 4, 14, 4) ,
-- (1, 5, 15, 5) ,
-- (1, 6, 16, 6) ,
-- (1, 7, 17, 7) ,
-- (1, 8, 18, 8) ,
-- (1, 9, 19, 9) ,
-- (1, 10, 20, 10);



-- -- criar 10 usuario, usuario, livro e para cada livro uma doação.