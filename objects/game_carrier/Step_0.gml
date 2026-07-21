if target_type == CARRIER_TARGET.INSTANCE && instance_exists(target)
{
	switch value_type
	{
		case CARRIER_VALUE.SIGNAL:
		send_signal(target, name, value);
		break;
		
		case CARRIER_VALUE.PACKAGE:
		send_package(target, name, value);
		break;
	}
	
	if instance_exists(origin) { send_signal(origin, "signal_carried", true); }
	instance_destroy();
}

if target_type == CARRIER_TARGET.PLACE && room == target { send_signal(id, "reached_dest", true); }
if got_signal("reached_dest") && room != target { instance_destroy(); }