CREATE TABLE cidade (
    cid_id SERIAL PRIMARY KEY,
    cid_nome VARCHAR(200),
    cid_uf CHAR(2)
);

CREATE TABLE endereco (
    end_id SERIAL PRIMARY KEY,
    end_tipo_logradouro VARCHAR(50),
    end_logradouro VARCHAR(200),
    end_numero INT,
    end_bairro VARCHAR(100),
    cid_id INT,
    FOREIGN KEY (cid_id) REFERENCES cidade(cid_id)
);

CREATE TABLE pessoa (
    pes_id SERIAL PRIMARY KEY,
    pes_nome VARCHAR(200),
    pes_data_nascimento DATE,
    pes_sexo VARCHAR(9),
    pes_mae VARCHAR(200),
    pes_pai VARCHAR(200)
);

CREATE TABLE unidade (
    unid_id SERIAL PRIMARY KEY,
    unid_nome VARCHAR(200),
    unid_sigla VARCHAR(20)
);

CREATE TABLE pessoa_endereco (
    pes_id INT,
    end_id INT,
    PRIMARY KEY (pes_id, end_id),
    FOREIGN KEY (pes_id) REFERENCES pessoa(pes_id),
    FOREIGN KEY (end_id) REFERENCES endereco(end_id)
);

CREATE TABLE servidor_temporario (
    pes_id INT PRIMARY KEY,
    st_data_admissao DATE,
    st_data_demissao DATE,
    FOREIGN KEY (pes_id) REFERENCES pessoa(pes_id)
);

CREATE TABLE servidor_efetivo (
    pes_id INT PRIMARY KEY,
    se_matricula VARCHAR(20),
    FOREIGN KEY (pes_id) REFERENCES pessoa(pes_id)
);

CREATE TABLE lotacao (
    lot_id SERIAL PRIMARY KEY,
    pes_id INT,
    unid_id INT,
    lot_data_lotacao DATE,
    lot_data_remocao DATE,
    lot_portaria VARCHAR(100),
    FOREIGN KEY (pes_id) REFERENCES pessoa(pes_id),
    FOREIGN KEY (unid_id) REFERENCES unidade(unid_id)
);

CREATE TABLE unidade_endereco (
    unid_id INT,
    end_id INT,
    PRIMARY KEY (unid_id, end_id),
    FOREIGN KEY (unid_id) REFERENCES unidade(unid_id),
    FOREIGN KEY (end_id) REFERENCES endereco(end_id)
);

CREATE TABLE foto_pessoa (
    fp_id SERIAL PRIMARY KEY,
    pes_id INT,
    fp_data DATE,
    fp_bucket VARCHAR(50),
    fp_hash VARCHAR(50),
    FOREIGN KEY (pes_id) REFERENCES pessoa(pes_id)
);


ALTER TABLE foto_pessoa ALTER COLUMN fp_hash TYPE varchar(255);

INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (1, 'Nunes', 'PA');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (2, 'Campos', 'TO');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (3, 'Oliveira', 'ES');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (4, 'Costa', 'SE');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (5, 'Teixeira de Melo', 'SC');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (6, 'Sales', 'RN');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (7, 'Dias', 'MS');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (8, 'Moura de Oliveira', 'MT');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (9, 'Peixoto Verde', 'PE');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (10, 'Souza', 'MG');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (11, 'Silva Alegre', 'MS');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (12, 'Ferreira do Sul', 'SC');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (13, 'Novaes', 'MT');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (14, 'Novaes do Amparo', 'PE');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (15, 'Costa', 'SE');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (16, 'Correia', 'ES');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (17, 'Aragão', 'SP');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (18, 'Lima Verde', 'PI');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (19, 'Correia', 'SE');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (20, 'Sales Grande', 'AL');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (21, 'Moraes', 'AC');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (22, 'Costela', 'MS');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (23, 'Nogueira', 'BA');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (24, 'Ferreira Paulista', 'AL');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (25, 'Farias dos Dourados', 'TO');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (26, 'Moraes do Galho', 'DF');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (27, 'Carvalho do Campo', 'CE');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (28, 'Nogueira', 'BA');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (29, 'Pinto do Sul', 'RR');
INSERT INTO cidade (cid_id, cid_nome, cid_uf) VALUES (30, 'Correia da Serra', 'GO');
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (1, 'Rua', 'Vale de Farias', '25', 'Pantanal', 21);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (2, 'Rua', 'Condomínio Almeida', '236', 'Flavio Marques Lisboa', 4);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (3, 'Rua', 'Trevo de Rocha', '9', 'Vila Madre Gertrudes 3ª Seção', 1);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (4, 'Rua', 'Rodovia de Cardoso', '89', 'Horto Florestal', 24);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (5, 'Rua', 'Ladeira das Neves', '56', 'Vila Atila De Paiva', 9);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (6, 'Rua', 'Avenida de Pereira', '6', 'São Jorge 3ª Seção', 8);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (7, 'Rua', 'Fazenda Gomes', '47', 'Vila Bandeirantes', 8);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (8, 'Rua', 'Colônia Pedro Miguel Silveira', '22', 'Vila Nova Cachoeirinha 1ª Seção', 5);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (9, 'Rua', 'Fazenda de Souza', '4', 'Vila São Francisco', 24);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (10, 'Rua', 'Esplanada de Farias', '6', 'São Vicente', 4);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (11, 'Rua', 'Travessa de Aragão', '793', 'Conjunto Califórnia I', 22);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (12, 'Rua', 'Vereda Monteiro', '995', 'Fernão Dias', 24);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (13, 'Rua', 'Condomínio de Vieira', '14', 'Bela Vitoria', 29);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (14, 'Rua', 'Trevo Melo', '9', 'Vila Jardim Leblon', 18);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (15, 'Rua', 'Distrito Rodrigues', '90', 'Cardoso', 3);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (16, 'Rua', 'Chácara Nunes', '60', 'Pindura Saia', 19);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (17, 'Rua', 'Pátio de Moura', '83', 'Bernadete', 14);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (18, 'Rua', 'Parque Joaquim Cardoso', '54', 'Cidade Jardim Taquaril', 2);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (19, 'Rua', 'Núcleo Novaes', '82', 'Prado', 1);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (20, 'Rua', 'Núcleo de da Costa', '982', 'Vila Santa Rosa', 3);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (21, 'Rua', 'Colônia Alícia Moreira', '53', 'Alta Tensão 1ª Seção', 7);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (22, 'Rua', 'Jardim Nunes', '889', 'Cabana Do Pai Tomás', 8);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (23, 'Rua', 'Avenida Moraes', '42', 'Tupi A', 17);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (24, 'Rua', 'Praia Cunha', '52', 'Vila Ipiranga', 20);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (25, 'Rua', 'Praia Levi Azevedo', '24', 'Penha', 1);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (26, 'Rua', 'Residencial de Fernandes', '55', 'Jardim Felicidade', 18);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (27, 'Rua', 'Travessa Lucas Novaes', '92', 'Barro Preto', 7);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (28, 'Rua', 'Condomínio Novaes', '9', 'São Marcos', 23);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (29, 'Rua', 'Condomínio Mendes', '693', 'Vila Mantiqueira', 21);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (30, 'Rua', 'Distrito Natália das Neves', '30', 'Camargos', 23);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (31, 'Rua', 'Residencial Ramos', '3', 'Minas Caixa', 18);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (32, 'Rua', 'Rua Davi Rocha', '913', 'Penha', 14);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (33, 'Rua', 'Vila Barbosa', '17', 'Delta', 8);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (34, 'Rua', 'Largo Carvalho', '9', 'Vila São Rafael', 15);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (35, 'Rua', 'Campo Marina Carvalho', '68', 'Marilandia', 19);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (36, 'Rua', 'Praia Theo da Rocha', '7', 'Xangri-Lá', 9);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (37, 'Rua', 'Morro de Moura', '53', 'Flavio Marques Lisboa', 26);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (38, 'Rua', 'Recanto de Viana', '12', 'Vila Trinta E Um De Março', 28);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (39, 'Rua', 'Campo de Melo', '63', 'Cachoeirinha', 1);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (40, 'Rua', 'Vila da Luz', '72', 'Jardim Dos Comerciarios', 25);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (41, 'Rua', 'Distrito Ana Beatriz Costa', '34', 'Vila Da Paz', 26);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (42, 'Rua', 'Passarela Luiz Gustavo da Luz', '79', 'Conjunto Capitão Eduardo', 6);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (43, 'Rua', 'Ladeira João Pedro Gomes', '164', 'Camponesa 1ª Seção', 23);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (44, 'Rua', 'Avenida Campos', '948', 'Serra Do Curral', 14);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (45, 'Rua', 'Morro Barbosa', '98', 'Caetano Furquim', 11);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (46, 'Rua', 'Avenida da Conceição', '1', 'Dom Bosco', 9);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (47, 'Rua', 'Recanto de Gomes', '2', 'Dom Cabral', 5);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (48, 'Rua', 'Aeroporto João Guilherme Carvalho', '9', 'Vila Bandeirantes', 7);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (49, 'Rua', 'Rodovia Sabrina da Paz', '623', 'Ribeiro De Abreu', 25);
INSERT INTO endereco (end_id, end_tipo_logradouro, end_logradouro, end_numero, end_bairro, cid_id) VALUES (50, 'Rua', 'Passarela Ana Carolina Pereira', '37', 'Vila Dos Anjos', 11);
INSERT INTO unidade (unid_id, unid_nome, unid_sigla) VALUES (1, 'Santos', 'COV');
INSERT INTO unidade (unid_id, unid_nome, unid_sigla) VALUES (2, 'Lopes', 'CSG');
INSERT INTO unidade (unid_id, unid_nome, unid_sigla) VALUES (3, 'Nogueira', 'LCS');
INSERT INTO unidade (unid_id, unid_nome, unid_sigla) VALUES (4, 'Lima e Filhos', 'CVV');
INSERT INTO unidade (unid_id, unid_nome, unid_sigla) VALUES (5, 'Campos', 'BYK');
INSERT INTO unidade (unid_id, unid_nome, unid_sigla) VALUES (6, 'Alves', 'HBX');
INSERT INTO unidade (unid_id, unid_nome, unid_sigla) VALUES (7, 'Lopes Fogaça - EI', 'YAJ');
INSERT INTO unidade (unid_id, unid_nome, unid_sigla) VALUES (8, 'Sales', 'KTY');
INSERT INTO unidade (unid_id, unid_nome, unid_sigla) VALUES (9, 'da Rocha Farias Ltda.', 'GQD');
INSERT INTO unidade (unid_id, unid_nome, unid_sigla) VALUES (10, 'das Neves', 'MGU');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (1, 'Murilo Rezende', '1962-06-27', 'Masculino', 'Lara Nunes', 'Dr. Matheus da Mata');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (2, 'Bianca Moreira', '1960-03-01', 'Masculino', 'Sra. Maria Eduarda Farias', 'Raul Fogaça');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (3, 'Eloah Mendes', '1962-12-18', 'Feminino', 'Maria Cecília da Mota', 'Gustavo Henrique Campos');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (4, 'Laura Silveira', '1961-04-20', 'Masculino', 'Isis Cavalcanti', 'Cauã Aragão');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (5, 'Sophia Gonçalves', '1984-01-23', 'Feminino', 'Emanuella Gonçalves', 'Davi Ramos');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (6, 'Sra. Emanuelly Araújo', '1973-12-02', 'Feminino', 'Daniela Correia', 'Davi Melo');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (7, 'Sra. Maria Eduarda Lima', '1961-07-25', 'Feminino', 'Eloah Rezende', 'Leandro Silva');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (8, 'Srta. Alícia Moura', '2002-08-21', 'Masculino', 'Carolina da Costa', 'Yago Caldeira');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (9, 'Enzo da Paz', '1987-01-06', 'Feminino', 'Srta. Nicole Martins', 'Leandro Lima');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (10, 'Bruno Melo', '1999-02-09', 'Masculino', 'Emanuella Lopes', 'Dr. Bryan Moura');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (11, 'Giovanna da Mata', '2005-07-28', 'Feminino', 'Esther Souza', 'Benjamin Nascimento');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (12, 'Breno Melo', '1983-01-12', 'Masculino', 'Larissa Ramos', 'João Miguel Cavalcanti');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (13, 'Thomas Duarte', '1980-08-17', 'Feminino', 'Yasmin Cardoso', 'Ryan Lopes');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (14, 'Noah Barbosa', '1983-08-12', 'Feminino', 'Ana Clara da Cruz', 'Theo Teixeira');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (15, 'Heitor da Cruz', '1996-04-13', 'Masculino', 'Evelyn Cavalcanti', 'Vitor Hugo Barbosa');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (16, 'Elisa Fernandes', '1978-07-01', 'Masculino', 'Ana Julia das Neves', 'Daniel Aragão');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (17, 'Vinicius da Rocha', '1997-11-08', 'Masculino', 'Srta. Eloah Monteiro', 'Murilo Gonçalves');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (18, 'Joana da Paz', '1975-12-17', 'Masculino', 'Helena Rodrigues', 'Guilherme Barbosa');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (19, 'Olivia Pires', '1983-08-23', 'Feminino', 'Isabel Vieira', 'Sr. Noah da Mata');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (20, 'Dr. Antônio Moreira', '1996-09-03', 'Masculino', 'Letícia Pinto', 'Ryan Nogueira');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (21, 'Sr. Carlos Eduardo Moura', '1959-11-18', 'Masculino', 'Maria Fernanda Rezende', 'Marcelo Correia');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (22, 'Maria Julia da Cruz', '1964-12-13', 'Masculino', 'Caroline Pinto', 'Lucas Fernandes');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (23, 'Ana Laura Silva', '1984-06-14', 'Feminino', 'Melissa Gonçalves', 'Sr. Felipe Ribeiro');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (24, 'Vitor Campos', '1966-10-09', 'Feminino', 'Dra. Ana Julia Mendes', 'Thales Ramos');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (25, 'Sophia da Mata', '1990-07-28', 'Feminino', 'Isabella Silveira', 'Yuri Santos');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (26, 'Emanuelly Ribeiro', '1987-09-03', 'Feminino', 'Alice Silveira', 'Dr. Diogo Caldeira');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (27, 'Sofia Costela', '1960-04-24', 'Masculino', 'Rebeca Rocha', 'Danilo Cardoso');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (28, 'Sr. Gustavo Henrique Araújo', '1966-04-16', 'Feminino', 'Ana Laura Moraes', 'Davi Rodrigues');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (29, 'Sra. Ana Martins', '1987-02-20', 'Feminino', 'Sra. Mariane Cardoso', 'Vitor Hugo Rezende');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (30, 'Luiz Otávio Campos', '2006-08-12', 'Masculino', 'Alexia Moura', 'Raul Silveira');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (31, 'Catarina Almeida', '1975-12-08', 'Feminino', 'Valentina Fernandes', 'Dr. Antônio Azevedo');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (32, 'Mariana Lopes', '1994-09-07', 'Masculino', 'Ana Carolina Fernandes', 'Luiz Fernando Viana');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (33, 'Samuel Alves', '1977-06-09', 'Masculino', 'Nicole Rodrigues', 'Isaac da Costa');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (34, 'Dra. Ana Luiza Pereira', '2004-08-20', 'Masculino', 'Luna Dias', 'Dr. Davi Lucca Alves');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (35, 'Bruna Moura', '1982-08-01', 'Masculino', 'Sophia Pires', 'Francisco Rodrigues');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (36, 'Bruna Oliveira', '1972-03-26', 'Feminino', 'Dra. Catarina Azevedo', 'Luiz Felipe da Cunha');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (37, 'Renan Azevedo', '1991-04-11', 'Feminino', 'Srta. Melissa Pires', 'Francisco Caldeira');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (38, 'Cecília Gonçalves', '2005-10-03', 'Feminino', 'Camila Pinto', 'Luiz Fernando da Mota');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (39, 'Dr. Otávio Santos', '1973-05-08', 'Masculino', 'Rafaela Rodrigues', 'Breno Monteiro');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (40, 'Stephany Campos', '1973-01-15', 'Feminino', 'Olivia Carvalho', 'Pedro Mendes');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (41, 'Heloísa Souza', '1983-03-10', 'Masculino', 'Sofia Ferreira', 'Sr. Davi Jesus');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (42, 'Sophia Dias', '1961-02-19', 'Masculino', 'Alana Silva', 'Breno Moraes');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (43, 'Davi Lucca Santos', '2006-12-22', 'Masculino', 'Yasmin Viana', 'Raul Pinto');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (44, 'Laura Sales', '2004-11-26', 'Feminino', 'Marina Carvalho', 'Levi da Rosa');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (45, 'Murilo Gonçalves', '2005-10-22', 'Feminino', 'Stella Cavalcanti', 'Dr. Bryan Silveira');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (46, 'Caroline Cardoso', '2006-02-10', 'Feminino', 'Maria Clara Moreira', 'Bruno Campos');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (47, 'Sr. Kaique Ribeiro', '1975-07-10', 'Masculino', 'Srta. Ana Vitória Ferreira', 'Paulo Moura');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (48, 'Ana Julia Lima', '1984-08-29', 'Masculino', 'Ana Beatriz Moreira', 'Dr. Anthony Sales');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (49, 'Srta. Gabriela Moreira', '1964-02-16', 'Feminino', 'Esther Ferreira', 'Sr. Vitor Hugo Costa');
INSERT INTO pessoa (pes_id, pes_nome, pes_data_nascimento, pes_sexo, pes_mae, pes_pai) VALUES (50, 'Maysa Alves', '2005-07-16', 'Masculino', 'Milena Campos', 'Vitor Gabriel Freitas');
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (1, 42);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (2, 32);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (3, 26);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (4, 42);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (5, 30);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (6, 10);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (7, 17);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (8, 9);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (9, 16);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (10, 48);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (11, 36);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (12, 35);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (13, 17);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (14, 48);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (15, 38);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (16, 28);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (17, 38);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (18, 26);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (19, 24);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (20, 15);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (21, 9);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (22, 33);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (23, 32);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (24, 6);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (25, 49);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (26, 4);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (27, 8);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (28, 10);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (29, 41);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (30, 11);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (31, 44);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (32, 28);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (33, 39);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (34, 5);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (35, 25);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (36, 25);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (37, 39);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (38, 30);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (39, 34);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (40, 17);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (41, 36);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (42, 1);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (43, 44);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (44, 47);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (45, 8);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (46, 44);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (47, 35);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (48, 49);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (49, 18);
INSERT INTO pessoa_endereco (pes_id, end_id) VALUES (50, 50);
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (1, 'bSHoZIeQ');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (2, 'hcxijBGM');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (3, 'DwlZGpWr');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (4, 'dKlLpUTe');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (5, 'HqRRRsUc');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (6, 'OLMscBPG');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (7, 'LwUCAAmR');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (8, 'xCNojcMv');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (9, 'vhMkpCrJ');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (10, 'PtJDccfp');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (11, 'qfesgkkQ');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (12, 'RifdQgIw');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (13, 'LFYfVTQP');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (14, 'xILqINGg');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (15, 'dpBglhWl');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (16, 'uCJRTVgC');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (17, 'ULAnApoo');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (18, 'rkeaqjtN');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (19, 'PfoKLJzv');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (20, 'otAcJXqo');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (21, 'RUaTnngh');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (22, 'AaPSUDwX');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (23, 'EKiKyUAx');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (24, 'HKsfUGYz');
INSERT INTO servidor_efetivo (pes_id, se_matricula) VALUES (25, 'GwbJsVPt');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (26, '2021-10-25', '2021-12-30');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (27, '2020-06-18', '2024-04-19');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (28, '2021-01-11', '2021-10-27');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (29, '2023-03-20', '2025-03-11');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (30, '2023-09-09', '2023-09-28');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (31, '2020-09-26', '2023-06-02');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (32, '2020-09-26', '2023-11-02');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (33, '2021-04-29', '2022-09-19');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (34, '2022-10-11', '2025-02-15');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (35, '2023-07-25', '2024-12-05');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (36, '2020-10-02', '2022-07-07');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (37, '2022-01-31', '2022-06-26');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (38, '2020-08-20', '2023-01-13');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (39, '2023-05-24', '2023-10-22');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (40, '2022-04-14', '2024-07-27');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (41, '2021-03-14', '2023-03-26');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (42, '2020-07-11', '2024-11-27');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (43, '2023-07-07', '2024-04-29');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (44, '2021-12-11', '2024-07-10');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (45, '2024-02-06', '2024-12-28');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (46, '2022-08-28', '2024-03-18');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (47, '2022-11-14', '2024-04-04');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (48, '2022-12-13', '2025-03-27');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (49, '2021-11-30', '2022-07-28');
INSERT INTO servidor_temporario (pes_id, st_data_admissao, st_data_demissao) VALUES (50, '2023-07-23', '2024-01-29');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (1, 1, 6, '2020-10-18', '2023-05-25', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (2, 2, 2, '2022-05-10', '2023-11-06', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (3, 3, 5, '2021-06-21', '2024-08-13', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (4, 4, 7, '2023-05-30', '2024-06-05', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (5, 5, 3, '2023-05-11', '2024-03-10', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (6, 6, 8, '2023-10-31', '2024-07-04', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (7, 7, 1, '2020-12-25', '2023-07-09', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (8, 8, 5, '2020-05-20', '2023-02-14', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (9, 9, 9, '2021-09-23', '2024-07-03', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (10, 10, 3, '2021-04-23', '2022-09-26', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (11, 11, 9, '2023-04-10', '2023-06-16', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (12, 12, 2, '2023-12-12', '2025-03-10', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (13, 13, 5, '2022-09-01', '2024-12-16', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (14, 14, 9, '2020-10-09', '2024-09-07', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (15, 15, 10, '2021-04-21', '2023-03-16', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (16, 16, 4, '2022-01-04', '2023-02-28', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (17, 17, 3, '2022-07-29', '2024-03-09', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (18, 18, 6, '2023-12-30', '2024-10-17', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (19, 19, 3, '2022-04-18', '2023-11-14', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (20, 20, 9, '2020-08-16', '2023-03-02', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (21, 21, 9, '2020-07-17', '2024-05-20', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (22, 22, 1, '2022-01-18', '2024-09-27', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (23, 23, 10, '2023-05-07', '2024-10-17', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (24, 24, 6, '2020-05-04', '2022-04-14', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (25, 25, 8, '2023-06-08', '2024-04-03', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (26, 26, 1, '2021-09-12', '2024-09-22', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (27, 27, 2, '2023-11-03', '2024-05-24', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (28, 28, 6, '2023-08-16', '2024-09-05', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (29, 29, 5, '2023-01-01', '2023-07-05', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (30, 30, 4, '2023-02-04', '2023-11-10', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (31, 31, 1, '2021-02-23', '2024-10-22', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (32, 32, 4, '2020-11-02', '2021-02-07', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (33, 33, 10, '2022-07-15', '2024-10-23', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (34, 34, 2, '2020-08-21', '2023-11-26', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (35, 35, 2, '2024-02-03', '2024-07-06', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (36, 36, 8, '2022-03-19', '2024-03-31', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (37, 37, 2, '2023-10-02', '2024-01-27', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (38, 38, 9, '2020-12-31', '2021-07-30', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (39, 39, 3, '2021-06-11', '2022-09-14', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (40, 40, 3, '2023-10-08', '2023-12-14', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (41, 41, 8, '2021-10-22', '2023-11-15', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (42, 42, 9, '2022-08-29', '2023-01-11', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (43, 43, 3, '2023-04-19', '2023-12-18', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (44, 44, 5, '2024-01-23', '2025-01-04', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (45, 45, 9, '2022-04-10', '2022-07-03', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (46, 46, 10, '2022-11-18', '2023-01-09', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (47, 47, 7, '2020-05-14', '2021-07-28', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (48, 48, 4, '2022-12-31', '2024-04-13', 'PORTARIA ####/202#');
INSERT INTO lotacao (lot_id, pes_id, unid_id, lot_data_lotacao, lot_data_remocao, lot_portaria) VALUES (49, 49, 9, '2023-05-11', '2025-02-20', 'PORTARIA ####/202#');
INSERT INTO unidade_endereco (unid_id, end_id) VALUES (1, 46);
INSERT INTO unidade_endereco (unid_id, end_id) VALUES (2, 20);
INSERT INTO unidade_endereco (unid_id, end_id) VALUES (3, 26);
INSERT INTO unidade_endereco (unid_id, end_id) VALUES (4, 43);
INSERT INTO unidade_endereco (unid_id, end_id) VALUES (5, 42);
INSERT INTO unidade_endereco (unid_id, end_id) VALUES (6, 24);
INSERT INTO unidade_endereco (unid_id, end_id) VALUES (7, 29);
INSERT INTO unidade_endereco (unid_id, end_id) VALUES (8, 34);
INSERT INTO unidade_endereco (unid_id, end_id) VALUES (9, 29);
INSERT INTO unidade_endereco (unid_id, end_id) VALUES (10, 8);
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (1, 1, '2025-01-04', 'fotos', '0d833f20be6a226fb2fce437ce5d6be27c5ac387');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (2, 2, '2023-05-08', 'fotos', '89e324f83b2590e76b5d201e1b73c76d1d0433c5');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (3, 3, '2025-02-11', 'fotos', '87639841caeeab8539b1da6aad1b534b236125d4');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (4, 4, '2025-02-14', 'fotos', '8defaaaa562bf01a7ba89f29f28747862ea5cd03');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (5, 5, '2023-09-03', 'fotos', '1107f81aa7c2b4e61bd381eb27e72904fe6f1feb');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (6, 6, '2024-03-26', 'fotos', '423c1e56736051c23e14a1ee185ed7092d0003bc');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (7, 7, '2024-01-26', 'fotos', '545dc7d7d7c74bd68b14d625bc88eb29ca9226a6');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (8, 8, '2024-04-13', 'fotos', 'e4aee01decde9c3921e39c1d5248ad310f2786fc');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (9, 9, '2024-05-07', 'fotos', '29feab1c1e305f9f30daecc1d4ce160030504eaf');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (10, 10, '2023-09-21', 'fotos', '2395b91d5bab41121ac00ac6cc597f293a25cc3d');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (11, 11, '2025-01-21', 'fotos', '42346354c738edc827aeec1252d9da6e9f05a3ff');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (12, 12, '2024-05-14', 'fotos', '00a59a84ee6c5bc827e648d581fdff6fab1c97c4');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (13, 13, '2025-03-02', 'fotos', '8fffa09e609e2e660dff11311fc46ae2a97b346a');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (14, 14, '2024-08-05', 'fotos', '2b366bf1f3dc92aa17b3d6af1cd4eb6ff5a7e158');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (15, 15, '2024-12-18', 'fotos', 'b0a2b92f06899ab4245099f7503eb324efaa4057');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (16, 16, '2023-06-18', 'fotos', 'dc34f795aff75ffbc6601fded028f6434e77d60a');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (17, 17, '2023-06-14', 'fotos', '19763dc20bb358fd6e03358a04b2dd145536359d');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (18, 18, '2023-06-20', 'fotos', '2ef335dc06d4e4e6835b45d1734c05db91ab4f96');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (19, 19, '2024-01-12', 'fotos', '5f0e9cd50ff23500b24123f0ef65198691c646d8');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (20, 20, '2024-03-27', 'fotos', '02029f690bb9ef214cc260f5a0e03c84cac75f59');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (21, 21, '2024-10-26', 'fotos', '7b9cdb5ed4247106e7ae17d4411e12edb07841cd');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (22, 22, '2023-10-08', 'fotos', 'be555a14da58754bd59c9155fff42b2dfc7fef2a');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (23, 23, '2023-06-19', 'fotos', 'f80c7ab52e44eb0809448368d33840dc7a8dae5d');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (24, 24, '2023-04-10', 'fotos', '25676987a24a9d2f131a21d97861f0aeffdc6b65');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (25, 25, '2024-09-09', 'fotos', '0bf40108f3915f01e640815fccbc8fbafba352bd');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (26, 26, '2024-08-23', 'fotos', 'c5e9093377cd3efbfed3aff60c4ac4a333f92a0c');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (27, 27, '2024-12-12', 'fotos', 'acfd1b54b6177d0069bdea1af7c5b0ad675fc33a');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (28, 28, '2023-04-25', 'fotos', 'fc338dc476fbe6f85e8f5fb82c257d11fb132c63');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (29, 29, '2023-09-05', 'fotos', '209727c512ae1835246c472263a34c24e7cf45da');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (30, 30, '2023-04-28', 'fotos', '90380bf864fa402ab402bcce04aa4a32da942b19');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (31, 31, '2024-05-26', 'fotos', '133eb1c7bbc243c1e85ea2e0c30cf31d112c4167');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (32, 32, '2023-10-18', 'fotos', '5efe12025e8f09af2e4c12d479e1d2f37ba0bf3c');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (33, 33, '2023-06-01', 'fotos', 'e63f8450a8b740306be04836a7428fa5d9a8ba92');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (34, 34, '2024-09-23', 'fotos', '30ead4c5c3fde86579bc9e485047c207bd6fa98c');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (35, 35, '2024-05-11', 'fotos', '6d44f26882d760d917228925f4b07818544ef12c');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (36, 36, '2023-07-05', 'fotos', '8d6e18f7c05ea16420474e83f8dfcacced8b53fe');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (37, 37, '2023-09-29', 'fotos', '82df9ac6143f54bb9b74c48442164f6ae55105ef');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (38, 38, '2024-03-24', 'fotos', '4cdf505f6acbf9a78047a8e342be5e199811f995');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (39, 39, '2024-05-09', 'fotos', 'eec5aea4b72f3a0786ddf81bf423003721be8991');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (40, 40, '2023-10-01', 'fotos', 'f69f5a17f86bdd7e194ee6c0d4f71bfd3ce622c0');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (41, 41, '2023-12-13', 'fotos', '73393758f1068c1dc8074e29b2cc66982f80a780');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (42, 42, '2025-02-11', 'fotos', '5e81a9e237a15e18eb1bb9f3782dd99419e424da');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (43, 43, '2023-07-24', 'fotos', '56ef614dc2f6a149fad15e733b12193b6a313f5e');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (44, 44, '2023-10-13', 'fotos', '3331197a81fcbbf3abea7de3535c11b4de83174b');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (45, 45, '2024-05-20', 'fotos', '360fe803ec8162d9199f0f6bdae2f58fc7519c1e');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (46, 46, '2025-01-25', 'fotos', '8c1d0d42ce4f03d0ea18e3795e23d5f0dbb4dfe9');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (47, 47, '2024-12-13', 'fotos', '924c20fa55db182183152acc61c6564269adda31');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (48, 48, '2024-07-23', 'fotos', 'aa6ef83e6abbc223e3db19f7b0bbf4593b0fc1a8');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (49, 49, '2024-07-06', 'fotos', '07a687893984d8d46dc511363c16a6d842625776');
INSERT INTO foto_pessoa (fp_id, pes_id, fp_data, fp_bucket, fp_hash) VALUES (50, 50, '2024-06-08', 'fotos', '76562832a5d8fadf85032c90099eec38ca371a52');

SELECT setval('unidade_unid_id_seq', (SELECT MAX(unid_id) FROM unidade));
SELECT setval('lotacao_lot_id_seq', (SELECT MAX(lot_id) FROM lotacao));
SELECT setval('foto_pessoa_fp_id_seq', (SELECT MAX(fp_id) FROM foto_pessoa));