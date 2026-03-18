///@func setup_freeroam()
setup_freeroam = function()
{
	var allowedDirs = [
	[-1, -1], [0, -1], [1, -1],
	[-1, 0],           [1, 0],
	[-1, 1],  [0, 1],  [1, 1]];

	allowedDirs = array_shuffle(allowedDirs);
	
	var prevfreeroam_x = freeroam_x;
	var prevfreeroam_y = freeroam_y;
	var lastValidfreeroam_x = 0;
	var lastValidfreeroam_y = 0;
	
	for (var i = 0; i <= array_length(allowedDirs); i++)
	{
		if i == array_length(allowedDirs)
		{
			freeroam_x = lastValidfreeroam_x;
			freeroam_y = lastValidfreeroam_y;
			break;
		}
		
		freeroam_x = allowedDirs[i][0];
		freeroam_y = allowedDirs[i][1];
		var xOpposites = prevfreeroam_x == freeroam_x * -1 && freeroam_x != 0;
		var yOpposites = prevfreeroam_y == freeroam_y * -1 && freeroam_y != 0;
		
		//Full reversal is least probable, then opposing 1 direction, then opposing none
		//Chances are a bit different than shown because if all chances fail it'll use the last one
		var chance = xOpposites && yOpposites ? 0.2 : (xOpposites || yOpposites ? 0.6 : 1);
		
		var collided = false;
		var startDist = freeroam_dist;
		var interruptDist = RAND_FREEROAM/2;
		
		for (var j = game_pathfinder.tile_size/2; j <= startDist; j += game_pathfinder.tile_size/2)
		{
			var newX = x + freeroam_x * j;
			var newY = y + freeroam_y * j;
			
			if !place_free(newX, newY) ||
			collision_point(newX, newY, [trig_slope, trigDoor, trigFreeroamBlock],
			false, true) != noone
			{
				if j < interruptDist { collided = true; }
				else { freeroam_dist = j - game_pathfinder.tile_size; }
				break;
			}
		}
		
		if !collided
		{
			//Valid path but failed chance
			if random(1) > chance
			{
				lastValidfreeroam_x = freeroam_x;
				lastValidfreeroam_y = freeroam_y;
				continue;
			}
			
			break;
		}
		
	}

	axis = get_axis_from_spd(freeroam_x, freeroam_y);
	dir = get_dir(freeroam_x, freeroam_y, axis);
}