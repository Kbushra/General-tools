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