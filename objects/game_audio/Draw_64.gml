if !log { exit; }

draw_set_alpha(0.5);
try draw_text(20, 45, $"area music: {audio_get_name(area_music)}");
catch(no_music) draw_text(20, 45, $"area music: none");

draw_set_alpha(0.25);
draw_set_halign(fa_middle);
draw_text(GAME_WIDTH / 4, 35, "-Audio-");

draw_reset();