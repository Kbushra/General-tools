///@func array_push_unique(arr, vals...)
function array_push_unique(_arr)
{
	for (var i = 1; i < argument_count; i++)
	{
		if !array_contains(_arr, argument[i])
		{ array_push(_arr, argument[i]); }
	}
}

//only for perfect 2d arrays rn
function array_length_flattened(arr)
{
	var count = 0;
	for (var i = 0; i < array_length(arr); i++)
	{
		for (var j = 0; j < array_length(arr[i]); j++)
		{
			count++;
		}
	}
	
	return count;
}