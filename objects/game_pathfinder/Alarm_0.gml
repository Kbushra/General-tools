///@desc pathfind
if !got_place_signal("pathfind") && !log && !got_signal("room_start") { alarm[0] = 1; exit; }

source_x = (obj_player.bbox_right + obj_player.bbox_left)/2;
source_y = (obj_player.bbox_top + obj_player.bbox_bottom)/2;
var x_in_bounds = source_x >= 0 && source_x < room_width;
var y_in_bounds = source_y >= 0 && source_y < room_height;
if !x_in_bounds || !y_in_bounds { alarm[0] = 1; exit; }

stop_signal("room_start");
send_signal(id, "pathfound");
flow_field();

alarm[0] = interval;