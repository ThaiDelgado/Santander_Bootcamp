-- VIEW:

SELECT numero, nome, ativo 
FROM banco;

CREATE OR REPLACE VIEW vw_banco AS( -- View simples
	SELECT numero, nome, ativo
	FROM banco
);

SELECT numero, nome, ativo 
FROM vw_banco;




CREATE OR REPLACE VIEW vw_banco2 (banco_numero, banco_nome, banco_ativo) AS( -- View criada definindo os nomes das colunas.
	SELECT numero, nome, ativo
	FROM banco
);

SELECT banco_numero, banco_nome, banco_ativo
FROM vw_banco2;

INSERT INTO vw_banco2 (banco_numero, banco_nome, banco_ativo) VALUES (51, 'Banco Boa Ideia', TRUE);

SELECT banco_numero, banco_nome, banco_ativo 
FROM vw_banco2
WHERE banco_numero = 51;

SELECT numero, nome, ativo -- Verificando se o banco(view) realmente foi criado e dados inseridos corretamente
FROM banco
WHERE numero = 51;

UPDATE vw_banco2 SET banco_ativo = FALSE
WHERE banco_numero = 51;

DELETE FROM vw_banco2 
WHERE banco_numero = 51;


-- VIEW TEMPORÁRIA:

CREATE OR REPLACE TEMPORARY VIEW vw_agencia AS (
	SELECT nome
	FROM agencia
);

SELECT nome -- caso você faça o select em outra tool, a view temporária não existirá mais.  
FROM vw_agencia;

-- View usando WITH CHECK OPTION:

CREATE OR REPLACE VIEW vw_bancos_ativos AS(
	SELECT numero, nome, ativo
	FROM banco
	WHERE ativo IS TRUE
) WITH LOCAL CHECK OPTION;

INSERT INTO vw_bancos_ativos (numero, nome, ativo) -- O insert não será realizado pois fizemos com que houvesse erro caso tente ser inserido um valor que viole a nossa opção de Check.
VALUES (51, 'Banco Belenense', FALSE);

CREATE OR REPLACE VIEW vw_bancos_com_a AS(
	SELECT numero, nome, ativo
	FROM vw_bancos_ativos
	WHERE nome ILIKE 'a%'
) WITH LOCAL CHECK OPTION;

SELECT numero, nome, ativo -- não temos nenhum banco que incicie com aletra 'a'
FROM vw_bancos_com_a;

INSERT INTO vw_bancos_com_a (numero, nome, ativo) -- Não conseguimos fazer a inserção por conta da opção Check da View vw_bancos_ativos.
VALUES (52, 'Ações Paraenses' FALSE);

INSERT INTO vw_bancos_com_a (numero, nome, ativo) -- Não será permitida a inserção pelo Check.
VALUES (52, 'Banco Paraense', TRUE);

INSERT INTO vw_bancos_com_a (numero, nome, ativo) -- Check ok!
VALUES (52, 'Ações Paresnses', TRUE);

SELECT numero, nome, ativo
FROM vw_bancos_com_a;

-- VIEW RECURSIVA:

CREATE TABLE Funcionarios (
	id SERIAL,
	nome VARCHAR (50),
	gerente INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (gerente) REFERENCES Funcionarios (id)
);

INSERT INTO Funcionarios (nome, gerente) VALUES ('Ancelmo', NULL);
INSERT INTO Funcionarios (nome, gerente) VALUES ('Beatriz', 1);
INSERT INTO Funcionarios (nome, gerente) VALUES ('Magno', 1);
INSERT INTO Funcionarios (nome, gerente) VALUES ('Cremilda', 2);
INSERT INTO Funcionarios (nome, gerente) VALUES ('Wagner', 4);

CREATE OR REPLACE RECURSIVE VIEW vw_func( id, gerente, funcionario) AS (
	SELECT id, nome, gerente
	FROM Funcionarios
	WHERE gerente is NULL
	
	UNION ALL
	
	SELECT Funcionarios.id, Funcionarios.nome, Funcionarios.gerente
	FROM Funcionarios
	JOIN vw_func ON vw_func.id = Funcionarios.gerente
);

SELECT id, gerente, funcionario
FROM vw_func;





