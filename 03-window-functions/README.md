# 03 — Funções de Janela

## Escopo

Esta seção aborda cálculos analíticos que preservam os detalhes de cada linha enquanto adicionam sequenciamento, classificação, comparações e métricas de distribuição.

## Conceitos praticados

- `ROW_NUMBER()`
- `DENSE_RANK()`
- Classificação considerando empates
- `LAG()`
- `NTILE()`
- `PARTITION BY`
- Ordenação em funções de janela

## Questões práticas

O arquivo SQL revisado inclui exemplos como:

- Numerar transações de clientes em sequência
- Classificar produtos dentro de cada pedido preservando empates
- Retornar o segundo maior nível de quantidade em cada pedido
- Comparar cada pedido de um cliente com o pedido anterior
- Identificar o 1% de clientes com maior gasto total

## Observação de implementação

O material de referência do curso destaca explicitamente que uma abordagem com `NTH_VALUE()` para encontrar o segundo produto mais popular pode apresentar resultados incorretos quando existem empates. Por isso, o arquivo público de exercícios utiliza a alternativa com `DENSE_RANK()`.

## SQL

[Acessar `window_functions.sql`](window_functions.sql)

O arquivo é publicado como exercício revisado com base no conteúdo do curso, e não como código original de produção.
