view: pbp {
  sql_table_name: nba_data.pbp ;;

  dimension: eventmsgactiontype {
    type: string
    sql: ${TABLE}.EVENTMSGACTIONTYPE ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.EVENTMSGTYPE ;;
  }

  dimension: play_type {
    case: {
      when: {
        sql: ${event_type} = "1" ;;
        label: "Made shot attempt"
      }
      when: {
        sql: ${event_type} = "2" ;;
        label: "Missed shot attempt"
      }
      when: {
        sql: ${event_type} = "3" ;;
        label: "Free throw"
      }
      when: {
        sql: ${event_type} = "4" ;;
        label: "Defense rebound"
      }
      when: {
        sql: ${event_type} = "5" ;;
        label: "Turnover"
      }
      when: {
        sql: ${event_type} = "6" ;;
        label: "Shooting foul"
      }
      when: {
        sql: ${event_type} = "7" ;;
        label: "Goaltending"
      }
      when: {
        sql: ${event_type} = "8" ;;
        label: "Substitution"
      }
      when: {
        sql: ${event_type} = "9" ;;
        label: "Timeout"
      }
      when: {
        sql: ${event_type} = "10" ;;
        label: "Jump Ball"
      }
      when: {
        sql: ${event_type} = "11" ;;
        label: "Ejection"
      }when: {
        sql: ${event_type} = "12" ;;
        label: "Start of quarter"
      }
      when: {
        sql: ${event_type} = "13" ;;
        label: "End of quarter"
      }
    }
  }

  dimension: eventnum {
    type: number
    sql: CAST(${TABLE}.EVENTNUM AS INT64) ;;
  }

  dimension: game_id {
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

  dimension: time {
    type: number
    sql: CASE WHEN ${period} > 4
    THEN 48*60 + (${period}-4)*5*60-(CAST(SPLIT(${pctimestring}, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(${pctimestring}, ':')[OFFSET(1)] AS INT64))
    ELSE 12*60*${period} - (CAST(SPLIT(${pctimestring}, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(${pctimestring}, ':')[OFFSET(1)] AS INT64))
    END;;
  }

  dimension: period {
    type: number
    sql: CAST(${TABLE}.PERIOD AS INT64) ;;
  }

  dimension: person1_type {
    type: string
    sql: ${TABLE}.PERSON1TYPE ;;
  }

  dimension: person2_type {
    type: string
    sql: ${TABLE}.PERSON2TYPE ;;
  }

  dimension: person3_type {
    type: string
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

  dimension: home_score {
    type: number
    sql: CAST(SPLIT(${score}, ' - ')[OFFSET(1)] AS INT64) ;;
  }

  dimension: visitor_score {
    type: number
    sql: CAST(SPLIT(${score}, ' - ')[OFFSET(0)] AS INT64) ;;
  }

  dimension: scoremargin {
    type: string
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

  ###New stuff

  dimension: made {
    type: number
    sql: CASE WHEN ${event_type} = "1" THEN 1
              WHEN ${event_type} = "2" THEN 0
              ELSE NULL
          END;;

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
