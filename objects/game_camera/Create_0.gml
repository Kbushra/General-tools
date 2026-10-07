print("camera created");

image_alpha = 0;

//x = obj_player.x;
//y = obj_player.y;

x_start = x;
y_start = y;
cam_x = x
cam_y = y

width = GAME_WIDTH;
height = GAME_HEIGHT;
gui_scale = 1;
display_set_gui_size(width * gui_scale, height * gui_scale);

if os_type == os_gxgames { window_set_size(DISP_W, DISP_H); }
else { window_set_size(GAME_WIDTH * RENDER_SCALE, GAME_HEIGHT * RENDER_SCALE); }

window_center();

xoffset = width / 2;
yoffset = height / 2;
zoom = 1;
angle = 0;
tint = new rgba(c_black, 0);

cam_target = obj_player
target_lerp_factor = 1
target_offset = 10;

target_x = x_start;
target_y = y_start;

//prev_target_x = target_x;
//prev_target_y = target_y;

progress_x = 0;
progress_y = 0;

custom = false;
custom_post_draw = false;
shake_intensity = 0;

//Used for post processing stuff
application_surface_draw_enable(false);
gui_surface = noone;
app_zoom = 1;

event_user(0);
event_user(1);

cam_set();