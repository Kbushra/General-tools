///Welcome to the new SIGNAL system

///@func send_package(receiver, package_name, value)
///@param receiver {asset}
///@param package_name {string}
///@param value {any}
///@desc To send a package to another object
function send_package(_id, _package_name, _value) 
{
	if !instance_exists(_id) { return; }
	
	var _variable_name = _package_name + "_package";
	variable_instance_set(_id, _variable_name, _value);
}

///@func send_persistent_package(receiver, package_name, type, value)
///@param receiver {asset}
///@param package_name {string}
///@param type {carrier enum}
///@param value {any}
///@desc To carry a package that persists between rooms, directed at an instance or room
function send_persistent_package(_id, _package_name, _target_type, _value)
{
	var carrier = noone;
	
	with (game_carrier)
	{
		if value_type == carrierValue.package && target_type == _target_type &&
			target == _id && name == _package_name { value = _value; carrier = id; }
	}
	
	if carrier == noone
	{
		carrier = instance_create_depth(0, 0, 0, game_carrier,
			{ name: _package_name, value: _value, value_type: carrierValue.package,
				target: _id, target_type: _target_type });
	}
	
	//If id exists the origin is set
	try { carrier.origin = id; }
	catch(error) { }
	
	return carrier;
}

///@func send_place_package(signal_name, value)
///@param package_name {string}
///@param value {any}
///@desc To send a package to the entire room
function send_place_package(_package_name, _value)
{
	return send_persistent_package(room, _package_name, carrierTarget.place, _value);
}

///@func package_contents(package_name)
///@param package_name {string}
///@desc Get the contents of a package. Returns NONE if package doesn't exist.
function package_contents(_package_name)
{
	var _variable_name = _package_name + "_package";
	if !variable_instance_exists(id, _variable_name) { return NONE; }
	return variable_instance_get(id, _variable_name);
}

///@func place_package_contents(package_name)
///@param package_name {string}
///@desc Get the contents of a place package. Returns NONE if package doesn't exist.
function place_package_contents(_package_name)
{
	with (game_carrier)
	{
		if value_type == carrierValue.package && target_type == carrierTarget.place &&
			room == target && name == _package_name { return value; }
	}
	
	return NONE;
}

///@func remove_package(package_name)
///@param package_name {string}
///@desc Removes a package
function remove_package(_package_name)
{
    var _variable_name = _package_name + "_package";
    variable_instance_set(id, _variable_name, NONE);
}

///@func remove_place_package(_package_name)
///@param package_name {string}
///@desc Removes a place package
function remove_place_package(_package_name)
{
	with (game_carrier)
	{
		if value_type == carrierValue.package && target_type == carrierTarget.place &&
			room == target && name == _package_name { instance_destroy(); }
	}
}