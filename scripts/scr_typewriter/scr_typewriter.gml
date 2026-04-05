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
				
				//Delete here as it shouldn't affect when count is reached
				if chars_to_skip > 0 { _string = string_delete(_string, curr_char, chars_to_skip); }
			
				if curr_char > min(_char_count, string_length(_string)) { return; }
			}
			until chars_to_skip <= 0
		
			while string_char_at(_string, curr_char) == "\n"
			{
				var asterisk_offsetting = string_pos("*", _string) != 0 &&
					string_char_at(_string, curr_char + 1) != "*";
				
				var asterik_offset = asterisk_offsetting ? 2 * _char_spacing_x : 0;
				
				curr_x = _x + asterik_offset;
				curr_y += _char_spacing_y;
				
				//Add here as it should affect when count is reached
				curr_char++;
			
				if curr_char > min(_char_count, string_length(_string)) { return; }
			}
		}
		
		draw_text_transformed(curr_x + choose(_shake, -_shake),
			curr_y + choose(_shake, -_shake), string_char_at(_string, curr_char),
				_scale, _scale, 0);
		
		curr_x += _char_spacing_x;
	}
}