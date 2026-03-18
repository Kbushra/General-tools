function slope_colliding(_x, _y)
{
	var colliding = noone;
	
	var prevX = x;
	var prevY = y;
	x = _x;
	y = _y;
	
	with (trig_slope)
	{
		if rectangle_in_triangle(other.bbox_left, other.bbox_top, other.bbox_right, other.bbox_bottom,
		points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y)
		{ colliding = id; break; }
	}
	
	x = prevX;
	y = prevY;
	return colliding;
}

///@func collision_extended(extension, obj)
///@desc Does a collision rectangle with the bounding box but extends by some pixels

///@param extension {real} Amount of pixels to extend by
///@param obj {asset} Object to check collision for
function collision_extended(extension, obj)
{
	return collision_rectangle(bbox_left - extension, bbox_top - extension, bbox_right + extension,
		bbox_bottom + extension, obj, true, true);
}