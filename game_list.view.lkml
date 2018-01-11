view: game_list {
  sql_table_name: nba_data.game_list ;;

  dimension: date {
    type: date
    sql: DATE(${TABLE}.date) ;;
  }


  dimension: game_ids {
    type: string
    sql: ${TABLE}.gameIds ;;
  }


}
