view: game_list {
  sql_table_name: nba_data.game_list ;;


  dimension_group: game {
    type: time
    datatype: yyyymmdd
    timeframes: [raw, date, week, month, year]
    sql: CAST(REPLACE (${TABLE}.date, "-", "") AS INT64);;
  }


  dimension: game_ids {
    type: string
    sql: ${TABLE}.gameIds ;;
  }


}
