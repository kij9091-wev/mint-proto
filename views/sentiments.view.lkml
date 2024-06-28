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
    drill_fields: [sentiments.*]
    label: "Positive Sentiments"
  }

  measure: count_negative {
    type: count
    filters: {
      field: sentiment
      value: "NEGATIVE"
    }
    drill_fields: [sentiments.*]
    label: "Negative Sentiments"
  }

  measure: count_mixed {
    type: count
    filters: {
      field: sentiment
      value: "MIXED"
    }
    drill_fields: [sentiments.*]
    label: "Mixed Sentiments"
  }

  measure: count_neutral {
    type: count
    filters: {
      field: sentiment
      value: "NEUTRAL"
    }
    drill_fields: [sentiments.*]
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
    link: {
      label: "해당 링크로 이동"
      url:"{{ message_url }}"
      icon_url: "http://www.google.com/s2/favicons?domain=theqoo.net"
    }
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
  dimension: lesserafim_insta__filter {
    type: yesno
    sql: CASE
          WHEN ${TABLE}.text LIKE '%르세라핌%' AND ${TABLE}.text LIKE '%인스타%' THEN TRUE
          ELSE FALSE
        END ;;
  }
  dimension: lesserafim_weverse_filter {
    type: yesno
    sql: CASE
          WHEN ${TABLE}.text LIKE '%르세라핌%' AND ${TABLE}.text LIKE '%위버스%' THEN TRUE
          ELSE FALSE
        END ;;
  }
  measure: count {
    type: count
    drill_fields: [sentiments.*]
  }
}
