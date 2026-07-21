print("save created--------------------------------------------------------------------");

image_alpha = 0;
event_user(0);

global.save = load_json_safe();
global.config = load_json_safe(CONFIG_NAME, default_config());