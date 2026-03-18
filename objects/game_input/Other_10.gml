///@func update_inputs()
update_inputs = function()
{
	right = keyboard_check(key_right[0]) || keyboard_check(key_right[1]);
	left = keyboard_check(key_left[0]) || keyboard_check(key_left[1]);
	down = keyboard_check(key_down[0]) || keyboard_check(key_down[1]);
	up = keyboard_check(key_up[0]) || keyboard_check(key_up[1]);
	
	right_pressed = keyboard_check_pressed(key_right[0]) || keyboard_check_pressed(key_right[1]);
	left_pressed = keyboard_check_pressed(key_left[0]) || keyboard_check_pressed(key_left[1]);
	down_pressed = keyboard_check_pressed(key_down[0]) || keyboard_check_pressed(key_down[1]);
	up_pressed = keyboard_check_pressed(key_up[0]) || keyboard_check_pressed(key_up[1]);
}