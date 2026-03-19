function to_time(_total_seconds)
{
	var minutes = floor(_total_seconds / 60);
	var seconds = floor(_total_seconds) - (minutes * 60);
	return $"{minutes}:{seconds < 10 ? "0" : ""}{seconds}";
}

function near_to(val, nearest) { return round(val / nearest) * nearest; }
function near_equals(val1, val2, diff) { return abs(val1 - val2) <= diff; }

///@func center(box_width, object_width)
///@param box_width {real}
///@param object_width {real}
///@desc this function returns the centered x or y position for an object with a left anchor point
function center(_box, _object) { return _box/2 - _object/2; }

function vector_to_angle(_x, _y)
{
	return darctan2(_x - _y,
		_x + _y);
}

function rotate_vector(_x, _y, deg)
{
	return { x: _x * dcos(deg) + _y * dsin(deg),
		y: _y * dcos(deg) - _x * dsin(deg) };
}