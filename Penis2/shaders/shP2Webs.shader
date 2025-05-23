//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform vec4 uv;
uniform sampler2D tex;
uniform vec4 tex_uv;

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

float random(vec2 st) {return fract(sin(dot(mod(st, 10.0), vec2(58.2894, 28.483))) * 43028.49);}

vec2 remap(vec2 val, vec2 src_mn, vec2 src_mx, vec2 dest_mn, vec2 dest_mx) {
	return ((val - src_mn) / (src_mx - src_mn)) * (dest_mx - dest_mn) + dest_mn;
}
vec2 invlerp(vec2 val, vec2 mn, vec2 mx) {return (val - mn) / (mx - mn);}
vec2 lerp(vec2 val, vec2 mn, vec2 mx) {return (mx - mn) * val + mn;}

void main()
{
    vec2 st = invlerp(v_vTexcoord, uv.xy, vec2(uv.z, uv.w));
    st.x = fract(st.x + random(vec2(st.y, time)) * 0.002);
    st = lerp(st, uv.xy, vec2(uv.z, uv.w));
    
	float val = texture2D(gm_BaseTexture, st).r;
	vec3 hsv = rgb2hsv(v_vColour.rgb);
	float t = time * 0.25;
	float webs = 0.0;
	for (int i = 0; i < 3; i++) {
		float tadd = float(i) * 0.33;
		float up = fract(t + tadd);
		float down = fract(t + tadd + 0.1);
		float alpha = (smoothstep(0.0, 0.1, up) - smoothstep(0.9, 1.0, up)) * (smoothstep(0.0, 0.2, down) - smoothstep(0.8, 1.0, down));
		float area = step(up, val) * step(val, down);
		webs += area * alpha;
	    hsv.r = mix(hsv.r, fract(hsv.r + sin(time * 0.2 + float(i)) * 0.1), area * alpha);
	}
	
	vec4 pattern = texture2D(tex, remap(st, uv.xy, vec2(uv.z, uv.w), tex_uv.xy, vec2(tex_uv.z, tex_uv.w)));
	gl_FragColor = vec4(hsv2rgb(hsv) * pattern.rgb, webs);
}

