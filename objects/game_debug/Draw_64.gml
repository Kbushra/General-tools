draw_reset();

draw_set_alpha(0.5 * show_help_text);
draw_set_halign(fa_right);
draw_text_transformed(GAME_WIDTH - 5, 4,
@"
Debugging!
ALT+A to toggle audio log
P to toggle pathfinder grid
G to toggle trigger vis
SPACE to toggle trigger coll
Q to slow the game down
F to save
CTRL+D to toggle debug overlay
",
0.5, 0.5, 0);

draw_reset();