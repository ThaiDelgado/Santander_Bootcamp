CREATE TABLE IF NOT EXISTS banco(
	numero INTEGER NOT NULL,
	nome VARCHAR(50) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE, -- boa prática (campo de controle)
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW(), -- boa prática (campo de controle)
	PRIMARY KEY (numero)
)

ALTER TABLE agencia RENAME numero_banco TO banco_numero; 

ALTER TABLE agencia ALTER COLUMN nome TYPE VARCHAR (80);

CREATE TABLE IF NOT EXISTS agencia(
	banco_numero INTEGER NOT NULL,
	numero INTEGER NOT NULL,
	nome VARCHAR(50) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
	PRIMARY KEY (numero_banco, numero),                --colocar como parâmetro o que não pode se repetir na tabela
	FOREIGN KEY (numero_banco) REFERENCES banco (numero)
)

ALTER TABLE cliente ALTER COLUMN nome TYPE VARCHAR (120);
ALTER TABLE cliente ALTER COLUMN email TYPE VARCHAR (250);
ALTER TABLE cliente ADD PRIMARY KEY (numero); -- foi adicionado a restrição primary key À coluna numero da tabela cliente, a qual esqueci de fazer na sua criação.

CREATE TABLE IF NOT EXISTS cliente(  --tabela criada apenas para dados dos clientes
	numero BIGSERIAL NOT NULL,
	nome VARCHAR(80) NOT NULL,
	email VARCHAR (50) NOT NULL,
	ativo BOOLEAN DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW()
)

ALTER TABLE conta_corrente RENAME numero_banco TO banco_numero;
ALTER TABLE conta_corrente RENAME numero_agencia TO agencia_numero;
ALTER TABLE conta_corrente RENAME numero_cliente TO cliente_numero;

CREATE TABLE IF NOT EXISTS conta_corrente(
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	cliente_numero BIGINT NOT NULL,
	numero BIGINT NOT NULL,
	digito SMALLINT NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
	PRIMARY KEY (numero_banco, numero_agencia, numero_cliente, numero, digito),
	FOREIGN KEY (numero_banco, numero_agencia) REFERENCES agencia (numero_banco, numero),
	FOREIGN KEY (numero_cliente) REFERENCES cliente (numero)
)

ALTER TABLE tipo_transacao ADD PRIMARY KEY (id);

CREATE TABLE IF NOT EXISTS tipo_transacao(
	id SMALLSERIAL NOT NULL, --numeros de transações existentes não são muitas
	nome VARCHAR (50) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW()
)

ALTER TABLE cliente_transacao RENAME numero_banco TO banco_numero;
ALTER TABLE cliente_transacao RENAME numero_agencia TO agencia_numero;
ALTER TABLE cliente_transacao RENAME numero_cliente TO cliente_numero;

ALTER TABLE cliente_transacao RENAME TO cliente_transacoes;

ALTER TABLE cliente_transacoes RENAME numero_conta_corrente TO conta_corrente_numero;
ALTER TABLE cliente_transacoes RENAME numero_conta_digito TO conta_corrente_digito;

DROP TABLE cliente_transacoes;

CREATE TABLE IF NOT EXISTS cliente_transacao( --essa tabela tem relação com as tabelas conta_corrente e tipo_transaçaõ.
	id BIGSERIAL NOT NULL PRIMARY KEY,        -- tabela dropada.
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	cliente_numero BIGINT NOT NULL,
	numero_conta_corrente BIGINT NOT NULL,
	numero_conta_digito SMALLINT NOT NULL,
	tipo_transacao_id SMALLINT NOT NULL,
	valor NUMERIC (15,2) NOT NULL,
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
	FOREIGN KEY (numero_banco, numero_agencia, numero_cliente, numero_conta_corrente, numero_conta_digito) REFERENCES conta_corrente (numero_banco, numero_agencia, numero_cliente, numero, digito)
)

CREATE TABLE IF NOT EXISTS cliente_transacoes( --Foi criada uma nova tabela cliente_transacoes
	id BIGSERIAL NOT NULL PRIMARY KEY,         -- pois as colunas da tabela anterior não estavam na mesma ordem das inserções, causando erro.
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	conta_corrente_numero BIGINT NOT NULL,
	conta_corrente_digito SMALLINT NOT NULL,
	cliente_numero BIGINT NOT NULL,
	tipo_transacao_id SMALLINT NOT NULL,
	valor NUMERIC (15,2) NOT NULL,
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
	FOREIGN KEY (banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero) REFERENCES conta_corrente(banco_numero, agencia_numero, numero, digito, cliente_numero)

);





