///@func draw_reset()
function draw_reset()
{
	draw_set_colour(c_white);
	draw_set_alpha(1);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	if surface_get_target() != APP_SURF && surface_get_target() != NONE
	{ surface_reset_target(); }
	
	gpu_set_colorwriteenable(true, true, true, true);
	gpu_set_blendmode(bm_normal);
	shader_reset();
}

function gpu_set_blendmode_shader(shader, surf = APP_SURF)
{
	shader_set(shader);
	
	var surf_width = surface_get_width(surf);
	var surf_height = surface_get_height(surf);

	var stage = shader_get_sampler_index(shader, "surf");
	var tex = surface_get_texture(surf);
	texture_set_stage(stage, tex);
	shader_set_uniform_f(shader_get_uniform(shader, "surf_res"),
		surf_width, surf_height);
	shader_set_uniform_f(shader_get_uniform(shader, "cam_pos"),
		VIEW_X, VIEW_Y);
}

function setup_text(_font = fnt_default, _color = c_white, _halign = fa_left, _valign = fa_top, _alpha = 1) 
{
	draw_set_font(_font);
	draw_set_color(_color);
	
	draw_set_halign(_halign);
	draw_set_valign(_valign);
	
	draw_set_alpha(_alpha);
}

function draw_self_pos(_x, _y)
{
	var prev_x = x;
	var prev_y = y;
	x = _x;
	y = _y;
	
	draw_self();
	x = prev_x;
	y = prev_y;
}