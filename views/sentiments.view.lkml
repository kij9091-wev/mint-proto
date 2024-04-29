view: sentiments {
  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  sql_table_name: `mint_proto.posts` ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: creation_time {
    type: number
    sql: ${TABLE}.creation_time ;;
  }
  dimension: date {
    type: date_time
    sql: TIMESTAMP_SECONDS(${TABLE}.creation_time) ;;
  }

  dimension: sentiment {
    type: string
    sql: ${TABLE}.sentiment ;;
  }

  measure: count_positive {
    type: count
    filters: {
      field: sentiment
      value: "POSITIVE"
    }
    label: "Positive Sentiments"
  }

  measure: count_negative {
    type: count
    filters: {
      field: sentiment
      value: "NEGATIVE"
    }
    label: "Negative Sentiments"
  }

  measure: count_mixed {
    type: count
    filters: {
      field: sentiment
      value: "MIXED"
    }
    label: "Mixed Sentiments"
  }

  measure: count_neutral {
    type: count
    filters: {
      field: sentiment
      value: "NEUTRAL"
    }
    label: "Neutral Sentiments"
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      date,
      week,
      month
    ]
    sql: ${TABLE}.creation_time;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }
  dimension: message_url {
    type: string
    sql: ${TABLE}.message_url ;;
  }
  dimension: source_url {
    type: string
    sql: ${TABLE}.source_url ;;
  }
  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }
  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: sentiments_timeline {
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
