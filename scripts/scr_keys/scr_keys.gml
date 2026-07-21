enum KEY
{
	UP,
	DOWN,
	LEFT,
	RIGHT,
	CONFIRM,
	CANCEL,
	MENU,
	PAUSE,
	COUNT
}

enum KEY_STATE
{
	PRESSED,
	HELD,
	RELEASED
}

function key_check_direct(key, state)
{
	switch (state)
	{
		case KEY_STATE.PRESSED:
		return keyboard_check_pressed(global.config.keyboard_bind[key][0]) ||
			keyboard_check_pressed(global.config.keyboard_bind[key][1]);
		
		case KEY_STATE.HELD:
		return keyboard_check(global.config.keyboard_bind[key][0]) ||
			keyboard_check(global.config.keyboard_bind[key][1]);
		
		case KEY_STATE.RELEASED:
		return keyboard_check_released(global.config.keyboard_bind[key][0]) ||
			keyboard_check_released(global.config.keyboard_bind[key][1]);
	}
	
	return false;
}