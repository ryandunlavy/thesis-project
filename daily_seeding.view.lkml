view: daily_seeding {
  derived_table: {
    sql: SELECT TEAM_NAME,
                conference,
                date,
                wins,
                losses,
                RANK() OVER ( PARTITION BY DATE, CONFERENCE ORDER BY (wins/NULLIF(losses,0)) DESC) AS conference_rank,
                RANK() OVER ( PARTITION BY DATE ORDER BY (wins/NULLIF(losses,0)) DESC) AS league_rank
    FROM (SELECT *,
          SUM(CASE WHEN won THEN 1 ELSE 0 END) OVER (PARTITION BY TEAM_NAME ORDER BY date) AS wins,
          SUM(CASE WHEN NOT won THEN 1 ELSE 0 END) OVER (PARTITION BY TEAM_NAME ORDER BY date) AS losses
          FROM
      (SELECT CAST(dates.date AS DATE) as date,
              dates.TEAM_NAME,
              CASE WHEN dates.TEAM_NAME IN ("Clippers",
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
              (games.PLUS_MINUS > 0) as won
              FROM
        (SELECT * FROM (SELECT TEAM_NAME FROM team_data GROUP BY 1)
        FULL JOIN (SELECT date FROM game_list GROUP BY 1) ON 1=1) dates
        LEFT JOIN (SELECT * FROM game_list g LEFT JOIN team_data t ON g.gameIds=t.GAME_ID) games
        ON games.date=dates.date AND games.TEAM_NAME=dates.TEAM_NAME
      ORDER BY TEAM_NAME, date) games)
      WHERE TEAM_NAME NOT IN ('LeBron', 'World', 'USA', 'Stephen')
      GROUP BY 1,2,3,4,5
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

  dimension_group: seeding {
    type: time
    datatype: date
    timeframes: [raw, date, week, month, year]
    sql: ${TABLE}.date;;
  }

  dimension: wins {
    type: number
    sql: ${TABLE}.wins ;;
  }

  dimension: losses {
    type: number
    sql: ${TABLE}.losses ;;
  }

  dimension: conference_rank {
    type: number
    sql: ${TABLE}.conference_rank ;;
  }
  dimension: league_rank {
    type: number
    sql: ${TABLE}.league_rank ;;
  }
  measure: highest_league_rank {
    type: max
    sql:  ${league_rank};;
  }
  measure: lowest_league_rank {
    type: min
    sql:  ${league_rank};;
  }
  measure: highest_conference_rank {
    type: max
    sql:  ${conference_rank};;
  }
  measure: lowest_conference_rank {
    type: min
    sql:  ${conference_rank};;
  }

  filter: date_filter {
    type: date
  }

  set: detail {
    fields: [
      team_name,
      conference,
      seeding_date,
      wins,
      losses,
      league_rank,
      conference_rank
    ]
  }
}
