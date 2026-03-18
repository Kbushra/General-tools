update_inputs();

/*
if string_pos("debug", string_lower(keyboard_string)) != 0 
{
	if !keyboard_check(vk_shift) { keyboard_string = ""; exit; }
	if !instance_exists(game_debug) instance_create_depth(0, 0, 0, game_debug); 
		else instance_destroy(game_debug);
	
	keyboard_string = "";
}