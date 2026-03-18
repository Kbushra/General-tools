///@desc Pathfinder grid
with (game_pathfinder)
{
	log = !log;
	stop_signal("pathfound");
}

with (parent_pathfinder_ai)
{ state = game_pathfinder.log ? pathfinderStates.chase : pathfinderStates.freeroam; }