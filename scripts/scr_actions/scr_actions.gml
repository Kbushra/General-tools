///@func done_action(action_id, [count])
///@param action_id {string} The action id
///@param count {integer} The amount of times to check for (default 1)
///@desc Helps to execute a piece of code a certain count of times
function done_action(_action_id, _count = 1)
{	
	var _action_name = _action_id + "_action";
	
	if !variable_instance_exists(id, _action_name)
	{
		variable_instance_set(id, _action_name, 1);
		return false;
	}
	
	var _action_val = variable_instance_get(id, _action_name);
	variable_instance_set(id, _action_name, _action_val + 1);
	
	return _action_val >= _count; //Previous action value btw
}

///@func reset_action(action_id)
///@param action_id {string} The action id
///@desc Resets an action allowing you to run done_action again
function reset_action(_action_id)
{	
	var _action_name = _action_id + "_action";
	variable_instance_set(id, _action_name, 0);
}