view: entities {
  sql_table_name: `mint_proto.entities` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
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
  dimension: creation_time {
    type: number
    sql: ${TABLE}.creationTime ;;
  }
  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }
  dimension: message_url {
    type: string
    sql: ${TABLE}.messageUrl ;;
  }
  dimension: source_url {
    type: string
    sql: ${TABLE}.sourceUrl ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
