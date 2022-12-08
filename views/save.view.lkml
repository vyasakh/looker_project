view: save {
  derived_table: {
    sql: SELECT
          (DATE(CONVERT_TZ(orders.created_at ,'UTC','America/Los_Angeles'))) AS `orders.created_date`,
              (DATE_FORMAT(CONVERT_TZ(orders.created_at ,'UTC','America/Los_Angeles'),'%Y-%m')) AS `orders.created_month`,
          orders.status  AS `orders.status`,
          orders.id  AS `orders.id`,
          COUNT(DISTINCT orders.id ) AS `orders.count`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      where orders.created_at between date({% date_start period %}) AND date({% date_end period %})
      GROUP BY
          1,
          2,
          3,
          4
      ORDER BY
          (DATE(CONVERT_TZ(orders.created_at ,'UTC','America/Los_Angeles'))) DESC
       ;;
  }

  filter: period {  label: "Period Date" type: date }

  measure: count {
    type: count
  }

  dimension_group: orders_created_date {
    sql: ${TABLE}.`orders.created_date` ;;
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
  }

  dimension: orders_status {
    type: string
    sql: ${TABLE}.`orders.status` ;;
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.`orders.id` ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }

}
