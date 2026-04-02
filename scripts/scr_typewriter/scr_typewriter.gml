///@func insert_linebreaks(string, width)
function insert_linebreaks(_string, _width)
{
	for (var curr_char = 1; curr_char <= string_length(_string); curr_char++)
	{
		var pre_string = curr_char == 1 ? "" : string_copy(_string, 1, curr_char - 1);
		var last_linebreak_pos = string_last_pos("\n", pre_string);
		
		var post_string = string_copy(_string, curr_char, string_length(_string) - curr_char + 1);
		var next_space_pos = string_pos(" ", post_string);
		if next_space_pos == 0 { break; }
		
		next_space_pos += curr_char - 1;
		
		var line_string = next_space_pos <= last_linebreak_pos ? "" :
			string_copy(_string, last_linebreak_pos + 1, next_space_pos - last_linebreak_pos);
		
		if string_width(line_string) > _width
		{
			_string = string_delete(_string, next_space_pos, 1);
			_string = string_insert("\n", _string, next_space_pos);
			curr_char = next_space_pos + 1;
		}
	}
	
	return _string;
}

///special_chars is a function that takes in full string and position of current char
//being written, and returns how many characters to skip (0 if not special),
//used to do special actions with some invisible control characters

///@func draw_typewriter(x, y, string, char_gap_x, char_gap_y, char_count, width, [special_chars])
function draw_typewriter(_x, _y, _string, _char_gap_x, _char_gap_y, _char_count, _width,
_special_chars = wrapper_constant(0))
{
	var curr_x = _x;
	var curr_y = _y;
	
	_string = insert_linebreaks(_string, _width);
	
	for (var curr_char = 1; curr_char <= min(_char_count, string_length(_string)); curr_char++)
	{
		while _special_chars(_string, curr_char) > 0 || string_char_at(_string, curr_char) == "\n"
		{
			do
			{
				var chars_to_skip = _special_chars(_string, curr_char);
				if chars_to_skip > 0 { _string = string_delete(_string, curr_char, chars_to_skip); }
			
				if curr_char > min(_char_count, string_length(_string)) { return; }
			}
			until chars_to_skip <= 0
		
			while string_char_at(_string, curr_char) == "\n"
			{
				curr_x = _x;
				curr_y += string_height("A") + _char_gap_y;
				_string = string_delete(_string, curr_char, 1);
			
				if curr_char > min(_char_count, string_length(_string)) { return; }
			}
		}
		
		draw_text(curr_x, curr_y, string_char_at(_string, curr_char));
		curr_x += string_width(string_char_at(_string, curr_char)) + _char_gap_x;
	}
}