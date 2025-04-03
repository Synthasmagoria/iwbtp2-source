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

float random(vec2 st) {return fract(sin(dot(mod(st, 10.0), vec2(58.2894, 28.483))) * 43028.49);}

#define DITHER_FACTOR 0.03
#define DISAPPEARANCE_RATE 0.2

void main()
{
    vec2 uv = v_vTexcoord;
    float r = random(vec2(uv.y, time));
    uv.x += (r * 2.0 - 1.0) * DITHER_FACTOR * random(uv + time);
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, uv) - step(1.0 - DISAPPEARANCE_RATE, r) * 0.005;
}

