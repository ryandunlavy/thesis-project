view: team_data {
  sql_table_name: nba_data.team_data ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: CONCAT(${game_id},${team_abbreviation}) ;;
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
    link: {
      label: "Game Dashboard"
      url: "/dashboards/7?Game={{ value }}"
    }
  }


  dimension: min {
    label: "MIN"
    description: "Minutes Played"
    type: string
    sql: ${TABLE}.MIN ;;
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

  dimension: team_name {
    type: string
    sql: ${TABLE}.TEAM_NAME ;;
  }

  dimension: to {
    label: "TO"
    description: "Turnovers"
    type: number
    sql: ${TABLE}.`TO` ;;
  }

  measure: count {
    type: count
    drill_fields: [team_name]
  }

  measure: tot_ast {
    label: "Total AST"
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

  measure: 3pt_pct {
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
    sql: ${TABLE}.MIN ;;
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
    description: "Cumulative Points Scored"
    type: sum
    sql: ${TABLE}.PTS ;;
  }

  measure: tot_reb {
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
    sql: ${TABLE}.AST ;;
  }

  measure: avg_blk {
    label: "Average BLK"
    description: "Average Blocks"
    type: average
    sql: ${TABLE}.BLK ;;
  }

  measure: avg_dreb {
    label: "Average DREB"
    description: "Average defensive rebounds"
    type: average
    sql: ${TABLE}.DREB ;;
  }

  measure: avg_fg3_a {
    label: "Average FG3A"
    description: "Average 3PT Field Goal Attempts"
    type: average
    sql: ${TABLE}.FG3A ;;
  }

  measure: avg_fg3_m {
    label: "Average FG3M"
    description: "Average 3PT Field Goal Makes"
    type: average
    sql: ${TABLE}.FG3M ;;
  }

  measure: avg_fga {
    label: "Average FGA"
    description: "Average Field Goal Attempts"
    type: average
    sql: ${TABLE}.FGA ;;
  }

  measure: avg_fgm {
    label: "Average FG3M"
    description: "Average Field Goal Makes"
    type: average
    sql: ${TABLE}.FGM ;;
  }


  measure: avg_fta {
    label: "Average FTA"
    description: "Average Free Throw Attempts"
    type: average
    sql: ${TABLE}.FTA ;;
  }

  measure: avg_ftm {
    label: "Average FTM"
    description: "Average Free Throw Makes"
    type: average
    sql: ${TABLE}.FTM ;;
  }


  measure: avg_min {
    label: "Average MIN"
    description: "Average Minutes Played"
    type: average
    sql: ${TABLE}.MIN ;;
  }

  measure: avg_oreb {
    label: "Average OREB"
    description: "Average Offensive Rebounds"
    type: average
    sql: ${TABLE}.OREB ;;
  }

  measure: avg_pf {
    label: "Average PF"
    description: "Average Personal Fouls"
    type: average
    sql: ${TABLE}.PF ;;
  }

  measure: avg_plus_minus {
    label: "Average Plus Minus"
    description: "Average Point Margin"
    type: average
    sql: ${TABLE}.PLUS_MINUS ;;
  }

  measure: avg_pts {
    label: "Average PTS"
    description: "Average Points Scored"
    type: average
    sql: ${TABLE}.PTS ;;
  }

  measure: avg_reb {
    label: "Average REB"
    description: "Average Rebounds"
    type: average
    sql: ${TABLE}.REB ;;
  }

  measure: avg_stl {
    label: "Average STL"
    description: "Average Steals"
    type: average
    sql: ${TABLE}.STL ;;
  }

  measure: avg_to {
    label: "Average TO"
    description: "Average Turnovers"
    type: average
    sql: ${TABLE}.`TO` ;;
  }

  dimension: team_image {
    sql: ${team_abbreviation} ;;
    html: <img src="http://stats.nba.com/media/img/teams/logos/{{ value }}_logo.svg" width="100" height="100"/> ;;
  }

  dimension: team_image_large {
    sql: ${team_abbreviation} ;;
    html: <img src="http://stats.nba.com/media/img/teams/logos/{{ value }}_logo.svg" width="190" height="190"/> ;;
  }

  dimension: won_game {
    type: yesno
    sql: ${plus_minus} > 0 ;;
  }

  measure: wins {
    type: count
    filters: {
      field: won_game
      value: "yes"
    }
  }

  measure: losses {
    type: count
    filters: {
      field: won_game
      value: "no"
    }
  }

  dimension: conference {
    type: string
    sql: CASE WHEN ${team_name} IN ("Clippers",
                                    "Grizzlies",
                                    "Jazz",
                                    "Kings",
                                    "Lakers",
                                    "Mavericks",
                                    "Nuggets",
                                    "Pelicans",
                                    "Rockets",
                                    "Spurs",
                                    "Suns",
                                    "Thunder",
                                    "Timberwolves",
                                    "Trail Blazers",
                                    "Warriors") THEN "Western"
              ELSE "Eastern"
              END;;
  }

  measure: win_percentage {
    type: number
    sql: ${wins}/${count} ;;
    link: {
      label: "Game Dashboard"
      url: "/dashboards/7?Game={{ value }}"
    }
  }
}
