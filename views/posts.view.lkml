view: posts {
  sql_table_name: `mint_proto.posts` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: creation_time {
    type: number
    sql: ${TABLE}.creation_time ;;
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
  dimension: sentiment {
    type: string
    sql: ${TABLE}.sentiment ;;
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
}
