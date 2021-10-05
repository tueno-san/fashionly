view: brand_order_number {
  derived_table: {
    sql:
    SELECT
                order_items.user_id  AS order_items_user_id,
                products.brand  AS products_brand,
                COUNT(*) AS order_items_count
            FROM `ecomm.order_items` AS order_items
        LEFT JOIN `ecomm.inventory_items`
             AS inventory_items ON order_items.inventory_item_id = inventory_items.id
        LEFT JOIN `ecomm.products`
              AS products ON inventory_items.product_id = products.id
            GROUP BY
                1,
                2;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.order_items_user_id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.products_brand ;;
  }

  dimension: order_items_count {
    type: number
    sql: ${TABLE}.order_items_count ;;
  }


  measure: total_number_of_order{
    type: count
  }

  measure: one_tiime_order_number {
    type: sum
    sql: ${order_items_count} ;;
    filters: [order_items_count: "1"]
  }

  measure: parcent_of_non_repeat {
    type: number
    sql: ${one_tiime_order_number}/${total_number_of_order} ;;
    value_format: "0.00%"
  }

}
