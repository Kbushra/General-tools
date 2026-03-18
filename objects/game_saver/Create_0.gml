print("save created--------------------------------------------------------------------");

global.save = {};
if file_exists(JSON_NAME) global.save = json_load();

var _default_save = default_save();

var names = struct_get_names(_default_save);
for (var i = 0; i < array_length(names); i++)
{
	global.save[$ names[i]] ??= _default_save[$ names[i]];
}

var compatibility_functions = [];
for (var i = global.save.compatibility_version; i < array_length(compatibility_functions); i++)
{
	if !assert(i >= 0, "Invalid save version!", true) { break; }
	
	compatibility_functions[i]();
	global.save.compatibility_version++;
}

//Save again with the extra default values
json_save();