view: loc {
  label: "Locations"
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
    value_format: "0.# \" ft\""
  }

  dimension: distance_range {
    type: tier
    style: integer
    tiers: [0, 8, 16, 24, 30]
    sql: ${distance} ;;
    value_format: "0 \" ft\""
  }

  measure: shot_distribution {
    type: percent_of_total
    sql:  ${count};;
  }

  measure: average_distance {
    type: average
    sql: ${distance} ;;
    value_format: "0.# \" ft\""
  }
}
