connection: "looker-private-demo"
label: "Tsutomu-Fashion.ly"
# include all the views
include: "/views/**/*.view"

datagroup: training_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"



}

persist_with: training_default_datagroup

explore: brand_order_number {}

explore: category_order_number {}

explore: onetime_order_user {
  join: users {
    type: left_outer
    sql_on: ${onetime_order_user.user_id}=${users.id} ;;
    relationship: one_to_one
  }
  # join: order_items {
  #   type: left_outer
  #   sql_on: ${onetime_order_user.user_id}=${order_items.user_id} ;;
  #   relationship: one_to_many
  # }
}

explore: user_order_frequency {
  join: users {
    type: left_outer
    sql_on: ${user_order_frequency.user_id}=${users.id} ;;
    relationship: many_to_one
  }

  # join:order_items {
  #   type: left_outer
  #   sql_on: ${user_order_frequency.user_id}=${order_items.user_id} and
  #     ${user_order_frequency.order_id}=${order_items.order_id};;
  #   relationship: one_to_many
  # }

  join: events {
    type: left_outer
    sql_on: ${user_order_frequency.user_id}=${events.user_id} and
            ${events.created_date} >= ${user_order_frequency.create_dt_raw} and
            ${events.created_date} < ${user_order_frequency.create_dt_raw};;
    relationship: one_to_many
  }
}

explore: customer_life_time_value {
  join: users {
    type: left_outer
    sql_on: ${customer_life_time_value.id}=${users.id};;
    relationship: many_to_one
  }

  join: order_items {
    type: left_outer
    sql_on: ${customer_life_time_value.id}=${order_items.user_id} ;;
    relationship: one_to_many
  }

  join: events {
    type: left_outer
    sql_on: ${customer_life_time_value.id} = ${events.user_id} ;;
    relationship: one_to_many
  }
}

explore: distribution_centers {}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
#   hidden: yes
# group_label: "オーダーとユーザ情報"
#   label: "オーダーアイテム"
#   description: "オーダーに関する情報"
  # sql_always_where: ${created_date} >= "2000-01-01";;
  # always_filter: {
  #   filters: [order_items.created_date: "2000-01-01"]
  # }
  # conditionally_filter: {
  #   filters: [order_items.created_date: "2000-01-01"]
  #   unless: [order_items.shipped_date]
  # }
  #fields: [set_test*]

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }


  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

  join: onetime_order_user {
    type: left_outer
    sql_on: ${order_items.user_id}=${onetime_order_user.user_id} ;;
    relationship: many_to_one
  }
  join: customer_life_time_value {
    type: left_outer
    sql_on: ${order_items.user_id} = ${customer_life_time_value.id} ;;
    relationship: many_to_one
  }
  join: user_order_frequency {
    type: left_outer
    sql_on: ${order_items.user_id} = ${user_order_frequency.user_id} and
      ${order_items.order_id} = ${user_order_frequency.order_id};;
    relationship: many_to_one
  }
}

explore: products {
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: users {
# group_label: "オーダーとユーザ情報"
  join: customer_life_time_value {
    type: left_outer
    sql_on: ${users.id} = ${customer_life_time_value.id}   ;;
    relationship: one_to_many
  }


}
