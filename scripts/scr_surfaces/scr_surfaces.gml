///@desc Resize only if the surface is not already at the specified width and height
function surface_resize_dynamic(surf, width, height)
{
	if surface_get_width(surf) != width || surface_get_height(surf) != height
	{ surface_resize(surf, width, height); }
}