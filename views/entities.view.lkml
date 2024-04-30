view: entities {
  sql_table_name: `mint_proto.entities` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }
  dimension: message_url {
    type: string
    sql: ${TABLE}.message_url ;;
  }
  dimension: source_url {
    type: string
    sql: ${TABLE}.source_url ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
