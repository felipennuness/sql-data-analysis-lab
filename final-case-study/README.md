# Projeto Final — Análise de Dados de Beisebol

## Visão geral

O projeto final de SQL combina as técnicas praticadas ao longo do laboratório em um estudo analítico mais amplo, baseado em dados de beisebol.

A implementação revisada está organizada em torno de escolas, salários de times, carreiras de jogadores e características dos atletas.

## Parte I — Análise de Escolas

Perguntas abordadas:

- Quantas escolas formadoras de jogadores existiam em cada década?
- Quais escolas formaram a maior quantidade de jogadores distintos?
- Quais escolas ficaram entre as três primeiras em cada década?

Principais técnicas:

- Funções numéricas
- Joins
- Agregação
- CTEs
- `DENSE_RANK()`

## Parte II — Análise de Salários

Perguntas abordadas:

- Quais times estão entre os 20% com maior gasto anual médio?
- Como o gasto acumulado dos times evolui ao longo do tempo?
- Em que ano cada time ultrapassou pela primeira vez US$ 1 bilhão em folha salarial acumulada?

Principais técnicas:

- Agregação
- `NTILE()`
- Funções de janela
- Cálculos acumulados
- CTEs
- Filtros por limite

## Parte III — Análise da Carreira dos Jogadores

Perguntas abordadas:

- Quais eram as idades dos jogadores na estreia e no último jogo?
- Quanto tempo durou cada carreira?
- Quais times correspondem às temporadas inicial e final?
- Quantos jogadores com carreiras longas começaram e terminaram no mesmo time?

Principais técnicas:

- Funções de data e hora
- Joins
- Métricas derivadas
- CTEs
- Filtros condicionais

## Parte IV — Análise Comparativa de Jogadores

Perguntas abordadas:

- Quais jogadores fazem aniversário na mesma data?
- Qual percentual dos jogadores de cada time rebate com a mão direita, esquerda ou ambas?
- Como a altura e o peso médios dos jogadores mudaram por década?

Principais técnicas:

- `GROUP_CONCAT()`
- Remoção de duplicidades antes da agregação
- Agregação condicional
- Resumos no formato de tabela dinâmica
- `LAG()`
- Funções de janela

## Observações da revisão

A implementação é baseada na atividade do curso e no conjunto de soluções de referência, e não é apresentada como um projeto de produção desenvolvido de forma independente.

Dois pequenos ajustes estão documentados explicitamente no arquivo SQL:

- a pergunta sobre jogadores com carreira longa no mesmo time retorna uma contagem real, pois o enunciado pergunta "quantos";
- a consulta de aniversários compartilhados filtra datas com mais de um jogador, para que o resultado corresponda ao objetivo da pergunta analítica.

A classificação das escolas por década também utiliza a alternativa `DENSE_RANK()`, que considera empates, mencionada nas notas de referência.

## SQL

[Acessar `baseball_analysis.sql`](baseball_analysis.sql)
