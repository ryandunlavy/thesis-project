view: box_score {
  sql_table_name: nba_data.box_score ;;




  dimension: comment {
    type: string
    sql: ${TABLE}.COMMENT ;;
  }

  dimension: player_id {
    type: string
    sql: ${TABLE}.PLAYER_ID ;;
  }

  dimension: player_name {
    type: string
    sql: ${TABLE}.PLAYER_NAME ;;
    link: {
      label: "Player Dashboard"
      url: "/dashboards/6?Player={{ value }}"
    }
  }

  dimension: start_position {
    type: string
    sql: ${TABLE}.START_POSITION ;;
  }

  dimension: started {
    type: yesno
    sql: ${start_position} IS NOT NULL ;;
  }

  dimension: ast {
    label: "AST"
    description: "Assists"
    type: number
    sql: ${TABLE}.AST ;;
  }

  dimension: blk {
    label: "BLK"
    description: "Blocks"
    type: number
    sql: ${TABLE}.BLK ;;
  }

  dimension: dreb {
    label: "DREB"
    description: "Defensive Rebounds"
    type: number
    sql: ${TABLE}.DREB ;;
  }

  dimension: fg3_a {
    label: "FG3A"
    description: "3PT Field Goal Attempts"
    type: number
    sql: ${TABLE}.FG3A ;;
  }

  dimension: fg3_m {
    label: "FG3M"
    description: "3PT Field Goal Makes"
    type: number
    sql: ${TABLE}.FG3M ;;
  }

  dimension: fg3_pct {
    hidden: yes
    label: "FG3%"
    description: "3PT Field Goal Percentage"
    type: number
    sql: ${TABLE}.FG3_PCT ;;
  }

  dimension: fg_pct {
    hidden: yes
    label: "FG%"
    description: "Field Goal Percentage"
    type: number
    sql: ${TABLE}.FG_PCT ;;
  }

  dimension: fga {
    label: "FGA"
    description: "Field Goal Attempts"
    type: number
    sql: ${TABLE}.FGA ;;
  }

  dimension: fgm {
    label: "FGM"
    description: "Field Goal Makes"
    type: number
    sql: ${TABLE}.FGM ;;
  }

  dimension: ft_pct {
    hidden: yes
    label: "FT%"
    description: "Free Throw Percentage"
    type: number
    sql: ${TABLE}.FT_PCT ;;
  }

  dimension: fta {
    description: "Free Throw Attempts"
    label: "FTA"
    type: number
    sql: ${TABLE}.FTA ;;
  }

  dimension: ftm {
    label: "FTM"
    description: "Free Throw Makes"
    type: number
    sql: ${TABLE}.FTM ;;
  }

  dimension: game_id {
    label: "Game ID"
    description: "Game ID"
    type: string
    sql: ${TABLE}.GAME_ID ;;
  }

  dimension: min {
    label: "MIN"
    description: "Minutes Played"
    type: number
    value_format: "0.#"
    sql: (CAST(SPLIT(${TABLE}.MIN, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(${TABLE}.MIN, ':')[OFFSET(1)] AS INT64))/60.0 ;;
  }

  dimension: oreb {
    label: "OREB"
    description: "Offensive Rebounds"
    type: number
    sql: ${TABLE}.OREB ;;
  }

  dimension: pf {
    label: "PF"
    description: "Personal Fouls"
    type: number
    sql: ${TABLE}.PF ;;
  }

  dimension: plus_minus {
    label: "Plus Minus"
    description: "Point margin"
    type: number
    sql: ${TABLE}.PLUS_MINUS ;;
  }

  dimension: pts {
    label: "PTS"
    description: "Points"
    type: number
    sql: ${TABLE}.PTS ;;
  }

  dimension: reb {
    label: "REB"
    description: "Total Rebounds"
    type: number
    sql: ${TABLE}.REB ;;
  }

  dimension: stl {
    label: "STL"
    description: "Steals"
    type: number
    sql: ${TABLE}.STL ;;
  }

  dimension: team_abbreviation {
    type: string
    sql: ${TABLE}.TEAM_ABBREVIATION ;;
  }

  dimension: team_city {
    type: string
    sql: ${TABLE}.TEAM_CITY ;;
  }

  dimension: team_id {
    label: "Team ID"
    type: string
    sql: ${TABLE}.TEAM_ID ;;
  }



  dimension: to {
    label: "TO"
    description: "Turnovers"
    type: number
    sql: ${TABLE}.`TO` ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: tot_ast {
    label: "Total AST"
    drill_fields: [box_score_set*]
    description: "Total Assists"
    type: sum
    sql: ${TABLE}.AST ;;
  }

  measure: tot_blk {
    label: "Total BLK"
    description: "Total Blocks"
    type: sum
    sql: ${TABLE}.BLK ;;
  }

  measure: tot_dreb {
    label: "Total DREB"
    description: "Total defensive rebounds"
    type: sum
    sql: ${TABLE}.DREB ;;
  }

  measure: tot_fg3_a {
    label: "Total FG3A"
    description: "Total 3PT Field Goal Attempts"
    type: sum
    sql: ${TABLE}.FG3A ;;
  }

  measure: tot_fg3_m {
    label: "Total FG3M"
    description: "Total 3PT Field Goal Makes"
    type: sum
    sql: ${TABLE}.FG3M ;;
  }

  measure: tot_3pt_pct {
    label: "FG3%"
    description: "3PT Field Goal Percentage"
    type: number
    sql: ${tot_fg3_m}/${tot_fg3_a} ;;
  }

  measure: tot_fga {
    label: "Total FGA"
    description: "Total Field Goal Attempts"
    type: sum
    sql: ${TABLE}.FGA ;;
  }

  measure: tot_fgm {
    label: "Total FG3M"
    description: "Total Field Goal Makes"
    type: sum
    sql: ${TABLE}.FGM ;;
  }

  measure: fg_percent {
    label: "FG%"
    description: "Field Goal Percent"
    type: number
    sql: ${tot_fgm}/${tot_fga} ;;
  }

  measure: tot_fta {
    label: "Total FTA"
    description: "Total Free Throw Attempts"
    type: sum
    sql: ${TABLE}.FTA ;;
  }

  measure: tot_ftm {
    label: "Total FTM"
    description: "Total Free Throw Makes"
    type: sum
    sql: ${TABLE}.FTM ;;
  }

  measure: ft_percent {
    label: "Total FTA"
    description: "Total Free Throw Attempts"
    type: number
    sql: ${tot_ftm}/${tot_fta} ;;
  }

  measure: tot_min {
    label: "Total MIN"
    description: "Total Minutes Played"
    type: sum
    value_format: "0.#"
    sql: ${min};;
  }

  measure: tot_oreb {
    label: "Total OREB"
    description: "Total Offensive Rebounds"
    type: sum
    sql: ${TABLE}.OREB ;;
  }

  measure: tot_pf {
    label: "Total PF"
    description: "Total Personal Fouls"
    type: sum
    sql: ${TABLE}.PF ;;
  }

  measure: tot_plus_minus {
    label: "Total Plus Minus"
    description: "Cumulative Point Margin"
    type: sum
    sql: ${TABLE}.PLUS_MINUS ;;
  }

  measure: tot_pts {
    label: "Total PTS"
    drill_fields: [box_score_set*]
    description: "Cumulative Points Scored"
    type: sum
    sql: ${TABLE}.PTS ;;
  }

  measure: tot_reb {
    drill_fields: [box_score_set*]
    label: "Total REB"
    description: "Total Rebounds"
    type: sum
    sql: ${TABLE}.REB ;;
  }

  measure: tot_stl {
    label: "Total STL"
    description: "Total Steals"
    type: sum
    sql: ${TABLE}.STL ;;
  }

  measure: tot_to {
    label: "Total TO"
    description: "Total Turnovers"
    type: sum
    sql: ${TABLE}.`TO` ;;
  }
  measure: avg_ast {

    label: "Average AST"
    description: "Average Assists"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.AST ;;
  }

  measure: avg_blk {
    label: "Average BLK"
    description: "Average Blocks"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.BLK ;;
  }

  measure: avg_dreb {
    label: "Average DREB"
    description: "Average defensive rebounds"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.DREB ;;
  }

  measure: avg_fg3_a {
    label: "Average FG3A"
    description: "Average 3PT Field Goal Attempts"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.FG3A ;;
  }

  measure: avg_fg3_m {
    label: "Average FG3M"
    description: "Average 3PT Field Goal Makes"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.FG3M ;;
  }

  measure: avg_fga {
    label: "Average FGA"
    description: "Average Field Goal Attempts"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.FGA ;;
  }

  measure: avg_fgm {
    label: "Average FG3M"
    description: "Average Field Goal Makes"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.FGM ;;
  }


  measure: avg_fta {
    label: "Average FTA"
    description: "Average Free Throw Attempts"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.FTA ;;
  }

  measure: avg_ftm {
    label: "Average FTM"
    description: "Average Free Throw Makes"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.FTM ;;
  }


  measure: avg_min {
    label: "Average MIN"
    description: "Average Minutes Played"
    type: average
    value_format: "0.#"
    sql: ${min} ;;
  }

  measure: avg_oreb {
    label: "Average OREB"
    description: "Average Offensive Rebounds"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.OREB ;;
  }

  measure: avg_pf {
    label: "Average PF"
    description: "Average Personal Fouls"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.PF ;;
  }

  measure: avg_plus_minus {
    label: "Average Plus Minus"
    description: "Average Point Margin"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.PLUS_MINUS ;;
  }

  measure: avg_pts {
    label: "Average PTS"
    description: "Average Points Scored"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.PTS ;;
  }

  measure: avg_reb {
    label: "Average REB"
    description: "Average Rebounds"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.REB ;;
  }

  measure: avg_stl {
    label: "Average STL"
    description: "Average Steals"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.STL ;;
  }

  measure: avg_to {
    label: "Average TO"
    description: "Average Turnovers"
    type: average
    value_format: "0.#"
    sql: ${TABLE}.`TO` ;;
  }

  dimension: game_score {
    type: number
    sql: ${pts}+0.4*${fgm}-0.7*${fga}-0.4*(${fta}-${ftm})+0.7*${oreb}+0.3*${dreb}+${stl}+0.7*${ast}+0.7*${blk}-0.4*${pf}-${to} ;;
    description: "Game Score was created by John Hollinger to give a rough measure of a player's productivity for a single game. The scale is similar to that of points scored, (40 is an outstanding performance, 10 is an average performance, etc.)."
  }

  measure: avg_game_score {
    label: "Average Game Score"
    type: average
    value_format: "0.#"
    sql: ${game_score} ;;
  }

  measure: true_shooting {
    label: "TS%"
    value_format: "0.#"
    description: "True Shooting percentage (PTS / (2 * (FGA + 0.44 * FTA)) )"
    sql: ${tot_pts} / (2*(${tot_fga}+0.44*${tot_fta}) ;;
  }

  dimension: player_image {
    sql: CONCAT("https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/", ${team_id}, "/2017/260x190/", ${player_id}, ".png") ;;
    html: <img src="{{ value }}" width="137" height="100"/> ;;
  }

  dimension: player_image_large {
    sql: CONCAT("https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/", ${team_id}, "/2017/260x190/", ${player_id}, ".png") ;;
    html: <img src="{{ value }}" width="260" height="190"/> ;;
  }
  dimension: team_image {
    sql: ${team_abbreviation} ;;
    html: <img src="http://stats.nba.com/media/img/teams/logos/{{ value }}_logo.svg" width="100" height="100"/> ;;
  }

  dimension: team_image_large {
    sql: ${team_abbreviation} ;;
    html: <img src="http://stats.nba.com/media/img/teams/logos/{{ value }}_logo.svg" width="190" height="190"/> ;;
  }

  set: box_score_set {
    fields: [min, pts, fgm, fga, fg_pct, fg3_a, fg3_m, fg3_pct, fta, ftm, ft_pct, oreb, dreb, reb, ast, to, stl, blk, pf, plus_minus]
  }



}
