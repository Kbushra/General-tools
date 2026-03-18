///@func change_bgm
function change_bgm(sound)
{
    if audio_sound_get_asset(game_audio.areaMusic) == sound { exit; }
    game_audio.areaMusic = sound;
}

///@func play_bgm
function play_bgm(sound, gain = 1, priority = 1)
{
	if audio_is_playing(sndNobody) { return NONE; }
	
    if !audio_exists(sound) { return NONE; }
	if audio_is_paused(sound) { audio_resume_sound(sound); return sound; }
	if audio_is_playing(sound) { audio_sound_gain(sound, gain); return sound; }
    
	stop_bgm();
    var mus = audio_play_sound_on(game_audio.emitterBGM, sound, true, priority, gain);
	game_audio.areaMusic = mus;
	return mus;
}

///@func stop_bgm
function stop_bgm()
{
    if audio_exists(game_audio.areaMusic) && audio_is_playing(game_audio.areaMusic)
	{ audio_stop_sound(game_audio.areaMusic); }
	
	change_bgm(NONE);
}

///@func pause_bgm
function pause_bgm()
{
    if audio_exists(game_audio.areaMusic) && audio_is_playing(game_audio.areaMusic)
	{ audio_pause_sound(game_audio.areaMusic); }
}

///@func resume_bgm
function resume_bgm()
{
    if audio_exists(game_audio.areaMusic) && audio_is_paused(game_audio.areaMusic)
	{ audio_resume_sound(game_audio.areaMusic); }
}

///@func play_sfx
function play_sfx(sound, gain = 1, priority = 0)
{
    if !audio_exists(sound) { exit; }
    return audio_play_sound_on(game_audio.emitterSFX, sound, false, priority, gain);
}

///@func custom_pause_bgm()
function custom_pause_bgm()
{
	send_signal(game_audio, "custom_bgm", true);
	pause_bgm();
}

///@func custom_play_bgm(sound)
function custom_play_bgm(sound)
{
	send_signal(game_audio, "custom_bgm", true);
	return play_bgm(sound);
}