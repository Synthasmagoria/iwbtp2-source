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
uniform vec4 uvs;
uniform vec2 pixel;

#define WAVE 25.0
#define SHADOW 0.3

vec3 hsv2rgb(vec3 c) {
  vec4 K = vec4(3. / 3., 2. / 3., 1. / 3., 3.);
  vec3 p = abs(fract(c.xxx + K.xyz) * 6. - K.www);
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

void main() {
	
	vec2 uv = v_vTexcoord;
	
	// Stop waving at the pole
	float factor = min((uv.x - uvs.r) / (uvs.b - uvs.r) * 4.0, 1.0);
	
	// 
	uv.y += sin(-time + uv.x * 32.0) * pixel.y * WAVE * factor;
	
	// Manual texture interpolation because why not?
	vec4 img = 
		texture2D(gm_BaseTexture, uv) +
		texture2D(gm_BaseTexture, uv + pixel) +
		texture2D(gm_BaseTexture, uv - pixel) +
		texture2D(gm_BaseTexture, uv + vec2(pixel.x, -pixel.y)) +
		texture2D(gm_BaseTexture, uv + vec2(-pixel.x, pixel.y));
	img /= 5.0;
	
	img.rgb = rgb2hsv(img.rgb);
	img.rgb = hsv2rgb(vec3(img.r, img.g, max(img.b + min(cos(-time + uv.x * 32.0) * SHADOW, 0.0), 0.0)));
	
	// Shadow on the flag
	// img.rgb *= 1.0 + min(cos(time + uv.x * 32.0) * SHADOW, 0.0);
	
	// Calculate where to cut off the texture
	float cut = step(uvs.r, uv.x) * step(uv.x, uvs.b) * step(uvs.g, uv.y) * step(uv.y, uvs.a);
	
	gl_FragColor = v_vColour * img * cut;
}
