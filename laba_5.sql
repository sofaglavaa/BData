USE laba_3_sql_sport;
-- Создаем ИНДЕКСЫ и представления
SELECT *from должность
WHERE оклад 
BETWEEN 15000 AND 30000;

CREATE INDEX idx_salary_post ON должность(оклад);


CREATE VIEW nameOfClothes
AS SELECT *from отдел
WHERE`название` = "Женская одежда";

select * from nameOfClothes;

SELECT *from посетитель
WHERE `возраст` = 45 AND `рост`= 164;

CREATE INDEX idx_age_client ON посетитель(возраст, рост);

SELECT *from кража
WHERE время = "11:28:15";

CREATE INDEX idx_theft_time ON кража(время);

SELECT * FROM сотрудник WHERE `рабочий стаж` = 6;
CREATE INDEX idx_work_expirience_specialist ON сотрудник(`рабочий стаж`);

CREATE VIEW scanSize
AS SELECT `Размер`
FROM требования
WHERE `Размер` NOT LIKE '%3%';

select *from scanSize;

CREATE VIEW duties
AS SELECT * FROM должность WHERE `Обязанности` LIKE 'Р%';
select *from duties;

-- ПРОЦЕДУРЫ
-- 1 -- Вывести всех клиентов заданного сотрудника добавиь джоин и выводить возраст посетителя
DELIMITER //
CREATE PROCEDURE pseWorker() 
BEGIN 
	SELECT  `ФИО`, `возраст`
    FROM `обслуживание посетителя сотрудником` 
    JOIN `сотрудник` ON `обслуживание посетителя сотрудником`.`id сотрудника` = сотрудник.id
    JOIN `посетитель` ON `обслуживание посетителя сотрудником`.`id посетителя` = посетитель.id;
END //
DELIMITER ;
CALL pseWorker();
-- 2
DELIMITER //
CREATE PROCEDURE maximumPrize(OUT оклад INT)
BEGIN 
	SELECT MAX(оклад)
    INTO оклад
    FROM должность;
END //
DELIMITER ;

CALL maximumPrize(@MaxSalary);
SELECT @MaxSalary;

select MAX(оклад)  AS `@MaxSalary`
from должность;
-- 3 использовать параметр по цвету
DELIMITER //
CREATE PROCEDURE productAndType()
BEGIN
	SELECT `Форма`, `Название`
    FROM товар
    WHERE Цвет = "Красный";
END //
CALL productAndType

-- ФУНКЦИИ
-- 1 
DELIMITER $$ 
CREATE FUNCTION prize (
	prize INT
)
RETURNS  INT
DETERMINISTIC
BEGIN
	IF prize > 5000 AND prize < 250000 THEN
	SET prize = 0.1 * prize;
	END IF; 
RETURN (prize); 
END $$; 
DELIMITER $$ 	

SELECT prize(оклад)
FROM `должность`
WHERE Название = "Администратор магазина";


SELECT post,specialist.fullname AS correct, postSpecialist (post)
FROM specialist;

-- 2

DELIMITER $$ 
CREATE FUNCTION SizeCloth (Размер int)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN 
	DECLARE correct VARCHAR(100); 
    set correct = CASE
		WHEN Размер >= 35 AND Размер <= 44 THEN "размер S"
        WHEN Размер >= 46 AND Размер <= 48 THEN "размер M"
        WHEN Размер >= 50 AND Размер <= 54 THEN "размер L"
	END;
RETURN (correct); 
END $$; 
DELIMITER $$ 
SELECT  SizeCloth(Размер) AS `size`, `Размер`
FROM требования;

-- 3

DELIMITER $$ 
CREATE FUNCTION newPrice (Стоимость int)
RETURNS int
DETERMINISTIC
BEGIN 
	DECLARE correct VARCHAR(100); 
    IF Стоимость > 500  THEN SET correct = 500; 
ELSE SET correct= 400; 
END IF; 
RETURN (correct); 
END $$; 
DELIMITER $$ 

SELECT Стоимость, Цвет AS correct, newPrice(Стоимость)
FROM товар;

-- Представление

CREATE VIEW ClientInformation
AS SELECT *
FROM посетитель 
JOIN заказ ON заказ.`id посетителя` = посетитель.id
JOIN `заказанный товар` ON `заказанный товар`.`id заказа` = заказ.id
JOIN товар т ON т.id = `заказанный товар`.`id товара`;

SELECT *FROM ClientInformation;

