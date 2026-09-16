USE Restaurant
GO

CREATE INDEX order_id_index ON [Order](Order_ID)
CREATE INDEX order_date_index ON [Order](Order_datetime)
CREATE INDEX meal_index ON [Meal_Order](Meal)
CREATE INDEX order_index ON [Meal_Order](Order_id)
CREATE INDEX main_meal_index ON Meal(Meal_name)
CREATE INDEX ingredient_index ON Ingredient_Meal(Ingredient)
CREATE INDEX ingred_meal_index ON Ingredient_Meal(Meal)
CREATE INDEX delivery_id_index ON Delivery(ID)
CREATE INDEX delivery_date_index ON Delivery(Delivery_date)
