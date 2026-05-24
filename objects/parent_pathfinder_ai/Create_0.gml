send_place_signal("pathfind");

next_coord = new coordinate(0, 0);
moving = new moving_state(false, false);

dir = cache_read_prop("dir", "d");
axis = cache_read_prop("axis", HORIZONTAL);
sprite_index = get_sprite(name, "idle");

spd = 1;

event_user(0);
event_user(1);

freeroam_dist = 0;
freeroam_delay = 0;
freeroam_x = 0;
freeroam_y = 0;
state = pathfinder_states.freeroam;

roam_transition();
freeroam_delay = 0;

x = cache_read_prop("x", x);
y = cache_read_prop("y", y);