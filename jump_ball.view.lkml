view: jump_ball {
  derived_table: {
    sql: SELECT GAME_ID,
       EVENTNUM,
       EVENTMSGTYPE,
       EVENTMSGACTIONTYPE,
       PERIOD,
       WCTIMESTRING,
       PCTIMESTRING,
       HOMEDESCRIPTION AS DESCRIPTION,
       SCORE, SCOREMARGIN,
       PERSON1TYPE AS PERSONTYPE,
       PLAYER2_ID AS PLAYER_ID,
       PLAYER2_NAME AS PLAYER_NAME,
       PLAYER2_TEAM_ID AS PLAYER_TEAM_ID,
       PLAYER2_TEAM_CITY AS PLAYER_TEAM_CITY,
       PLAYER2_TEAM_NICKNAME AS PLAYER_TEAM_NICKNAME,
       PLAYER2_TEAM_ABBREVIATION AS PLAYER_TEAM_ABBREVIATION,
       CASE WHEN PLAYER2_TEAM_ID=PLAYER3_TEAM_ID THEN TRUE
       ELSE FALSE
       END AS WON_JUMP_BALL
FROM nba_data.pbp
WHERE EVENTMSGTYPE=10
UNION ALL
SELECT GAME_ID,
       EVENTNUM,
       EVENTMSGTYPE,
       EVENTMSGACTIONTYPE,
       PERIOD,
       WCTIMESTRING,
       PCTIMESTRING,
       HOMEDESCRIPTION AS DESCRIPTION,
       SCORE, SCOREMARGIN,
       PERSON1TYPE AS PERSONTYPE,
       PLAYER1_ID AS PLAYER_ID,
       PLAYER1_NAME AS PLAYER_NAME,
       PLAYER1_TEAM_ID AS PLAYER_TEAM_ID,
       PLAYER1_TEAM_CITY AS PLAYER_TEAM_CITY,
       PLAYER1_TEAM_NICKNAME AS PLAYER_TEAM_NICKNAME,
       PLAYER1_TEAM_ABBREVIATION AS PLAYER_TEAM_ABBREVIATION,
       CASE WHEN PLAYER1_TEAM_ID=PLAYER3_TEAM_ID THEN TRUE
       ELSE FALSE
       END AS WON_JUMP_BALL
FROM nba_data.pbp
WHERE EVENTMSGTYPE=10 ;;
  }

  dimension: eventmsgactiontype {
    type: number
    sql: ${TABLE}.EVENTMSGACTIONTYPE ;;
  }


  dimension: id {
    hidden: yes
    type: string
    primary_key: yes
    sql: CONCAT(${game_id}, ${event_num}) ;;
  }

  measure: total_jump_balls {
    type: count
  }

  measure: jump_balls_won {
    type: count
    filters: {
      field: won_jump_ball
      value: "yes"
    }
  }
  measure: jump_ball_win_percentage {
    type: number
    sql: 1.0*${jump_balls_won}/${total_jump_balls} ;;
    value_format: "0.00%"
    drill_fields: [player_name, jump_balls_won, total_jump_balls]
  }
  dimension: won_jump_ball {
    type: yesno
    sql: ${TABLE}.won_jump_ball ;;
  }
  dimension: event_type {
    hidden: yes
    type: number
    sql: ${TABLE}.EVENTMSGTYPE ;;
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

  dimension: description {
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }


  dimension: pctimestring {
    type: string
    sql: ${TABLE}.PCTIMESTRING ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.PERIOD ;;
  }

  dimension: time {
    type: number
    sql: CASE WHEN ${period} > 4
          THEN 48*60 + (${period}-4)*5*60-(CAST(SPLIT(${pctimestring}, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(${pctimestring}, ':')[OFFSET(1)] AS INT64))
          ELSE 12*60*${period} - (CAST(SPLIT(${pctimestring}, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(${pctimestring}, ':')[OFFSET(1)] AS INT64))
          END;;
  }

  dimension: player_id {
    type: string
    sql: ${TABLE}.PLAYER_ID ;;
  }

  dimension: player_name {
    type: string
    sql: ${TABLE}.PLAYER_NAME ;;
  }

  dimension: player_team_abbreviation {
    type: string
    sql: ${TABLE}.PLAYER_TEAM_ABBREVIATION ;;
  }

  dimension: player_team_city {
    type: string
    sql: ${TABLE}.PLAYER_TEAM_CITY ;;
  }

  dimension: player_team_id {
    type: string
    sql: ${TABLE}.PLAYER_TEAM_ID ;;
  }

  dimension: player_team_nickname {
    type: string
    sql: ${TABLE}.PLAYER_TEAM_NICKNAME ;;
  }

}
