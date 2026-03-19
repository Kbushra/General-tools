print("camera created");

image_alpha = 0;

x = obj_player.x;
y = obj_player.y;

xstart = x;
ystart = y;

square = { w: GAME_WIDTH_SQUARE, h: GAME_HEIGHT_SQUARE, gui_scale : 1 };

size = square;
width = size.w;
height = size.h;
scale = size.gui_scale;
display_set_gui_size(width / scale, height / scale);

window_set_size(width, height);
window_center();

xoffset = width / 2;
yoffset = height / 2;
zoom = 1;

target_offset = 10;

target_x = xstart;
target_y = ystart;

progress_x = 0;
progress_y = 0;

view = 0;

custom = false;
shake_intensity = 0;

event_user(0);

cam_set();