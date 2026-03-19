#macro GAME_WIDTH (game_camera.size.w)
#macro GAME_HEIGHT (game_camera.size.h)

#macro GAME_WIDTH_SQUARE 720
#macro GAME_HEIGHT_SQUARE 480

#macro HORIZONTAL 0
#macro VERTICAL 1
#macro DIAGONAL 2

#macro RIGHT 0
#macro LEFT 1
#macro DOWN 2
#macro UP 3

#macro NONE -1

#macro JSON_NAME "save.json"

#macro DISP_W display_get_width()
#macro DISP_H display_get_height()

#macro WIN_X window_get_x()
#macro WIN_Y window_get_y()
#macro WIN_W window_get_width()
#macro WIN_H window_get_height()
#macro WIN_GET_FULL window_get_fullscreen()

#macro APP_SURF application_surface
#macro APP_W surface_get_width(APP_SURF)
#macro APP_H surface_get_height(APP_SURF)
#macro APP_ASPECT (APP_W / APP_H)

#macro VIEW view_camera[0]
#macro VIEW_X camera_get_view_x(VIEW)
#macro VIEW_Y camera_get_view_y(VIEW)
#macro VIEW_W camera_get_view_width(VIEW)
#macro VIEW_H camera_get_view_height(VIEW)
#macro VIEW_R (VIEW_X + VIEW_W)
#macro VIEW_B (VIEW_Y + VIEW_H)
#macro VIEW_CENTER_X (VIEW_X + VIEW_W/2)
#macro VIEW_CENTER_Y (VIEW_Y + VIEW_H/2)
#macro VIEW_ASPECT (VIEW_W / VIEW_H)

#macro GUI_W display_get_gui_width()
#macro GUI_H display_get_gui_height()
#macro GUI_ASPECT (GUI_W / GUI_H)

#macro print show_debug_message