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

if !global.respawn
{
	window_set_size(wide.w, wide.h);
	window_center();
}

xoffset = width / 2;
yoffset = height / 2;
zoom = 1;

targetOffset = 10;

targetX = xstart;
targetY = ystart;

prevTargetX = targetX;
prevTargetY = targetY;

progressX = 0;
progressY = 0;

view = 0;

custom = false;
shakeIntensity = 0;

event_user(0);

cam_set();