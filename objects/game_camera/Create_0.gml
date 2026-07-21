print("camera created");

image_alpha = 0;

x_start = x;
y_start = y;
cam_x = x;
cam_y = y;

width = GAME_WIDTH;
height = GAME_HEIGHT;
scale = 1;
display_set_gui_size(width / scale, height / scale);

xoffset = width / 2;
yoffset = height / 2;
zoom = 1;

cam_target = obj_player;
target_lerp_factor = 1;

target_x = x_start;
target_y = y_start;

prev_target_x = target_x;
prev_target_y = target_y;

progress_x = 0;
progress_y = 0;

custom = false;
shake_intensity = 0;

event_user(0);

cam_create();
cam_set();

window_set_size(GAME_WIDTH * RENDER_SCALE, GAME_HEIGHT * RENDER_SCALE);
window_center();