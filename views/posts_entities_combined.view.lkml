view: _posts_entities_combined {
  derived_table: {
    sql: SELECT
            p.id AS post_id,
            p.creation_time,
            p.category,
            p.message,
            p.message_url,
            p.sentiment,
            p.source_url,
            p.subject,
            p.text,
            COUNT(e.id) AS entity_count,
            GROUP_CONCAT(e.keyword) AS keywords
          FROM
            `mint_proto.posts` AS p
          LEFT JOIN
            `mint_proto.entities` AS e
          ON
            p.message_url = e.message_url
          GROUP BY
            p.id,
            p.creation_time,
            p.category,
            p.message,
            p.message_url,
            p.sentiment,
            p.source_url,
            p.subject,
            p.text ;;
  }

  dimension: post_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.post_id ;;
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
    sql: ${TABLE}.creation_time ;;
  }
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
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
  dimension: entity_count {
    type: number
    sql: ${TABLE}.entity_count ;;
  }
  dimension: keywords {
    type: string
    sql: ${TABLE}.keywords ;;
  }
  measure: post_count {
    type: count_distinct
    sql: ${TABLE}.post_id ;;
  }

  # Sentiment Measures
  measure: count_positive {
    type: count
    filters: {
      field: sentiment
      value: "positive"
    }
    drill_fields: [sentiments.*]
    label: "Positive Sentiments"
  }

  measure: count_negative {
    type: count
    filters: {
      field: sentiment
      value: "negative"
    }
    drill_fields: [sentiments.*]
    label: "Negative Sentiments"
  }

  measure: count_neutral {
    type: count
    filters: {
      field: sentiment
      value: "neutral"
    }
    drill_fields: [sentiments.*]
    label: "Neutral Sentiments"
  }

  dimension: lesserafim_insta_filter {
    type: yesno
    sql: CASE
          WHEN ${TABLE}.text LIKE '%르세라핌%' AND ${TABLE}.text LIKE '%인스타%' THEN TRUE
          ELSE FALSE
        END ;;
  }
  dimension: lesserafim_content_filter {
    type: yesno
    sql: CASE
          WHEN ${TABLE}.text LIKE '%르세라핌%' AND (${TABLE}.text LIKE '%자컨%' OR ${TABLE}.text LIKE '%자체컨텐츠%') THEN TRUE
          ELSE FALSE
        END ;;
  }
}
