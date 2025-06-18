CREATE DATABASE IMDB
CREATE TABLE Directors
(
Id INT PRIMARY KEY IDENTITY,
Fullname NVARCHAR(150) NOT NULL
)
CREATE TABLE Genres
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(150) NOT NULL
)
CREATE TABLE Actors
(
Id INT PRIMARY KEY IDENTITY,
Fullname NVARCHAR(150) NOT NULL
)
CREATE TABLE Movies
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(150) NOT NULL,
Point DECIMAL(10,2),
Duration INT,
DirectorId INT FOREIGN KEY REFERENCES Directors(Id)
)
ALTER TABLE Movies ALTER COLUMN Point DECIMAL(3,1)
CREATE TABLE MovieGenre
(
Id INT PRIMARY KEY IDENTITY,
MovieId INT FOREIGN KEY REFERENCES Movies(Id),
GenreId INT FOREIGN KEY REFERENCES Genres(Id)
)


CREATE TABLE MoviesActors
(
Id INT PRIMARY KEY IDENTITY,
MovieId INT FOREIGN KEY REFERENCES Movies(Id),
ActorId INT FOREIGN KEY REFERENCES Actors(Id)
)
SELECT m.[Name] AS MovieName,
       m.Point AS ImdbPoint,
       g.[Name] AS GenreName,
       d.Fullname AS DirectorName,
       a.Fullname AS ActorName
FROM Movies m
JOIN MovieGenre mg ON m.Id=mg.MovieId
JOIN Genres g ON mg.GenreId=g.Id
JOIN Directors d ON m.Id=d.Id
JOIN MoviesActors ma ON m.Id = ma.Id
JOIN Actors a ON ma.Id=a.Id
WHERE m.Point>6

SELECT m.Name AS MovieName,
       m.Point,
       g.[Name] AS GenreName
FROM Movies m
JOIN MovieGenre mg ON m.Id=mg.Id
JOIN Genres g ON g.Id=mg.Id
WHERE g.[Name] LIKE '%a%'

SELECT m.[Name] AS MovieName,
       m.Point,
       m.Duration,
       g.[Name] AS GenreName
FROM Movies m
JOIN MovieGenre mg ON m.Id=mg.Id
JOIN Genres g ON g.Id=mg.Id
WHERE Len(m.[Name])>10 AND m.[Name] LIKE  '%t'

SELECT 
    m.[Name] AS MovieName,
    m.Point,
    g.[Name] AS GenreName,
    d.Fullname AS DirectorName,
    a.Fullname AS ActorName
FROM Movies m
JOIN Directors d ON m.Id = d.id
JOIN MovieGenre mg ON m.id = mg.Id
JOIN Genres g ON mg.Id = g.id
JOIN MoviesActors ma ON m.id = ma.Id
JOIN Actors a ON ma.Id = a.id
WHERE m.Point > (
    SELECT AVG(Point) FROM Movies
)



