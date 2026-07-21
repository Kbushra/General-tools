enum AUDIO_PRIORITY
{
	MUSIC = 100,
	SFX = 50
}

function change_bgm(sound)
{
    if !instance_exists(game_audio) || audio_sound_get_asset(game_audio.area_music) == sound { exit; }
    game_audio.area_music = sound;
}

function get_sound(sound_name)
{
	if !is_string(sound_name) { return sound_name; }
	if !instance_exists(game_audio) { return noone; }
	
	game_audio.streams[$ sound_name] ??= audio_create_stream(sound_name);
	return game_audio.streams[$ sound_name];
}

function destroy_sound(sound_name)
{
	if !is_string(sound_name) || !instance_exists(game_audio) { return; }
	
	audio_destroy_stream(game_audio.streams[$ sound_name]);
	struct_remove(game_audio.streams, sound_name);
}

function play_bgm(sound, gain = 1, priority = AUDIO_PRIORITY.MUSIC)
{
	sound = get_sound(sound);
	if !instance_exists(game_audio) || audio_is_playing(mus_nobody) { return noone; }
	
	if audio_is_paused(sound) { audio_resume_sound(sound); return sound; }
	if audio_is_playing(sound) { audio_sound_gain(sound, gain); return sound; }
    
	stop_bgm();
    var mus = audio_play_sound_on(game_audio.emitter_bgm, sound, true, priority, gain);
	change_bgm(mus);
	return mus;
}

function stop_bgm()
{
	if !instance_exists(game_audio) { return; }
	
    if audio_exists(game_audio.area_music) && audio_is_playing(game_audio.area_music)
	{ audio_stop_sound(game_audio.area_music); }
	
	change_bgm(noone);
}

function pause_bgm()
{
	if !instance_exists(game_audio) { return; }
	
    if audio_exists(game_audio.area_music) && audio_is_playing(game_audio.area_music)
	{ audio_pause_sound(game_audio.area_music); }
}

function resume_bgm()
{
	if !instance_exists(game_audio) { return; }
	
    if audio_exists(game_audio.area_music) && audio_is_paused(game_audio.area_music)
	{ audio_resume_sound(game_audio.area_music); }
}

function play_sfx(sound, rand_pitch = false, loops = false, gain = 1, priority = AUDIO_PRIORITY.SFX)
{
	sound = get_sound(sound);
    if !instance_exists(game_audio) { return noone; }
	
    var sfx = audio_play_sound_on(game_audio.emitter_sfx, sound, loops, priority, gain);
	if rand_pitch { audio_sound_pitch(sfx, random_range(0.9, 1.1)); }
	return sfx;
}

function play_sfx_unique(sound)
{
	sound = get_sound(sound);
	
	if audio_is_playing(sound) { audio_stop_sound(sound); }
	return play_sfx(sound);
}

function custom_pause_bgm()
{
	if !instance_exists(game_audio) { return; }
	
	send_signal(game_audio, "custom_bgm");
	pause_bgm();
}

function custom_play_bgm(sound, gain = 1, priority = AUDIO_PRIORITY.MUSIC)
{
	if !instance_exists(game_audio) { return; }
	
	send_signal(game_audio, "custom_bgm");
	return play_bgm(sound, gain, priority);
}