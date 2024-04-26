view: postscopy {
  sql_table_name: `mint_proto.posts-copy` ;;
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
    type: string
    sql: ${TABLE}.creationTime ;;
  }
  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }
  dimension: message_url {
    type: string
    sql: ${TABLE}.messageUrl ;;
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
