///@func instance_create_unique()
///@param x {real}
///@param y {real}
///@param depth {string}
///@param obj {asset}
///@param var_struct {struct}
///@desc this function creates an instance if it doesn't exist yet
function instance_create_unique(_x, _y, _depth, _obj, _struct = {})
{
	if instance_exists(_obj) exit;
	var _inst = instance_create_depth(_x, _y, _depth, _obj, _struct);
	return _inst;
}