view: onetime_order_user {
  derived_table: {
    sql: SELECT
                order_items.user_id as order_items_user_id,
                count(distinct order_id) as number_of_order_id
        FROM `ecomm.order_items` AS order_items
group by 1 ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.order_items_user_id ;;
    primary_key: yes
  }

  dimension: number_of_order_id {
    type: number
    sql: ${TABLE}.number_of_order_id ;;
  }

  dimension: tier_of_number_of_order_id {
    type: tier
    tiers: [1,2]
    sql: ${number_of_order_id} ;;
    style: integer
  }

  measure: number_of_order {
    type: max
    sql: ${number_of_order_id} ;;
  }
}
