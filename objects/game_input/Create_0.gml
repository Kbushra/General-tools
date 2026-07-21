print("input created");

image_alpha = 0;

for (var i = 0; i < KEY.COUNT; i++)
{
	global.input_pressed[i] = false;
	global.input_held[i] = false;
	global.input_released[i] = false;
}

event_user(0);