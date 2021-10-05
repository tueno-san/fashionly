view: order_items {
  sql_table_name: `ecomm.order_items`
    ;;
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

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
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

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.shipped_at ;;
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

  dimension: Order_SEQ {
    type: number
    sql: rank() over (partition by ${user_id} order by ${created_raw}) ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: Total_Sales_Price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: Average_Sale_Price {
    type: average
    sql: ${sale_price} ;;
  }

  measure: Cumulative_Total_Sales{
    type: running_total
    sql: ${sale_price} ;;
  }

  measure: Total_Gross_Revenue {
    type: sum
    sql: ${sale_price};;
    filters: [status: "Complete"]
  }

  measure: Number_of_Items_Returned{
    type: count_distinct
    sql: ${inventory_item_id} ;;
    filters: [status: "Returned"]
  }

  measure: Item_Return_Rate {
    type: number
    sql: ${Number_of_Items_Returned}/${count};;
    value_format: "0.00%"
  }

  measure: Number_of_Customers_Reteuning_Items {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [status: "Retruned"]
  }

  measure: Total_Number_of_Customers {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: Percent_of_Users_with_Returns{
    type: number
    sql: ${Number_of_Customers_Reteuning_Items}/${Total_Number_of_Customers} ;;
    value_format: "0.00%"
  }

  measure: Average_Spend_per_Customer {
    type: number
    sql: ${Total_Sales_Price}/${Total_Number_of_Customers} ;;
    value_format: "0.00"
  }

  measure: Gross_Margin_Percentage {
    type: number
    sql: ${Total_Gross_Revenue}/${Total_Sales_Price} ;;
    value_format: "0.0%"
  }

  measure: order_count {
    label: "Total_Lifetime_Orders"
    type: count_distinct
    sql: ${order_id} ;;
    sql_distinct_key: ${user_id} ;;
  }

  measure: count_user_order_lastday {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [created_date: "yesterday"]
  }

 measure: count_user {
   type: count_distinct
  sql: ${user_id} ;;
 }
  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
