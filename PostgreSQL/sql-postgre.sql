CREATE TABLE IF NOT EXISTS banco(
	numero INTEGER NOT NULL,
	nome VARCHAR(50) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE, -- boa prática (campo de controle)
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW(), -- boa prática (campo de controle)
	PRIMARY KEY (numero)
)

CREATE TABLE IF NOT EXISTS agencia(
	banco_numero INTEGER NOT NULL,
	numero INTEGER NOT NULL,
	nome VARCHAR(80) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
	PRIMARY KEY (banco_numero, numero),                --colocar como parâmetro o que não pode se repetir na tabela
	FOREIGN KEY (banco_numero) REFERENCES banco (numero)
)

CREATE TABLE IF NOT EXISTS cliente(  --tabela criada apenas para dados dos clientes
	numero BIGSERIAL NOT NULL,
	nome VARCHAR(120) NOT NULL,
	email VARCHAR (250) NOT NULL,
	ativo BOOLEAN DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW()
)

CREATE TABLE IF NOT EXISTS conta_corrente(
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	cliente_numero BIGINT NOT NULL,
	numero BIGINT NOT NULL,
	digito SMALLINT NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
	PRIMARY KEY (banco_numero, agencia_numero, cliente_numero, numero, digito),
	FOREIGN KEY (banco_numero, agencia_numero) REFERENCES agencia (banco_numero, numero),
	FOREIGN KEY (cliente_numero) REFERENCES cliente (numero)
)

CREATE TABLE IF NOT EXISTS tipo_transacao(
	id SMALLSERIAL NOT NULL, --numeros de transações existentes não são muitas
	nome VARCHAR (50) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW()
)

CREATE TABLE IF NOT EXISTS cliente_transacoes( --estabela tem relação com as tabelas conta_corrente e tipo_transaçaõ.
	id BIGSERIAL NOT NULL PRIMARY KEY,
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	conta_corrente_numero BIGINT NOT NULL,
	conta_corrente_digito SMALLINT NOT NULL,
	cliente_numero BIGINT NOT NULL,
	tipo_transacao_id SMALLINT NOT NULL,
	valor NUMERIC (15,2) NOT NULL,
	data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
	FOREIGN KEY (banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito) REFERENCES conta_corrente (banco_numero, agencia_numero, numero, digito, cliente_numero)
)






