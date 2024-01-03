SELECT  title, time FROM Treks
WHERE time = (SELECT MAX(time) FROM Treks);


SELECT  title FROM Treks
WHERE time >= 3.5;

SELECT  years FROM sbornik
WHERE years >= '2018' AND years < '2021';

-- Исполнители, чьё имя состоит из одного слова.
SELECT name FROM performers WHERE not name like '%% %%';

--Название треков, которые содержат слово «мой» или «my».
SELECT  title FROM Treks
WHERE title like '%%My%%';



-- Количество исполнителей в каждом жанре

SELECT g.title, count(p.name)
FROM musgenres as g
LEFT JOIN genresperfom as gp on g.id = gp.musgenres_id
LEFT JOIN performers as p on gp.performers_id = p.id
GROUP BY g.title
ORDER BY count(p.id) DESC


--Количество треков, вошедших в альбомы 2019–2020 годов.

SELECT count(t.title)
FROM alboms as a
LEFT JOIN treks as t on t.alboms_id = a.id
WHERE (a.years >= 2019) AND (a.years <= 2020)



SELECT COUNT(t.title)
FROM alboms AS a
LEFT JOIN treks AS t ON t.alboms_id = a.id
WHERE a.years BETWEEN 2018 AND 2020;

--Средняя продолжительность треков по каждому альбому.

SELECT a.name_albom, AVG(t.time)
FROM alboms AS a
LEFT JOIN treks AS t ON t.alboms_id = a.id
GROUP BY a.name_albom
ORDER BY AVG(t.time)

--Все исполнители, которые не выпустили альбомы в 2020 году.

SELECT DISTINCT p.name
FROM performers AS p
WHERE p.name NOT IN (
    SELECT DISTINCT p.name
    FROM performers AS p
    LEFT JOIN perfomalbom AS pa ON p.id = pa.performers_id
    LEFT JOIN alboms AS a ON a.id = pa.alboms_id
    WHERE a.years = 2020
)
ORDER BY p.name


--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).



SELECT DISTINCT s.title
FROM sbornik AS s
LEFT JOIN sbornik_treks AS st ON s.id = st.sbornik_id
LEFT JOIN treks AS t ON t.id = st.treks_id
LEFT JOIN alboms AS a ON a.id = t.alboms_id
LEFT JOIN perfomalbom AS ap ON ap.alboms_id = a.id
LEFT JOIN performers AS p ON p.id = ap.performers_id
WHERE p.name LIKE '%%AB%%'
ORDER BY s.title

-- название альбомов, в которых присутствуют исполнители более 1 жанра

SELECT a.name_albom 
FROM alboms AS a
LEFT JOIN perfomalbom AS ap ON a.id = ap.alboms_id
LEFT JOIN performers AS p ON p.id = ap.performers_id
LEFT JOIN genresperfom AS gp ON p.id = gp.performers_id
LEFT JOIN musgenres AS g ON g.id = gp.musgenres_id
GROUP BY a.name_albom 
HAVING count(DISTINCT g.title) > 1
ORDER BY a.name_albom 

--наименование треков, которые не входят в сборники
SELECT t.title
FROM treks AS t
LEFT JOIN sbornik_treks AS st ON t.id = st.treks_id
WHERE st.treks_id IS NULL

--исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)

SELECT p.name, t.time
FROM treks AS t
LEFT JOIN alboms AS a on a.id = t.alboms_id
LEFT JOIN perfomalbom AS ap on ap.alboms_id = a.id
LEFT JOIN performers AS p on p.id = ap.performers_id
GROUP BY p.name, t.time
HAVING t.time  = (SELECT min(time) FROM treks)
ORDER BY p.name

--название альбомов, содержащих наименьшее количество треков

SELECT DISTINCT a.name_albom 
FROM alboms as a
LEFT JOIN treks as t on t.alboms_id = a.id
WHERE t.alboms_id in (
    SELECT alboms_id
    FROM treks
    GROUP BY alboms_id
    HAVING count(id) = (
        SELECT count(id)
        FROM treks
        GROUP BY alboms_id
        ORDER BY count
        LIMIT 1
    )
)
ORDER BY a.name_albom

