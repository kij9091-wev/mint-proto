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
  # dimension: creation_time_kst {
  #   type: string
  #   sql: FORMAT_TIMESTAMP('%F %T', TIMESTAMP_SECONDS(${TABLE}.creation_time), 'Asia/Seoul') ;;
  #   description: "Creation time in Korea Standard Time"
  #   # type: string
  #   # sql: CONVERT_TIMEZONE('UTC', 'Asia/Seoul', TIMESTAMP_SECONDS(${TABLE}.creation_time)) ;;
  #   # 이 경우 your_timestamp_field는 유닉스 타임스탬프를 포함하는 필드 이름으로 변경하세요.
  # }

  # dimension_group: kst_created {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     hour,
  #     date,
  #     week,
  #     month
  #   ]
  #   sql: ${TABLE}.creation_time_kst;;
  # }
  # 타임스탬프 형식으로 변환된 차원을 생성
  # dimension: creation_time_kst {
  #   type: timestamp
  #   sql: TIMESTAMP(FORMAT_TIMESTAMP('%F %T', TIMESTAMP_SECONDS(${TABLE}.creation_time), 'Asia/Seoul')) ;;
  #   description: "Creation time in Korea Standard Time"
  # }

  # 타임스탬프 차원을 사용하여 dimension_group 생성
  dimension_group: kst_creation {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      date,
      week,
      month
    ]
    # UTC에서 한국 시간으로 변환된 타임스탬프
    sql: FORMAT_TIMESTAMP('%F %X', ${TABLE}.creation_time, 'Asia/Seoul') ;;
    # sql: TIMESTAMP(FORMAT_TIMESTAMP('%F %T', TIMESTAMP_SECONDS(${TABLE}.creation_time), 'Asia/Seoul')) ;;
    # convert_tz: yes
    # datatype: timestamp
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
    drill_fields: [sentiments.*]
  }
}
