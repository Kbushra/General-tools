function change_sequence(current_instance, target_asset, _layer, keep_headpos = false)
{
	if layer_sequence_get_sequence(current_instance).name == sequence_get(target_asset).name
	{ return current_instance; }
	
	var _x = layer_sequence_get_x(current_instance);
	var _y = layer_sequence_get_y(current_instance);
	var sequence_pos = layer_sequence_get_headpos(current_instance);
	
	layer_sequence_destroy_safe(_layer, current_instance);
		
	//Spawn anim
	current_instance = layer_sequence_create(_layer, _x, _y, target_asset);
	layer_sequence_play(current_instance);
	
	if keep_headpos { layer_sequence_headpos(current_instance, sequence_pos); }
	
	return current_instance;
}

function layer_sequence_destroy_safe(_layer, instance)
{
	if layer_sequence_exists(_layer, instance)
	{
		layer_sequence_destroy(instance);
	}
}