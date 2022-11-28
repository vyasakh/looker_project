view: users_test {
 derived_table: {
  sql: SELECT order_items.user_id AS user_id
    ,COUNT(distinct order_items.order_id) AS lifetime_order_count
    ,SUM(order_items.sale_price) AS lifetime_revenue
    ,MIN(order_items.created_at) AS first_order_date
    ,MAX(order_items.created_at) AS latest_order_date
FROM cloud-training-demos.looker_ecomm.order_items
GROUP BY user_id
LIMIT 10 ;;
}
}
