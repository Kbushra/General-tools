///@desc Freeroam method

///@func setup_freeroam()
setup_freeroam = function()
{
	var allowed_dirs = [
	new coordinate(-1, -1), new coordinate(0, -1), new coordinate(1, -1), 
	new coordinate(-1, 0),                         new coordinate(1, 0), 
	new coordinate(-1, 1),  new coordinate(0, 1),  new coordinate(1, 1)];

	allowed_dirs = array_shuffle(allowed_dirs);
	
	var prev_freeroam_x = freeroam_x;
	var prev_freeroam_y = freeroam_y;
	var last_valid_freeroam_x = 0;
	var last_valid_freeroam_y = 0;
	
	for (var i = 0; i <= array_length(allowed_dirs); i++)
	{
		if i == array_length(allowed_dirs)
		{
			freeroam_x = last_valid_freeroam_x;
			freeroam_y = last_valid_freeroam_y;
			break;
		}
		
		freeroam_x = allowed_dirs[i].x;
		freeroam_y = allowed_dirs[i].y;
		var x_opposites = prev_freeroam_x == freeroam_x * -1 && freeroam_x != 0;
		var y_opposites = prev_freeroam_y == freeroam_y * -1 && freeroam_y != 0;
		
		//Full reversal is least probable, then opposing 1 direction, then opposing none
		//Chances are a bit different than shown because if all chances fail it'll use the last one
		var chance = x_opposites && y_opposites ? 0.2 : (x_opposites || y_opposites ? 0.6 : 1);
		
		var collided = false;
		var _start_dist = freeroam_dist;
		var interrupt_dist = RAND_FREEROAM/2;
		
		for (var j = game_pathfinder.tile_size/2; j <= _start_dist; j += game_pathfinder.tile_size/2)
		{
			var new_x = x + freeroam_x * j;
			var new_y = y + freeroam_y * j;
			
			if !place_free(new_x, new_y) ||
			collision_point(new_x, new_y, [trig_slope, trig_door, trig_freeroam_block],
			false, true) != noone
			{
				if j < interrupt_dist { collided = true; }
				else { freeroam_dist = j - game_pathfinder.tile_size; }
				break;
			}
		}
		
		if !collided
		{
			//Valid path but failed chance
			if random(1) > chance
			{
				last_valid_freeroam_x = freeroam_x;
				last_valid_freeroam_y = freeroam_y;
				continue;
			}
			
			break;
		}
		
	}

	axis = get_axis_from_spd(freeroam_x, freeroam_y, axis);
	dir = get_dir(freeroam_x, freeroam_y, axis);
}