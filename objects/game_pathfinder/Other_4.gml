//Always pathfind on entering a room
alarm[0] = 1;
send_signal(id, "room_start", true);