
-- select nas tabelas verificando se foram feitos todos os inserts
SELECT numero, nome FROM banco;
SELECT banco_numero, numero, nome FROM agencia;
SELECT numero, nome, email FROM cliente;
SELECT banco_numero, agencia_numero, cliente_numero, numero, digito FROM conta_corrente;
SELECT (id),nome FROM tipo_transacao;
SELECT (id), banco_numero, agencia_numero, cliente_numero FROM cliente_transacoes;

-- Fazendo a verificação das colunas existentes na tabela solicitada utilizando o catálogo do banco 'information_schima.columns':
SELECT * FROM information_schema.columns WHERE table_name = 'banco';

-- AVG
-- COUNT (HAVING)
-- MAX
-- MIN
-- SUM

SELECT AVG (valor) FROM cliente_transacoes; -- calcula a media dos valores inseridos na coluna 'valor'

SELECT COUNT (numero) FROM cliente; --faz a contagem 

SELECT COUNT (numero), email 
FROM cliente
WHERE email ILIKE '%gmail.com'
GROUP BY email;

SELECT COUNT (id), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
HAVING COUNT (id) > 150; -- faz com que a query retorne apenas as contagens maiores que 150.

SELECT MAX (valor) -- retorna o maior valor da coluna 
FROM cliente_transacoes;

SELECT MAX (valor), tipo_transacao_id -- retorna o maior valor em cada tipo de transação
FROM cliente_transacoes
GROUP BY tipo_transacao_id
ORDER BY tipo_transacao_id ASC; --colocando em ordem ascendente


SELECT MIN (valor) -- retorna o menor valor
FROM cliente_transacoes;

SELECT MIN (valor), tipo_transacao_id -- retorna o valor minimo em cada tipo de transação 
FROM cliente_transacoes
GROUP BY tipo_transacao_id
ORDER BY tipo_transacao_id  DESC; -- colocando em ordem descendente

SELECT SUM (valor) FROM cliente_transacoes; -- retorna a soma de todos os valores da coluna

SELECT SUM (valor), tipo_transacao_id -- retornando a soma de cada transação do meu banco de dados.
FROM cliente_transacoes
GROUP BY tipo_transacao_id;





