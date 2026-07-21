cache_write_prop("x", x);
cache_write_prop("y", y);
cache_write_prop("dir", dir);
cache_write_prop("axis", axis);

if obj_player.state == PLAYER_STATES.FREEZE
{ sprite_index = get_sprite(name, "idle"); path_speed = 0; exit; }

if state == PATHFINDER_STATES.PATHROAM
{
	pathroam_state();
	exit;
}

path_end();	

if state == PATHFINDER_STATES.FREEROAM
{
	freeroam_state();
	exit;
}

if state != PATHFINDER_STATES.CHASE { exit; }

if moving.is_moving()
{
	moving = pathfind_move();
	exit;
}

if !setup_pathfind() { roam_transition(); }