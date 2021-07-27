-- TRANSAÇÕES

CREATE TABLE teste_conta(
  id integer PRIMARY KEY,
  cliente varchar(255) NOT NULL,
  saldo numeric(15,2) DEFAULT 0
)

INSERT INTO teste_conta(id,cliente,saldo)
VALUES (1,'JOAO',1000),
	   (2,'PEDRO',15000),
       (3,'MARIO',450),
 	   (4,'JOAQUIM',40000)
		
-- Trabalhando com transações:

-- usando ROLLBACK:
SELECT * FROM teste_conta WHERE id = 1;

BEGIN;  -- (INICIAR)
UPDATE teste_conta SET saldo = 120 WHERE id = 1;
ROLLBACK; --(ANULA a operação)

SELECT * FROM teste_conta WHERE id = 1; -- resultado igual ao primeiro select.

-- usando SAVEPOINT:

SELECT * FROM teste_conta WHERE id = 1; 

BEGIN; 
UPDATE teste_conta SET saldo = 120 WHERE id = 1;
SAVEPOINT savepoint_1; 
UPDATE teste_conta SET saldo = saldo - 1000 WHERE id = 2;
ROLLBACK TO savepoint_1; -- Anula o último update e retorna para o savepoint.
COMMIT; -- FINALIZA

SELECT * FROM teste_conta;


