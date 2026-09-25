-- ============================================================
-- PROJETO 3 - BACKUP E RECOVERY
-- PARTE 3 - BACKUP E RECOVERY
-- PostgreSQL
-- Banco: dio / dio_teste
-- Schema: ecommerce
-- ============================================================


-- ============================================================
-- 1. VERIFICAR O BANCO E O SCHEMA
-- ============================================================

SELECT
    current_database() AS banco,
    current_schema() AS schema;


-- ============================================================
-- 2. VERIFICAR AS TABELAS DO E-COMMERCE
-- ============================================================

SELECT
    table_schema,
    table_name
FROM information_schema.tables
WHERE table_schema = 'ecommerce'
ORDER BY table_name;


-- ============================================================
-- 3. VERIFICAR A PROCEDURE
-- ============================================================

SELECT
    routine_schema,
    routine_name,
    routine_type
FROM information_schema.routines
WHERE routine_schema = 'ecommerce'
ORDER BY routine_name;


-- ============================================================
-- 4. VERIFICAR OS DADOS ANTES DO BACKUP
-- ============================================================

SELECT
    id_pedido,
    id_cliente,
    data_pedido,
    status
FROM ecommerce.pedido
ORDER BY id_pedido;


-- ============================================================
-- 5. APÓS O RECOVERY
-- EXECUTAR NOVAMENTE A CONSULTA ABAIXO
-- ============================================================

SELECT
    id_pedido,
    id_cliente,
    data_pedido,
    status
FROM ecommerce.pedido
ORDER BY id_pedido;

-- Banco de origem: dio
-- Banco de teste/recovery: dio_teste