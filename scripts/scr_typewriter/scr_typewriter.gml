///@func draw_typewriter(x, y, string, halign, valign, scale, char_spacing_x, char_spacing_y, char_count, width, monospace, actions)
///@return Processed string
function draw_typewriter(_x, _y, _string, _halign, _valign, _scale, _char_spacing_x, _char_spacing_y,
_char_count, _width, _monospace, _actions)
{
	_actions = variable_clone(_actions, 0);
	_string = insert_linebreaks(_string, _width / _scale, _monospace, _char_spacing_x / _scale);
	var _processed_string = string_replace_all(_string, "[action]", "");
	
	switch _halign
	{
		case fa_left: break;
		
		//I keep mixing up center and middle so I'm just allowing both
		case fa_center: case fa_middle: _x -= string_width(_processed_string) * _scale/2; break;
		
		case fa_right: _x -= string_width(_processed_string) * _scale; break;
	}
	
	switch _valign
	{
		case fa_top: break;
		
		//I keep mixing up center and middle so I'm just allowing both
		case fa_center: case fa_middle: _y -= string_height(_processed_string) * _scale/2; break;
		
		case fa_bottom: _y -= string_height(_processed_string) * _scale; break;
	}
	
	var asterisk_width = _monospace ?
		2 * _char_spacing_x : string_width("* ") + 2 * _char_spacing_x;
	
	var found_asterisk = false;
	var curr_x = _x;
	var curr_y = _y;
	
	for (var curr_char = 1; curr_char <= min(_char_count, string_length(_string)); curr_char++)
	{
		while string_copy(_string, curr_char, 8) == "[action]" ||
		string_char_at(_string, curr_char) == "\n"
		{
			while string_copy(_string, curr_char, 8) == "[action]"
			{
				call(array_shift(_actions));
				_string = string_delete(_string, curr_char, 8);
				if curr_char > min(_char_count, string_length(_string)) { return _processed_string; }
			}
		
			while string_char_at(_string, curr_char) == "\n"
			{
				curr_x = found_asterisk ? _x + asterisk_width : _x;
				curr_y += _char_spacing_y;
				curr_char++;
				if curr_char > min(_char_count, string_length(_string)) { return _processed_string; }
			}
		}
		
		if string_asterisk_line(_string, curr_char) { curr_x = _x; found_asterisk = true; }
		
		var char = string_char_at(_string, curr_char);
		draw_text_transformed(curr_x + choose(inline_shake, -inline_shake),
			curr_y + choose(inline_shake, -inline_shake), char,
			_scale, _scale, 0);
		
		curr_x += _monospace ? _char_spacing_x : string_width(char) + _char_spacing_x;
	}
	
	return _processed_string;
}