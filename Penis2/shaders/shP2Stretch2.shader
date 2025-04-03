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

uniform vec2 stretch_range;
uniform vec2 resolution;
uniform sampler2D screen_buffer;

float area(float start, float end, float val) {return step(val, end) * step(start, val);}

void main()
{
    vec2 uv = mix(
        v_vPosition / resolution,
        vec2(stretch_range.x, v_vPosition.y) / resolution,
        area(stretch_range.x, stretch_range.y, v_vPosition.x));
    gl_FragColor = texture2D(screen_buffer, uv);
}

