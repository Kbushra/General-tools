///@desc Methods

///@func target_gui()
target_gui = function()
{
	if !surface_exists(gui_surface)
	{
		gui_surface = surface_create(GUI_W, GUI_H);
		surface_set_target(gui_surface);
		draw_clear_alpha(c_black, 0);
	}
	else
	{
		surface_set_target(gui_surface);
	}
}

///@func cam_set()
cam_set = function()
{
	cam_set_offsets();
	cam_clamp();
	
	var x_shake = random_range(-shake_intensity, shake_intensity);
	var y_shake = random_range(-shake_intensity, shake_intensity);
	shake_intensity = 0;
	
	var target_x = x - xoffset_zoom + x_shake
	var target_y = y - yoffset_zoom + y_shake
	cam_x = lerp(cam_x, target_x, target_lerp_factor)
	cam_y = lerp(cam_y, target_y, target_lerp_factor)
	
	camera_set_view_size(VIEW, width / zoom, height / zoom);
	camera_set_view_pos(VIEW, cam_x, cam_y);
}

///@func cam_dimensions()
cam_dimensions = function()
{
	display_set_gui_size(width * gui_scale, height * gui_scale);
	surface_resize_dynamic(application_surface, width * RENDER_SCALE, height * RENDER_SCALE);
}

///@func cam_set_target()
cam_set_target = function(_target)
{
	target_x = _target.x;
	target_y = _target.y;

	/*
	if obj_player.prev_hsp != obj_player.hsp
	{
	    x_start = x;
	    progress_x = 0;
	}

	if obj_player.prev_vsp != obj_player.vsp
	{
	    y_start = y;
	    progress_y = 0;
	}
	*/
}

///@func cam_ease_pos()
cam_ease_pos = function()
{
	if target_x > x { x = floor(exponential_out(x_start, target_x, progress_x, 3)); }
	    else { x = ceil(exponential_out(x_start, target_x, progress_x, 3)); }

	if target_y > y { y = floor(exponential_out(y_start, target_y, progress_y, 3)); }
	    else { y = ceil(exponential_out(y_start, target_y, progress_y, 3)); }

	progress_x += 0.02;
	progress_y += 0.02;
}

///@func cam_set_offsets()
cam_set_offsets = function()
{
	var prev_x_offset = xoffset;
	var prev_y_offset = yoffset;
	
	xoffset = width/2;
	yoffset = height/2;
	
	x += (xoffset - prev_x_offset) / 2;
	y += (yoffset - prev_y_offset) / 2;
	
	xoffset_zoom = xoffset - (zoom - 1) * (xoffset / zoom);
	yoffset_zoom = yoffset - (zoom - 1) * (yoffset / zoom);
}

///@func cam_clamp()
cam_clamp = function()
{
	x = clamp(x, xoffset_zoom, room_width - xoffset_zoom);
	y = clamp(y, yoffset_zoom, room_height - yoffset_zoom);
}

///@func default_behaviour()
default_behaviour = function()
{
	cam_dimensions();
	if (instance_exists(cam_target))
		cam_set_target(cam_target);
	cam_ease_pos();

	cam_set();
}

///@func default_values()
default_values = function()
{
	tint = new rgba(c_black, 0);
	shake_intensity = 0;
	width = GAME_WIDTH;
	height = GAME_HEIGHT;
	app_zoom = 1;
	gui_scale = 1;
	zoom = 1;
	angle = 0;
}

///@func set_shake(shake)
set_shake = function(shake)
{
	if shake <= shake_intensity { return; }
	shake_intensity = shake;
}

///@func fit_room()
fit_room = function()
{
	width = room_width;
	height = room_height;
	gui_scale = 1;
	zoom = 1;
}

/// @func cam_create()
cam_create = function ()
{
	if !view_get_visible(VIEW) { view_set_visible(VIEW, true); }
	
	camera_set_view_size(VIEW, width / zoom, height / zoom);
	view_set_wport(VIEW, GAME_WIDTH * RENDER_SCALE);
	view_set_hport(VIEW, GAME_HEIGHT * RENDER_SCALE);
}