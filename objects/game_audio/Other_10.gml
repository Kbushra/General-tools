///@desc Methods

///@func start_area_music()
start_area_music = function()
{
	var overrideable = true;
	var bgm = NONE;
	
	switch global.save.area
	{
		case area.battle: bgm = sndRuderBuster; break;
		case area.ruins: bgm = sndRuins; break;
		case area.home: bgm = sndHome; overrideable = false; break;
	}
	
	if audio_sound_get_asset(areaMusic) != bgm { stop_bgm(); }
	change_bgm(bgm);
	
	if global.save.killCount[global.save.area] <= 0 && overrideable { change_bgm(sndNobody); }

	play_bgm(areaMusic);
}