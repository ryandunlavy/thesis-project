view: pbp {
  sql_table_name: nba_data.pbp ;;

  dimension: eventmsgactiontype {
    type: number
    sql: ${TABLE}.EVENTMSGACTIONTYPE ;;
  }

  dimension: event_type {
    hidden: yes
    type: number
    sql: ${TABLE}.EVENTMSGTYPE ;;
  }
  dimension: play_type {
    case: {
      when: {
        sql: ${event_type} = 1 ;;
        label: "Made shot attempt"
      }
      when: {
        sql: ${event_type} = 2 ;;
        label: "Missed shot attempt"
      }
      when: {
        sql: ${event_type} = 3 ;;
        label: "Free throw"
      }
      when: {
        sql: ${event_type} = 4 ;;
        label: "Rebound"
      }
      when: {
        sql: ${event_type} = 5 ;;
        label: "Turnover"
      }
      when: {
        sql: ${event_type} = 6 ;;
        label: "Shooting foul"
      }
      when: {
        sql: ${event_type} = 7 ;;
        label: "Goaltending"
      }
      when: {
        sql: ${event_type} = 8 ;;
        label: "Substitution"
      }
      when: {
        sql: ${event_type} = 9 ;;
        label: "Timeout"
      }
      when: {
        sql: ${event_type} = 10 ;;
        label: "Jump Ball"
      }
      when: {
        sql: ${event_type} = 11 ;;
        label: "Ejection"
      }when: {
        sql: ${event_type} = 12 ;;
        label: "Start of quarter"
      }
      when: {
        sql: ${event_type} = 13 ;;
        label: "End of quarter"
      }
    }
  }
  dimension: event_num {
    label: "Event Number"
    type: number
    sql: ${TABLE}.EVENTNUM ;;
  }

  dimension: game_id {
    label: "Game ID"
    type: string
    sql: ${TABLE}.GAME_ID ;;
  }

  dimension: homedescription {
    type: string
    sql: ${TABLE}.HOMEDESCRIPTION ;;
  }

  dimension: neutraldescription {
    type: string
    sql: ${TABLE}.NEUTRALDESCRIPTION ;;
  }

  dimension: pctimestring {
    type: string
    sql: ${TABLE}.PCTIMESTRING ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.PERIOD ;;
  }

  dimension: person1_type {
    type: number
    sql: ${TABLE}.PERSON1TYPE ;;
  }

  dimension: person2_type {
    type: number
    sql: ${TABLE}.PERSON2TYPE ;;
  }

  dimension: person3_type {
    type: number
    sql: ${TABLE}.PERSON3TYPE ;;
  }

  dimension: player1_id {
    type: string
    sql: ${TABLE}.PLAYER1_ID ;;
  }

  dimension: player1_name {
    type: string
    sql: ${TABLE}.PLAYER1_NAME ;;
  }

  dimension: player1_team_abbreviation {
    type: string
    sql: ${TABLE}.PLAYER1_TEAM_ABBREVIATION ;;
  }

  dimension: player1_team_city {
    type: string
    sql: ${TABLE}.PLAYER1_TEAM_CITY ;;
  }

  dimension: player1_team_id {
    type: string
    sql: ${TABLE}.PLAYER1_TEAM_ID ;;
  }

  dimension: player1_team_nickname {
    type: string
    sql: ${TABLE}.PLAYER1_TEAM_NICKNAME ;;
  }

  dimension: player2_id {
    type: string
    sql: ${TABLE}.PLAYER2_ID ;;
  }

  dimension: player2_name {
    type: string
    sql: ${TABLE}.PLAYER2_NAME ;;
  }

  dimension: player2_team_abbreviation {
    type: string
    sql: ${TABLE}.PLAYER2_TEAM_ABBREVIATION ;;
  }

  dimension: player2_team_city {
    type: string
    sql: ${TABLE}.PLAYER2_TEAM_CITY ;;
  }

  dimension: player2_team_id {
    type: string
    sql: ${TABLE}.PLAYER2_TEAM_ID ;;
  }

  dimension: player2_team_nickname {
    type: string
    sql: ${TABLE}.PLAYER2_TEAM_NICKNAME ;;
  }

  dimension: player3_id {
    type: string
    sql: ${TABLE}.PLAYER3_ID ;;
  }

  dimension: player3_name {
    type: string
    sql: ${TABLE}.PLAYER3_NAME ;;
  }

  dimension: player3_team_abbreviation {
    type: string
    sql: ${TABLE}.PLAYER3_TEAM_ABBREVIATION ;;
  }

  dimension: player3_team_city {
    type: string
    sql: ${TABLE}.PLAYER3_TEAM_CITY ;;
  }

  dimension: player3_team_id {
    type: string
    sql: ${TABLE}.PLAYER3_TEAM_ID ;;
  }

  dimension: player3_team_nickname {
    type: string
    sql: ${TABLE}.PLAYER3_TEAM_NICKNAME ;;
  }

  dimension: score {
    type: string
    sql: ${TABLE}.SCORE ;;
  }

  dimension: scoremargin {
    type: number
    sql: ${TABLE}.SCOREMARGIN ;;
  }

  dimension: visitordescription {
    type: string
    sql: ${TABLE}.VISITORDESCRIPTION ;;
  }

  dimension: wctimestring {
    type: string
    sql: ${TABLE}.WCTIMESTRING ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: jumpball_count {
    type: count
    filters: {
      field: event_num
      value: "4"
    }
    filters: {
      field: play_type
      value: "Jump Ball"
    }
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      player2_team_nickname,
      player3_name,
      player3_team_nickname,
      player2_name,
      player1_team_nickname,
      player1_name
    ]
  }
}
