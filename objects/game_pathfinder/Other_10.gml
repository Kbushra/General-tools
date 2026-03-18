///@desc Methods

///@func neighbours(tile_x, tile_y)
function neighbours(tile_x, tile_y)
{
	var new_arr = [];
	
	for (var i = -1; i <= 1; i++)
	{
		for (var j = -1; j <= 1; j++)
		{
			if (i == 0 && j == 0) { continue; }
			
			var coll = !place_free(tile_size/2 + (tile_x + i) * tile_size,
			tile_size/2 + (tile_y + j) * tile_size);
			
			//Adjacent tile on X not colliding
			coll = coll || !place_free(tile_size/2 + (tile_x + i) * tile_size,
			tile_size/2 + tile_y * tile_size);
			
			//Adjacent tile on Y not colliding
			coll = coll || !place_free(tile_size/2 + tile_x * tile_size,
			tile_size/2 + (tile_y + j) * tile_size);
			
			var x_in_bounds = false;
			var y_in_bounds = false;
			x_in_bounds = tile_x + i >= 0 && tile_x + i < array_length(nodes);
			if x_in_bounds { y_in_bounds = tile_y + j >= 0 && tile_y + j < array_length(nodes[tile_x + i]); }
			
			if (x_in_bounds && y_in_bounds && !coll) { array_push(new_arr, [tile_x + i, tile_y + j]); }
		}
	}
	
	return new_arr;
}

///@func set_weights(tile_x, tile_y, neighbours)
function set_weights(tile_x, tile_y, nbs)
{
	var changed_nbs = [];
	
	for (var i = 0; i < array_length(nbs); i++)
	{
		var nb_inds = nbs[i];
		var dist_x = nb_inds[0] - tile_x;
		var dist_y = nb_inds[1] - tile_y;
		var dist = sqrt(power(dist_x, 2) + power(dist_y, 2));
		
		var final_weight = nodes[tile_x][tile_y].weight + dist;
		var targ_node = nodes[nb_inds[0]][nb_inds[1]];
		
		if (targ_node.weight != NONE && targ_node.weight <= final_weight) { continue; }
		
		if final_weight > max_weight { max_weight = final_weight; }
		
		var to_end = sqrt(power(source_tile_x - nb_inds[0], 2) + power(source_tile_y - nb_inds[1], 2));
		targ_node.weight = final_weight;
		targ_node.priority = final_weight + to_end;
		array_push(changed_nbs, nb_inds);
	}
	
	return changed_nbs;
}

///@func reset_nodes()
function reset_nodes()
{
	for (var i = 0; i < room_width/tile_size - 0.5; i++)
	{
		for (var j = 0; j < room_height/tile_size - 0.5; j++)
		{
			nodes[i][j] =
			{
				x: tile_size/2 + i*tile_size,
				y: tile_size/2 + j*tile_size,
				weight: NONE,
				priority: NONE,
				next: []
			};
		}
	}
	
	nodes[source_tile_x][source_tile_y].weight = 0;
}

///@func evaluate_weights()
function evaluate_weights()
{
	var queue = [[source_tile_x, source_tile_y]];
	
	var count = 0;
	while (array_length(queue) > 0 && count < 100)
	{
		var new_nodes = [];
	
		for (var i = 0; i < array_length(queue); i++)
		{
			var inds = queue[i];
			if point_distance(source_tile_x, source_tile_y, inds[0], inds[1]) > max_distance { continue; } 
			
			var nbs = neighbours(inds[0], inds[1]);
			var changed_nbs = set_weights(inds[0], inds[1], nbs);
			new_nodes = array_concat(new_nodes, changed_nbs);
		}
		
		queue = new_nodes;
		array_sort(queue, function(current, next)
		{
			var current_node = nodes[current[0]][current[1]];
			var next_node = nodes[next[0]][next[1]];
			return current_node.priority - next_node.priority;
		});
		
		count++;
	}
}

///@func retrace_path()
function retrace_path()
{
	for (var i = 0; i < room_width/tile_size - 0.5; i++)
	{
		for (var j = 0; j < room_height/tile_size - 0.5; j++)
		{
			if point_distance(source_tile_x, source_tile_y, i, j) > max_distance { continue; }
			
			var lowest_weight = noone; //Different from NONE so they don't clash
			var nbs = neighbours(i, j);
			var goto_ind = [];
	
			for (var k = 0; k < array_length(nbs); k++)
			{
				var current_node = nodes[nbs[k][0]][nbs[k][1]];
				if (current_node.weight > lowest_weight && lowest_weight != noone) { continue; }
				
				if current_node.weight == lowest_weight
				{ array_push(goto_ind, [current_node.x, current_node.y]); }
				else { goto_ind = [[current_node.x, current_node.y]]; }
				
				lowest_weight = current_node.weight;
			}
			
			nodes[i][j].next = goto_ind;
		}
	}
}

///@func flow_field()
function flow_field()
{
	source_tile_x = floor(source_x / tile_size);
	source_tile_y = floor(source_y / tile_size);
	
	if source_tile_x < 0 || source_tile_x > room_width/tile_size - 0.5 ||
	source_tile_y < 0 || source_tile_y > room_height/tile_size - 0.5 { exit; }
	
	if array_length(neighbours(source_tile_x, source_tile_y)) == 0 { exit; }

	reset_nodes();
	evaluate_weights();
	retrace_path();
}