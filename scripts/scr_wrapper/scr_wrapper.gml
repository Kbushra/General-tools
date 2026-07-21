function wrapper(caller, func)
{
	var args = [];
	for (var i = 2; i < argument_count; i++) { array_push(args, argument[i]); }
	return method({ caller, func, args },
	function()
	{
		var _func = func;
		var _args = args;
		if !instance_exists(caller) { caller = other.id; }
		with (caller) { return script_execute_ext(_func, _args); }
	});
}

function wrapper_constant(constant)
{
	return method({ constant }, function()
	{
		return constant;
	});
}

function call(_func)
{
	if is_array(_func) { return script_execute_ext(_func[0], _func, 1); }
	if !assert(is_callable(_func), "Passed in uncallable function to call()!") { return NONE; }
	return _func();
}

function can_call(_func)
{
	return (is_array(_func) && array_length(_func) > 0 && is_callable(_func[0])) ||
		is_callable(_func);
}