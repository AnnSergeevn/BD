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

INSERT INTO Treks(title, time, alboms_id) 
VALUES('Sometimes', '4.05', '6');



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