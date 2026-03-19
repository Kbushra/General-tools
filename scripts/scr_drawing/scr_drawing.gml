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

function gpu_set_blendmode_shader(shader)
{
	shader_set(shader);
	
	var stage = shader_get_sampler_index(shader, "surf");
	var tex = surface_get_texture(application_surface);
	texture_set_stage(stage, tex);
	shader_set_uniform_f_array(shader_get_uniform(shader, "surf_res"),
		[APP_W, APP_H]);
}