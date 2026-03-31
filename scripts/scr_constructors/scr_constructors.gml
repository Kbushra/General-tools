function coordinate(_x, _y) constructor
{
	x = _x;
	y = _y;
}

function moving_state(_in_x, _in_y) constructor
{
	moving_in_x = _in_x;
	moving_in_y = _in_y;
	
	///@func is_moving()
	static is_moving = function() { return moving_in_x || moving_in_y; }
}

function axis_collision(_coll_x, _coll_y) constructor
{
	coll_x = _coll_x;
	coll_y = _coll_y;
}