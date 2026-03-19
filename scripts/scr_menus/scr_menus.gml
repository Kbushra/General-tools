function move_selection(selection, limit, dir)
{
	if dir == HORIZONTAL
	{
		selection += game_input.right_pressed - game_input.left_pressed;
	}
	
	if dir == VERTICAL
	{
		selection += game_input.down_pressed - game_input.up_pressed;
	}
	
	if dir == DIAGONAL
	{
		selection += game_input.right_pressed - game_input.left_pressed;
		selection = clamp(selection, (prev_selection div 2) * 2, (prev_selection div 2) * 2 + 1);
		selection = clamp(selection, 0, limit - 1);
		
		var intermediate_selection = selection;
		selection += (game_input.down_pressed - game_input.up_pressed) * 2;
		
		if selection < 0 { selection = intermediate_selection; }
		else if selection >= limit { selection = limit - 1; }
	}
	
	selection = ((selection % limit) + limit) % limit;
	return selection;
}

function draw_list_element(_x, _y, is_selected, text)
{
	var initial_col = draw_get_colour();
	
	if is_selected draw_set_colour(c_yellow);
	draw_text(_x + offset, _y, text);
	
	draw_set_colour(initial_col);
}

function draw_list(_x, _y, gap_x, gap_y, selection, dir, list)
{
	for (var i = 0; i < array_length(list); i++)
	{
		var row = 0;
		var col = 0;
		
		if dir == HORIZONTAL { col = i; }
		if dir == VERTICAL { row = i; }
		if dir == DIAGONAL { col = i % 2; row = i div 2; }
		
		draw_list_element(_x + col * gap_x, _y + row * gap_y,
			i == selection, list[i]);
	}
}