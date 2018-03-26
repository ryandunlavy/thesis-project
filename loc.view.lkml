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

  dimension: x {
    type: number
    sql: ABS(${TABLE}.xloc)/10.0 ;;
    html: <a href="/explore/nba_project/shots?fields=game_list.game_month,shots.made_shots,shots.shot_attempts&fill_fields=game_list.game_month&sorts=game_list.game_month+desc&limit=500&query_timezone=America%2FLos_Angeles&vis=%7B%22stacking%22%3A%22normal%22%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22legend_position%22%3A%22center%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Atrue%2C%22limit_displayed_rows%22%3Afalse%2C%22y_axis_combined%22%3Atrue%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22show_null_points%22%3Atrue%2C%22point_style%22%3A%22none%22%2C%22interpolation%22%3A%22linear%22%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_area%22%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22series_types%22%3A%7B%7D%7D&filter_config=%7B%7D&origin=share-expanded">{{value}}</a> ;;
  }

  dimension: y {
    type: number
    sql: (${TABLE}.yloc)/10.0 ;;
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
