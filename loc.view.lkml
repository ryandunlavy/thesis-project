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

  dimension: xloc {
    type: number
    sql: ${TABLE}.xloc ;;
  }

  dimension: yloc {
    type: number
    sql: ${TABLE}.yloc ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  dimension: xtrans {
    type: number
    sql: ROUND(ABS(${xloc}/10));;
  }
  dimension: ytrans {
    type: number
    sql: ROUND(ABS(${yloc}/10));;
  }
}
