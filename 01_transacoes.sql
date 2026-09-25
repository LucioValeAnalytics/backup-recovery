-- ============================================================
-- PROJETO 3 - BACKUP E RECOVERY
-- PARTE 1 - TRANSAÇÕES
-- PostgreSQL
-- Banco: dio
-- Schema: ecommerce
-- ============================================================


-- Verificar banco e schema atual
SELECT
    current_database() AS banco,
    current_schema() AS schema;


-- ============================================================
-- TRANSAÇÃO COM ROLLBACK
-- ============================================================

-- Estado inicial do pedido
SELECT
    id_pedido,
    id_cliente,
    status
FROM ecommerce.pedido
WHERE id_pedido = 5;


BEGIN;

-- Altera o status temporariamente
UPDATE ecommerce.pedido
SET status = 'PROCESSANDO'
WHERE id_pedido = 5;

-- Verifica a alteração dentro da transação
SELECT
    id_pedido,
    id_cliente,
    status
FROM ecommerce.pedido
WHERE id_pedido = 5;

-- Desfaz a alteração
ROLLBACK;

-- Verifica se voltou ao estado anterior
SELECT
    id_pedido,
    id_cliente,
    status
FROM ecommerce.pedido
WHERE id_pedido = 5;


-- ============================================================
-- TRANSAÇÃO COM COMMIT
-- ============================================================

BEGIN;

-- Altera o status
UPDATE ecommerce.pedido
SET status = 'PROCESSANDO'
WHERE id_pedido = 5;

-- Verifica a alteração dentro da transação
SELECT
    id_pedido,
    id_cliente,
    status
FROM ecommerce.pedido
WHERE id_pedido = 5;

-- Confirma a alteração
COMMIT;

-- Verifica se a alteração foi persistida
SELECT
    id_pedido,
    id_cliente,
    status
FROM ecommerce.pedido
WHERE id_pedido = 5;