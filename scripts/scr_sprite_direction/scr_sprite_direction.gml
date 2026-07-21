enum DIR
{
	RIGHT,
	UP,
	LEFT,
	DOWN
}

function get_dir_from_angle(angle)
{
	return get_dir(lengthdir_x(1, angle), lengthdir_y(1, angle));
}

function get_dir(_num_x, _num_y, priority_axis = abs(_num_x) > abs(_num_y) ? HORIZONTAL : VERTICAL)
{
	var _num1 = priority_axis == HORIZONTAL ? _num_x : _num_y;
	var _num2 = priority_axis == HORIZONTAL ? _num_y : _num_x;
	
	if sign(_num1) == 1 { return priority_axis == HORIZONTAL ? DIR.RIGHT : DIR.DOWN; }
		else if sign(_num1) == -1 { return priority_axis == HORIZONTAL ? DIR.LEFT : DIR.UP; }
	
	if sign(_num2) == 1 { return priority_axis == HORIZONTAL ? DIR.DOWN : DIR.RIGHT; }
		else if sign(_num2) == -1 { return priority_axis == HORIZONTAL ? DIR.UP : DIR.LEFT; }
		
	return DIR.DOWN;
}

function get_axis_from_spd(hsp, vsp, _default = HORIZONTAL)
{
	if hsp == 0 && vsp == 0 { return _default; }
	if hsp != 0 && vsp == 0 { return HORIZONTAL; }
	if hsp == 0 && vsp != 0 { return VERTICAL; }
	return _default;
}

function get_axis(_dir, _default = HORIZONTAL)
{
	switch (_dir)
	{
		case DIR.RIGHT: case DIR.LEFT: return HORIZONTAL;
		case DIR.DOWN: case DIR.UP: return VERTICAL;
		default: return _default;
	}
}

function path_get_dir(priority_axis, path_loops = false)
{
	if path_index == NONE { return DIR.DOWN; }
	
	var first_pos;
	var second_pos;
	
	var step_length = 1 / path_get_length(path_index);
	
	//If its not updated when running this function just put it back a bit
	if path_positionprevious == path_position
	{ 
		path_positionprevious = path_position - step_length;
		
		first_pos = path_position;
		second_pos = path_positionprevious;
		
		if path_loops && path_position - step_length < 0
		{
			first_pos = path_position + step_length;
			second_pos = path_position;
		}
	}
	
	var x_change = path_get_x(path_index, first_pos) - path_get_x(path_index, second_pos);
	var y_change = path_get_y(path_index, first_pos) - path_get_y(path_index, second_pos);
	return get_dir(x_change, y_change, priority_axis);
}