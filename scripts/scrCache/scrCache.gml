///@desc Run at saveable object create event to get instance
function calculate_id()
{
	if variable_instance_exists(id, "instance") { return instance; }
	
	var object_id = $"{room_get_name(room)}_{object_get_name(object_index)}";
	
	//If a package doesn't exist its NONE, so the first instance makes it 0
	send_place_package(object_id, place_package_contents(object_id) + 1);
	
	instance = $"{object_id}_{place_package_contents(object_id)}";
	return instance;
}

///@param variable_name {string}
///@param instance_id {string}
///@param area {area enum}
function cache_write_prop(_var, _id = calculate_id(), _area = global.save.area)
{
	var _value = variable_instance_get(id, _var);
	
	var _struct_area = global.save.cache[_area];
	var _struct_self = _struct_area[$ _id] ?? {};
	_struct_self[$ _var] = _value;
	
	_struct_area[$ _id] = _struct_self;
	global.save.cache[_area] = _struct_area;
}

///@param array_name {string}
///@param instance_id {string}
///@param area {area enum}
function cache_write_prop_array(_array_name, _id = calculate_id(), _area = global.save.area)
{
	var _struct_area = global.save.cache[_area];
	var _struct_self = _struct_area[$ _id] ?? {};
	
	var _array = variable_instance_get(id, _array_name);
	
	for (var i = 0; i < array_length(_array); i++)
	{ _struct_self[$ $"{_array_name}_{i}"] = _array[i]; }
	
	_struct_area[$ _id] = _struct_self;
	global.save.cache[_area] = _struct_area;
}

///@param struct_name {string}
///@param instance_id {string}
///@param area {area enum}
function cache_write_prop_struct(_struct_name, _id = calculate_id(), _area = global.save.area)
{
	var _struct_area = global.save.cache[_area];
	var _struct_self = _struct_area[$ _id] ?? {};
	
	var _struct = variable_instance_get(id, _struct_name);
	var _names = struct_get_names(_struct);
	
	for (var i = 0; i < array_length(_names); i++)
	{ _struct_self[$ _names[i]] = _struct[$ _names[i]]; }
	
	_struct_area[$ _id] = _struct_self;
	global.save.cache[_area] = _struct_area;
}

///@param variable_name {string}
///@param default_value {string}
///@param instance_id {string}
///@param area {area enum}
function cache_read_prop(_var, _default, _id = calculate_id(), _area = global.save.area)
{
	var _struct_area = global.save.cache[_area];
	var _struct_self = _struct_area[$ _id] ?? {};
	
	var _value = _struct_self[$ _var] ?? _default;
	try { _value = _value; }
	catch(error) {}
	
	variable_instance_set(id, _var, _value);
}

///@param array_name {string}
///@param default {array}
///@param instance_id {string}
///@param area {string}
function cache_read_prop_array(_array_name, _default, _id = calculate_id(), _area = global.save.area)
{
	var _struct_area = global.save.cache[_area];
	var _struct_self = _struct_area[$ _id] ?? {};
	var _array_values = [];
	
	//Any values that have a default will be read into
	for (var i = 0; i < array_length(_default); i++)
	{
		var _value = _struct_self[$ $"{_array_name}_{i}"] ?? _default[i];
		try { _value = real(_value); }
		catch(error) {}
	
		array_push(_array_values, _value);
	}
	
	variable_instance_set(id, _array_name, _array_values);
}

///@param struct_name {string}
///@param default_struct {struct}
///@param instance_id {string}
///@param area {string}
function cache_read_prop_struct(_struct_name, _default, _id = calculate_id(), _area = global.save.area)
{
	var _struct_area = global.save.cache[_area];
	var _struct_self = _struct_area[$ _id] ?? {};
	var _names = struct_get_names(_default);
	
	//Any values that have a default will be read into
	for (var i = 0; i < array_length(_names); i++)
	{
		var _value = _struct_self[$ _names[i]] ?? _default[$ _names[i]];
		try { _value = real(_value); }
		catch(error) {}
	
		_struct_self[$ _names[i]] = _value;
	}
	
	variable_instance_set(id, _struct_name, _struct_self);
}