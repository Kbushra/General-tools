//
// bm_overlay
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D surf;
uniform vec2 surf_res;

float overlay(float channel1, float channel2)
{
	if (channel1 < 0.5) { return 2.0 * channel1 * channel2; }
	else { return 1.0 - (2.0 * (1.0 - channel1) * (1.0 - channel2)); }
}

void main()
{
	vec2 normalised_pos = gl_FragCoord.xy / surf_res;
	vec4 tex1 = texture2D(surf, normalised_pos);
	vec4 tex2 = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	gl_FragColor = vec4(overlay(tex1.r, tex2.r), overlay(tex1.g, tex2.g),
		overlay(tex1.b, tex2.b), tex2.a);
}