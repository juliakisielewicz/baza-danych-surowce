CREATE TABLE cennik (
	id INT PRIMARY KEY,
	id_surowca INT,
	rok INT,
	miesiac INT,
	cena_srednia FLOAT(53)
);

INSERT INTO cennik VALUES
(5,1,2017,9,0.90),
(6,2,2017,2,2.40),
(7,2,2017,4,2.00),
(8,3,2017,3,3.50),
(9,3,2017,9,1.66),
(10,3,2017,12,0.22),
(11,1,2018,3,4.50),
(12,1,2018,6,2.12),
(13,5,2016,3,2.22),
(14,4,2017,8,5.34),
(15,4,2017,5,6.66),
(16,4,2016,11,3.45);

SELECT * FROM cennik ORDER BY id;

-- W powy¿szej tabeli wpis dotycz¹cy ceny nie jest powielony

CREATE UNIQUE INDEX idx_cena
 ON cennik (id_surowca, rok, miesiac, cena_srednia);

--INSERT INTO cennik VALUES (17,1,2017,9,0.9); => zwracany b³¹d

-- zapytanie wykorzystane przy tworzeniu raportu:
SELECT a.id_surowca as [ID], a.data, CONVERT(DECIMAL(18,2), b.cena_srednia) as [aktualna cena] FROM 
	(SELECT id_surowca, MAX(FORMAT(CONVERT(DATETIME, CONCAT(CONCAT(CONCAT(CAST(miesiac AS VARCHAR(10)), '/'), CONCAT(CAST(1 AS VARCHAR(10)), '/')), CAST(rok AS VARCHAR(10))), 101),'yyyy/MM')) as data FROM cennik GROUP BY id_surowca) as a
	JOIN cennik as b ON a.data = FORMAT(CONVERT(DATETIME, CONCAT(CONCAT(CONCAT(CAST(miesiac AS VARCHAR(10)), '/'), CONCAT(CAST(1 AS VARCHAR(10)), '/')), CAST(rok AS VARCHAR(10))), 101),'yyyy/MM');


