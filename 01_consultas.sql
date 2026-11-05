-- Projeto World - Jose Eduardo - RA 220100


USE jose_eduardo_world;

-- BLOCO 1 - Consultas básicas, filtros e ordenação

-- 1. Países da América do Sul, da maior para a menor população
SELECT Name, Continent, Population
FROM country
WHERE Continent = 'South America'
ORDER BY Population DESC;

-- 2. As 10 cidades mais populosas
SELECT Name, CountryCode, Population
FROM city
ORDER BY Population DESC
LIMIT 10;

-- 3. Países com expectativa de vida > 80 e GNP > 100.000
SELECT Name, LifeExpectancy, GNP
FROM country
WHERE LifeExpectancy > 80
  AND GNP > 100000;


-- BLOCO 2 - Funções de agregação e agrupamento

-- 1. População total, média por país e número de países por continente
SELECT Continent,
       SUM(Population) AS TotalPopulation,
       ROUND(AVG(Population), 2) AS AveragePopulationPerCountry,
       COUNT(*) AS CountryCount
FROM country
GROUP BY Continent
ORDER BY TotalPopulation DESC;

-- 2. Códigos de país com mais de 100 cidades cadastradas
SELECT CountryCode, COUNT(*) AS CityCount
FROM city
GROUP BY CountryCode
HAVING COUNT(*) > 100
ORDER BY CityCount DESC;

-- 3. Maior, menor e média do GNP na Europa
SELECT MAX(GNP) AS MaxGNP,
       MIN(GNP) AS MinGNP,
       ROUND(AVG(GNP), 2) AS AverageGNP
FROM country
WHERE Continent = 'Europe';


-- BLOCO 3 - Junção de tabelas (INNER JOIN)

-- 1. Cidades asiáticas com país e população
SELECT ci.Name AS CityName,
       co.Name AS CountryName,
       ci.Population
FROM city AS ci
INNER JOIN country AS co
  ON ci.CountryCode = co.Code
WHERE co.Continent = 'Asia'
ORDER BY co.Name, ci.Name;

-- 2. Idiomas registrados para o Brasil
SELECT cl.Language,
       cl.Percentage,
       cl.IsOfficial
FROM countrylanguage AS cl
INNER JOIN country AS co
  ON cl.CountryCode = co.Code
WHERE co.Name = 'Brazil'
ORDER BY cl.Percentage DESC;

-- 3. Países da América do Sul e o nome de suas capitais
SELECT co.Name AS CountryName,
       ci.Name AS CapitalName
FROM country AS co
INNER JOIN city AS ci
  ON co.Capital = ci.ID
WHERE co.Continent = 'South America'
ORDER BY co.Name;


-- BLOCO 4 - Consultas avançadas e subconsultas

-- 1. Países com expectativa de vida acima da média global
SELECT Name, LifeExpectancy
FROM country
WHERE LifeExpectancy > (
    SELECT AVG(LifeExpectancy)
    FROM country
)
ORDER BY LifeExpectancy DESC;

-- 2. Cinco idiomas oficiais com maior número estimado de falantes
SELECT cl.Language,
       ROUND(SUM(co.Population * cl.Percentage / 100), 0) AS EstimatedSpeakers
FROM countrylanguage AS cl
INNER JOIN country AS co
  ON cl.CountryCode = co.Code
WHERE cl.IsOfficial = 'T'
GROUP BY cl.Language
ORDER BY EstimatedSpeakers DESC
LIMIT 5;
