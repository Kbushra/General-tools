///@func done_action(action_id, [count])
///@param action_id {string} The action id
///@param count {integer} The amount of times to check for (default 1)
///@desc Helps to execute a piece of code a certain count of times
function done_action(_actionId, _count = 1)
{	
	var _actionName = _actionId + "_action";
	
	if !variable_instance_exists(id, _actionName)
	{
		variable_instance_set(id, _actionName, 1);
		return false;
	}
	
	var _actionVal = variable_instance_get(id, _actionName);
	variable_instance_set(id, _actionName, _actionVal + 1);
	
	return _actionVal >= _count; //Previous action value btw
}

///@func reset_action(action_id)
///@param action_id {string} The action id
///@desc Resets an action allowing you to run done_action again
function reset_action(_actionId)
{	
	var _actionName = _actionId + "_action";
	variable_instance_set(id, _actionName, 0);
}