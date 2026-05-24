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
	return new coordinate(_x * dcos(deg) + _y * dsin(deg),
		_y * dcos(deg) - _x * dsin(deg));
}

function asymptote_get_mixes(_y_approach, _y_intercept, _bases, _points)
{
	if !assert(array_length(_bases) == array_length(_points),
		"Base matrix must be a square!") { return; }
	
	var _bases_matrix = [];
	var _sums = [];
	
	for (var i = 0; i < array_length(_points); i++)
	{
		_sums[i][0] = (_points[i].y - _y_approach) / (_y_intercept - _y_approach);
		//sum[i] is mix1*base1^-x[i] + mix2*base2^-x[i] + ...
		//create a matrix row of bases^-x[i] (known) and multiply by mixes (unknown) to get sums (known)
		for (var j = 0; j < array_length(_bases); j++)
		{
			_bases_matrix[i][j] = power(_bases[j], -_points[i].x);
		}
	}
	
	//sums divided by bases = mixes
	var _mixes_matrix = matrix_multiply_any(matrix_inverse_any(_bases_matrix), _sums);
	_mixes_matrix = array_reduce(_mixes_matrix,
		function(prev, current) { return array_concat(prev, current); });
	
	return _mixes_matrix;
}

function horizontal_asymptote(_x, _y_approach, _y_intercept, _bases, _mixes)
{
	//Adding an extra base + mix allows for an extra point of accuracy
	//f(x) = y_approach + (y_intercept - y_approach)(SUM OF mix*base^-x WHERE MIXES ARE NORMALISED)
	
	if !assert(array_length(_bases) == array_length(_mixes),
		"Bases do not align to mixes!") { return; }
	
	var _mix_total = array_reduce(_mixes, function(prev, current) { return prev + current; });
	
	var _total = _y_approach;
	var _diff = _y_intercept - _y_approach;
	for (var i = 0; i < array_length(_bases); i++)
	{
		var _mult = _diff * (_mixes[i] / _mix_total);
		_total += _mult * power(_bases[i], -_x);
	}
	
	return _total;
}

function horizontal_asymptote_points(_x, _y_approach, _y_intercept, _bases, _points)
{
	var _mixes = asymptote_get_mixes(_y_approach, _y_intercept, _bases, _points);
	return horizontal_asymptote(_x, _y_approach, _y_intercept, _bases, _mixes);
}

function inv_lerp(a, b, value)
{
	return (value - a) / (b - a);
}

#macro RISE 0
#macro FALL 1

///@param x In degrees
///@param min Trough value
///@param start Y-Intercept
///@param max Crest value
///@param period In degrees
///@param edge Start point in rise or fall
function transformed_sin(_x, _min, _start, _max, _period, _edge = RISE)
{
	if !assert(_start == clamp(_start, _min, _max), "Invalid start y in sin phase!") { return 0; }
	if !assert(_min <= _max, "Min and max swapped around in sin phase!") { return 0; }
	
	var phase = darcsin(2 * inv_lerp(_min, _max, _start) - 1);
	if _edge == FALL { phase = 180 - phase; }
	
	var normalised_dsin = (dsin(_x * 360/_period + phase) + 1)/2;
	return normalised_dsin * (_max - _min) + _min;
}

///@param min Trough value
///@param start Y-Intercept
///@param max Crest value
///@param point Point with x value in degrees
///@param edge Start point in rise or fall
function transformed_sin_get_period(_min, _start, _max, _point, _edge = RISE, _point_edge = FALL)
{
	if !assert(_point.y == clamp(_point.y, _min, _max), "Invalid point y!") { return 360; }
	if !assert(_start == clamp(_start, _min, _max), "Invalid start y in sin get phase!") { return 360; }
	if !assert(_min <= _max, "Min and max swapped around in sin get phase!") { return 360; }
	
	var phase_point = darcsin(2 * inv_lerp(_min, _max, _point.y) - 1);
	var phase = darcsin(2 * inv_lerp(_min, _max, _start) - 1);
	if _edge == FALL { phase = 180 - phase; }
	if _point_edge == FALL { phase_point = 180 - phase_point; }
	
	var phase_change = phase_point - phase;
	while (phase_change <= 0) { phase_change += 360; }
	
	var _period = 360 * _point.x / phase_change;
	return _period;
}