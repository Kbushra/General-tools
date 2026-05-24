cache_write_prop("x", x);
cache_write_prop("y", y);
cache_write_prop("dir", dir);
cache_write_prop("axis", axis);

if obj_player.state == player_states.freeze
{ sprite_index = get_sprite(name, "idle"); path_speed = 0; exit; }

if state == pathfinder_states.pathroam
{
	pathroam_state();
	exit;
}

path_end();	

if state == pathfinder_states.freeroam
{
	freeroam_state();
	exit;
}

if state != pathfinder_states.chase { exit; }

if moving.is_moving()
{
	moving = pathfind_move();
	exit;
}

if !setup_pathfind() { roam_transition(); }