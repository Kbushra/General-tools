///@desc Post processing
if custom_post_draw { exit; }

draw_gui_surface();

var application_draw_data = get_application_draw_data();
draw_application(application_draw_data);