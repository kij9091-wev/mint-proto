connection: "mint_proto"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: mint_proto_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: mint_proto_default_datagroup

explore: entities {}

explore: posts {
 query: posts_query {
  limit: 100000
 }
}

explore: postscopy {}
