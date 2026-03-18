///@func init_game()
init_game = function()
{
	instance_create_unique(x, y, depth, game_saver);
	
	instance_create_unique(x, y, depth, game_input);
	instance_create_depth(x, y, depth, obj_player);
	instance_create_unique(x, y, depth, game_camera);
	
	instance_create_unique(x, y, depth, game_pathfinder);
	instance_create_unique(x, y, depth, game_audio);
}