///@desc Trigger visibility
if keyboard_check(vk_shift) exit;

debug_visible = !debug_visible;
with (parent_trigger) { send_package(id, "debug_visible", other.debug_visible); }