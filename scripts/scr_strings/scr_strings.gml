//Special chars must return the amount of chars to skip and
//take in full string, current character pos and whether to apply effect or not

///@func insert_linebreaks(string, width, monospace, char_spacing_x, [special_chars])
function insert_linebreaks(_string, _width, _monospace, _char_spacing_x, _special_chars = wrapper_constant(0))
{
	var line_width = 0;
	var word_width = 0;
	var last_space_pos = 0;
	
	for (var curr_char = 1; curr_char <= string_length(_string); curr_char++)
	{
		var chars_to_skip = 0;
		
		do
		{	
			chars_to_skip = _special_chars(_string, curr_char, false);
			if chars_to_skip > 0 { curr_char += chars_to_skip }
			if curr_char > string_length(_string) { return _string; }
		}
		until chars_to_skip <= 0
		
		var letter = string_char_at(_string, curr_char);
		if letter == "\n"
		{
			line_width = 0;
			word_width = 0;
			
			//if curr_char + 2 <= string_length(_string) &&
			//string_copy(_string, curr_char + 1, 2) != "* "
			//{
			//	//Gap made by asterik
			//	line_width += _monospace ? _char_spacing_x * 2 : string_width("* ");
			//} 
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
			line_width = word_width;
		}
	}
	
	return _string;
}

function tracked_string(original_string, new_string, original_char_count)
{
	var tracker_string = "";
	var original_pos = 1;
	
	for (var new_pos = 1; new_pos <= string_length(new_string); new_pos++)
	{
		var original_char = string_char_at(original_string, original_pos);
		var new_char = string_char_at(new_string, new_pos);
		
		tracker_string += new_char;
		if original_char == new_char { original_pos++; }
		
		if original_pos > original_char_count { break; }
	}
	
	return tracker_string;
}