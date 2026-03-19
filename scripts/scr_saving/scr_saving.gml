function default_save()
{
	var struct =
	{
		compatibility_version: 0,
		cache: {}
	};
	
	return struct;
}

function json_save(data = global.save, file_name = JSON_NAME)
{
    var save_string = json_stringify(data, true);
    var save_buffer = buffer_create(string_byte_length(save_string) + 1, buffer_fixed, 1);
	
    buffer_write(save_buffer, buffer_string, save_string);
    buffer_save(save_buffer, file_name);
    buffer_delete(save_buffer);
}

function json_load(file_name = JSON_NAME) 
{
    if !file_exists(file_name) return;
   
    var load_buffer = buffer_load(file_name);
    var load_string = buffer_read(load_buffer, buffer_string);
	
    buffer_delete(load_buffer);
	return json_parse(load_string);
}