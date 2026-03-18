print("audio created");

image_alpha = 0;

areaMusic = NONE;

emitterBGM = audio_emitter_create();
emitterSFX = audio_emitter_create();

busBGM = audio_bus_create();
busSFX = audio_bus_create();

audio_emitter_bus(emitterBGM, busBGM);
audio_emitter_bus(emitterSFX, busSFX);

ini_open("options.ini");
audio_emitter_gain(emitterBGM, ini_read_real("audio", "bgm volume", 1));
audio_emitter_gain(emitterSFX, ini_read_real("audio", "sfx volume", 1));
ini_close();

log = false;
if !variable_global_exists("debugMute") global.debugMute = false;

event_user(0);