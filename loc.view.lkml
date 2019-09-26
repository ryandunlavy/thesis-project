view: loc {
  label: "Locations"
  sql_table_name: nba_data.loc ;;

  dimension: eventid {
    label: "Event ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.eventid ;;
  }

  dimension: gameid {
    label: "Game ID"
    type: string
    sql: ${TABLE}.gameid ;;
  }

  dimension: xloc {
    hidden: yes
    type: number
    sql: ${TABLE}.xloc ;;
  }

  dimension: yloc {
    hidden: yes
    type: number
    sql: ${TABLE}.yloc ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  dimension: x {
    label: "X (in feet)"
    type: number
    sql: (${xloc})/10.0;;
  }
  dimension: y {
    label: "Y (in feet)"
    type: number
    sql: (${yloc})/10.0;;
  }

  dimension: distance {
    description: "Distance from basket (in feet)"
    type: number
    sql: sqrt((${x}*${x})+(${y}*${y})) ;;
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
