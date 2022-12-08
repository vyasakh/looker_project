connection: "thelook"

# include all the views
include: "/views/**/*.view"

include: "//test/views/flights.view.lkml"
datagroup: 0_vysakh_thelook_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}



persist_with: 0_vysakh_thelook_default_datagroup

datagroup: updt_datagroup {
  max_cache_age: "24 hours"
  interval_trigger: "12 hours"
}

explore: flights {}


explore: order_items {
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: productsfirst {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${productsfirst.id} ;;
    relationship: many_to_one
  }

}
