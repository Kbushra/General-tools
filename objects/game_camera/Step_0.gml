if keyboard_check_pressed(vk_f4) { window_set_fullscreen(!window_get_fullscreen()); }
depth = -99999999999;

if custom { exit; }

if got_place_signal("goto_spawn")
{
	x = obj_player.x;
	y = obj_player.y;
	xstart = x;
	ystart = y;
	
	cam_clamp();
	cam_set();
	exit;
}

cam_dimensions();
cam_target_player();
cam_ease_pos();

cam_clamp();
cam_set();