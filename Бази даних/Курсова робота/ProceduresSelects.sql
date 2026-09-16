USE Restaurant
GO

-- Отримати загальну вартість замовлення за його ID
CREATE FUNCTION Get_order_price (@order_id INT)
RETURNS FLOAT
AS
BEGIN
    IF @order_id IN (SELECT Order_ID FROM [Order])
        RETURN (SELECT SUM(Price) FROM Meal
                INNER JOIN Meal_Order ON Meal.Meal_name = Meal_Order.Meal
                WHERE Meal_Order.Order_ID = @order_id)
    RETURN NULL
END
GO

-----------------------------------------
-- DECLARE @sum FLOAT
-- EXEC @sum = Get_Order_price 21
-- PRINT(@sum)
-- GO
-----------------------------------------

-- Отримати всі страви замовлення за його ID
CREATE FUNCTION Get_order_meals (@order_id INT)
RETURNS TABLE
AS
RETURN (SELECT Meal.* FROM Meal
        INNER JOIN Meal_Order ON Meal.Meal_name = Meal_Order.Meal
        WHERE Meal_Order.Order_ID = @order_id)
GO

-----------------------------------------
-- SELECT * FROM Get_order_meals(21)
-- GO
-----------------------------------------

CREATE PROCEDURE Close_order @order_id INT
AS
BEGIN
    UPDATE [Order]
    SET Active_status = 0
    WHERE Order_ID = @order_id
END
GO

-----------------------------------------
-- UPDATE [Order]
-- SET Active_status = 1
-- WHERE Order_ID = 20

-- SELECT * FROM [Order]
-- WHERE Order_ID = 20

-- EXEC Close_order 20
-- GO

-- SELECT * FROM [Order]
-- WHERE Order_ID = 20
-----------------------------------------

-- Зменшити залишок продуктів на складі, із яких складається замовлена страва
CREATE TRIGGER Meal_Order_insert
ON Meal_Order
AFTER INSERT
AS
BEGIN
    DECLARE @meal VARCHAR(40)
    SELECT @meal = Meal FROM inserted

    DECLARE Ingredient_weight_cursor CURSOR FOR
        SELECT Ingredient, Ingredient_weight FROM Ingredient_Meal
        WHERE Meal = @meal

    OPEN Ingredient_weight_cursor

    DECLARE @ingredient VARCHAR(20)
    DECLARE @ingredient_weight FLOAT

    FETCH FROM Ingredient_weight_cursor INTO @ingredient, @ingredient_weight

    WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE Ingredient
            SET Left_in_storage = Left_in_storage - @ingredient_weight/1000
            WHERE Ingredient_name = @ingredient

            FETCH NEXT FROM Ingredient_weight_cursor INTO @ingredient, @ingredient_weight
        END
    CLOSE Ingredient_weight_cursor
END
GO

-----------------------------------------
-- SELECT * FROM Ingredient
-- WHERE Ingredient_name = 'Jack Daniels'

-- INSERT INTO [Order] (Order_datetime, Waiter)
-- VALUES
--     ('2022-05-06 16:10:00', 3)

-- GO
-- INSERT INTO Meal_Order(Order_ID, Meal)
-- VALUES
--     (32, 'Jack Daniels')
-- GO

-- SELECT * FROM Ingredient
-- WHERE Ingredient_name = 'Jack Daniels'
-- GO
-----------------------------------------

-- Збільшити залишок продуктів на складі, коли заносяться дані про нову доставку
CREATE TRIGGER Delivery_ingredient_insert
ON Delivery_Ingredient
AFTER INSERT
AS
BEGIN
    DECLARE @delivery_id INT
    SELECT @delivery_id = Delivery_ID FROM inserted

    DECLARE Delivery_weight_cursor CURSOR FOR
        SELECT Ingredient, Ingredient_weight FROM Delivery_Ingredient
        WHERE Delivery_ID = @delivery_id

    OPEN Delivery_weight_cursor

    DECLARE @ingredient VARCHAR(20)
    DECLARE @ingredient_weight FLOAT

    FETCH FROM Delivery_weight_cursor INTO @ingredient, @ingredient_weight

    WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE Ingredient
            SET Left_in_storage = Left_in_storage + @ingredient_weight
            WHERE Ingredient_name = @ingredient

            FETCH NEXT FROM Delivery_weight_cursor INTO @ingredient, @ingredient_weight
        END
    CLOSE Delivery_weight_cursor
END
GO
-------------------------------------------
-- SELECT * FROM Ingredient
-- WHERE Ingredient.Ingredient_name = 'Eel'

-- INSERT INTO Delivery_Ingredient(Delivery_ID, Ingredient, Ingredient_weight)
-- VALUES(10, 'Eel', 5)

-- SELECT * FROM Ingredient
-- WHERE Ingredient.Ingredient_name = 'Eel'
-- GO
-------------------------------------------

CREATE VIEW [Monthly Salary]
AS
SELECT 
    Position_name AS [Position],
    Salary,
    COUNT(*) AS [Amount of Employees],
    Salary*COUNT(*) AS [Total Monthly Salary]
    FROM Position
INNER JOIN Employee ON Employee.Position = Position.Position_ID
GROUP BY Position_name, Salary
GO

SELECT * FROM [Monthly Salary]

-- 1) Отримати список замовлених страв для кожного замовлення
SELECT * FROM [Order]
INNER JOIN Meal_Order ON [Order].Order_ID = Meal_Order.Order_ID

-- 2) Отримати інформацію про кожного працівника та його посаду, відсортувати за зменшенням зарплатні
SELECT * FROM Employee
INNER JOIN Position ON Position = Position.Position_ID
ORDER BY Salary DESC

-- 3) Отримати суму яку щомісячно потрібно виплатити усім працівникам на певній посаді
SELECT 
    Position_name AS Position,
    (SELECT COUNT(*) FROM Employee WHERE Position = Position.Position_ID)*Salary AS [Total Salary]
FROM Position
ORDER BY [Total Salary] DESC

-- 4) Отримати страви, які найчастіше замовляють
SELECT 
    Meal_name AS [Meal], 
    COUNT(*) AS [Times Ordered]
FROM Meal 
INNER JOIN Meal_Order ON Meal_Order.Meal = Meal.Meal_name
GROUP BY Meal_name
ORDER BY [Times Ordered] DESC

-- 5) Отримати інформацію про кожне меню та кількість страв у ньому
SELECT 
    Menu_name AS [Menu], 
    COUNT(*) AS [Meals In Menu]
FROM Menu 
INNER JOIN Meal ON Meal.Menu = Menu.ID
GROUP BY Menu_name

-- 6) Отримати інформацію про кожну доставку
SELECT 
    Delivery.ID,
    Delivery_date,
    Ingredient,
    Ingredient_weight,
    (SELECT Provider_name FROM [Provider] WHERE ID = Delivery.Delivery_provider) AS [Provider name]
FROM Delivery
INNER JOIN Delivery_Ingredient ON Delivery.ID = Delivery_Ingredient.Delivery_ID

-- 7) Отримати інформацію про інгредієнти та місце їх зберігання
SELECT 
    Ingredient_name,
    Ingredient_type,
    Storage_type,
    Left_in_storage
FROM Ingredient
LEFT OUTER JOIN Storage ON Ingredient.Storage = Storage.Storage_type

-- 8) Отримати інформацію де повинна зберігатись більшість продуктів певного типу
SELECT 
    Ingredient_type, 
    Storage_type
FROM Ingredient
INNER JOIN Storage ON Ingredient.Storage = Storage.Storage_type
GROUP BY Ingredient_type, Storage_type
HAVING COUNT(*) >= 2

-- 9) Отримати найбільш використовані інгредієнти
SELECT 
    Ingredient_name, COUNT(*) AS [Amount of Meals] 
FROM Ingredient
INNER JOIN Ingredient_Meal ON Ingredient = Ingredient_name
GROUP BY Ingredient_name
ORDER BY [Amount of meals] DESC

--10) Інгредієнти, які скоро потрібно буде замовити, та їх постачальник
SELECT
    Ingredient_name,
    Left_in_storage,
    Provider_name,
    Email
FROM Ingredient
INNER JOIN Delivery_Ingredient ON Delivery_Ingredient.Ingredient = Ingredient.Ingredient_name
INNER JOIN Delivery ON Delivery.ID = Delivery_Ingredient.Delivery_ID
INNER JOIN [Provider] ON [Provider].ID = Delivery.Delivery_provider
WHERE Ingredient.Left_in_storage <= 3

-- 11) Отримати інформацію про меню та страви, які в нього входять
SELECT 
    Menu_name,
    Meal_name,
    Price
FROM Menu
INNER JOIN Meal ON Menu.ID = Meal.Menu
ORDER BY Menu_name

--12) Отримати інформацію скільки замовлень прийняв кожен із офіціантів за 2022 рік
SELECT 
    First_name, 
    Last_name, 
    COUNT(*) AS [Orders Taken] 
FROM Employee
INNER JOIN [Order] ON Waiter = ID
WHERE Order_datetime > '2022-01-01'
GROUP BY First_name, Last_name
ORDER BY [Orders Taken] DESC

--13) Отримати продукти які не входять в жодну страву і дарма займають місце на складі
SELECT 
    Ingredient_name, 
    Left_in_storage 
FROM Ingredient
LEFT OUTER JOIN Ingredient_Meal ON Ingredient.Ingredient_name = Ingredient_Meal.Ingredient
GROUP BY Ingredient_name, Left_in_storage, Meal
HAVING Meal IS NULL

--14) Отримати виручку за 2022 рік
SELECT 
    SUM(Price) AS [Total Earnings]
FROM [Order]
INNER JOIN Meal_Order ON Meal_Order.Order_ID = [Order].Order_ID
INNER JOIN Meal ON Meal.Meal_name = Meal_Order.Meal
WHERE [Order].Order_datetime >= '2022-01-01'

--15) Отримати витрати на доставку інгредієнтів за 2022 рік
SELECT 
    SUM([Total Monthly Salary])*12 + 
    (SELECT SUM(Delivery_sum) FROM Delivery
    WHERE Delivery_date >= '2022-01-01') AS [Total Spendings]
FROM [Monthly Salary]

-- 16) Отримати інформацію про постачальників, у яких найчастіше замовляється доставка
SELECT 
    Provider_name, 
    Email, 
    COUNT(*) AS [Delivery Amount] 
FROM [Provider]
INNER JOIN Delivery ON Delivery_provider = [Provider].ID
GROUP BY Provider_name, Email
ORDER BY [Delivery Amount] DESC

--17) Бонуси для кожного офіціанта за квітень 2022 року
SELECT 
    First_name,
    Last_name,
    ROUND(SUM(Price)*0.1, 0) AS [10% Bonus]
FROM Employee
INNER JOIN [Order] ON [Order].Waiter = Employee.ID
INNER JOIN Meal_Order ON [Order].Order_ID = Meal_Order.Order_ID
INNER JOIN Meal ON Meal.Meal_name = Meal_Order.Meal
WHERE Order_datetime BETWEEN '2022-01-04' AND '2022-30-04'
GROUP BY First_name, Last_name

--18) Список інгредієнтів та коли вони були востаннє доставлені
SELECT
    Ingredient_name,
    Left_in_storage,
    Delivery_date,
    Ingredient_weight
FROM Ingredient
INNER JOIN Delivery_Ingredient ON Delivery_Ingredient.Ingredient = Ingredient.Ingredient_name
INNER JOIN Delivery ON Delivery.ID = Delivery_Ingredient.Delivery_ID
GROUP BY Ingredient_name, Left_in_storage, Delivery_date, Ingredient_weight
ORDER BY Delivery_date DESC

--19) В якому із складів зберігається найбільше продуктів
SELECT 
    Storage_type,
    SUM(Left_in_storage) AS [Total Ingredients Weight]
FROM Storage
INNER JOIN Ingredient ON Ingredient.Storage = Storage.Storage_type
GROUP BY Storage_type
ORDER BY [Total Ingredients Weight] DESC

--20) Яка кількість інгредієнту була використана з моменту останньої доставки
SELECT 
    Ingredient_name,
    Delivery_date,
    (Ingredient_weight - Left_in_storage) AS [Used since last delivery]
FROM Ingredient
INNER JOIN Delivery_Ingredient ON Delivery_Ingredient.Ingredient = Ingredient.Ingredient_name
INNER JOIN Delivery ON Delivery.ID = Delivery_Ingredient.Delivery_ID
GROUP BY Ingredient_name, Delivery_date, (Ingredient_weight - Left_in_storage)
HAVING (Ingredient_weight - Left_in_storage) >= 0
