-- JOINs: JOIN ou INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN, CROSS JOIN.

SELECT numero, nome FROM banco;
SELECT banco_numero, numero, nome FROM agencia;
SELECT numero, nome, email FROM cliente;
SELECT banco_numero, agencia_numero, cliente_numero, numero, digito FROM conta_corrente;
SELECT id, nome FROM tipo_transacao;
SELECT banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero, valor FROM cliente_transacoes;

-- verificando o numero de registros que irá retornar:
SELECT COUNT (numero) FROM banco; --151
SELECT COUNT (numero) FROM agencia; --296

-- INNER JOIN: retorna apenas os dados que têm relação entre as duas tabelas: 
SELECT banco.numero, banco.nome, agencia.numero, agencia.nome -- 296
FROM banco
INNER JOIN agencia
ON agencia.banco_numero = banco.numero;

SELECT conta_corrente.numero, cliente.numero, cliente.nome,
       banco.numero, banco.nome,
	   cliente_transacoes.valor
FROM conta_corrente
JOIN cliente ON cliente.numero = conta_corrente.cliente_numero
JOIN banco ON banco.numero = conta_corrente.banco_numero

SELECT cliente_transacoes.valor, tipo_transacao.id, tipo_transacao.nome,
	   agencia.numero, agencia.nome,
	   conta_corrente.numero, conta_corrente.digito,
	   cliente.numero, cliente.nome,
	   banco.numero, banco.nome
FROM cliente_transacoes
JOIN tipo_transacao ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
JOIN agencia ON agencia.numero = cliente_transacoes.agencia_numero
JOIN conta_corrente ON conta_corrente.numero = cliente_transacoes.conta_corrente_numero
JOIN cliente ON cliente.numero = cliente_transacoes.cliente_numero
JOIN banco ON banco.numero = cliente_transacoes.banco_numero
		
-- LEFT JOIN: 
SELECT banco.numero, banco.nome, agencia.numero, agencia.nome -- 438
FROM banco
LEFT JOIN agencia
ON agencia.banco_numero = banco.numero;

SELECT COUNT (distinct banco.numero) -- usando 'distinct' para conferir quantos bancos estão relacionados com a tabela agencia
FROM banco
LEFT JOIN agencia
ON agencia.banco_numero = banco.numero;

-- RIGHT JOIN:
SELECT agencia.numero, agencia.nome, banco.numero, banco.nome -- 438
FROM agencia
RIGHT JOIN banco
ON banco.numero = agencia.banco_numero;

-- FULL JOIN
SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM banco
FULL JOIN agencia
ON agencia.banco_numero = banco.numero;





	   

	   
	