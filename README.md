# Laboratório de Análise de Dados com SQL

![SQL](https://img.shields.io/badge/SQL-Estudo%20e%20Pr%C3%A1tica-336791)
![MySQL](https://img.shields.io/badge/MySQL-Analytics-4479A1)

> Documentação de estudos de SQL com exercícios práticos em MySQL, abordando análise relacional, CTEs, funções de janela, funções SQL, técnicas analíticas e um projeto final de análise de beisebol.

## Tópicos de estudo

### 1. Junções (Joins)

- `LEFT JOIN`
- Registros sem correspondência
- Junções da tabela com ela mesma (self joins)
- Comparações relacionais

[Anotações](01-joins/README.md) • [SQL](01-joins/joins.sql)

### 2. Subconsultas e CTEs

- Subconsultas em `SELECT`, `FROM` e `WHERE`
- Expressões de Tabela Comum (CTEs)
- Múltiplas CTEs
- Consultas em várias etapas

[Anotações](02-subqueries-ctes/README.md) • [SQL](02-subqueries-ctes/subqueries_ctes.sql)

### 3. Funções de janela

- `ROW_NUMBER()`
- `RANK()` / `DENSE_RANK()`
- `LAG()` / `LEAD()`
- `NTILE()`
- `PARTITION BY`

[Anotações](03-window-functions/README.md) • [SQL](03-window-functions/window_functions.sql)

### 4. Funções SQL

- Funções numéricas
- Funções de data e hora
- Funções de texto
- Correspondência de padrões
- Tratamento de valores `NULL`

[Anotações](04-sql-functions/README.md) • [SQL](04-sql-functions/sql_functions.sql)

### 5. Técnicas analíticas

- Análise de duplicidades
- Agregação condicional
- Resumos no formato de tabela dinâmica
- Totais acumulados
- Médias móveis

[Anotações](05-analytical-techniques/README.md) • [SQL](05-analytical-techniques/analytical_techniques.sql)

## Projeto final de estudo — Análise de beisebol

O exercício final combina os tópicos anteriores para analisar:

- Escolas que formam jogadores;
- Salários dos times e gastos acumulados;
- Carreiras dos jogadores;
- Distribuição por lado de rebatida;
- Tendências de altura e peso dos jogadores por década.

[Anotações do projeto](final-case-study/README.md) • [SQL](final-case-study/baseball_analysis.sql)

## Estrutura do repositório

```text
.
├── README.md
├── COURSE_CONTEXT.md
├── 01-joins/
├── 02-subqueries-ctes/
├── 03-window-functions/
├── 04-sql-functions/
├── 05-analytical-techniques/
└── final-case-study/
```

## Contexto dos estudos

Os exercícios foram realizados como parte dos estudos de SQL, utilizando materiais do curso e soluções de referência. Os arquivos deste repositório estão organizados como documentação pessoal de estudo e anotações práticas para revisão.

Consulte [Contexto dos Estudos](COURSE_CONTEXT.md).

---

**Luiz Felipe Nunes — Desenvolvedor de BI | Qlik | SQL | Análise de Dados**
