-- �������� ���� ������
USE master;
GO
DROP DATABASE IF EXISTS TravelGraphDB;
GO
CREATE DATABASE TravelGraphDB;
GO
USE TravelGraphDB;
GO

-- ������� �������� (12 �������)
CREATE TABLE Tourists (
    TouristID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Age INT,
    Email NVARCHAR(100),
    TravelStyle NVARCHAR(50) -- adventure, cultural, luxury � �.�.
) AS NODE;

-- ������� ������� (12 �������)
CREATE TABLE Cities (
    CityID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Country NVARCHAR(100),
    Population INT,
    Climate NVARCHAR(50)
) AS NODE;

-- ������� ���������������������� (12 �������)
CREATE TABLE Attractions (
    AttractionID INT PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Type NVARCHAR(100), -- museum, nature, historical � �.�.
    EntryFee DECIMAL(10,2),
    Rating DECIMAL(3,1)
) AS NODE;


-- ������� ��������� ������ ����� ���������
CREATE TABLE TravelBuddies AS EDGE;
ALTER TABLE TravelBuddies
ADD CONSTRAINT EC_TravelBuddies CONNECTION (Tourists TO Tourists);

-- ������� ��������� ������� ���������
CREATE TABLE Visited (
    VisitYear INT,
    DurationDays INT,
    Rating INT
) AS EDGE;
ALTER TABLE Visited
ADD CONSTRAINT EC_Visited CONNECTION (Tourists TO Cities);

-- ������� ������������ ���������������������� � �������
CREATE TABLE LocatedIn AS EDGE;
ALTER TABLE LocatedIn
ADD CONSTRAINT EC_LocatedIn CONNECTION (Attractions TO Cities);

---- ������� ������������ ����������������������
--CREATE TABLE Recommends (
--    Rating INT,
--    Comment NVARCHAR(500),
--    VisitDate DATE
--) AS EDGE;
--ALTER TABLE Recommends
--ADD CONSTRAINT EC_Recommends CONNECTION (Tourists TO Attractions);


-- ���������� ������� Tourists (12 �������)
INSERT INTO Tourists (TouristID, Name, Age, Email, TravelStyle) VALUES
(1, '���� ������', 28, 'ivan@mail.com', 'adventure'),
(2, '����� ��������', 32, 'maria@gmail.com', 'cultural'),
(3, '������� �������', 25, 'alex@yandex.ru', 'backpacker'),
(4, '����� ���������', 41, 'olga@mail.com', 'luxury'),
(5, '������� ������', 36, 'dmitry@gmail.com', 'family'),
(6, '���� ��������', 29, 'anna@yandex.ru', 'solo'),
(7, '������ �������', 45, 'sergey@mail.com', 'business'),
(8, '������� ������', 31, 'nataly@gmail.com', 'backpacker'),
(9, '����� �������', 27, 'pavel@yandex.ru', 'adventure'),
(10, '��������� ��������', 38, 'ekaterina@mail.com', 'cultural'),
(11, '����� �������', 33, 'artem@gmail.com', 'luxury'),
(12, '���� ���������', 26, 'julia@yandex.ru', 'family');

-- ���������� ������� Cities (12 �������)
INSERT INTO Cities (CityID, Name, Country, Population, Climate) VALUES
(1, '�����', '�������', 2148000, '���������'),
(2, '���', '������', 2873000, '�����������������'),
(3, '���������', '�������', 1620000, '�����������������'),
(4, '�����', '�����', 1309000, '���������'),
(5, '���������', '����������', 872000, '�������'),
(6, '����', '�������', 1920000, '���������'),
(7, '������', '��������', 3769000, '���������'),
(8, '��������', '����������', 505000, '�����������������'),
(9, '���������', '������', 380000, '�����������������'),
(10, '�������', '������', 260000, '�����������������'),
(11, '��������', '�������', 1750000, '���������'),
(12, '����������', '�����', 633000, '�������');

-- ���������� ������� Attractions (12 �������)
INSERT INTO Attractions (AttractionID, Name, Type, EntryFee, Rating) VALUES
(1, '�������� �����', 'landmark', 25.50, 4.7),
(2, '�������', 'historical', 16.00, 4.8),
(3, '������� �������', 'architecture', 26.00, 4.9),
(4, '�������� ����', 'historical', 15.50, 4.6),
(5, '����������', 'museum', 20.00, 4.7),
(6, 'ظ������', 'palace', 22.00, 4.6),
(7, '��������������� ������', 'landmark', 0.00, 4.4),
(8, '����� �����', 'historical', 6.00, 4.3),
(9, '����� �����-�����-����-�����', 'architecture', 18.00, 4.8),
(10, '������ �����', 'historical', 25.00, 4.6),
(11, '�������� �������', 'landmark', 10.00, 4.5),
(12, '���������', 'landmark', 0.00, 4.3);

-- ���������� TravelBuddies (��������� �����)
INSERT INTO TravelBuddies ($from_id, $to_id) VALUES
((SELECT $node_id FROM Tourists WHERE TouristID = 1), (SELECT $node_id FROM Tourists WHERE TouristID = 2)),
((SELECT $node_id FROM Tourists WHERE TouristID = 1), (SELECT $node_id FROM Tourists WHERE TouristID = 3)),
((SELECT $node_id FROM Tourists WHERE TouristID = 2), (SELECT $node_id FROM Tourists WHERE TouristID = 4)),
((SELECT $node_id FROM Tourists WHERE TouristID = 3), (SELECT $node_id FROM Tourists WHERE TouristID = 5)),
((SELECT $node_id FROM Tourists WHERE TouristID = 4), (SELECT $node_id FROM Tourists WHERE TouristID = 6)),
((SELECT $node_id FROM Tourists WHERE TouristID = 5), (SELECT $node_id FROM Tourists WHERE TouristID = 7)),
((SELECT $node_id FROM Tourists WHERE TouristID = 6), (SELECT $node_id FROM Tourists WHERE TouristID = 8)),
((SELECT $node_id FROM Tourists WHERE TouristID = 7), (SELECT $node_id FROM Tourists WHERE TouristID = 9)),
((SELECT $node_id FROM Tourists WHERE TouristID = 8), (SELECT $node_id FROM Tourists WHERE TouristID = 10)),
((SELECT $node_id FROM Tourists WHERE TouristID = 9), (SELECT $node_id FROM Tourists WHERE TouristID = 11)),
((SELECT $node_id FROM Tourists WHERE TouristID = 10), (SELECT $node_id FROM Tourists WHERE TouristID = 12)),
((SELECT $node_id FROM Tourists WHERE TouristID = 11), (SELECT $node_id FROM Tourists WHERE TouristID = 1));

-- ���������� Visited (��������� �������)
INSERT INTO Visited ($from_id, $to_id, VisitYear, DurationDays, Rating) VALUES
((SELECT $node_id FROM Tourists WHERE TouristID = 1), (SELECT $node_id FROM Cities WHERE CityID = 1), 2022, 5, 5),
((SELECT $node_id FROM Tourists WHERE TouristID = 1), (SELECT $node_id FROM Cities WHERE CityID = 3), 2021, 3, 4),
((SELECT $node_id FROM Tourists WHERE TouristID = 2), (SELECT $node_id FROM Cities WHERE CityID = 2), 2023, 7, 5),
((SELECT $node_id FROM Tourists WHERE TouristID = 3), (SELECT $node_id FROM Cities WHERE CityID = 4), 2022, 4, 4),
((SELECT $node_id FROM Tourists WHERE TouristID = 4), (SELECT $node_id FROM Cities WHERE CityID = 5), 2021, 2, 3),
((SELECT $node_id FROM Tourists WHERE TouristID = 5), (SELECT $node_id FROM Cities WHERE CityID = 6), 2023, 5, 5),
((SELECT $node_id FROM Tourists WHERE TouristID = 6), (SELECT $node_id FROM Cities WHERE CityID = 7), 2022, 3, 4),
((SELECT $node_id FROM Tourists WHERE TouristID = 7), (SELECT $node_id FROM Cities WHERE CityID = 8), 2021, 4, 4),
((SELECT $node_id FROM Tourists WHERE TouristID = 8), (SELECT $node_id FROM Cities WHERE CityID = 9), 2023, 6, 5),
((SELECT $node_id FROM Tourists WHERE TouristID = 9), (SELECT $node_id FROM Cities WHERE CityID = 10), 2022, 2, 3),
((SELECT $node_id FROM Tourists WHERE TouristID = 10), (SELECT $node_id FROM Cities WHERE CityID = 11), 2021, 5, 4),
((SELECT $node_id FROM Tourists WHERE TouristID = 11), (SELECT $node_id FROM Cities WHERE CityID = 12), 2023, 3, 5);

-- ���������� LocatedIn (������������ ����������������������)
INSERT INTO LocatedIn ($from_id, $to_id) VALUES
((SELECT $node_id FROM Attractions WHERE AttractionID = 1), (SELECT $node_id FROM Cities WHERE CityID = 1)),
((SELECT $node_id FROM Attractions WHERE AttractionID = 2), (SELECT $node_id FROM Cities WHERE CityID = 2)),
((SELECT $node_id FROM Attractions WHERE AttractionID = 3), (SELECT $node_id FROM Cities WHERE CityID = 3)),
((SELECT $node_id FROM Attractions WHERE AttractionID = 4), (SELECT $node_id FROM Cities WHERE CityID = 4)),
((SELECT $node_id FROM Attractions WHERE AttractionID = 5), (SELECT $node_id FROM Cities WHERE CityID = 5)),
((SELECT $node_id FROM Attractions WHERE AttractionID = 6), (SELECT $node_id FROM Cities WHERE CityID = 6)),
((SELECT $node_id FROM Attractions WHERE AttractionID = 7), (SELECT $node_id FROM Cities WHERE CityID = 7)),
((SELECT $node_id FROM Attractions WHERE AttractionID = 8), (SELECT $node_id FROM Cities WHERE CityID = 8)),
((SELECT $node_id FROM Attractions WHERE AttractionID = 9), (SELECT $node_id FROM Cities WHERE CityID = 9)),
((SELECT $node_id FROM Attractions WHERE AttractionID = 10), (SELECT $node_id FROM Cities WHERE CityID = 10)),
((SELECT $node_id FROM Attractions WHERE AttractionID = 11), (SELECT $node_id FROM Cities WHERE CityID = 11)),
((SELECT $node_id FROM Attractions WHERE AttractionID = 12), (SELECT $node_id FROM Cities WHERE CityID = 12));

---- ���������� Recommends (������������ ����������������������)
--INSERT INTO Recommends ($from_id, $to_id, Rating, Comment, VisitDate) VALUES
--((SELECT $node_id FROM Tourists WHERE TouristID = 1), (SELECT $node_id FROM Attractions WHERE AttractionID = 1), 5, '����������� �������� �������!', '2022-06-15'),
--((SELECT $node_id FROM Tourists WHERE TouristID = 2), (SELECT $node_id FROM Attractions WHERE AttractionID = 2), 4, '���������� ��������� �� �������', '2023-04-22'),
--((SELECT $node_id FROM Tourists WHERE TouristID = 3), (SELECT $node_id FROM Attractions WHERE AttractionID = 3), 5, '����������� �����������!', '2022-09-10'),
--((SELECT $node_id FROM Tourists WHERE TouristID = 4), (SELECT $node_id FROM Attractions WHERE AttractionID = 4), 4, '�������� ��� �� �����', '2021-11-05'),
--((SELECT $node_id FROM Tourists WHERE TouristID = 5), (SELECT $node_id FROM Attractions WHERE AttractionID = 5), 5, '�������� ��������� ���������', '2023-03-18'),
--((SELECT $node_id FROM Tourists WHERE TouristID = 6), (SELECT $node_id FROM Attractions WHERE AttractionID = 6), 4, '���������� ��������� ��������', '2022-08-12'),
--((SELECT $node_id FROM Tourists WHERE TouristID = 7), (SELECT $node_id FROM Attractions WHERE AttractionID = 7), 4, '������ ������', '2021-05-30'),
--((SELECT $node_id FROM Tourists WHERE TouristID = 8), (SELECT $node_id FROM Attractions WHERE AttractionID = 8), 3, '���������, �� ���������', '2023-07-25'),
--((SELECT $node_id FROM Tourists WHERE TouristID = 9), (SELECT $node_id FROM Attractions WHERE AttractionID = 9), 5, '����������� �����!', '2022-10-14'),
--((SELECT $node_id FROM Tourists WHERE TouristID = 10), (SELECT $node_id FROM Attractions WHERE AttractionID = 10), 4, '������� �������', '2021-12-08'),
--((SELECT $node_id FROM Tourists WHERE TouristID = 11), (SELECT $node_id FROM Attractions WHERE AttractionID = 11), 5, '���������� ��� �� �����', '2023-05-20'),
--((SELECT $node_id FROM Tourists WHERE TouristID = 12), (SELECT $node_id FROM Attractions WHERE AttractionID = 12), 3, '���������, �� ��������', '2022-11-03');


-- 1. ��� ������ ����������� ������� (����� �������)?
SELECT t2.Name AS FriendName, t2.TravelStyle
FROM Tourists t1, TravelBuddies, Tourists t2
WHERE MATCH(t1-(TravelBuddies)->t2)
AND t1.Name = '���� ������';

-- 2. ����� ������ ������� ������ � ��� ������?
SELECT t1.Name AS Tourist, t2.Name AS Friend, c.Name AS City, v.VisitYear, v.Rating
FROM Tourists t1, TravelBuddies, Tourists t2, Visited v, Cities c
WHERE MATCH(t1-(TravelBuddies)->t2-(v)->c)
AND t1.Name = '���� ������'
ORDER BY v.VisitYear DESC;

-- 3. ����� ��������������������� ����������� ������ �������?
SELECT t2.Name AS Friend, a.Name AS Attraction, a.Type, r.Rating, r.Comment
FROM Tourists t1, TravelBuddies, Tourists t2, Recommends r, Attractions a
WHERE MATCH(t1-(TravelBuddies)->t2-(r)->a)
AND t1.Name = '���� ������'
ORDER BY r.Rating DESC;

-- 4. ����� ��������������������� � �������, ������� ������� ������?
SELECT t.Name AS Tourist, c.Name AS City, a.Name AS Attraction, a.Type, a.Rating
FROM Tourists t, Visited v, Cities c, LocatedIn li, Attractions a
WHERE MATCH(t-(v)->c<-(li)-a)
AND t.Name = '���� ������';

-- 5. ����� ��������������������� ��������� ����� ���� ��������?
SELECT a.Name AS Attraction, AVG(r.Rating) AS AvgRating, COUNT(*) AS RecommendationsCount
FROM Tourists t, Recommends r, Attractions a
WHERE MATCH(t-(r)->a)
GROUP BY a.Name
HAVING COUNT(*) > 1
ORDER BY AvgRating DESC;

-- 6. ��� �� �������� ������� ���� � �� �� ������?
SELECT t1.Name AS Tourist1, t2.Name AS Tourist2, c.Name AS City
FROM Tourists t1, Visited v1, Cities c, Visited v2, Tourists t2
WHERE MATCH(t1-(v1)->c<-(v2)-t2)
AND t1.Name <> t2.Name
ORDER BY c.Name;



-- ����� ��� ��������� ���� ��������� �� ����� ������� �� ������ ��������
SELECT 
    t1.Name AS StartTourist,
    STRING_AGG(t2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS ConnectionPath,
    COUNT(t2.Name) WITHIN GROUP (GRAPH PATH) AS ConnectionLevel,
    LAST_VALUE(t2.Name) WITHIN GROUP (GRAPH PATH) AS EndTourist
FROM 
    Tourists AS t1,
    TravelBuddies FOR PATH AS tb,
    Tourists FOR PATH AS t2
WHERE 
    MATCH(SHORTEST_PATH(t1(-(tb)->t2)+))
    AND t1.Name = '���� ������'
ORDER BY 
    ConnectionLevel, EndTourist;


-- � ��� ���� ������ ����� ������������� ����� 1-3 ������ ���������
SELECT 
    t1.Name AS StartTourist,
    STRING_AGG(t2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS ConnectionPath,
    COUNT(t2.Name) WITHIN GROUP (GRAPH PATH) AS LevelsDeep
FROM 
    Tourists AS t1,
    TravelBuddies FOR PATH AS tb,
    Tourists FOR PATH AS t2
WHERE 
    MATCH(SHORTEST_PATH(t1(-(tb)->t2){1,3}))
    AND t1.Name = '���� ������'
ORDER BY 
    LevelsDeep;