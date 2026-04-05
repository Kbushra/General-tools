///@func make_particles_from_surface(surface, system, particle, left, top)
function make_particles_from_surface(surf, sys, part, left, top)
{
	var width = surface_get_width(surf);
	var height = surface_get_height(surf);
	
	var buffer = buffer_create(4 * width * height, buffer_fixed, buffer_u8);
	buffer_get_surface(buffer, surf, 0);
	
	buffer_seek(buffer, buffer_seek_start, 0);
	
	for (var i = 0; i < width * height; i++)
	{
		var r = buffer_read(buffer, buffer_u8);
		var g = buffer_read(buffer, buffer_u8);
		var b = buffer_read(buffer, buffer_u8);
		var a = buffer_read(buffer, buffer_u8);
		var col = make_colour_rgb(r, g, b);
		if a < 255 || col == c_black { continue; }
		
		var relative_x = i % width;
		var relative_y = i div width;
		
		part_particles_create_colour(sys, left + relative_x, top + relative_y, part, col, 1);
	}
	
	buffer_delete(buffer);
}