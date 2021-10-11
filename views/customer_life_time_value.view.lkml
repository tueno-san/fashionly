view: customer_life_time_value {
  derived_table: {
    sql:
      SELECT
        user_id as user_id
        , COUNT(*) as lifetime_items
        , COUNT(DISTINCT order_items.order_id) as lifetime_orders
        , MIN(created_at) as first_order
        , MAX(created_at) as latest_order
        , SUM(order_items.sale_price) as lifetime_revenue
        , case when min(date_diff(current_date(),date(created_at),day)) <= 90 then 'Active'
          else 'Non Active' end is_active
      FROM `ecomm.order_items` as order_items
      GROUP BY user_id
;;
#partition_keys: ["user_id"]
#sql_trigger_value:  ;;
#datagroup_trigger:

  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }


  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [raw,date,week,day_of_week,month,quarter,year]
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: latest_order {
    type: time
    timeframes: [raw,date,week,day_of_week,month,quarter,year]
    sql: ${TABLE}.latest_order ;;
  }

  dimension: Customer_Lifetime_Orders {
    type: tier
    tiers: [1,2,5,9]
    sql: ${lifetime_orders} ;;
    style: integer
  }

  dimension: Customer_Lifetime_Orders_1_or_NOT {
    type: tier
    tiers: [1,2]
    sql: ${lifetime_orders} ;;
    style: integer
  }

  dimension: Customer_Lifetime_Revenue {
    type: tier
    tiers: [5,20,50,100,500,1000]
    sql: ${lifetime_revenue} ;;
    style: integer
  }

  dimension: Is_Active {
    type: string
    sql: ${TABLE}.is_active ;;
  }

  dimension_group: Days_Since_Latest_Order {
    type: duration
    sql_start: ${latest_order_date} ;;
    sql_end: CURRENT_DATE() ;;
    intervals: [day,month,year]
  }

  dimension_group: Days_Since_First_Order {
    type: duration
    sql_start: ${first_order_date} ;;
    sql_end: CURRENT_DATE() ;;
    intervals: [day,month]
  }


  dimension_group: Days_Between_FirstOrder_to_LatestOrder {
    type: duration
    sql_start: ${first_order_date} ;;
    sql_end: ${latest_order_date} ;;
    intervals: [day,month]
  }

  dimension: repate_customer {
    type: yesno
    sql:  ${days_Days_Between_FirstOrder_to_LatestOrder} <= 30
      and ${Customer_Lifetime_Orders} >=3;;
  }

  measure: Total_Lifetime_Orders {
    type: sum
    sql: ${lifetime_orders} ;;
  }

  measure: Average_Lifetime_Orders {
    type: average
    sql: ${lifetime_orders} ;;
  }

  measure: Total_Lifetime_Revenue {
    type: sum
    sql: ${lifetime_revenue} ;;
  }

  measure:  Average_Lifetime_Revenue{
    type: average
    sql: ${lifetime_revenue} ;;
  }

  measure: Average_Days_Since {
    type: average
    sql: ${days_Days_Since_Latest_Order} ;;
  }

  measure: Average_Days_from_FirstOrder_to_LastOrder {
    type: average
    sql: ${days_Days_Between_FirstOrder_to_LatestOrder} ;;
  }

  measure: Average_Months_from_FirstOrder_to_LastOrder {
    type: average
    sql: ${months_Days_Between_FirstOrder_to_LatestOrder} ;;
  }


}
