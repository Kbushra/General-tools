///@desc Other methods

///@func roam_transition()
roam_transition = function()
{
	if path != noone { state = pathfinder_states.pathroam; exit; }

	state = pathfinder_states.freeroam;
	freeroam_dist = RAND_FREEROAM;
	freeroam_delay = RAND_FREEROAM;
	reset_action("freeroam_setup");
	setup_freeroam();
}

///@func pathroam_state()
pathroam_state = function()
{
	path_speed = initial_path_speed;
	
	if path_index != path
	{
		path_start(path, path_speed, path_action_restart, path_is_absolute);
	}
	
	dir = path_get_dir(path_priority_axis, true);
	sprite_index = get_sprite(name, "walk");
}

///@func freeroam_state()
freeroam_state = function()
{
	freeroam_delay--;
	if freeroam_delay > 0 { sprite_index = get_sprite(name, "idle"); exit; }
	
	if !done_action("freeroam_setup")
	{
		freeroam_x = 0;
		freeroam_y = 0;
		setup_freeroam();
	}
	
	x += freeroam_x * spd;
	y += freeroam_y * spd;
	freeroam_dist -= spd;
	if freeroam_dist > 0 { sprite_index = get_sprite(name, "walk"); exit; }
	
	freeroam_dist = RAND_FREEROAM;
	freeroam_delay = RAND_FREEROAM;
	reset_action("freeroam_setup");
}

///@func pathfind_move()
pathfind_move = function()
{
	var move_x = next_coord.x - x;
	var move_y = next_coord.y - y;
	axis = get_axis_from_spd(move_x, move_y, axis);
	dir = get_dir(move_x, move_y, axis);
	sprite_index = get_sprite(name, "walk");
	
	return move_towards_point_ordinal(next_coord, spd, moving);
}

///@func setup_pathfind()
setup_pathfind = function()
{
	var bbox_lr = (bbox_left + bbox_right)/2;
	var bbox_ud = (bbox_top + bbox_bottom)/2;
	var player_bbox_lr = (obj_player.bbox_left + obj_player.bbox_right)/2;
	var player_bbox_ud = (obj_player.bbox_top + obj_player.bbox_bottom)/2;
	var xoffset = x - bbox_lr;
	var yoffset = y - bbox_ud;
	
	if distance_to_object(obj_player) < game_pathfinder.tile_size
	{
		next_coord = new coordinate(player_bbox_lr + xoffset,
			player_bbox_ud + yoffset);
		moving = new moving_state(true, true);
		
		with (obj_player)
		{
			if !place_free(x - 1, y) { other.next_coord.x = bbox_left + (other.x - other.bbox_left); }
			else if !place_free(x + 1, y) { other.next_coord.x = bbox_right + (other.x - other.bbox_right); }
			
			if !place_free(x, y - 1) { other.next_coord.y = bbox_top + (other.y - other.bbox_top); }
			else if !place_free(x, y + 1) { other.next_coord.y = bbox_bottom + (other.y - other.bbox_bottom); }
		}
		
		return true;
	}
	
	var tile_x = floor(bbox_lr / game_pathfinder.tile_size);
	var tile_y = floor(bbox_ud / game_pathfinder.tile_size);
	tile_x = clamp(tile_x, 0, array_length(game_pathfinder.nodes) - 1);
	tile_y = clamp(tile_y, 0, array_length(game_pathfinder.nodes[tile_x]) - 1);
	var node = game_pathfinder.nodes[tile_x][tile_y];

	//Go to next tile
	if array_length(node.next_nodes) > 0 && node.weight != NONE
	{
		var rand_node = irandom(array_length(node.next_nodes) - 1);
		next_coord = variable_clone(node.next_nodes[rand_node], 0);
		moving = new moving_state(true, true);
		next_coord.x += xoffset;
		next_coord.y += yoffset;
		return true;
	}
	
	moving = new moving_state(false, false);
	return false;
}