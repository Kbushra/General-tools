///@func update_keyboard_inputs()
update_keyboard_inputs = function()
{
	for (var i = 0; i < KEY.COUNT; i++)
	{
		//These variables can be set to false to stop detecting an input
		global.input_pressed[i] = key_check_direct(i, KEY_STATE.PRESSED);
		global.input_held[i] = key_check_direct(i, KEY_STATE.HELD);
		global.input_released[i] = key_check_direct(i, KEY_STATE.RELEASED);
	}
}