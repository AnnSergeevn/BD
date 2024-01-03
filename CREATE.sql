
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
  