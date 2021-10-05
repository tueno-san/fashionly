view: user_order_frequency {
  derived_table: {
    sql:
      SELECT distinct
              order_items.order_items_user_id as order_items_user_id,
              order_items.order_items_order_seq_1,
              order_items.order_items_created_date,
              last_order_item.order_items_created_date as last_order_item_created_date,
              order_items.order_id
      FROM
            (SELECT distinct
                    order_items.user_id as order_items_user_id,
                    rank() over (partition by order_items.user_id order by order_items.created_at)  AS order_items_order_seq_1,
                    order_items.created_at AS order_items_created_date,
                    order_items.order_id
            FROM `ecomm.order_items` AS order_items
            ) as order_items
                  left outer join
            (SELECT distinct
                    last_order_items.user_id  AS order_items_user_id,
                    rank() over (partition by last_order_items.user_id order by last_order_items.created_at)   AS order_items_order_seq_1,
                    last_order_items.created_at AS order_items_created_date,
                    last_order_items.order_id
              FROM `ecomm.order_items` AS last_order_items) as last_order_item
              on ( order_items.order_items_user_id = last_order_item.order_items_user_id
                    and (order_items.order_items_order_seq_1 -1)=last_order_item.order_items_order_seq_1)
    order by 1,2 ;;
  }


  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.order_items_user_id ;;
  }

  dimension: order_seq {
    type: number
    sql: ${TABLE}.order_items_order_seq_1 ;;
  }

  dimension_group: create_dt {
    type: time
    timeframes: [raw,date,week,month,quarter,year]
    sql: ${TABLE}.order_items_created_date ;;
  }

  dimension_group: last_create_dt {
    type: time
    timeframes: [raw,date,week,month,quarter,year]
    sql: ${TABLE}.last_order_item_created_date ;;
  }

  dimension_group: interval_create_dt {
    type: duration
    intervals: [day]
    sql_start: ${last_create_dt_date} ;;
    sql_end: ${last_create_dt_date} ;;
  }

  dimension: is_First_Purchase {
    type: yesno
    sql: ${order_seq}=1 ;;
  }

  measure: max_order_seq {
    type: max
    sql: ${order_seq} ;;
  }

  measure: average_days_between_orders {
    type: average
    sql: ${days_interval_create_dt} ;;
  }
  measure: count_number_of_order {
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: max_number_of_order {
    type: max
    sql: ${order_id} ;;
    sql_distinct_key: ${user_id} ;;
  }

}
