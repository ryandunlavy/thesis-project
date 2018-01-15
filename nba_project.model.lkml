connection: "ryan-thesis"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"


datagroup: ryan_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ryan_thesis_default_datagroup

explore: loc {}

explore: play_by_play {
  from: pbp
  join: loc {
    sql_on: ${loc.gameid} = ${play_by_play.game_id} AND ${loc.eventid} = ${play_by_play.event_num} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: game_list {
    sql_on: ${game_list.game_ids} = ${play_by_play.game_id} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: game_list {}
explore: box_score {
  join: game_list {
    sql_on: ${box_score.game_id} = ${game_list.game_ids} ;;
    relationship: many_to_one
  }
}


explore: team_data {
  join: opposing_team {
    from: team_data
    sql_on: ${opposing_team.game_id} = ${team_data.game_id} AND ${opposing_team.team_id} != ${team_data.team_id} ;;
    relationship: one_to_one
  }
  join: game_list {
    sql_on: ${team_data.game_id} = ${game_list.game_ids} ;;
    relationship: many_to_one
  }
}


explore: rotations {}
