connection: "ryan-thesis"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"


datagroup: nba_trigger {
  sql_trigger: SELECT MAX(GAME_ID) FROM nba_data.pbp;;
}

persist_with: nba_trigger

explore: loc {}

explore: jump_ball {
  join: game_list {
    sql_on: ${game_list.game_ids} = ${jump_ball.game_id} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: shots {
  join: loc {
    sql_on: ${loc.gameid} = ${shots.game_id} AND ${loc.eventid} = ${shots.event_num} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: game_list {
    sql_on: ${game_list.game_ids} = ${shots.game_id} ;;
    type: left_outer
    relationship: many_to_one
  }
}

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


explore: rotations {
  join: game_list {
    sql_on: ${rotations.game_id} = ${game_list.game_ids} ;;
    relationship: many_to_one
  }
}
