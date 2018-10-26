# 1. Bigger than Russia

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

# 2. Richer than UK

SELECT name FROM world
WHERE gdp/population >
(SELECT gdp/population FROM world
WHERE name = 'United Kingdom')
AND continent = 'Europe';

# 3. Neighbours of Argentina and Australia

SELECT name, continent
FROM world
WHERE continent = 
(SELECT continent FROM world
WHERE name = 'Argentina')
OR continent = 
(SELECT continent FROM world
WHERE name = 'Australia')
ORDER BY name;

# 4. Between Canada and Poland

SELECT name, population FROM world
WHERE population > 
(SELECT population FROM world
WHERE name = 'Canada')
AND population <
(SELECT population FROM world
WHERE name = 'Poland');

# 5. Percentages of Germany

SELECT name, concat(round(population/(SELECT population FROM world WHERE name = 'Germany')*100, 0), '%') 
FROM world
WHERE continent = 'Europe';

# 6. Bigger than every country in Europe

SELECT name
FROM world
WHERE gdp > 
ALL (SELECT gdp
     FROM world
     WHERE continent = 'Europe' 
     AND gdp IS NOT NULL);

# 7. Largest in each continent

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)

# 8. First country of each continent (alphabetically)

SELECT continent, name FROM world x
WHERE name = (SELECT name FROM world y
WHERE y.continent = x.continent
ORDER BY name ASC LIMIT 1);

# 9. 