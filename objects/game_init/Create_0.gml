if instance_number(parent_game) > 1 { instance_destroy(); exit; } //Already init
randomize();

event_user(0);
init_game();