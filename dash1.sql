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