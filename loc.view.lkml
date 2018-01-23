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

  dimension: xfeet {
    type: number
    sql: (${xloc})/10.0;;
  }
  dimension: yfeet {
    type: number
    sql: (${yloc})/10.0;;
  }

  dimension: distance {
    description: "Distance from basket (in feet)"
    type: number
    sql: sqrt((${xfeet}*${xfeet})+(${yfeet}*${yfeet})) ;;
    value_format: "0.#"
  }

  measure: average_distance {
    type: average
    sql: ${distance} ;;
  }
}
