include: "/views/order_items.view"
include: "/views/users.view"

view: +order_items {
  measure: count {
    alias: [order_item_count]
    type: count
  }

  measure: total_revenue_dashboard {
    hidden: yes
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
  }
}

view: +users {
  dimension: age_tier_dashboard {
    hidden: yes
    type: tier
    sql: ${age} ;;
    tiers: [20, 30, 40, 50, 60, 70]
    style: integer
  }
}
