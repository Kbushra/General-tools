///@func assert(condition, [desc])
///@param condition Condition to assert to be true, else error
///@param desc Object this is used in
function assert(condition, desc = "Unknown error. No valid description. Ya dun goofed.", severe = false)
{
	if condition { return true; }
	if instance_exists(game_asserter) { return false; }
	
	instance_create_depth(0, 0, 0, game_asserter, { severe: severe, desc: desc });
	return false;
}