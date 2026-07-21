function default_keyboard_binds(struct)
{
	struct.keyboard_bind[KEY.UP][0] = vk_up;
	struct.keyboard_bind[KEY.UP][1] = ord("W");
	struct.keyboard_bind[KEY.DOWN][0] = vk_down;
	struct.keyboard_bind[KEY.DOWN][1] = ord("S");
	struct.keyboard_bind[KEY.LEFT][0] = vk_left;
	struct.keyboard_bind[KEY.LEFT][1] = ord("A");
	struct.keyboard_bind[KEY.RIGHT][0] = vk_right;
	struct.keyboard_bind[KEY.RIGHT][1] = ord("D");
	
	struct.keyboard_bind[KEY.CONFIRM][0] = ord("Z");
	struct.keyboard_bind[KEY.CONFIRM][1] = vk_enter;
	struct.keyboard_bind[KEY.CANCEL][0] = ord("X");
	struct.keyboard_bind[KEY.CANCEL][1] = vk_shift;
	struct.keyboard_bind[KEY.MENU][0] = ord("C");
	struct.keyboard_bind[KEY.MENU][1] = vk_control;
	
	struct.keyboard_bind[KEY.PAUSE][0] = vk_escape;
	struct.keyboard_bind[KEY.PAUSE][1] = NONE;
	
	return struct;
}

function default_save()
{
	var struct =
	{
		compatibility_version: 0,
		cache: {}
	};
	
	return struct;
}

function default_config()
{
	var struct =
	{
		compatibility_version: 0,
		language: LANG.EN,
		keyboard_bind: []
	};
	
	struct = default_keyboard_binds(struct);
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