view: sentiments_pdt_test {
  derived_table: {
    increment_key: "entity_id"
    sql: SELECT
            e.*,
            e.id AS entity_id,
            p.message,
            p.sentiment,
            p.creation_time AS post_creation_time
          FROM
            `mint_proto.entities` AS e
          LEFT JOIN
            `mint_proto.posts` AS p
          ON
            e.message_url = p.message_url ;;
    sql_trigger_value: SELECT MAX(updated_at) FROM etl_log ;;
    # persist_for: "1 hour"
    # datagroup_trigger: mint_proto_default_datagroup
  }




}
