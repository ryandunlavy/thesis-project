view: rotations {
  derived_table: {
    sql:SELECT * ,
    CASE
      WHEN (GAME_ID!=prev_game_id AND SUB="OUT") THEN 0
      ##check if time = max time where game=gameid and player=player
      WHEN (GAME_ID=prev_game_id AND SUB="IN" AND
      END
      AS
    FROM (SELECT * ,
LAG(TIME,1) OVER (ORDER BY PLAYER, GAME_ID, TIME) AS prev_time,
LAG(PLAYER,1) OVER (ORDER BY PLAYER, GAME_ID, TIME) AS prev_player,
LAG(GAME_ID,1) OVER (ORDER BY PLAYER, GAME_ID, TIME) AS prev_game_id,
LAG(SUB,1) OVER (ORDER BY PLAYER, GAME_ID, TIME) AS prev_sub
FROM
((SELECT GAME_ID,
    PLAYER1_NAME as PLAYER,
    PLAYER1_TEAM_ABBREVIATION AS TEAM,
    'Out' as SUB,
    CASE WHEN CAST(PERIOD AS INT64) > 4
    THEN 48*60 + (CAST(PERIOD AS INT64)-4)*5*60-(CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(1)] AS INT64))
    ELSE 12*60*CAST(PERIOD AS INT64) - (CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(1)] AS INT64))
    END AS TIME FROM nba_data.pbp WHERE EVENTMSGTYPE='8')
    UNION ALL
    (SELECT GAME_ID,
    PLAYER2_NAME as PLAYER,
    PLAYER2_TEAM_ABBREVIATION AS TEAM,
    'In' as SUB,
    CASE WHEN CAST(PERIOD AS INT64) > 4
    THEN 48*60 + (CAST(PERIOD AS INT64)-4)*5*60-(CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(1)] AS INT64))
    ELSE 12*60*CAST(PERIOD AS INT64) - (CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(0)] AS INT64)*60 + CAST(SPLIT(PCTIMESTRING, ':')[OFFSET(1)] AS INT64))
    END AS TIME FROM nba_data.pbp WHERE EVENTMSGTYPE='8')))
    WHERE (prev_sub = "In" AND SUB="Out" AND PLAYER=prev_player AND GAME_ID=prev_game_id) OR (GAME_ID!=prev_game_id AND SUB="OUT")
    ;;
  }

  dimension: game_id {
    type: string
    sql: ${TABLE}.GAME_ID ;;
  }

  dimension: player {
    type: string
    sql: ${TABLE}.PLAYER ;;
  }

  dimension: time_in {
  type: number
  sql: ${TABLE}.prev_time ;;
  }

  dimension: time_out {
    type: number
    sql: ${TABLE}.TIME ;;
  }


}
