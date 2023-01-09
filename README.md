# Pizza-Restaurant
Ben is opening a new pizzeria in the town, it will be a dining room withe delivery service like Domino´s.
For this, Ben has given us the task to design the back-end of the ordering system, for this we will perform a tailor made relational database for future analysis. For the front end, Ben is hiring someone else.
For this, Ben has given us a brief with the key points and data that he will be monitoring. 
First is the Orders data required, this is:
- Item name
- Item price
- Quantity
- Customer name
- Delivery address

Ben has also given us the menu that the pizzeria is offering, to have more information about the task.

![image](https://user-images.githubusercontent.com/39070251/210880601-cf289081-9bf8-4c3f-9792-c567d8701d6f.png)

Just looking at the menu, we can obserb that there is different sizes of pizza, and categorys, so this will be information that need to be adressed into the database.
Also there are Stock control requirements, for example, he wants to be able to know when it is time to order new stock, to do this we´re going to need more information about:
- what ingredients go into each pizza
- their quantity based on the size of the pizza 
- the existing stock level

**(For simplicity porpouses we assume that all the lead times are the same)**

And finally, there is Staff data. Ben wants to know which staff members are working when, based on the staff salary information, how much each pizza costs (ingredients, chef, delivery).

So after listening carefully about what the client (Ben) wants, the final relational database looks something like this:

![image](https://user-images.githubusercontent.com/39070251/210882667-8c71d005-5a79-4f45-8f79-5953b1855461.png)

And after creating the tables in MySQL and importing the sample data, the next to-do task is create the fist dashboard.
For this, after chatting with Ben, the requirements are the following:
- Total orders
- Total Sales
- Total items
- Average order Value
- Sales by category
- Top selling items
- Orders by hour
- Sales by hour
- Orders by address
- Orders by delivery/pick up

So the SQL query to gather this information its like this.
```sql
SELECT
o.order_id,
i.item_price,
o.quantity,
i.item_cat,
o.created_at,
a.delivery_city,
a.delivery_address1,
a.delivery_address2,
a.delivery_city,
a.delivery_zipcode,
o.delivery
from orders o 
left join item i on i.item_id = o.item_id
left join address a on a.add_id = o.add_id
```

Output:
![image](https://user-images.githubusercontent.com/39070251/211308823-21462524-8487-4e45-9b9f-e5239f2b69c3.png)

This is all the information that we will need for the first dashboard, now lets get the info for the second one.
So, the aim of this dashboard is for inventory management, so due this in mind, there are 4 main focus points:
- Total quantity by ingredient
- Total cost of ingredients
- Calculated cost of pizza
- Percentage stock remaining by ingredient.

First, lets calculate the total quantity by ingredient.
```sql
SELECT
o.item_id,
i.sku,
i.item_name,
r.ing_id,
ing.ing_name,
r.quantity as recipe_quantity,
sum(o.quantity) as order_quantity
FROM 
	orders o
	left join item i on o.item_id = i.item_id
	left join recipe r on i.sku = r.recipe_id
	left join ingredient ing on ing.ing_id = r.ing_id
group by
 o.item_id,
 i.sku,
 i.item_name,
 r.ing_id, 
 ing.ing_name,
 r.quantity
```

Output:

![image](https://user-images.githubusercontent.com/39070251/211321141-afa34ab7-3d36-4339-9a2f-ee427b525437.png)

Now, lets calculate the total cost of ingredients.
With the previous query, we have all the info that we need, but, because we need to calculate de cost of each ingredient, we cannot use directly the column order_quantity, because its an aggregate column, so we use a subquery format an name it S1.
```sql
SELECT 
S1.item_name,
S1.ing_name,
S1.recipe_quantity,
S1.order_quantity,
S1.order_quantity*S1.recipe_quantity as ordered_weight,
S1.ing_price/S1.ing_weight as unit_cost,
(S1.order_quantity*S1.recipe_quantity)*(S1.ing_price/S1.ing_weight) as ingredient_cost
FROM (SELECT
o.item_id,
i.sku,
i.item_name,
r.ing_id,
ing.ing_name,
ing.ing_price,
ing.ing_weight,
r.quantity as recipe_quantity,
sum(o.quantity) as order_quantity
FROM 
	orders o
	left join item i on o.item_id = i.item_id
	left join recipe r on i.sku = r.recipe_id
	left join ingredient ing on ing.ing_id = r.ing_id
group by
 o.item_id,
 i.sku,
 i.item_name,
 r.ing_id, 
 ing.ing_name,
 r.quantity,
 ing.ing_weight) S1
 ```
 
 Output:
 
 ![image](https://user-images.githubusercontent.com/39070251/211331799-01d26a48-582a-4bf4-b265-fe775d492166.png)



