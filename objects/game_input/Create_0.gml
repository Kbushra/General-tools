print("input created");

image_alpha = 0;

key_right = [vk_right, ord("D")];
key_down  = [vk_down, ord("S")];
key_left  = [vk_left, ord("A")];
key_up    = [vk_up, ord("W")];

right = false;
left = false;
down = false;
up = false;

event_user(0);
update_inputs();