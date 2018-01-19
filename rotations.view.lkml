view: rotations {
  derived_table: {
    sql:SELECT * FROM (SELECT *,
  CASE WHEN SUB="In" AND prev_game_id!=GAME_ID THEN TIME
       WHEN prev_game_id!=GAME_ID AND SUB="Out" THEN 0
       ELSE prev_time
       END AS sub_in_time,
  CASE WHEN SUB="In" AND next_game_id!=GAME_ID THEN 48*60
       ELSE TIME
       END AS sub_out_time,
  CASE WHEN (SUB="In" AND next_game_id!=GAME_ID) OR (prev_game_id!=GAME_ID AND SUB="Out") THEN "In"
       ELSE prev_sub
       END AS first_sub,
  CASE WHEN (SUB="In" AND next_game_id!=GAME_ID) THEN "Out"
       ELSE SUB
       END AS second_sub
FROM (SELECT * ,
LAG(TIME,1) OVER (ORDER BY PLAYER, GAME_ID, TIME) AS prev_time,
LAG(GAME_ID,1) OVER (ORDER BY PLAYER, GAME_ID, TIME) AS prev_game_id,
LAG(SUB,1) OVER (ORDER BY PLAYER, GAME_ID, TIME) AS prev_sub,
LAG(margin,1) OVER (ORDER BY PLAYER, GAME_ID, TIME) AS prev_margin,
LEAD(GAME_ID,1) OVER (ORDER BY PLAYER, GAME_ID, TIME) AS next_game_id
FROM
((SELECT GAME_ID,
    PLAYER1_NAME as PLAYER,
    PLAYER1_TEAM_ABBREVIATION AS TEAM,
    'Out' as SUB,
    CASE WHEN CAST(PERIOD AS INT64) > 4
    THEN 48*60 + (CAST(PERIOD AS INT64)-4)*5*60-(CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(1)] AS INT64))
    ELSE 12*60*CAST(PERIOD AS INT64) - (CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(1)] AS INT64))
    END AS TIME,
    CASE WHEN HOMEDESCRIPTION IS NULL THEN -1*SCOREMARGIN
    ELSE SCOREMARGIN
    END AS margin FROM nba_data.pbp WHERE EVENTMSGTYPE=8)
    UNION ALL
    (SELECT GAME_ID,
    PLAYER2_NAME as PLAYER,
    PLAYER2_TEAM_ABBREVIATION AS TEAM,
    'In' as SUB,
    CASE WHEN CAST(PERIOD AS INT64) > 4
    THEN 48*60 + (CAST(PERIOD AS INT64)-4)*5*60-(CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(1)] AS INT64))
    ELSE 12*60*CAST(PERIOD AS INT64) - (CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(1)] AS INT64))
    END AS TIME,
    CASE WHEN HOMEDESCRIPTION IS NULL THEN -1*SCOREMARGIN
    ELSE SCOREMARGIN
    END AS margin
    FROM nba_data.pbp WHERE EVENTMSGTYPE=8)))) WHERE first_sub="In" AND second_sub="Out"
    ;;
  }

  dimension: team {
    type: string
    sql: ${TABLE}.TEAM ;;
  }
  dimension: game_id {
    type: string
    sql: ${TABLE}.GAME_ID ;;
  }

  dimension: player {
    type: string
    sql: ${TABLE}.PLAYER ;;
  }

  dimension: sub_in_time {
  type: number
  sql: ${TABLE}.first_sub ;;
  }

  dimension: sub_out_time {
    type: number
    sql: ${TABLE}.second_sub ;;
  }




}
