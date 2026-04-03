///@func insert_linebreaks(string, width)
function insert_linebreaks(_string, _width)
{
	for (var curr_char = 1; curr_char <= string_length(_string); curr_char++)
	{
		var pre_string = curr_char == 1 ? "" : string_copy(_string, 1, curr_char - 1);
		var last_linebreak_pos = string_last_pos("\n", pre_string);
		var last_space_pos = string_last_pos(" ", pre_string);
		
		var last_break_pos = max(last_linebreak_pos, last_space_pos);
		
		var post_string = string_copy(_string, curr_char, string_length(_string) - curr_char + 1);
		var next_linebreak_pos = string_pos("\n", post_string);
		var next_space_pos = string_pos(" ", post_string);
		
		var next_break_pos = 0;
		if next_linebreak_pos == 0 { next_break_pos = next_space_pos; }
		else if next_space_pos == 0 { next_break_pos = next_linebreak_pos; }
		else { next_break_pos = min(next_linebreak_pos, next_space_pos); }
		
		if next_break_pos == 0 { next_break_pos = string_length(post_string); }
		
		next_break_pos += curr_char - 1;
		
		var line_string = string_copy(_string,
			last_linebreak_pos + 1, next_break_pos - last_linebreak_pos);
		
		if string_width(line_string) > _width
		{
			if last_break_pos != 0
			{
				_string = string_delete(_string, last_break_pos, 1);
				_string = string_insert("\n", _string, last_break_pos);
			}
			
			curr_char = next_break_pos + 1;
		}
	}
	
	return _string;
}

///special_chars is a function that takes in full string and position of current char
//being written, and returns how many characters to skip (0 if not special),
//used to do special actions with some invisible control characters

///@func draw_typewriter(x, y, string, shake, scale, char_spacing_x, char_spacing_y, char_count, width, [special_chars])
function draw_typewriter(_x, _y, _string, _shake, _scale, _char_spacing_x, _char_spacing_y,
_char_count, _width, _special_chars = wrapper_constant(0))
{
	var curr_x = _x;
	var curr_y = _y;
	
	_string = insert_linebreaks(_string, _width);
	
	for (var curr_char = 1; curr_char <= min(_char_count, string_length(_string)); curr_char++)
	{
		while _special_chars(_string, curr_char) > 0 || string_char_at(_string, curr_char) == "\n"
		{
			var chars_to_skip = 0;
			
			do
			{
				chars_to_skip = _special_chars(_string, curr_char);
				if chars_to_skip > 0 { _string = string_delete(_string, curr_char, chars_to_skip); }
			
				if curr_char > min(_char_count, string_length(_string)) { return; }
			}
			until chars_to_skip <= 0
		
			while string_char_at(_string, curr_char) == "\n"
			{
				//Undertale thing lol, you can just remove asterik_offset if not needed
				var asterisk_offsetting = string_pos("*", _string) != 0 &&
					string_char_at(_string, curr_char + 1) != "*";
				
				var asterik_offset = asterisk_offsetting ? 2 * _char_spacing_x : 0;
				
				curr_x = _x + asterik_offset;
				curr_y += _char_spacing_y * _scale;
				_string = string_delete(_string, curr_char, 1);
			
				if curr_char > min(_char_count, string_length(_string)) { return; }
			}
		}
		
		draw_text_transformed(curr_x + choose(_shake, -_shake),
			curr_y + choose(_shake, -_shake), string_char_at(_string, curr_char),
				_scale, _scale, 0);
		
		curr_x += _char_spacing_x * _scale;
	}
}