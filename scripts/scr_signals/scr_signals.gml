///Welcome to the new SIGNAL system

///@func send_signal(receiver, signal_name, hold_signal)
///@param receiver {asset}
///@param signal_name {string}
///@param hold_signal {bool}
///@desc To send a signal to another object, you can choose whether or not you want it to be a hold signal.
function send_signal(_id, _signal_name, _hold) 
{
	if !instance_exists(_id) { return; }
	
	var _variable_name = _signal_name + "_signal";
	
	if variable_instance_exists(_id, _variable_name)
	{ variable_instance_set(_id, _variable_name, _hold); exit; }
	
	variable_instance_set(_id, _variable_name, true);
}

///@func send_persistent_signal(receiver, signal_name, target_type)
///@param receiver {asset}
///@param signal_name {string}
///@param target_type {carrier enum}
///@desc To carry a signal that persists between rooms, directed at an instance or room
function send_persistent_signal(_id, _signal_name, _target_type)
{
	var carrier = noone;
	
	with (game_carrier)
	{
		if value_type == carrierValue.signal && target_type == _target_type &&
			target == _id && name == _signal_name { value = true; carrier = id; }
	}
	
	if carrier == noone
	{
		carrier = instance_create_depth(0, 0, 0, game_carrier,
			{ name: _signal_name, value: true, value_type: carrierValue.signal,
				target: _id, target_type: _target_type });
	}
	
	//If id exists the origin is set
	try { carrier.origin = id; }
	catch(error) { }
	
	return carrier;
}

///@func send_place_signal(signal_name)
///@param signal_name {string}
///@desc To send a signal to the entire room
function send_place_signal(_signal_name)
{
	return send_persistent_signal(room, _signal_name, carrierTarget.place);
}

///@func got_signal(signal_name)
///@param signal_name {string}
///@desc Whether or not an object has gotten a signal from another object.
function got_signal(_signal_name)
{
	var _variable_name = _signal_name + "_signal";
	return variable_instance_exists(id, _variable_name) && variable_instance_get(id, _variable_name)
}

///@func got_place_signal(signal_name)
///@param signal_name {string}
///@desc Whether or not a room has gotten a signal from a carrier
function got_place_signal(_signal_name)
{
	with (game_carrier)
	{
		if value_type == carrierValue.signal && target_type == carrierTarget.place &&
			room == target && name == _signal_name { return value; }
	}
	
	return false;
}

///@func stop_signal(signal_name)
///@param signal_name {string}
///@desc To stop a hold signal.
function stop_signal(_signal_name)
{
    var _variable_name = _signal_name + "_signal";
    variable_instance_set(id, _variable_name, false);
}

///@func stop_place_signal(signal_name)
///@param signal_name {string}
///@desc To stop a signal directed to a place.
function stop_place_signal(_signal_name)
{
    with (game_carrier)
	{
		if value_type == carrierValue.signal && target_type == carrierTarget.place &&
			room == target && name == _signal_name { instance_destroy(); }
	}
}