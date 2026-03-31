function move_until_collide(dx, dy, obj)
{
	var x_coll = false;
	var y_coll = false;
	var x_inst = noone;
	var y_inst = noone;
	
	for (var i = 0; i < max(abs(dx), abs(dy)); i++)
	{
		if !x_coll && i < abs(dx) { x_inst = instance_place(x + sign(dx), y, obj); }
		if !y_coll && i < abs(dy) { y_inst = instance_place(x, y + sign(dy), obj); }
		
		if x_inst == noone && sign(dx) != 0 { x += x_coll ? 0 : sign(dx); } else { x_coll = true; }
		if y_inst == noone && sign(dy) != 0 { y += y_coll ? 0 : sign(dy); } else { y_coll = true; }
		
		if x_coll && y_coll { return new axis_collision(x_inst, y_inst); } //Collided fully
	}
	
	return new axis_collision(x_inst, y_inst);
}

//Returns if the x movement or y movement is still going
function move_towards_point_ordinal(_coord, _speed, _prev_moving = [true, true])
{
	if !_prev_moving[0] { _coord.x = x; }
	if !_prev_moving[1] { _coord.y = y; }
	
	var sign_x = sign(_coord.x - x);
	var sign_y = sign(_coord.y - y);
	x += sign_x * _speed;
	y += sign_y * _speed;
	
	var new_sign_x = sign(_coord.x - x);
	var new_sign_y = sign(_coord.y - y);
	return new moving_state(new_sign_x == sign_x && sign_x != 0,
		new_sign_y == sign_y && sign_y != 0);
}