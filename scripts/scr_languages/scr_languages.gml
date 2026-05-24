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

///@func language_string(key, csv, format args...)
function language_string(_key, _csv_id) constructor
{
	key = _key;
	csv_id = _csv_id;
	for (var i = 2; i < argument_count; i++) { format_args[i - 2] = argument[i]; }
	
	language = NONE;
	loaded_string = "";
	
	///@func load()
	load = function()
	{
		if language == global.save.language { return loaded_string; }
		
		//Will move find_text into here later
		loaded_string = script_execute_ext(find_text, array_concat([key, csv_id], format_args));
		language = global.save.language;
		return loaded_string;
	}
}

///@func find_text(key, type, [a], ...)
///@param key Key for the text to find
///@param type CSV file to look in
///@param [a] Variables to substitute in
///@param ... Variables to substitute in
function find_text(key, type)
{
	var text = "";
	var translation_keys = noone; var translation_grid = noone;
	
	switch (type)
	{
		case csv.overworld:
		translation_keys = global.overworld_keys;
		translation_grid = global.overworld_grid;
		break;
		
		case csv.battle:
		translation_keys = global.battle_keys;
		translation_grid = global.battle_grid;
		break;
		
		case csv.gui:
		translation_keys = global.gui_keys; 
		translation_grid = global.gui_grid;
		break;
		
		default:
		assert(false, "Invalid type given in find_text!");
		return "";
	}
	
	if translation_keys[? key] == undefined { return key; }
	
	text = translation_grid[# 1 + global.config.language, translation_keys[? key]];
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