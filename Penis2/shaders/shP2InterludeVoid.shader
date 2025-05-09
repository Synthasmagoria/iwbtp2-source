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
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

float zigzag(float val) {return min(fract(val) * 2.0, 1.0) - max(0.0, fract(val) * 2.0 - 1.0);}

uniform vec2 void_position;
uniform float radius;
uniform float fade;
uniform float time;
uniform float amplitude;

void main()
{
    float dist = distance(void_position, v_vPosition) - sin(time * 3.14) * amplitude;
	float circle = smoothstep(fade + radius, radius, dist);
    gl_FragColor = v_vColour * circle;
}

