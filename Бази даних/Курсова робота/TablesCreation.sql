USE Restaurant
GO

CREATE TABLE Position
(
    Position_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Position_name VARCHAR(20) NOT NULL,
    Salary INT NOT NULL CHECK (Salary >= 0),
)
GO

CREATE TABLE Employee
(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    First_name VARCHAR(20),
    Last_name VARCHAR(20),
    Position INT NOT NULL FOREIGN KEY
    REFERENCES Position(Position_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
GO

CREATE TABLE [Order]
(
    Order_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Order_datetime SMALLDATETIME NOT NULL,
    Active_status BIT,
    Waiter INT NOT NULL FOREIGN KEY
    REFERENCES Employee(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
GO

CREATE TABLE Menu
(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    Menu_name VARCHAR(20) NOT NULL
)
GO

CREATE TABLE Meal
(
    Meal_name VARCHAR(40) PRIMARY KEY,
    Price FLOAT NOT NULL CHECK (Price > 0),
    Meal_weight FLOAT NOT NULL CHECK (Meal_weight > 0),
    Menu INT FOREIGN KEY
    REFERENCES Menu(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
GO

CREATE TABLE Meal_Order
(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    Meal VARCHAR(40) FOREIGN KEY
    REFERENCES Meal(Meal_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    Order_ID INT NOT NULL FOREIGN KEY
    REFERENCES [Order](Order_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
GO

CREATE TABLE Storage
(
    Storage_type VARCHAR(20) PRIMARY KEY,
    Temperature FLOAT
)
GO

CREATE TABLE Ingredient
(
    Ingredient_name VARCHAR(20) PRIMARY KEY,
    Ingredient_type VARCHAR(20),
    Left_in_storage FLOAT CHECK (Left_in_storage >= 0),
    Storage VARCHAR(20) NOT NULL FOREIGN KEY
    REFERENCES Storage(Storage_type)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
GO

CREATE TABLE Provider
(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    Provider_name VARCHAR(40),
    Email VARCHAR(60) NOT NULL CHECK (Email LIKE '_%@__%.__%')
)
GO

CREATE TABLE Delivery
(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    Delivery_date DATE NOT NULL, 
    Delivery_sum INT NOT NULL,
    Delivery_provider INT FOREIGN KEY
    REFERENCES [Provider](ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
GO

CREATE TABLE Ingredient_Meal
(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    Ingredient VARCHAR(20) NOT NULL FOREIGN KEY
    REFERENCES Ingredient(Ingredient_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    Meal VARCHAR(40) NOT NULL FOREIGN KEY
    REFERENCES Meal(Meal_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    Ingredient_weight FLOAT
)

CREATE TABLE Delivery_Ingredient
(   
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    Delivery_ID INT NOT NULL FOREIGN KEY
    REFERENCES Delivery(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    Ingredient VARCHAR(20) FOREIGN KEY
    REFERENCES Ingredient(Ingredient_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    Ingredient_weight FLOAT
)