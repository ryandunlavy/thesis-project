view: shots {
  derived_table: {
    datagroup_trigger: nba_trigger
    sql: (SELECT *, CASE WHEN GAME_ID!=game_3 OR attempt_3 != 1 THEN 0
               WHEN (attempt_3=1) AND (attempt_2!=1 OR GAME_ID!=game_2) THEN 1
               WHEN (attempt_2=1) AND (attempt_1!=1 OR GAME_ID!=game_1) THEN 2
               ELSE 3
               END AS streak
       FROM (SELECT GAME_ID,
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
      LAG(GAME_ID,3) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS game_1,
      LAG(GAME_ID,2) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS game_2,
      LAG(GAME_ID,1) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS game_3,
      LAG(EVENTMSGTYPE,3) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS attempt_1,
      LAG(EVENTMSGTYPE,2) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS attempt_2,
      LAG(EVENTMSGTYPE,1) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS attempt_3
FROM nba_data.pbp
WHERE HOMEDESCRIPTION IS NOT NULL AND EVENTMSGTYPE IN (1, 2)))
UNION ALL
(SELECT *, CASE WHEN GAME_ID!=game_3 OR attempt_3 != 1 THEN 0
               WHEN (attempt_3=1) AND (attempt_2!=1 OR GAME_ID!=game_2) THEN 1
               WHEN (attempt_2=1) AND (attempt_1!=1 OR GAME_ID!=game_1) THEN 2
               ELSE 3
               END AS streak
       FROM (SELECT GAME_ID,
       EVENTNUM,
       EVENTMSGTYPE,
       EVENTMSGACTIONTYPE,
       PERIOD,
       WCTIMESTRING,
       PCTIMESTRING,
       VISITORDESCRIPTION AS DESCRIPTION,
       SCORE, SCOREMARGIN,
       PERSON1TYPE AS PERSONTYPE,
       PLAYER1_ID AS PLAYER_ID,
       PLAYER1_NAME AS PLAYER_NAME,
       PLAYER1_TEAM_ID AS PLAYER_TEAM_ID,
       PLAYER1_TEAM_CITY AS PLAYER_TEAM_CITY,
       PLAYER1_TEAM_NICKNAME AS PLAYER_TEAM_NICKNAME,
       PLAYER1_TEAM_ABBREVIATION AS PLAYER_TEAM_ABBREVIATION,
      LAG(GAME_ID,3) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS game_1,
      LAG(GAME_ID,2) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS game_2,
      LAG(GAME_ID,1) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS game_3,
      LAG(EVENTMSGTYPE,3) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS attempt_1,
      LAG(EVENTMSGTYPE,2) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS attempt_2,
      LAG(EVENTMSGTYPE,1) OVER (ORDER BY PLAYER1_ID, GAME_ID, EVENTNUM) AS attempt_3
FROM nba_data.pbp
WHERE VISITORDESCRIPTION IS NOT NULL AND EVENTMSGTYPE IN (1, 2))) ;;
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

  dimension: made_shot {
    type: yesno
    sql: ${event_type} = 1 ;;
  }

  measure: made_shots {
    type: count
    filters: {
      field: event_type
      value: "1"
    }
  }

  measure: missed_shots {
    type: count
    filters: {
      field: event_type
      value: "2"
    }
  }

  dimension: wctimestring {
    sql: ${TABLE}.WCTIMESTRING ;;
  }

  dimension_group: shot {
    type: time
    datatype: timestamp
    sql:PARSE_TIMESTAMP("%F %R %p", CONCAT(${game_list.date_string}, " ", ${wctimestring}), "US/Eastern") ;;
  }

  measure: shot_attempts {
    type: count
  }

  dimension: streak {
    type: number
    sql: ${TABLE}.streak ;;
  }

  measure: made_shots_after_0 {
    type: count
    filters: {
      field: event_type
      value: "1"
    }
    filters: {
      field: streak
      value: "0"
    }
  }

  measure: shot_attempts_after_0 {
    type: count
    filters: {
      field: streak
      value: "0"
    }
  }

  measure: shooting_percentage_after_0 {
    type: number
    sql: ${made_shots_after_0}/NULLIF(${shot_attempts_after_0},0) ;;
    value_format: "0.00%"
  }
  measure: made_shots_after_1 {
    type: count
    filters: {
      field: event_type
      value: "1"
    }
    filters: {
      field: streak
      value: "1"
    }
  }

  measure: shot_attempts_after_1 {
    type: count
    filters: {
      field: streak
      value: "1"
    }
  }

  measure: shooting_percentage_after_1 {
    type: number
    sql: ${made_shots_after_1}/NULLIF(${shot_attempts_after_1},0) ;;
    value_format: "0.00%"
  }
  measure: made_shots_after_2 {
    type: count
    filters: {
      field: event_type
      value: "1"
    }
    filters: {
      field: streak
      value: "2"
    }
  }

  measure: shot_attempts_after_2 {
    type: count
    filters: {
      field: streak
      value: "2"
    }
  }

  measure: shooting_percentage_after_2 {
    type: number
    sql: ${made_shots_after_2}/NULLIF(${shot_attempts_after_2},0) ;;
    value_format: "0.00%"
  }
  measure: made_shots_after_3 {
    type: count
    filters: {
      field: event_type
      value: "1"
    }
    filters: {
      field: streak
      value: "3"
    }
  }

  measure: shot_attempts_after_3 {
    type: count
    filters: {
      field: streak
      value: "3"
    }
  }

  measure: shooting_percentage_after_3 {
    type: number
    sql: ${made_shots_after_3}/NULLIF(${shot_attempts_after_3},0) ;;
    value_format: "0.00%"
  }

  measure: shooting_percentage {
    type: number
    sql: ${made_shots}/${shot_attempts} ;;
    value_format: "0.00%"
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

  dimension: player1_team_nickname {
    type: string
    sql: ${TABLE}.PLAYER_TEAM_NICKNAME ;;
  }





}
