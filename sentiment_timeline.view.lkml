
view: sentiment_timeline {
  derived_table: {
    sql: SELECT
          (FORMAT_TIMESTAMP('%Y-%m-%d %H:00:00', TIMESTAMP_SECONDS(CAST(sentiments_timeline.creationtime / 1000000000 AS INT64)) )) AS sentiments_timeline_created_time,
          COUNT(CASE WHEN (( sentiments_timeline.sentiment  ) = 'NEGATIVE') THEN 1 ELSE NULL END) AS sentiments_timeline_count_negative,
          COUNT(CASE WHEN (( sentiments_timeline.sentiment  ) = 'POSITIVE') THEN 1 ELSE NULL END) AS sentiments_timeline_count_positive
      FROM `mint_proto.posts`  AS sentiments_timeline
      WHERE ((( sentiments_timeline._PARTITIONDATE  ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -2 MONTH))) AND ( sentiments_timeline._PARTITIONDATE  ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -2 MONTH), INTERVAL 3 MONTH)))))
      GROUP BY
          1
      ORDER BY
          1 DESC
      LIMIT 500 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: sentiments_timeline_created_time {
    type: string
    sql: ${TABLE}.sentiments_timeline_created_time ;;
  }

  dimension: sentiments_timeline_count_negative {
    type: number
    sql: ${TABLE}.sentiments_timeline_count_negative ;;
  }

  dimension: sentiments_timeline_count_positive {
    type: number
    sql: ${TABLE}.sentiments_timeline_count_positive ;;
  }

  set: detail {
    fields: [
        sentiments_timeline_created_time,
	sentiments_timeline_count_negative,
	sentiments_timeline_count_positive
    ]
  }
}
