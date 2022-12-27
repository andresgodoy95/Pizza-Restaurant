SELECT
s2.ing_name,
s2.ordered_weight,
ing.ing_weight*inv.quantity as total_inv_weight,
(ing.ing_weight*inv.quantity) - s2.ordered_weight as Remaining_inv
FROM
(SELECT
	ing_id,
	ing_name,
	sum(ordered_weight) AS ordered_weight
FROM supply
GROUP BY
	ing_id,
	ing_name
ORDER BY
	ing_id) s2
LEFT JOIN inventory inv on inv.item_id = s2.ing_id
LEFT JOIN ingredient ing on ing.ing_id = s2.ing_id