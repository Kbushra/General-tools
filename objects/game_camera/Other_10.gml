///@func cam_set([view])
cam_set = function(view = 0)
{
	var xShake = random_range(-shake_intensity, shake_intensity);
	var yShake = random_range(-shake_intensity, shake_intensity);
	
	camera_set_view_size(view_camera[view], width / zoom, height / zoom);
	camera_set_view_pos(view_camera[view], x - xoffset + xShake, y - yoffset + yShake);
}

///@func cam_dimensions()
cam_dimensions = function()
{
	var prev_xoffset = xoffset;
	var prev_yoffset = yoffset;
	
	width = size.w;
	height = size.h;
	scale = size.gui_scale;
	display_set_gui_size(width / scale, height / scale);
	surface_resize(application_surface, width, height);
	
	xoffset = width/2;
	yoffset = height/2;
	
	x += (xoffset - prev_xoffset) / 2;
	y += (yoffset - prev_yoffset) / 2;
}

///@func cam_target_player()
cam_target_player = function()
{
	target_x = obj_player.x + target_offset * obj_player.hsp;
	target_y = obj_player.y + target_offset * obj_player.vsp;
	
	if obj_player.prev_hsp != obj_player.hsp
	{
	    xstart = x;
	    progress_x = 0;
	}

	if obj_player.prev_vsp != obj_player.vsp
	{
	    ystart = y;
	    progress_y = 0;
	}
}

///@func cam_ease_pos()
cam_ease_pos = function()
{
	if target_x > x { x = floor(exponential_out(xstart, target_x, progress_x, 3)); }
	    else { x = ceil(exponential_out(xstart, target_x, progress_x, 3)); }

	if target_y > y { y = floor(exponential_out(ystart, target_y, progress_y, 3)); }
	    else { y = ceil(exponential_out(ystart, target_y, progress_y, 3)); }

	progress_x += 0.02;
	progress_y += 0.02;
}

///@func cam_clamp()
cam_clamp = function()
{
	x = clamp(x, xoffset, room_width - xoffset);
	y = clamp(y, yoffset, room_height - yoffset);
}