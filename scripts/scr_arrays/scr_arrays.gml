///@func array_push_unique(arr, vals...)
function array_push_unique(_arr)
{
	for (var i = 1; i < argument_count; i++)
	{
		if !array_contains(_arr, argument[i])
		{ array_push(_arr, argument[i]); }
	}
}

function index_defined(arr, i) { return i < array_length(arr) && arr[i] != undefined; }

function array_length_flattened(arr)
{
	var count = 0;
	for (var i = 0; i < array_length(arr); i++)
	{
		if !is_array(arr[i]) { count++; continue; }
		count += array_length_flattened(arr[i]);
	}
	
	return count;
}

function array_get_counts(arr)
{
	var result = {};
	for (var i = 0; i < array_length(arr); i++)
	{
		result[$ string(arr[i])] ??= 0;
		result[$ string(arr[i])]++;
	}
	
	return result;
}

function array_get_mode_average(arr)
{
	var counts = array_get_counts(arr);
	var keys = struct_get_names(counts);
	
	var max_count = 0;
	var max_key = "";
	for (var i = 0; i < array_length(keys); i++)
	{
		if counts[$ keys[i]] <= max_count { continue; }
		max_count = counts[$ keys[i]];
		max_key = keys[i];
	}
	
	return { key: max_key, count: max_count };
}