///@func cam_set([view])
cam_set = function(view = 0)
{
	var xShake = random_range(-shakeIntensity, shakeIntensity);
	var yShake = random_range(-shakeIntensity, shakeIntensity);
	
	camera_set_view_size(view_camera[view], width / zoom, height / zoom);
	camera_set_view_pos(view_camera[view], x - xoffset + xShake, y - yoffset + yShake);
}

///@func cam_dimensions()
cam_dimensions = function()
{
	var prevXOffset = xoffset;
	var prevYOffset = yoffset;
	
	width = size.w;
	height = size.h;
	scale = size.gui_scale;
	display_set_gui_size(width / scale, height / scale);
	surface_resize(application_surface, width, height);
	
	xoffset = width/2;
	yoffset = height/2;
	
	x += (xoffset - prevXOffset) / 2;
	y += (yoffset - prevYOffset) / 2;
}

///@func cam_target_frisk()
cam_target_frisk = function()
{
	targetX = obj_player.x + targetOffset * obj_player.hsp;
	targetY = obj_player.y + targetOffset * obj_player.vsp;

	if obj_player.prevHsp != obj_player.hsp
	{
	    xstart = x;
	    progressX = 0;
	}

	if obj_player.prevVsp != obj_player.vsp
	{
	    ystart = y;
	    progressY = 0;
	}
}

///@func cam_ease_pos()
cam_ease_pos = function()
{
	if targetX > x { x = floor(exponential_out(xstart, targetX, progressX, 3)); }
	    else { x = ceil(exponential_out(xstart, targetX, progressX, 3)); }

	if targetY > y { y = floor(exponential_out(ystart, targetY, progressY, 3)); }
	    else { y = ceil(exponential_out(ystart, targetY, progressY, 3)); }

	progressX += 0.02;
	progressY += 0.02;
}

///@func cam_set_zoom_offsets()
cam_set_zoom_offsets = function()
{
	xoffsetZoom = xoffset - (zoom - 1) * (xoffset / zoom);
	yoffsetZoom = yoffset - (zoom - 1) * (yoffset / zoom);
}

///@func cam_clamp()
cam_clamp = function()
{
	x = clamp(x, xoffset, room_width - xoffset);
	y = clamp(y, yoffset, room_height - yoffset);
}