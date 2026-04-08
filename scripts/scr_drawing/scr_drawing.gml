///@func draw_reset()
function draw_reset()
{
	draw_set_colour(c_white);
	draw_set_alpha(1);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	if surface_get_target() != application_surface && surface_get_target() != NONE
	{ surface_reset_target(); }
	
	gpu_set_colorwriteenable(true, true, true, true);
	gpu_set_blendmode(bm_normal);
	shader_reset();
}

function gpu_set_blendmode_shader(shader, surf = APP_SURF,
surf_width = APP_W, surf_height = APP_H)
{
	shader_set(shader);
	
	var scale = min(WIN_W / APP_W, WIN_H / APP_H);
	var drawn_w = APP_W * scale;
	var drawn_h = APP_H * scale;
	var padding_x = (WIN_W - drawn_w) * 0.5;
	var padding_y = (WIN_H - drawn_h) * 0.5;
	
	var stage = shader_get_sampler_index(shader, "surf");
	var tex = surface_get_texture(surf);
	texture_set_stage(stage, tex);
	shader_set_uniform_f(shader_get_uniform(shader, "surf_res"),
		surf_width * scale, surf_height * scale);
	shader_set_uniform_f(shader_get_uniform(shader, "padding"),
		padding_x, padding_y);
}