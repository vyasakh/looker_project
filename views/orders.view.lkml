view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: createds {
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
    sql:  (SELECT created_at FROM demo_db.orders WHERE created_at > now() -1300);;
  }



  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }




  parameter: Currency_type {
    type: unquoted
    allowed_value: {
      value: "3"
      label: "EUR (annual exra)"
    }

    allowed_value: {
      value: "2"
      label: "EUR (latest exra)"
    }

    allowed_value: {
      value: "1"
      label: "LC"
    }


  }

  dimension: temp {
    type: string
    sql: {% if Currency_type._parameter_value == "3" %} '3' {% else %} '1' {% endif %} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, status, created_date]
    link: {
      label: "Order_count"
      url: "{{link}}&pivots=orders.status"
    }
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      status,
      users.id,
      users.first_name,
      users.last_name,
      billion_orders.count,
      fakeorders.count,
      hundred_million_orders.count,
      hundred_million_orders_wide.count,
      order_items.count,
      order_items_vijaya.count,
      ten_million_orders.count
    ]
  }
}
