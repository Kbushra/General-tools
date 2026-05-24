//
// bm_multiply
//
float multiply(float channel1, float channel2)
{
	return channel1 * channel2;
}

varying vec2 v_vPosition;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D surf;
uniform vec2 surf_res;
uniform vec2 cam_pos;

void main()
{
	vec2 normalised_pos = (v_vPosition - cam_pos) / surf_res;
    
    if (normalised_pos.x < 0.0 || normalised_pos.x > 1.0 ||
    normalised_pos.y < 0.0 || normalised_pos.y > 1.0)
    {
        discard;
    }
	
	vec4 tex1 = texture2D(surf, normalised_pos);
	vec4 tex2 = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	gl_FragColor = vec4(multiply(tex1.r, tex2.r), multiply(tex1.g, tex2.g),
		multiply(tex1.b, tex2.b), multiply(tex1.a, tex2.a));
}