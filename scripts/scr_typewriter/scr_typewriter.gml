//Special chars must return the amount of chars to skip and
//take in full string, current character pos and whether to apply effect or not

///@func draw_typewriter(x, y, string, shake, scale, char_spacing_x, char_spacing_y, char_count, width, monospace, [special_chars])
function draw_typewriter(_x, _y, _string, _shake, _scale, _char_spacing_x, _char_spacing_y,
_char_count, _width, _monospace, _special_chars = wrapper_constant(0))
{
	var curr_x = _x;
	var curr_y = _y;
	_string = insert_linebreaks(_string, _width / _scale, _monospace, _char_spacing_x / _scale, _special_chars);
	
	for (var curr_char = 1; curr_char <= min(_char_count, string_length(_string)); curr_char++)
	{
		while _special_chars(_string, curr_char, false) > 0 || string_char_at(_string, curr_char) == "\n"
		{
			var chars_to_skip = 0;
			
			do
			{
				chars_to_skip = _special_chars(_string, curr_char, true);
				
				//Delete here as it shouldn't affect when count is reached
				if chars_to_skip > 0 { _string = string_delete(_string, curr_char, chars_to_skip); }
			
				if curr_char > min(_char_count, string_length(_string)) { return; }
			}
			until chars_to_skip <= 0
		
			while string_char_at(_string, curr_char) == "\n"
			{
				//var asterisk_offsetting = string_pos("*", _string) != 0 &&
				//	string_char_at(_string, curr_char + 1) != "*";
				
				//var asterisk_width = _monospace ?
				//	2 * _char_spacing_x : string_width("* ") + 2 * _char_spacing_x;
				
				//var asterisk_offset = asterisk_offsetting ? asterisk_width : 0;
				
				curr_x = _x;// + asterisk_offset;
				curr_y += _char_spacing_y;
				
				//Add here as it should affect when count is reached
				curr_char++;
			
				if curr_char > min(_char_count, string_length(_string)) { return; }
			}
		}
		
		var char = string_char_at(_string, curr_char);
		draw_text_transformed(curr_x + choose(_shake, -_shake),
			curr_y + choose(_shake, -_shake), char,
				_scale, _scale, 0);
		
		curr_x += _monospace ? _char_spacing_x : string_width(char) + _char_spacing_x;
	}
}