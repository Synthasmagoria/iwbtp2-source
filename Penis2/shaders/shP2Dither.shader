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
uniform float severity;
uniform float limiter;
uniform vec2 uv_tl;
uniform vec2 uv_br;
uniform vec2 resolution;
uniform float monochrome;

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

//#define PX 1.0 / 400.0
//#define SEVERITY 200.0
#define ITERATIONS 5
//#define LIMITER 5.0

vec2 clamp_v2(vec2 val, vec2 mn, vec2 mx) {
    return vec2(
        clamp(val.x, mn.x, mx.x),
        clamp(val.y, mn.y, mx.y));
}

void main(void)
{
    float itime = floor(time);
    vec4 img = vec4(0.0);
    
    for (int i = 1; i <= 5; i++)
    {
        float dither_x = rand(vec2(v_vTexcoord.y + itime / 2.0, v_vTexcoord.y + itime)) * (1.0 / resolution.x) * pow(abs(severity), float(i) / limiter);
        
        img += texture2D(gm_BaseTexture, vec2(clamp(v_vTexcoord.x + dither_x / 8.0, uv_tl.x, uv_br.x), v_vTexcoord.y)) *
            (1.0 - img.a) * (1.0 - (float(i) / 5.0));
    }
    
    vec4 final = img * v_vColour;
    vec3 lum = vec3(0.299, 0.587, 0.114);
    vec4 final_bw = vec4(vec3(dot(final.rgb, lum)), final.a);
    
    gl_FragColor = mix(final, final_bw, monochrome);
}
