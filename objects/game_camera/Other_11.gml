///@desc Post Processing Methods

///@func draw_gui_surface()
draw_gui_surface = function()
{
	surface_set_target(application_surface);
	{
		if surface_exists(gui_surface)
		{
			draw_surface_ext(gui_surface, 0, 0, APP_W/GUI_W, APP_H/GUI_H, 0, c_white, 1);
		}

		draw_set_rgba(tint);
		draw_rectangle(0, 0, APP_W, APP_H, false);
	}
	surface_reset_target();
	draw_reset();
	
	if surface_exists(gui_surface)
	{
		surface_resize_dynamic(gui_surface, GUI_W, GUI_H);
		surface_set_target(gui_surface);
		draw_clear_alpha(c_black, 0);
		surface_reset_target();
	}
}

///@func get_application_draw_data(angle, zoom)
get_application_draw_data = function(_angle = angle, _zoom = app_zoom)
{
	var base_centre = new coordinate(APP_W/2, APP_H/2);
	var base_centre_len = point_distance(0, 0, base_centre.x, base_centre.y);
	var base_centre_dir = point_direction(0, 0, base_centre.x, base_centre.y);
	var new_centre = new coordinate(lengthdir_x(base_centre_len, base_centre_dir + _angle),
		lengthdir_y(base_centre_len, base_centre_dir + _angle));

	var scale = min(WIN_W/APP_W, WIN_H/APP_H) * _zoom;
	var move = new coordinate(base_centre.x - new_centre.x, base_centre.y - new_centre.y);
	
	return
	{
		x: (WIN_W - scale * APP_W)/2 + move.x * scale,
		y: (WIN_H - scale * APP_H)/2 + move.y * scale,
		xscale: scale,
		yscale: scale,
		angle: _angle,
		blend: c_white,
		alpha: 1
	};
}

///@func draw_application(draw_data)
draw_application = function(draw_data)
{
	gpu_set_blendenable(false);
	{
		draw_set_colour(c_black);
		draw_rectangle(0, 0, WIN_W, WIN_H, false);
		draw_set_colour(c_white);
	
		draw_surface_ext(application_surface, draw_data.x, draw_data.y, draw_data.xscale,
			draw_data.yscale, draw_data.angle, draw_data.blend, draw_data.alpha);
	}
	gpu_set_blendenable(true);

	surface_set_target(application_surface);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
}