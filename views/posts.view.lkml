view: posts {
  sql_table_name: `mint_proto.posts` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: __index_level_0__ {
    type: number
    sql: ${TABLE}.__index_level_0__ ;;
  }
  dimension_group: _partitiondate {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}._PARTITIONDATE ;;
  }
  dimension_group: _partitiontime {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}._PARTITIONTIME ;;
  }
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: creation_time {
    type: number
    sql: ${TABLE}.creationTime ;;
  }
  dimension: date {
    type: date_time
    sql: TIMESTAMP_SECONDS(CAST(${TABLE}.creationtime / 1000000000 AS INT64)) ;;
  }
  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }
  dimension: message_url {
    type: string
    sql: ${TABLE}.messageUrl ;;
  }
  dimension: sentiment {
    type: string
    sql: ${TABLE}.sentiment ;;
  }
  dimension: source_url {
    type: string
    sql: ${TABLE}.sourceUrl ;;
  }
  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
