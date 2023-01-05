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
