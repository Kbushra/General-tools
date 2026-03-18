if state == pathfinderStates.roam
{
	if path_index != path
	{
		path_start(path, path_speed, path_action_restart, path_is_absolute);
	}
	
	dir = path_get_dir(path_priority_axis, true);
	sprite_index = asset_get_index($"spr_{name}_walk_{dir}");
	
	exit;
}
else
{
	path_end();	
}

if state == pathfinderStates.freeroam
{
	freeroam_delay--;
	if freeroam_delay > 0 { sprite_index = asset_get_index($"spr_{name}_idle_{dir}"); exit; }
	
	if !done_action("freeroam_setup")
	{
		freeroam_x = 0;
		freeroam_y = 0;
		setup_freeroam();
	}
	
	x += freeroam_x * spd;
	y += freeroam_y * spd;
	freeroam_dist -= spd;
	if freeroam_dist > 0 { sprite_index = asset_get_index($"spr_{name}_walk_{dir}"); exit; }
	
	freeroam_dist = RAND_FREEROAM;
	freeroam_delay = RAND_FREEROAM;
	reset_action("freeroam_setup");
	
	exit;
}

if state != pathfinderStates.chase { exit; }

freeroam_dist = RAND_FREEROAM;
freeroam_delay = RAND_FREEROAM;
reset_action("freeroam_setup");

var tile_x = floor(x / game_pathfinder.tile_size);
var tile_y = floor(y / game_pathfinder.tile_size);
tile_x = clamp(tile_x, 0, array_length(game_pathfinder.nodes) - 1);
tile_y = clamp(tile_y, 0, array_length(game_pathfinder.nodes[tile_x]) - 1);

if !array_equals(moving, [false, false]) //Go to tile
{
	//Can't chase with nowhere to go
	if array_length(next) == 0 { moving = [false, false]; state = pathfinderStates.freeroam; exit; }
	
	axis = VERTICAL; //bandage fix
	dir = get_dir(next[0] - x, next[1] - y, axis);
	sprite_index = asset_get_index($"spr{name}Walk{dir}");
	
	moving = move_towards_point_overworld(next[0], next[1], spd, moving);
	exit;
}

var node = game_pathfinder.nodes[tile_x][tile_y];

//Go to next tile
next = node.next;
moving = [true, true];
if array_length(next) > 0
{
	var randNode = irandom(array_length(next) - 1);
	next = next[randNode];
}