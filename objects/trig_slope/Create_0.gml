points =
[
	{
		x : x + rotate_vector(0, sprite_height, image_angle).x,
		y : y + rotate_vector(0, sprite_height, image_angle).y
	},
	{
		x : x + rotate_vector(sprite_width, sprite_height, image_angle).x,
		y : y + rotate_vector(sprite_width, sprite_height, image_angle).y
	},
	{
		x : x + rotate_vector(sprite_width, 0, image_angle).x,
		y : y + rotate_vector(sprite_width, 0, image_angle).y
	}
];