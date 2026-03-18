print("pathfinder created");

image_alpha = 0;

tile_size = 20;
source_x = 0;
source_y = 0;
source_tile_x = floor(source_x / tile_size);
source_tile_y = floor(source_y / tile_size);

interval = 15;
max_distance = ceil((GAME_WIDTH/tile_size) / 2) + 5; //Only calculates tiles from that far away

max_weight = 1;
log = false;

event_user(0);
reset_nodes();