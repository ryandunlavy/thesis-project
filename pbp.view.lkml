view: pbp {
  label: "Play By Play"
  sql_table_name: nba_data.pbp ;;

  dimension: eventmsgactiontype {
    label: "Event Action Type"
    type: number
    sql: ${TABLE}.EVENTMSGACTIONTYPE ;;
  }
#
  dimension: is_shot {
    type: yesno
    sql: ${event_type}=1 OR ${event_type}=2 ;;
  }

  dimension: id {
    hidden: yes
    type: string
    primary_key: yes
    sql: CONCAT(${game_id}, ${event_num}) ;;
  }

  dimension: made_shot {
    type: yesno
    sql: ${event_type}=1 ;;
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
    link: {
      label: "Game Dashboard"
      url: "/dashboards/7?Game={{ value }}"
    }
  }

  dimension: homedescription {
    label: "Home Description"
    type: string
    sql: ${TABLE}.HOMEDESCRIPTION ;;
  }

  dimension: neutraldescription {
    label: "Neutral Description"
    type: string
    sql: ${TABLE}.NEUTRALDESCRIPTION ;;
  }

  dimension: pctimestring {
    label: "Play Clock Timestring"
    type: string
    sql: ${TABLE}.PCTIMESTRING ;;
  }

  dimension: period {
    label: "Quarter"
    type: number
    sql: ${TABLE}.PERIOD ;;
  }
  dimension: period_string {
    type: string
    hidden: yes
    sql: CAST(${period} AS STRING) ;;
  }

  dimension: person1_type {
    label: "Person 1 Type"
    type: number
    sql: ${TABLE}.PERSON1TYPE ;;
  }

  dimension: person2_type {
    label: "Person 2 Type"
    type: number
    sql: ${TABLE}.PERSON2TYPE ;;
  }

  dimension: person3_type {
    label: "Person 3 Type"
    type: number
    sql: ${TABLE}.PERSON3TYPE ;;
  }
  dimension: time {
    type: number
    sql: CASE WHEN ${period} > 4
    THEN 48*60 + (${period}-4)*5*60-(CAST(SPLIT(${pctimestring}, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(${pctimestring}, ':')[OFFSET(1)] AS INT64))
    ELSE 12*60*${period} - (CAST(SPLIT(${pctimestring}, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(${pctimestring}, ':')[OFFSET(1)] AS INT64))
    END;;
  }

  dimension: player1_id {
    label: "Player 1 ID"
    type: string
    sql: ${TABLE}.PLAYER1_ID ;;
  }

  dimension: player1_name {
    label: "Player 1 Name"
    type: string
    sql: ${TABLE}.PLAYER1_NAME ;;
  }

  dimension: player1_team_abbreviation {
    label: "Player 1 Team Abbreviation"
    type: string
    sql: ${TABLE}.PLAYER1_TEAM_ABBREVIATION ;;
  }

  dimension: player1_team_city {
    label: "Player 1 Team City"
    type: string
    sql: ${TABLE}.PLAYER1_TEAM_CITY ;;
  }

  dimension: player1_team_id {
    label: "Player 1 Team ID"
    type: string
    sql: ${TABLE}.PLAYER1_TEAM_ID ;;
  }

  dimension: player1_team_nickname {
    label: "Player 1 Team Nickname"
    type: string
    sql: ${TABLE}.PLAYER1_TEAM_NICKNAME ;;
  }

  dimension: player2_id {
    label: "Player 2 ID"
    type: string
    sql: ${TABLE}.PLAYER2_ID ;;
  }

  dimension: player2_name {
    label: "Player 2 Name"
    type: string
    sql: ${TABLE}.PLAYER2_NAME ;;
  }

  dimension: player2_team_abbreviation {
    label: "Player 2 Team Abbreviation"
    type: string
    sql: ${TABLE}.PLAYER2_TEAM_ABBREVIATION ;;
  }

  dimension: player2_team_city {
    label: "Player 2 Team City"
    type: string
    sql: ${TABLE}.PLAYER2_TEAM_CITY ;;
  }

  dimension: player2_team_id {
    label: "Player 2 Team ID"
    type: string
    sql: ${TABLE}.PLAYER2_TEAM_ID ;;
  }

  dimension: player2_team_nickname {
    label: "Player 2 Team Nickname"
    type: string
    sql: ${TABLE}.PLAYER2_TEAM_NICKNAME ;;
  }

  dimension: player3_id {
    label: "Player 3 ID"
    type: string
    sql: ${TABLE}.PLAYER3_ID ;;
  }

  dimension: player3_name {
    label: "Player 3 Name"
    type: string
    sql: ${TABLE}.PLAYER3_NAME ;;
  }

  dimension: player3_team_abbreviation {
    label: "Player 3 Team Abbreviation"
    type: string
    sql: ${TABLE}.PLAYER3_TEAM_ABBREVIATION ;;
  }

  dimension: player3_team_city {
    label: "Player 3 Team City"
    type: string
    sql: ${TABLE}.PLAYER3_TEAM_CITY ;;
  }

  dimension: player3_team_id {
    label: "Player 3 Team ID"
    type: string
    sql: ${TABLE}.PLAYER3_TEAM_ID ;;
  }

  dimension: player3_team_nickname {
    label: "Player 3 Team Nickname"
    type: string
    sql: ${TABLE}.PLAYER3_TEAM_NICKNAME ;;
  }

  dimension: score {
    type: string
    sql: ${TABLE}.SCORE ;;
  }

  dimension: scoremargin {
    label: "Score Margin"
    type: number
    sql: ${TABLE}.SCOREMARGIN ;;
  }

  dimension: visitordescription {
    label: "Visitor Description"
    type: string
    sql: ${TABLE}.VISITORDESCRIPTION ;;
  }

  dimension: wctimestring {
    hidden: yes
    label: "World Clock Time String"
    type: string
    sql: ${TABLE}.WCTIMESTRING ;;
  }

  dimension_group: event {
    type: time
    datatype: timestamp
    sql:PARSE_TIMESTAMP("%F %I:%M %p", CONCAT(${game_list.date_string}, " ", ${wctimestring}), "US/Eastern") ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: shooting_pct {
    label: "Shooting Percentage"
    type: number
    sql: ${count_made}/NULLIF(${count_attempts}, 0) ;;
    drill_fields: [player1_name, count_made, count_attempts]
    value_format: "0.00%"
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

  measure: count_made {
    type: count
    filters: {
      field: event_type
      value: "1"
    }
  }

  measure: count_attempts {
    type: count
    filters: {
      field: is_shot
      value: "yes"
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
