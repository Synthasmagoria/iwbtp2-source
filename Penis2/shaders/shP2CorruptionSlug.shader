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
uniform vec2 uv_tl;
uniform vec2 uv_br;
uniform float frequency;
uniform float amplitude;

void main(void)
{
    vec2 pos = (v_vTexcoord - uv_tl) / (uv_br - uv_tl) * 2.0 - 1.0;
    pos.y += sin(pos.x * 3.14 * frequency + time) * 0.15 * amplitude;
    vec2 apos = abs(pos);
    float limit_x = (1.0 - pow(apos.x * 1.1, 1.7)) * 0.5;
    float distortion_area = smoothstep(0.0, limit_x, apos.y) * step(apos.y, limit_x);
    
    gl_FragColor = vec4(vec3(distortion_area), ceil(distortion_area)) * v_vColour;
}
