///@param func
///@param arg1
///@param arg2
///@param arg3
function wrapper(func)
{
	var args = [];
	for (var i = 1; i < argument_count; i++) { array_push(args, argument[i]); }
	return method({ func, args, id },
		function() { with (id) script_execute_ext(other.func, other.args); });
}

///@param func
///@param arg1
///@param arg2
///@param arg3
function wrapper_return(func)
{
	var args = [];
	for (var i = 1; i < argument_count; i++) { array_push(args, argument[i]); }
	return method({ func, args, id },
		function() { with (id) return script_execute_ext(other.func, other.args); });
}

function wrapper_constant(constant)
{
	return method({ constant }, function()
	{
		return constant;
	});
}