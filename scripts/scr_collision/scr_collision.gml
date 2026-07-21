function check_collisions(_x, _y)
{
	return place_meeting(_x, _y, trig_solid)
}

function slope_colliding(_x, _y)
{
	var colliding = noone;
	
	var prev_x = x;
	var prev_y = y;
	x = _x;
	y = _y;
	
	with (trig_slope)
	{
		if collision_line(points[0].x, points[0].y, points[1].x, points[1].y, other, false, true)
		{ colliding = id; break; }
	}
	
	x = prev_x;
	y = prev_y;
	return colliding;
}

function move_collision(axis = GRID, _spd = spd, coll_func = check_collisions, _hsp = hsp, _vsp = vsp)
{
	var change_x = axis == VERTICAL ? 0 : _hsp * _spd;
	var change_y = axis == HORIZONTAL ? 0 : _vsp * _spd;
	return coll_func(x + change_x, y + change_y);
}

function basic_collisions()
{
	if move_collision(HORIZONTAL, spd)
	{
		while !move_collision(HORIZONTAL, 1) && hsp != 0 { x += sign(hsp); }
        hsp = 0;
	}
    
	if move_collision(VERTICAL, spd)
	{
		while !move_collision(VERTICAL, 1) && vsp != 0 { y += sign(vsp); }
        vsp = 0;
	}
}

function slope_collisions()
{
	if hsp == 0 && vsp == 0 { return; }
	
	var slope = move_collision(GRID, spd, slope_colliding);
	if !slope { slope_axis = get_axis(facing); return; }
	
	var _hsp = sign(hsp);
	var _vsp = sign(vsp);
	if hsp != 0 && vsp != 0
	{
		if slope_axis == HORIZONTAL { _vsp = 0; }
		else { _hsp = 0; }	
	}
	
	//Rotate and apply signs
	var first_vector = rotate_vector(0, -sign(slope.image_yscale), slope.image_angle);
	var second_vector = rotate_vector(sign(slope.image_xscale), 0, slope.image_angle);
	var first_horizontal = abs(first_vector.x) > abs(first_vector.y);
	var moving_horizontal = abs(_hsp) > abs(_vsp);
	
	//Find out which vector is required
	var vector = new coordinate(0, 0);	
	var first_wanted_horizontal = first_horizontal && !moving_horizontal;
	var first_wanted_vertical = !first_horizontal && moving_horizontal;
	if first_wanted_horizontal || first_wanted_vertical { vector = first_vector; }
	else { vector = second_vector; }
	
	hsp = _hsp + vector.x;
	vsp = _vsp + vector.y;
	if !move_collision(GRID, spd, slope_colliding) { exit; }
	
	var horizontal_slope = move_collision(HORIZONTAL, spd, slope_colliding);
	var vertical_slope = move_collision(VERTICAL, spd, slope_colliding);
	if horizontal_slope { hsp = 0; }
	if vertical_slope { vsp = 0; }
	if !horizontal_slope && !vertical_slope { hsp = 0; vsp = 0; }
}