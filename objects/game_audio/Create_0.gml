print("audio created");

image_alpha = 0;

area_music = NONE;

emitter_bgm = audio_emitter_create();
emitter_sfx = audio_emitter_create();

bus_bgm = audio_bus_create();
bus_sfx = audio_bus_create();

audio_emitter_bus(emitter_bgm, bus_bgm);
audio_emitter_bus(emitter_sfx, bus_sfx);

log = false;
if !variable_global_exists("debugMute") global.debugMute = false;

event_user(0);