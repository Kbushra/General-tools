var _solid = package_contents("debug_solid");
var _visible = package_contents("debug_visible");

///@desc Alternative to step (runs almost every frame, doesnt collide with existing step events)
if string_pos("spr_trig_", sprite_get_name(sprite_index)) == 1
{
	if _solid != NONE { solid = _solid; }
	if _visible != NONE { visible = _visible; }
}
else
{
	if _visible != NONE { debugDraw = _visible; }
}