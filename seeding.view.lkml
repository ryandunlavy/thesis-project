view: seeding {
  derived_table: {
    sql: SELECT seeds.TEAM_NAME,
       seeds.conference,
       seeds.wins,
       seeds.losses,
       seeds.win_percentage,
       last_month.seed_last_month,
       RANK() OVER ( PARTITION BY seeds.conference ORDER BY seeds.win_percentage DESC) AS seed
       FROM (SELECT
  team_data.TEAM_NAME  AS team_name,
  CASE WHEN team_data.TEAM_NAME IN ("Clippers",
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
              END AS conference,
  COUNT(CASE WHEN team_data.PLUS_MINUS > 0  THEN 1 ELSE NULL END) AS wins,
  COUNT(CASE WHEN NOT COALESCE(team_data.PLUS_MINUS > 0 , FALSE) THEN 1 ELSE NULL END) AS losses,
  (COUNT(CASE WHEN team_data.PLUS_MINUS > 0  THEN 1 ELSE NULL END))/(COUNT(*))  AS win_percentage
FROM nba_data.team_data  AS team_data
GROUP BY 1,2
ORDER BY 2 DESC,5 DESC) seeds LEFT JOIN (SELECT *,
         RANK() OVER ( PARTITION BY conference ORDER BY win_percentage DESC) AS seed_last_month
       FROM (SELECT
  team_data.TEAM_NAME  AS team_name,
  CASE WHEN team_data.TEAM_NAME IN ("Clippers",
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
              END AS conference,
  (COUNT(CASE WHEN team_data.PLUS_MINUS > 0  THEN 1 ELSE NULL END))/(COUNT(*))  AS win_percentage
FROM nba_data.team_data  AS team_data
LEFT JOIN nba_data.game_list  AS game_list ON team_data.GAME_ID = game_list.gameIds
WHERE
  (CAST(REPLACE (game_list.date, "-", "") AS INT64) < (CAST(FORMAT_TIMESTAMP('%Y%m%d', TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), MONTH) AS DATE), INTERVAL 0 MONTH) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), MONTH) AS TIMESTAMP)) AS STRING)))) AS INT64)))
GROUP BY 1,2
ORDER BY 2 DESC,3 DESC)) last_month ON seeds.TEAM_NAME=last_month.team_name
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: team_name {
    type: string
    sql: ${TABLE}.TEAM_NAME ;;
  }

  dimension: conference {
    type: string
    sql: ${TABLE}.conference ;;
  }

  dimension: wins {
    type: number
    sql: ${TABLE}.wins ;;
  }

  dimension: losses {
    type: number
    sql: ${TABLE}.losses ;;
  }

  dimension: win_percentage {
    type: number
    sql: ${TABLE}.win_percentage ;;
  }

  dimension: seed_last_month {
    type: number
    sql: ${TABLE}.seed_last_month ;;
  }

  dimension: seed {
    type: number
    sql: ${TABLE}.seed ;;
  }

  dimension: trend {
      sql: ${seed_last_month} - ${seed} ;;
      html:
      {% if value > 0 %}
         <p><font color="green"> {{ rendered_value }} </font></p>
      {% elsif value < 0 %}
        <p><font color="red"> {{ rendered_value }} </font></p>
      {% else %}
        <p>{{ rendered_value }}</p>
      {% endif %} ;;
  }

  set: detail {
    fields: [
      team_name,
      conference,
      wins,
      losses,
      win_percentage,
      seed_last_month,
      seed
    ]
  }
}
