///@func string_asterisk_line(string, pos)
function string_asterisk_line(_string, pos)
{
	return string_copy(_string, pos, 2) == "* " &&
		(pos == 1 || string_char_at(_string, pos - 1) == "\n");
}

///@func insert_linebreaks(string, width, monospace, char_spacing_x)
function insert_linebreaks(_string, _width, _monospace, _char_spacing_x)
{
	var line_width = 0;
	var word_width = 0;
	var last_space_pos = 0;
	
	for (var curr_char = 1; curr_char <= string_length(_string); curr_char++)
	{
		while string_copy(_string, curr_char, 8) == "[action]" { curr_char += 8; }
		
		var letter = string_char_at(_string, curr_char);
		if letter == "\n"
		{
			line_width = 0;
			word_width = 0;
			
			if curr_char + 2 <= string_length(_string) &&
			string_copy(_string, curr_char + 1, 2) != "* "
			{
				//Gap made by asterik
				line_width += _monospace ? _char_spacing_x * 2 : string_width("* ");
			} 
			continue;
		}
		
		if letter == " "
		{
			line_width += word_width;
			line_width += _monospace ? _char_spacing_x : string_width(letter);
			word_width = 0;
			
			last_space_pos = curr_char;
			continue;
		}
		
		//Add gap before next letter
		if word_width > 0 && !_monospace { word_width += _char_spacing_x; }
		word_width += _monospace ? _char_spacing_x : string_width(letter);
		
		if line_width + word_width > _width && last_space_pos != 0
		{
			_string = string_delete(_string, last_space_pos, 1);
			_string = string_insert("\n", _string, last_space_pos);
			line_width = 0;
		}
	}
	
	return _string;
}