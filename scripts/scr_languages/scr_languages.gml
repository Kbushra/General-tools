function clean_csv_text(text)
{
	text = string_trim(text);
	text = string_replace_all(text, "\r", "");
	text = string_replace_all(text, "\"", "");
	return text;
}

function load_language_csv(name)
{
	var _grid = load_csv(name);
	var _grid_height = ds_grid_height(_grid);
	var _keys = ds_map_create();

	for (var i = 0; i < _grid_height; i ++)
	{ ds_map_add(_keys, _grid[# 0, i], i); }
	
	return { grid: _grid, keys: _keys };
}

///@func find_text(key, type, [a], ...)
///@param key Key for the text to find
///@param type CSV file to look in
///@param [a] Variables to substitute in
///@param ... Variables to substitute in
function find_text(key, type)
{
	var text = "";
	var translation_keys = game_languages.language_keys;
	var translation_grid = game_languages.language_grid;
	
	if translation_keys[? key] == undefined { return key; }
	
	text = translation_grid[# 1 + global.save.language, translation_keys[? key]];
	text = clean_csv_text(text);
		
	for (var i = 2; i < argument_count; i++)
	{
		//{a} will be replaced with argument[2], {b} with argument[3], etc.
		text = string_replace_all(text, $"\{{chr(ord("a") + i - 2)}\}", argument[i]);
	}
		
	text = string_replace_all(text, "{lb}", "\n");
	text = string_replace_all(text, "{qt}", "\"");
		
	if text == "" { text = "-"; } //Placeholder text
	return text;
}