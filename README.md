# Backup e Recovery com PostgreSQL

Projeto prático para aplicação de conceitos de **transações, procedures, backup e recuperação de banco de dados utilizando PostgreSQL**.

O projeto utiliza uma base de e-commerce e demonstra o fluxo desde alterações transacionais até a criação de um backup e sua restauração em um banco de teste.

---

## 🎯 Objetivo

Praticar conceitos fundamentais de manipulação e recuperação de dados no PostgreSQL:

- Transações com `BEGIN`, `COMMIT` e `ROLLBACK`;
- Criação e execução de `PROCEDURE`;
- Tratamento de exceções com `RAISE EXCEPTION`;
- Backup utilizando `pg_dump`;
- Recuperação utilizando `pg_restore`;
- Validação dos dados após o recovery.

---

## 🛠️ Tecnologias

- PostgreSQL 18.4
- SQL
- PL/pgSQL
- VS Code
- PostgreSQL DBCode
- `pg_dump`
- `pg_restore`

---

## 📁 Estrutura do projeto

```text
PROJETO_3_backup_recovery/
│
├── README.md
├── 01_transacoes.sql
├── 02_transacao_procedure.sql
├── 03_backup_recovery.sql
└── backup_dio.dump
```

---

## 1. Transações

No primeiro script foram realizadas operações utilizando transações do PostgreSQL.

### ROLLBACK

O status do pedido `5` foi alterado temporariamente e depois desfeito:

```sql
BEGIN;

UPDATE ecommerce.pedido
SET status = 'PROCESSANDO'
WHERE id_pedido = 5;

ROLLBACK;
```

A consulta posterior confirmou que a alteração não permaneceu após o `ROLLBACK`.

### COMMIT

Em seguida, a alteração foi realizada novamente e confirmada:

```sql
BEGIN;

UPDATE ecommerce.pedido
SET status = 'PROCESSANDO'
WHERE id_pedido = 5;

COMMIT;
```

Nesse caso, a alteração permaneceu persistida no banco.

---

## 2. Procedure

Foi criada a procedure:

```text
ecommerce.atualizar_status_pedido
```

A procedure recebe o ID do pedido e o novo status.

Antes da atualização, é verificado se o pedido existe.

Exemplo com pedido existente:

```sql
CALL ecommerce.atualizar_status_pedido(4, 'ENVIADO');
```

Também foi realizado um teste com um pedido inexistente:

```sql
CALL ecommerce.atualizar_status_pedido(9999, 'ENVIADO');
```

Nesse cenário, a procedure utiliza `RAISE EXCEPTION` para informar que o pedido não foi encontrado.

---

## 3. Backup

O backup do banco `dio` foi realizado utilizando o utilitário `pg_dump`.

O arquivo gerado foi:

```text
backup_dio.dump
```

Foi utilizado o formato custom (`-F c`), permitindo a utilização posterior do `pg_restore`.

Exemplo do comando utilizado:

```bash
"C:\Program Files\PostgreSQL\18\bin\pg_dump.exe" ^
-h localhost ^
-p 5432 ^
-U postgres ^
-d dio ^
-F c ^
-f "D:\VS-Code\backup_dio.dump"
```

> `pg_dump` e `pg_restore` são ferramentas executadas no terminal. Por isso, esses comandos não fazem parte dos arquivos `.sql`.

---

## 4. Recovery

Para validar o backup, foi utilizado um banco separado:

```text
dio_teste
```

O arquivo `backup_dio.dump` foi restaurado nesse banco utilizando `pg_restore`.

Após a restauração, foram realizadas consultas para verificar a estrutura e os dados recuperados.

---

## 5. Validação do Recovery

A restauração apresentou as tabelas dos schemas `ecommerce` e `oficina`.

Foram identificadas:

```text
26 tabelas
```

Também foi validada a tabela:

```text
ecommerce.pedido
```

A consulta retornou:

```text
10 pedidos
```

Consulta utilizada:

```sql
SELECT
    id_pedido,
    id_cliente,
    data_pedido,
    status
FROM ecommerce.pedido
ORDER BY id_pedido;
```

Resultado validado:

| Pedido | Cliente | Status |
|---:|---:|---|
| 1 | 1 | ENTREGUE |
| 2 | 1 | ENVIADO |
| 3 | 2 | ENTREGUE |
| 4 | 2 | ENVIADO |
| 5 | 2 | PROCESSANDO |
| 6 | 3 | ENTREGUE |
| 7 | 4 | CANCELADO |
| 8 | 5 | ENTREGUE |
| 9 | 5 | ENVIADO |
| 10 | 6 | PROCESSANDO |

---

## 📌 Resultado

O projeto permitiu executar e validar o seguinte fluxo:

```text
Transação
    ↓
Procedure
    ↓
Backup
    ↓
Restauração
    ↓
Validação dos dados
```

O backup do banco `dio` foi utilizado para restaurar o banco `dio_teste`, onde a estrutura e os registros da tabela `ecommerce.pedido` foram conferidos após o recovery.

---

## 📚 Conceitos praticados

- Transações no PostgreSQL;
- `BEGIN`;
- `COMMIT`;
- `ROLLBACK`;
- `CREATE OR REPLACE PROCEDURE`;
- PL/pgSQL;
- `IF NOT EXISTS`;
- `RAISE EXCEPTION`;
- `pg_dump`;
- `pg_restore`;
- Backup em formato custom;
- Recovery em banco de teste;
- Validação de dados após restauração.
