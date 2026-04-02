///@desc Methods

///@func recursive_merge(value, default)
recursive_merge = function(value, _default)
{
	value = variable_clone(value);
	
	if is_undefined(value) { return _default; }
	if ((is_array(value) && !is_array(_default)) || (!is_array(value) && is_array(_default))) { return _default; }
	if ((is_struct(value) && !is_struct(_default)) || (!is_struct(value) && is_struct(_default))) { return _default; }
	
	if is_array(_default)
	{
		for (var i = 0; i < array_length(_default); i++)
		{
			if i >= array_length(value) { value[i] = _default[i]; }
			else { value[i] = recursive_merge(value[i], _default[i]); }
		}
		
		return value;
	}
	
	if is_struct(_default)
	{
		var _default_names = struct_get_names(_default);
		for (var i = 0; i < array_length(_default_names); i++)
		{
			value[$ _default_names[i]] = recursive_merge(value[$ _default_names[i]],
				_default[$ _default_names[i]]);
		}
		
		return value;
	}
	
	return value;
}

///@func load_json_safe([file_name], [default_save], [compatibility_functions])
load_json_safe = function(file_name = JSON_NAME, _default_save = default_save(),
compatibility_functions = [])
{
	var struct = {};
	if file_exists(file_name) struct = json_load(file_name);
	
	var names = struct_get_names(_default_save);
	for (var i = 0; i < array_length(names); i++)
	{
		var _default = _default_save[$ names[i]];
		struct[$ names[i]] = recursive_merge(struct[$ names[i]], _default);
	}
	
	for (var i = struct.compatibility_version; i < array_length(compatibility_functions); i++)
	{
		if !assert(i >= 0, "Invalid save version!", true) { break; }
	
		compatibility_functions[i]();
		struct.compatibility_version++;
	}
	
	//Save again with the extra default values
	json_save(struct, file_name);
	return struct;
}