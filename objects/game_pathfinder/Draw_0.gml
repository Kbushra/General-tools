if !got_signal("pathfound") || !log { exit; }

for (var i = 0; i < room_width/tile_size - 0.5; i++)
{
	for (var j = 0; j < room_height/tile_size - 0.5; j++)
	{
		if point_distance(source_tile_x, source_tile_y, i, j) > max_distance { continue; }
		
		var node = nodes[i][j];
		
		if node.weight == NONE { draw_set_colour(c_black); draw_set_alpha(1); }
		else { draw_set_alpha(1 - (node.weight / max_weight)); }
		
		draw_rectangle(node.x - tile_size/2, node.y - tile_size/2,
			node.x + tile_size/2, node.y + tile_size/2, false);
		
		draw_set_alpha(1);
		draw_set_colour(c_white);
	}
}