if keyboard_check_pressed(vk_f4) { window_set_fullscreen(!window_get_fullscreen()); }

draw_set_colour(c_black);
draw_rectangle(0, 0, GAME_WIDTH_SQUARE, GAME_HEIGHT_SQUARE, false);
draw_set_colour(c_white);

draw_set_halign(fa_middle);
draw_set_valign(fa_center);

draw_text(160, 60, "(BUG REPORT THIS)\nError!");

draw_set_colour(severe ? c_red : c_white);
draw_text(160, 120, desc);
draw_set_colour(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);