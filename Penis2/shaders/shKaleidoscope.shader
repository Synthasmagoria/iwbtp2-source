//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_vPosition = in_Position.xy;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//


#define PI05 1.57079
#define PI 3.14159
#define TAU 6.28318
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform vec4 uvs;
uniform float time;

vec2 cartesian_to_polar(vec2 cartesian) {return vec2(atan(cartesian.y, cartesian.x), length(cartesian));}
float cartesian_to_angle(vec2 cartesian) {return atan(cartesian.y, cartesian.x);}
vec2 polar_to_cartesian(vec2 polar) {return vec2(cos(polar.x), sin(polar.y)) * polar.y;}
vec2 angle_to_cartesian(float angle) {return vec2(cos(angle), sin(angle));}

vec2 make_kaleidoscope(vec2 polar, float n, float bias) {
	float slice = PI / n;
	polar.x = mix(fract(polar.x), 1.0 - fract(polar.x), mod(floor(polar.x), 2.0)) * slice;
	return vec2(cos(polar.x + bias), sin(polar.x + bias)) * polar.y;
}

void main() {
    vec2 pos = (v_vTexcoord - uvs.xy) / (vec2(uvs.z, uvs.w) - uvs.xy) * 2.0 - 1.0;
    vec2 kalpos = make_kaleidoscope(cartesian_to_polar(pos), 5.0, time);
    vec2 uv = (kalpos * 0.5 + 0.5) * (vec2(uvs.z, uvs.w) - uvs.xy) + uvs.xy;
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, uv);
}

