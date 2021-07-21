-- CTE - Common Table Expression / Expressão de tabela comum.

WITH clientes_e_transacoes AS (
	SELECT cliente.nome AS nome_cliente,
		   tipo_transacao.nome AS tipo_transacao_nome,
	       cliente_transacoes.valor AS transacao_valor
	FROM cliente_transacoes
	INNER JOIN cliente ON cliente.numero = cliente_transacoes.cliente_numero
	INNER JOIN tipo_transacao ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
	INNER JOIN banco ON banco.numero = cliente_transacoes.banco_numero AND banco.nome ILIKE '%Itaú%'
)
SELECT nome_cliente, tipo_transacao_nome, transacao_valor
FROM clientes_e_transacoes;