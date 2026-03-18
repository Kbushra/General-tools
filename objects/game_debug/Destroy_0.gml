game_audio.log = false;
game_pathfinder.log = false;

game_set_speed(60, gamespeed_fps);
with (parent_trigger) { send_package(id, "debug_visible", false); }