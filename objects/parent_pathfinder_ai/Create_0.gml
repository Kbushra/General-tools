send_place_signal("pathfind");

state = pathfinderStates.freeroam;

next = NONE; //NONE means not evaluated yet, [] means nowhere to go next
moving = [false, false];

spd = 1;

event_user(0);

freeroam_dist = RAND_FREEROAM;
freeroam_delay = 0;
freeroam_x = 0;
freeroam_y = 0;

if path != noone { state = pathfinderStates.roam; exit; }

setup_freeroam();