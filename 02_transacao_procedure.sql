-- ============================================================
-- PROJETO 3 - BACKUP E RECOVERY
-- PARTE 2 - TRANSAÇÃO COM PROCEDURE
-- PostgreSQL
-- Banco: dio
-- Schema: ecommerce
-- ============================================================


-- ============================================================
-- CRIAÇÃO DA PROCEDURE
-- ============================================================

CREATE OR REPLACE PROCEDURE ecommerce.atualizar_status_pedido(
    p_id_pedido INTEGER,
    p_novo_status VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Verifica se o pedido existe
    IF NOT EXISTS (
        SELECT 1
        FROM ecommerce.pedido
        WHERE id_pedido = p_id_pedido
    ) THEN

        RAISE EXCEPTION
            'Pedido % não encontrado.',
            p_id_pedido;

    END IF;


    -- Atualiza o status
    UPDATE ecommerce.pedido
    SET status = p_novo_status
    WHERE id_pedido = p_id_pedido;


    -- Mensagem de sucesso
    RAISE NOTICE
        'Pedido % atualizado para %.',
        p_id_pedido,
        p_novo_status;


EXCEPTION
    WHEN OTHERS THEN

        -- Tratamento do erro
        RAISE NOTICE
            'Erro: %. A operação foi desfeita.',
            SQLERRM;

        -- Devolve o erro ao chamador
        RAISE;

END;
$$;


-- ============================================================
-- TESTE 1 - PEDIDO EXISTENTE
-- ============================================================

CALL ecommerce.atualizar_status_pedido(4, 'ENVIADO');

SELECT
    id_pedido,
    id_cliente,
    status
FROM ecommerce.pedido
WHERE id_pedido = 4;

-- ============================================================
-- TESTE 2 - PEDIDO INEXISTENTE
-- ============================================================

CALL ecommerce.atualizar_status_pedido(9999, 'ENVIADO');
