function is_language_string(val)
{
	return is_struct(val) && is_instanceof(val, language_string);
}

function load_if_language_string(val, force = false)
{
	return is_language_string(val) ? val.load(force) : val;
}

function keys_to_language_string(keys)
{
	return array_map(keys, function(key) { return new language_string(key); });
}

function load_language_strings(language_strings, force = false)
{
	return array_map(language_strings,
		method({ force }, function(str) { return load_if_language_string(str, force); }));
}

function json_follow_path(json, path)
{
	json = variable_clone(json, 0);
	var keys = string_split(path, "/");
	for (var i = 0; i < array_length(keys); i++)
	{
		if string_digits(keys[i]) == keys[i]
		{
			if !is_array(json) || real(keys[i]) >= array_length(json) { return NONE; }
			json = json[real(keys[i])];
		}
		else
		{
			if !is_struct(json) || json[$ keys[i]] == undefined { return NONE; }
			json = json[$ keys[i]];
		}
	}
	
	return json;
}

function clean_json_text(text)
{
	text = string_trim(text);
	text = string_replace_all(text, "\r", "");
	text = string_replace_all(text, "\"", "");
	return text;
}

function replace_json_text(text, format)
{
	for (var i = 0; i < array_length(format); i++)
	{	
		//{0} will be replaced with format[0], {1} with format[1], etc.
		text = string_replace_all(text, $"\{{i}\}", load_if_language_string(format[i]));
	}
		
	text = string_replace_all(text, "{lb}", "\n");
	text = string_replace_all(text, "{qt}", "\"");
	return text;
}

///@func language_array(key, len, [key_start])
function language_array(_key, _len, _key_start = 1)
{
	var arr = [];
	for (var i = _key_start; i < _len + _key_start; i++)
	{ arr[i-_key_start] = new language_string($"{_key}/{i}"); }
	
	return arr;
}

///@func language_string(key, format args...)
function language_string(_key) constructor
{
	key = _key;
	format_args = [];
	for (var i = 1; i < argument_count; i++) { format_args[i - 1] = argument[i]; }
	
	language = NONE;
	loaded_string = "";
	
	///@func load([force])
	load = function(force = false)
	{
		if language == global.config.language && !force { return loaded_string; }
		language = global.config.language;
		
		var text = json_follow_path(global.language_json[global.config.language], key);
		if text == NONE { text = key; }
		
		text = clean_json_text(text);
		text = replace_json_text(text, format_args);
		
		if text == "" { text = "-"; } //Placeholder text
		loaded_string = text;
		return loaded_string;
	}
}