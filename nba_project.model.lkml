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
    sql_on: ${loc.gameid} = ${play_by_play.game_id} AND ${loc.eventid} = ${play_by_play.eventnum} ;;
    type: left_outer
    relationship: one_to_one
  }
}

explore: rotations {}
