view: real_pdt_test {
  derived_table: {
    sql: SELECT
            e.*,
            e.id AS entity_id,
            p.message,
            p.sentiment,
            p.creation_time AS post_creation_time
          FROM
            `mint_proto.entities` AS e
          LEFT JOIN
            `mint_proto.posts` AS p
          ON
            e.message_url = p.message_url ;;
    sql_trigger_value: SELECT MAX(updated_at) FROM mint_proto.entities ;;
    persist_for: "1 hour"
    # datagroup_trigger: mint_proto_default_datagroup

  }
}

# view: real_pdt_test {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
