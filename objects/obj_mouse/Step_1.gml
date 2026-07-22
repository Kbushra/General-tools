if !mouse_check_button_pressed(mb_left) { exit; }

var obj = noone;
var lowest_depth = 9999;
with (all)
{
	var _passthrough_clicks = variable_instance_exists(id, "passthrough_clicks") && passthrough_clicks;
	
	if id == other.id || !place_meeting(x, y, other) ||
	_passthrough_clicks || depth >= lowest_depth { continue; }
	
	lowest_depth = depth;
	obj = id;
}

send_signal(obj, "pressed");