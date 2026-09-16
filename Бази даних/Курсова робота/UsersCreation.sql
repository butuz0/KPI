USE Restaurant
GO

CREATE LOGIN Administrator WITH PASSWORD = 'Admin'
CREATE USER Administrator FOR LOGIN Administrator
EXEC sp_addrolemember N'db_ddladmin', N'Administrator'
EXEC sp_addrolemember N'db_datawriter', N'Administrator'
EXEC sp_addrolemember N'db_datareader', N'Administrator'
GO

CREATE LOGIN Waiter WITH PASSWORD = 'Waiter'
CREATE USER Waiter FOR LOGIN Waiter
GRANT SELECT, INSERT, UPDATE ON [Order] TO Waiter
GRANT SELECT, INSERT, UPDATE ON Meal_Order TO Waiter
GRANT SELECT ON Menu TO Waiter
GRANT SELECT ON Meal TO Waiter
GRANT SELECT ON Meal_Order TO Waiter
GRANT SELECT ON Ingredient TO Waiter
GRANT SELECT ON Ingredient_Meal TO Waiter
GO

CREATE LOGIN Storage_Manager WITH PASSWORD = 'Storage_Manager'
CREATE USER Storage_Manager FOR LOGIN Storage_Manager
GRANT INSERT, UPDATE, SELECT ON Storage TO Storage_Manager
GRANT INSERT, UPDATE, SELECT ON Ingredient TO Storage_Manager
GRANT INSERT, UPDATE, SELECT ON Delivery TO Storage_Manager
GRANT INSERT, UPDATE, SELECT ON Delivery_Ingredient TO Storage_Manager
GRANT INSERT, UPDATE, SELECT ON [Provider] TO Storage_Manager
GO

CREATE LOGIN Cook WITH PASSWORD = 'Cook'
CREATE USER Cook FOR LOGIN Cook
GRANT SELECT ON Ingredient TO Cook
GRANT SELECT ON Ingredient_Meal TO Cook
GRANT SELECT ON Menu TO Cook
