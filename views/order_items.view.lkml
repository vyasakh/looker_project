view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }


  dimension: times {
    type: date
    sql: date_format(${TABLE}.returned_at,'%H:%i') ;;
  }
  dimension: test {
    type: date

    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }




  measure: count {
    type: count
    drill_fields: [id, order_id, inventory_item_id]
    link: {
      label: "Order_count"
      url: "{{link}}&pivots=order_items.id"
    }
  }

  measure: testsss {
    type: number
    sql: ${count} ;;
    html: Count:{{rendered_value}}| other Count: {{order_items.count._rendered_value}} ;;
  }
}
