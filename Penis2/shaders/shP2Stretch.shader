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

uniform float time;
uniform vec2 stretch;
uniform vec2 resolution;
uniform vec2 distortion_factor;

float make_fbm(float val, float time) {
	float fbm = 0.0;
	float freqs[4]; freqs[3] = 0.9; freqs[2] = 0.58; freqs[1] = 0.25; freqs[0] = 0.111;
	float amps[4]; amps[3] = 0.7; amps[2] = 2.458; amps[1] = 5.09; amps[0] = 0.9;
	float speeds[4]; speeds[3] = 1.2; speeds[2] = 0.8; speeds[1] = 1.8; speeds[0] = 0.5;
	for (int i = 0; i < 4; i++)
		fbm += (sin(val * freqs[i] + time * speeds[i]) * amps[i]) / 4.0;
	return fbm;
}

float invlerp(float val, float mn, float mx) {return (val - mn) / (mx - mn);}

#define AMPLIFICATION 35.0
#define SPEED 0.3
#define FREQUENCY 173.5383

void main()
{
    vec2 pos = v_vPosition;
    float x = clamp(invlerp(v_vPosition.x, stretch.x, stretch.y), 0.0, 1.0);
    pos.x -= x * (stretch.y - stretch.x);
    pos.y += make_fbm((v_vPosition.x / resolution.x) * FREQUENCY, time * SPEED) *
        mix(distortion_factor.x, distortion_factor.y, x) * AMPLIFICATION;
    gl_FragColor = texture2D(gm_BaseTexture, fract(pos / resolution));
}

