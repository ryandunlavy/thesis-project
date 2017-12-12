view: loc {
  sql_table_name: nba_data.loc ;;

  dimension: eventid {
    type: number
    value_format_name: id
    sql: ${TABLE}.eventid ;;
  }

  dimension: gameid {
    type: string
    sql: ${TABLE}.gameid ;;
  }

  dimension: x {
    type: number
    sql: ${TABLE}.xloc ;;
  }

  dimension: y {
    type: number
    sql: ${TABLE}.yloc ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
