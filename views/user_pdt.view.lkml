view: user_pdt {
  derived_table: {
    sql: SELECT
          users.zip  AS `users.zip`,
          users.state  AS `users.state`,
          users.last_name  AS `users.last_name`,
          users.id  AS `users.id`,
          users.gender  AS `users.gender`,
          users.age  AS `users.age`,
          users.city  AS `users.city`,
          COUNT(DISTINCT users.id ) AS `users.count`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id
      GROUP BY
          1,
          2,
          3,
          4,
          5,
          6,
          7
      ORDER BY
          COUNT(DISTINCT users.id ) DESC
      LIMIT 500
       ;;
    datagroup_trigger: updt_datagroup
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_zip {
    type: number
    sql: ${TABLE}.`users.zip` ;;
  }

  dimension: users_state {
    type: string
    sql: ${TABLE}.`users.state` ;;
  }

  dimension: users_last_name {
    type: string
    sql: ${TABLE}.`users.last_name` ;;
  }

  dimension: users_id {
    type: number
    sql: ${TABLE}.`users.id` ;;
  }

  dimension: users_gender {
    type: string
    sql: ${TABLE}.`users.gender` ;;
  }

  dimension: users_age {
    type: number
    sql: ${TABLE}.`users.age` ;;
  }

  dimension: users_city {
    type: string
    sql: ${TABLE}.`users.city` ;;
  }

  dimension: users_count {
    type: number
    sql: ${TABLE}.`users.count` ;;
  }

  dimension: required {
    sql: ${users_id};;
    #html: <a href="{{ row['websites.url'] }}" target="_new">{{ value }}</a> ;;
    required_fields: [orders.status]
  }

  set: detail {
    fields: [
      users_zip,
      users_state,
      users_last_name,
      users_id,
      users_gender,
      users_age,
      users_city,
      users_count
    ]
  }
}
