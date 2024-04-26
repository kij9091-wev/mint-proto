
view: timeline {
  derived_table: {
    sql: SELECT
          (FORMAT_TIMESTAMP('%F %T', TIMESTAMP_SECONDS(CAST(posts.creationtime / 1000000000 AS INT64)) )) AS posts_date,
          COUNT(*) AS posts_count
      FROM `mint_proto.posts`  AS posts
      WHERE ((( posts._PARTITIONDATE  ) >= ((DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -2 MONTH))) AND ( posts._PARTITIONDATE  ) < ((DATE_ADD(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -2 MONTH), INTERVAL 3 MONTH)))))
      GROUP BY
          1
      ORDER BY
          1 DESC
      LIMIT 100000 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: posts_date {
    type: string
    sql: ${TABLE}.posts_date ;;
  }

  dimension: posts_count {
    type: number
    sql: ${TABLE}.posts_count ;;
  }

  set: detail {
    fields: [
        posts_date,
	posts_count
    ]
  }
}
