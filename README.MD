# Projeto SQL - Base World

**Aluno:** José Eduardo | **RA:** 220100
**Curso:** Engenharia da Computação - UNASP

Atividade de SQL sobre a base de dados oficial **World** do MySQL (tabelas `country`, `city` e `countrylanguage`), com consultas de seleção, agregação, junções e subconsultas.

## Conteúdo do pacote

| Arquivo | Descrição |
|---|---|
| `00_criar_schema.sql` | Cria o schema `jose_eduardo_world`. |
| `world_jose_eduardo.sql` | Cópia ajustada do dump oficial `world.sql` (veja o passo 3). Não vem pronta: você a gera. |
| `01_consultas.sql` | As 11 consultas da atividade, divididas em 4 blocos. Somente `SELECT`. |
| `resultado.txt` |  saída das consultas, gerada pelo terminal. |
| `world.sql` |  base onde é feita as consultas |

## Requisitos

- MySQL Server 8.x instalado e em execução (este projeto usou a versão 8.0.19, porta **3307**).
- VS Code com a extensão **SQLTools** + driver MySQL (opcional, se preferir o terminal).
- Arquivo `world-db.zip` da página oficial do MySQL.

> **Importante:** os scripts SQL não instalam nem iniciam o servidor MySQL. Para manter os dados do trabalho isolados, use uma instância MySQL local separada (ou, no mínimo, um schema próprio), e não a conexão usada em outros projetos. O schema `jose_eduardo_world` é criado nessa instância.

## Passo a passo

### 1. Baixar a base World
Baixe o `world-db.zip` em <https://dev.mysql.com/doc/index-other.html> (seção *Example Databases*).

### 2. Extrair o `world.sql`
Extraia o arquivo `world.sql` para a pasta do projeto.

### 3. Ajustar o `world.sql`
O dump oficial cria e seleciona o banco `world`. Troque o nome nas **3 linhas** abaixo (edite uma por uma, sem usar "substituir tudo"):

```sql
/*!40000 DROP DATABASE IF EXISTS `jose_eduardo_world`*/;

CREATE DATABASE `jose_eduardo_world` DEFAULT CHARACTER SET utf8mb4;

USE `jose_eduardo_world`;
```

Salve o resultado como `world_jose_eduardo.sql` (mantendo o original intacto).

### 4. Criar o schema
Execute o `00_criar_schema.sql` na instância MySQL escolhida.

### 5. Carregar as tabelas e os dados
Execute o `world_jose_eduardo.sql` **completo** (sem selecionar apenas um trecho). Ele cria `country`, `city` e `countrylanguage` e insere os dados de exemplo.

### 6. Rodar as consultas
Execute o `01_consultas.sql`. Pelo VS Code, rode cada `SELECT` individualmente e use uma captura da primeira página quando o resultado tiver várias páginas. Pelo terminal, rode o arquivo todo (veja abaixo).

## Executando pelo terminal (Windows)

Use o caminho completo do `mysql.exe` (ajuste a versão se necessário) e informe a porta e o host. No **cmd**, dentro da pasta do projeto:

```
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p -P 3307 -h 127.0.0.1 --default-character-set=utf8mb4 < world_jose_eduardo.sql
```

```
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p -P 3307 -h 127.0.0.1 -t --default-character-set=utf8mb4 < 01_consultas.sql > resultado.txt
```

- `-P 3307` (P maiúsculo) é a porta; `-h 127.0.0.1` força conexão TCP.
- `-t` mostra os resultados em formato de tabela.
- No **PowerShell** o operador `<` não funciona; use o cmd ou `cmd /c "..."`.

## Conferindo se deu certo

```sql
USE jose_eduardo_world;
SHOW TABLES;
SELECT COUNT(*) AS total_cidades FROM city;
```

Resultado esperado: tabelas `city`, `country` e `countrylanguage`, e **4079** cidades. A base padrão também tem 239 países e 984 registros em `countrylanguage`.

## Consultas do `01_consultas.sql`

**Bloco 1 - Consultas básicas, filtros e ordenação**
1. Países da América do Sul, da maior para a menor população.
2. As 10 cidades mais populosas.
3. Países com expectativa de vida acima de 80 e GNP acima de 100.000.

**Bloco 2 - Agregação e agrupamento**
1. População total, média por país e quantidade de países por continente.
2. Códigos de país com mais de 100 cidades cadastradas (`GROUP BY` + `HAVING`).
3. Maior, menor e média do GNP na Europa.

**Bloco 3 - Junções (`INNER JOIN`)**
1. Cidades asiáticas com país e população.
2. Idiomas registrados para o Brasil.
3. Países da América do Sul e o nome de suas capitais.

**Bloco 4 - Consultas avançadas e subconsultas**
1. Países com expectativa de vida acima da média global.
2. Cinco idiomas oficiais com maior número estimado de falantes.

As consultas apenas leem dados. O `01_consultas.sql` começa com `USE jose_eduardo_world;` para selecionar o schema do projeto e não modifica nenhum registro.

## Problemas comuns

| Erro / sintoma | Causa e solução |
|---|---|
| `'mysql' não é reconhecido como um comando` | O MySQL não está no PATH. Use o caminho completo do `mysql.exe`. |
| `Operador '<' reservado para uso futuro` | Você está no PowerShell. Use o cmd ou `cmd /c "..."`. |
| `ERROR 2003 ... localhost:3306 (10061)` | Porta errada. Use `-P 3307 -h 127.0.0.1` e confira se o serviço MySQL está rodando. |
| `ERROR 1064` perto de `USE` | Existe uma linha anterior sem `;` ou o arquivo foi editado de forma incorreta. Revise o topo do `.sql` e salve com `Ctrl+S` antes de rodar. |
| `Unknown database 'jose_eduardo_world'` | O dump foi importado sem renomear o banco (ficou `world`) ou o schema não foi criado. Refaça o passo 3. |
| Tabelas vazias / `Nothing here` no SQLTools | O dump não foi executado por completo. Rode o arquivo inteiro, sem selecionar trechos. |
| Acentos quebrados | Use `--default-character-set=utf8mb4` e salve os arquivos em UTF-8. |

## Referência oficial

- Instalação da base World: <https://dev.mysql.com/doc/world-setup/en/>
- Bancos de exemplo do MySQL: <https://dev.mysql.com/doc/index-other.html>