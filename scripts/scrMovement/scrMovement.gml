function move_until_collide(dx, dy, obj)
{
	var xColl = false;
	var yColl = false;
	var xInst = noone;
	var yInst = noone;
	
	for (var i = 0; i < max(abs(dx), abs(dy)); i++)
	{
		if !xColl && i < abs(dx) { xInst = instance_place(x + sign(dx), y, obj); }
		if !yColl && i < abs(dy) { yInst = instance_place(x, y + sign(dy), obj); }
		
		if xInst == noone && sign(dx) != 0 { x += xColl ? 0 : sign(dx); } else { xColl = true; }
		if yInst == noone && sign(dy) != 0 { y += yColl ? 0 : sign(dy); } else { yColl = true; }
		
		if xColl && yColl { return [xInst, yInst]; } //Collided fully
	}
	
	return [xInst, yInst];
}

//Returns if the x movement or y movement is still going
function move_towards_point_straight(_x, _y, _speed, _prevMoving = [true, true])
{
	if !_prevMoving[0] { _x = x; }
	if !_prevMoving[1] { _y = y; }
	
	var signX = sign(_x - x);
	var signY = sign(_y - y);
	x += signX * _speed;
	y += signY * _speed;
	
	var newSignX = sign(_x - x);
	var newSignY = sign(_y - y);
	return [newSignX == signX && signX != 0, newSignY == signY && signY != 0];
}