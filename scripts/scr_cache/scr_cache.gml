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

///@param name {string}
///@param value {any}
///@param instance_id {string}
function cache_write_prop(_name, _value, _id = calculate_id())
{
	var _struct_self = global.save.cache[$ _id] ?? {};
	_struct_self[$ _name] = _value;
	
	global.save.cache[$ _id] = _struct_self;
}

///@param name {string}
///@param default_value {any}
///@param instance_id {string}
function cache_read_prop(_name, _default, _id = calculate_id())
{
	var _struct_self = global.save.cache[$ _id] ?? {};
	return _struct_self[$ _name] ?? _default;
}