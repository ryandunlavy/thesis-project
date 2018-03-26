view: player_season {
  derived_table: {
    sql: SELECT *,
      RANK() OVER (ORDER BY games_played DESC) AS games_played_rank,
     RANK() OVER (ORDER BY avg_fgm DESC) AS avg_fgm_rank,
     RANK() OVER (ORDER BY avg_fga DESC) AS avg_fga_rank,
     RANK() OVER (ORDER BY avg_fg3m DESC) AS avg_fg3m_rank,
     RANK() OVER (ORDER BY avg_ftm DESC) AS avg_ftm_rank,
     RANK() OVER (ORDER BY avg_fta DESC) AS avg_fta_rank,
     RANK() OVER (ORDER BY avg_oreb DESC) AS avg_oreb_rank,
     RANK() OVER (ORDER BY avg_dreb DESC) AS avg_dreb_rank,
     RANK() OVER (ORDER BY avg_reb DESC) AS avg_reb_rank,
     RANK() OVER (ORDER BY avg_ast DESC) AS avg_ast_rank,
     RANK() OVER (ORDER BY avg_stl DESC) AS avg_stl_rank,
     RANK() OVER (ORDER BY avg_blk DESC) AS avg_blk_rank,
     RANK() OVER (ORDER BY avg_pf DESC) AS avg_pf_rank,
     RANK() OVER (ORDER BY avg_pts DESC) AS avg_pts_rank,
     RANK() OVER (ORDER BY avg_plus_minus DESC) AS avg_plus_minus_rank,
       RANK() OVER (ORDER BY tot_fgm DESC) AS tot_fgm_rank,
       RANK() OVER (ORDER BY tot_fga DESC) AS tot_fga_rank,
        RANK() OVER (ORDER BY tot_fg3m DESC) AS tot_fg3m_rank,
       RANK() OVER (ORDER BY tot_ftm DESC) AS tot_ftm_rank,
       RANK() OVER (ORDER BY tot_fta DESC) AS tot_fta_rank,
       RANK() OVER (ORDER BY tot_oreb DESC) AS tot_oreb_rank,
       RANK() OVER (ORDER BY tot_dreb DESC) AS tot_dreb_rank,
       RANK() OVER (ORDER BY tot_reb DESC) AS tot_reb_rank,
       RANK() OVER (ORDER BY tot_ast DESC) AS tot_ast_rank,
       RANK() OVER (ORDER BY tot_stl DESC) AS tot_stl_rank,
       RANK() OVER (ORDER BY tot_blk DESC) AS tot_blk_rank,
       RANK() OVER (ORDER BY tot_pf DESC) AS tot_pf_rank,
       RANK() OVER (ORDER BY tot_pts DESC) AS tot_pts_rank,
       RANK() OVER (ORDER BY tot_plus_minus DESC) AS tot_plus_minus_rank
FROM (SELECT TEAM_ID,
       TEAM_ABBREVIATION,
       PLAYER_ID,
       PLAYER_NAME,
       COUNT(MIN) AS games_played,
       AVG(FGM) AS avg_fgm,
       AVG(FGA) AS avg_fga,
       AVG(FG3M) AS avg_fg3m,
       AVG(FG3A) AS avg_fg3a,
       AVG(FTM) AS avg_ftm,
       AVG(FTA) AS avg_fta,
       AVG(OREB) AS avg_oreb,
       AVG(DREB) AS avg_dreb,
       AVG(REB) AS avg_reb,
       AVG(AST) AS avg_ast,
       AVG(STL) AS avg_stl,
       AVG(BLK) AS avg_blk,
       AVG(PF) AS avg_pf,
       AVG(PTS) AS avg_pts,
       AVG(PLUS_MINUS) AS avg_plus_minus,
       SUM(FGM) AS tot_fgm,
       SUM(FGA) AS tot_fga,
       SUM(FG3M) AS tot_fg3m,
       SUM(FG3A) AS tot_fg3a,
       SUM(FTM) AS tot_ftm,
       SUM(FTA) AS tot_fta,
       SUM(OREB) AS tot_oreb,
       SUM(DREB) AS tot_dreb,
       SUM(REB) AS tot_reb,
       SUM(AST) AS tot_ast,
       SUM(STL) AS tot_stl,
       SUM(BLK) AS tot_blk,
       SUM(PF) AS tot_pf,
       SUM(PTS) AS tot_pts,
       SUM(PLUS_MINUS) AS tot_plus_minus
  FROM nba_data.box_score
  GROUP BY TEAM_ABBREVIATION, TEAM_ID, PLAYER_ID, PLAYER_NAME);;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: player_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.PLAYER_ID ;;
  }

  dimension: player_name {
    type: string
    sql: ${TABLE}.PLAYER_NAME ;;
    link: {
      label: "Player Dashboard"
      url: "/dashboards/6?Player={{ value }}"
    }
  }

  dimension: games_played {
    type: number
    sql: ${TABLE}.games_played ;;
  }

  dimension: avg_fgm {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_fgm ;;
  }

  dimension: avg_fga {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_fga ;;
  }

  dimension: avg_fg3m {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_fg3m ;;
  }

  dimension: avg_fg3a {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_fg3a ;;
  }

  dimension: avg_ftm {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_ftm ;;
  }

  dimension: avg_fta {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_fta ;;
  }

  dimension: avg_oreb {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_oreb ;;
  }

  dimension: avg_dreb {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_dreb ;;
  }

  dimension: avg_reb {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_reb ;;
  }

  dimension: avg_ast {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_ast ;;
  }

  dimension: avg_stl {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_stl ;;
  }

  dimension: avg_blk {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_blk ;;
  }

  dimension: avg_pf {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_pf ;;
  }

  dimension: avg_pts {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_pts ;;
  }

  dimension: avg_plus_minus {
    type: number
    value_format: "0.#"
    sql: ${TABLE}.avg_plus_minus ;;
  }

  dimension: tot_fgm {
    type: number
    sql: ${TABLE}.tot_fgm ;;
  }

  dimension: tot_fga {
    type: number
    sql: ${TABLE}.tot_fga ;;
  }

  dimension: tot_fg3m {
    type: number
    sql: ${TABLE}.tot_fg3m ;;
  }

  dimension: tot_fg3a {
    type: number
    sql: ${TABLE}.tot_fg3a ;;
  }

  dimension: tot_ftm {
    type: number
    sql: ${TABLE}.tot_ftm ;;
  }

  dimension: tot_fta {
    type: number
    sql: ${TABLE}.tot_fta ;;
  }

  dimension: tot_oreb {
    type: number
    sql: ${TABLE}.tot_oreb ;;
  }

  dimension: tot_dreb {
    type: number
    sql: ${TABLE}.tot_dreb ;;
  }

  dimension: tot_reb {
    type: number
    sql: ${TABLE}.tot_reb ;;
  }

  dimension: tot_ast {
    type: number
    sql: ${TABLE}.tot_ast ;;
  }

  dimension: tot_stl {
    type: number
    sql: ${TABLE}.tot_stl ;;
  }

  dimension: tot_blk {
    type: number
    sql: ${TABLE}.tot_blk ;;
  }

  dimension: tot_pf {
    type: number
    sql: ${TABLE}.tot_pf ;;
  }

  dimension: tot_pts {
    type: number
    sql: ${TABLE}.tot_pts ;;
  }

  dimension: tot_plus_minus {
    type: number
    sql: ${TABLE}.tot_plus_minus ;;
  }

  dimension: games_played_rank {
    type: number
    sql: ${TABLE}.games_played_rank ;;
  }

  dimension: avg_fgm_rank {
    type: number
    sql: ${TABLE}.avg_fgm_rank ;;
  }

  dimension: avg_fga_rank {
    type: number
    sql: ${TABLE}.avg_fga_rank ;;
  }

  dimension: avg_fg3m_rank {
    type: number
    sql: ${TABLE}.avg_fg3m_rank ;;
  }

  dimension: avg_ftm_rank {
    type: number
    sql: ${TABLE}.avg_ftm_rank ;;
  }

  dimension: avg_fta_rank {
    type: number
    sql: ${TABLE}.avg_fta_rank ;;
  }

  dimension: avg_oreb_rank {
    type: number
    sql: ${TABLE}.avg_oreb_rank ;;
  }

  dimension: avg_dreb_rank {
    type: number
    sql: ${TABLE}.avg_dreb_rank ;;
  }

  dimension: avg_reb_rank {
    type: number
    sql: ${TABLE}.avg_reb_rank ;;
  }

  dimension: avg_ast_rank {
    type: number
    sql: ${TABLE}.avg_ast_rank ;;
  }

  dimension: avg_stl_rank {
    type: number
    sql: ${TABLE}.avg_stl_rank ;;
  }

  dimension: avg_blk_rank {
    type: number
    sql: ${TABLE}.avg_blk_rank ;;
  }

  dimension: avg_pf_rank {
    type: number
    sql: ${TABLE}.avg_pf_rank ;;
  }

  dimension: avg_pts_rank {
    type: number
    sql: ${TABLE}.avg_pts_rank ;;
  }

  dimension: avg_plus_minus_rank {
    type: number
    sql: ${TABLE}.avg_plus_minus_rank ;;
  }

  dimension: tot_fgm_rank {
    type: number
    sql: ${TABLE}.tot_fgm_rank ;;
  }

  dimension: tot_fga_rank {
    type: number
    sql: ${TABLE}.tot_fga_rank ;;
  }

  dimension: tot_fg3m_rank {
    type: number
    sql: ${TABLE}.tot_fg3m_rank ;;
  }

  dimension: tot_ftm_rank {
    type: number
    sql: ${TABLE}.tot_ftm_rank ;;
  }

  dimension: tot_fta_rank {
    type: number
    sql: ${TABLE}.tot_fta_rank ;;
  }

  dimension: tot_oreb_rank {
    type: number
    sql: ${TABLE}.tot_oreb_rank ;;
  }

  dimension: tot_dreb_rank {
    type: number
    sql: ${TABLE}.tot_dreb_rank ;;
  }

  dimension: tot_reb_rank {
    type: number
    sql: ${TABLE}.tot_reb_rank ;;
  }

  dimension: tot_ast_rank {
    type: number
    sql: ${TABLE}.tot_ast_rank ;;
  }

  dimension: tot_stl_rank {
    type: number
    sql: ${TABLE}.tot_stl_rank ;;
  }

  dimension: tot_blk_rank {
    type: number
    sql: ${TABLE}.tot_blk_rank ;;
  }

  dimension: tot_pf_rank {
    type: number
    sql: ${TABLE}.tot_pf_rank ;;
  }

  dimension: tot_pts_rank {
    type: number
    sql: ${TABLE}.tot_pts_rank ;;
  }

  dimension: team_abbreviation {
    type: string
    sql: ${TABLE}.TEAM_ABBREVIATION ;;
  }
  dimension: team_id {
    type: string
    sql: ${TABLE}.TEAM_ID ;;
  }

  dimension: tot_plus_minus_rank {
    type: string
    sql: ${TABLE}.tot_plus_minus_rank ;;
  }

  dimension: player_image {
    sql: CONCAT("https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/", ${team_id}, "/2017/260x190/", ${player_id}, ".png") ;;
    html: <img src="{{ value }}" width="137" height="100"/> ;;
    link: {
      label: "Player Dashboard"
      url: "/dashboards/6?Player={{ value }}"
    }
  }

  dimension: player_image_large {
    sql: CONCAT("https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/", ${team_id}, "/2017/260x190/", ${player_id}, ".png") ;;
    html: <img src="{{ value }}" width="260" height="190"/> ;;
    link: {
      label: "Player Dashboard"
      url: "/dashboards/6?Player={{ value }}"
    }
  }

  measure: player_pic {
    type: count
    html: <img src="https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/{{player_season.team_id._value}}/2017/260x190/{{player_season.player_id._value}}.png" width="137" height="100"/> ;;
    }

  set: detail {
    fields: [
      player_id,
      player_name,
      games_played,
      avg_fgm,
      avg_fga,
      avg_fg3m,
      avg_fg3a,
      avg_ftm,
      avg_fta,
      avg_oreb,
      avg_dreb,
      avg_reb,
      avg_ast,
      avg_stl,
      avg_blk,
      avg_pf,
      avg_pts,
      avg_plus_minus,
      tot_fgm,
      tot_fga,
      tot_fg3m,
      tot_fg3a,
      tot_ftm,
      tot_fta,
      tot_oreb,
      tot_dreb,
      tot_reb,
      tot_ast,
      tot_stl,
      tot_blk,
      tot_pf,
      tot_pts,
      tot_plus_minus,
      games_played_rank,
      avg_fgm_rank,
      avg_fga_rank,
      avg_fg3m_rank,
      avg_ftm_rank,
      avg_fta_rank,
      avg_oreb_rank,
      avg_dreb_rank,
      avg_reb_rank,
      avg_ast_rank,
      avg_stl_rank,
      avg_blk_rank,
      avg_pf_rank,
      avg_pts_rank,
      avg_plus_minus_rank,
      tot_fgm_rank,
      tot_fga_rank,
      tot_fg3m_rank,
      tot_ftm_rank,
      tot_fta_rank,
      tot_oreb_rank,
      tot_dreb_rank,
      tot_reb_rank,
      tot_ast_rank,
      tot_stl_rank,
      tot_blk_rank,
      tot_pf_rank,
      tot_pts_rank,
      tot_plus_minus_rank
    ]
  }
}
