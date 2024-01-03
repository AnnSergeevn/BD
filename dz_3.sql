
CREATE TABLE IF NOT EXISTS Performers (
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL
   );
  


CREATE TABLE IF NOT EXISTS MusGenres (
	id SERIAL PRIMARY KEY,
	title VARCHAR(80) UNIQUE
	);

CREATE TABLE IF NOT EXISTS GenresPerfom (
	id SERIAL PRIMARY KEY,
	musgenres_id INTEGER NOT NULL REFERENCES MusGenres(id),
	performers_id INTEGER NOT NULL REFERENCES Performers(id)
	
	);

  
 CREATE TABLE IF NOT EXISTS Sbornik (
	id SERIAL PRIMARY KEY,
	title VARCHAR(80) UNIQUE,
	years numeric CHECK (years > 1988)
);


CREATE TABLE IF NOT EXISTS Alboms (
	id SERIAL PRIMARY KEY,
	years numeric CHECK (years > 1988),
	name_albom VARCHAR(80) NOT NULL
   );
  
CREATE TABLE IF NOT EXISTS PerfomAlbom (
	id SERIAL PRIMARY KEY,
	alboms_id INTEGER NOT NULL REFERENCES Alboms(id),
	performers_id INTEGER NOT NULL REFERENCES Performers(id)
	);

CREATE TABLE IF NOT EXISTS Treks (
	id SERIAL PRIMARY KEY,
	title VARCHAR(80) NOT NULL,
	time numeric CHECK (time < 10),
	alboms_id INTEGER NOT NULL REFERENCES Alboms(id)
   );    
  
CREATE TABLE IF NOT EXISTS Sbornik_Treks (
	id SERIAL PRIMARY KEY,
	treks_id INTEGER NOT NULL REFERENCES Treks(id),
	sbornik_id INTEGER NOT NULL REFERENCES Sbornik(id)
	);
  

-- добавим исполнителей
INSERT INTO Performers(name) 
VALUES('ABBA');

INSERT INTO Performers(name) 
VALUES('Santana');

INSERT INTO Performers(name) 
VALUES('Эрик Клэптон');

INSERT INTO Performers(name) 
VALUES('Бритни Спирс');

-- добавим жанры
INSERT INTO MusGenres(title) 
VALUES('Поп');

INSERT INTO MusGenres(title) 
VALUES('Рок');

INSERT INTO MusGenres(title) 
VALUES('Акустический блюз');


-- добавим альбомы
INSERT INTO alboms(name_albom, years) 
VALUES('Abba Gold','1992');

INSERT INTO alboms(name_albom, years) 
VALUES('Supernatural', '1999');

INSERT INTO alboms(name_albom, years) 
VALUES('Unplugged', '1992');

INSERT INTO alboms(name_albom, years) 
VALUES('Baby one', '1999');

INSERT INTO alboms(name_albom, years) 
VALUES('Baby', '2019');

-- добавим треки
INSERT INTO treks (title, time, alboms_id) 
VALUES('Dancing Queen', '3.51', '1');

INSERT INTO Treks(title, time, alboms_id) 
VALUES('Mamma Mia', '3.33', '1');

INSERT INTO Treks(title, time, alboms_id) 
VALUES('Love of My Life', '5.47', '2');

INSERT INTO Treks(title, time, alboms_id) 
VALUES('Signe', '3.13', '3');

INSERT INTO Treks(title, time, alboms_id) 
VALUES('Baby one More time', '3.30', '4');


INSERT INTO Treks(title, time, alboms_id) 
VALUES('Sometimes', '4.05', '4');



-- добавим сборники
INSERT INTO sbornik(title, years) 
VALUES('Happy new year', '2009');


INSERT INTO sbornik(title, years) 
VALUES('Abba Platinum', '2017');

INSERT INTO sbornik(title, years) 
VALUES('Smooth', '2007');

INSERT INTO sbornik(title, years) 
VALUES('Clapton', '1999');

INSERT INTO sbornik(title, years) 
VALUES('Spirs', '2009');

INSERT INTO sbornik(title, years) 
VALUES('Abba', '2019');

-- добавим жанр-исполнитель

INSERT INTO genresperfom(musgenres_id, performers_id) 
VALUES('1', '1');

INSERT INTO genresperfom(musgenres_id, performers_id)
VALUES('2', '2');

INSERT INTO genresperfom(musgenres_id, performers_id)
VALUES('3', '3');

INSERT INTO genresperfom(musgenres_id, performers_id)
VALUES('1', '4');


-- добавим исполнитель-альбом

INSERT INTO perfomalbom(alboms_id, performers_id) 
VALUES('1', '1');

INSERT INTO perfomalbom(alboms_id, performers_id) 
VALUES('2', '2');

INSERT INTO perfomalbom(alboms_id, performers_id) 
VALUES('3', '3');

INSERT INTO perfomalbom(alboms_id, performers_id) 
VALUES('4', '4');


-- добавим  сборник- трекс

INSERT INTO sbornik_treks(treks_id, sbornik_id) 
VALUES('1', '1');

INSERT INTO sbornik_treks(treks_id, sbornik_id) 
VALUES('2', '1');

INSERT INTO sbornik_treks(treks_id, sbornik_id) 
VALUES('3', '3');

INSERT INTO sbornik_treks(treks_id, sbornik_id) 
VALUES('4', '4');

INSERT INTO sbornik_treks(treks_id, sbornik_id) 
VALUES('5', '6');

INSERT INTO sbornik_treks(treks_id, sbornik_id) 
VALUES('6', '6');


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

--Средняя продолжительность треков по каждому альбому.

select a.name, AVG(t.length)
from albums as a
left join tracks as t on t.album_id = a.id
group by a.name
order by AVG(t.length)

--Все исполнители, которые не выпустили альбомы в 2020 году.

select distinct m.name
from musicians as m
where m.name not in (
    select distinct m.name
    from musicians as m
    left join albums_musicians as am on m.id = am.musician_id
    left join albums as a on a.id = am.album_id
    where a.year = 2020
)
order by m.name


--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).



select distinct c.name
from collections as c
left join collections_tracks as ct on c.id = ct.collection_id
left join tracks as t on t.id = ct.track_id
left join albums as a on a.id = t.album_id
left join albums_musicians as am on am.album_id = a.id
left join musicians as m on m.id = am.musician_id
where m.name like '%%Steve%%'
order by c.name
