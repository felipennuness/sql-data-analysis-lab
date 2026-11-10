# 01 — Joins e Análise Relacional

## Escopo

Esta seção aborda a combinação de tabelas relacionais e como a estratégia de junção altera o resultado analítico.

## Conceitos praticados

- `LEFT JOIN`
- Análise de registros sem correspondência
- Validação de chaves de junção
- Junções da tabela com ela mesma (self joins)
- Comparação de registros dentro da mesma tabela
- Prevenção de pares duplicados espelhados no resultado de self joins

## Questões práticas

O arquivo SQL revisado responde a perguntas como:

- Quais produtos existem no catálogo, mas nunca apareceram em pedidos?
- Existem linhas de pedidos cuja chave de produto não corresponde ao catálogo?
- Quais produtos diferentes possuem preços com diferença de até US$ 0,25?

## SQL

[Acessar `joins.sql`](joins.sql)

O arquivo é publicado como exercício revisado com base no conteúdo do curso, e não como código original de produção.
