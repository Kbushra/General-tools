///@desc Methods

///@func start_area_music()
start_bgm = function()
{
	var bgm = NONE;
	//Code to change bgm
	
	if audio_sound_get_asset(area_music) != bgm { stop_bgm(); }
	change_bgm(bgm);

	play_bgm(area_music);
}