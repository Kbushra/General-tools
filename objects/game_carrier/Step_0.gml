if target_type == carrierTarget.instance && instance_exists(target)
{
	switch value_type
	{
		case carrierValue.signal:
		send_signal(target, name, value);
		break;
		
		case carrierValue.package:
		send_package(target, name, value);
		break;
	}
	
	if instance_exists(origin) { send_signal(origin, "signal_carried", true); }
	instance_destroy();
}

if target_type == carrierTarget.place && room == target { send_signal(id, "reached_dest", true); }
if got_signal("reached_dest") && room != target { instance_destroy(); }