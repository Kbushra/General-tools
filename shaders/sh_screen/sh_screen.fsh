//
// bm_screen
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D surf;

uniform vec2 surf_res;
uniform vec2 padding;

float screen(float channel1, float channel2)
{
	return 1.0 - (2.0 * (1.0 - channel1) * (1.0 - channel2));
}

void main()
{
	vec2 normalised_pos = (gl_FragCoord.xy - padding) / surf_res;
	
	if (normalised_pos.x < 0.0 || normalised_pos.x > 1.0 ||
	normalised_pos.y < 0.0 || normalised_pos.y > 1.0)
	{
	    discard;
	}
	
	vec4 tex1 = texture2D(surf, normalised_pos);
	vec4 tex2 = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	gl_FragColor = vec4(screen(tex1.r, tex2.r), screen(tex1.g, tex2.g),
		screen(tex1.b, tex2.b), tex2.a);
}