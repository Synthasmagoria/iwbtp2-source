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
uniform float strength;

float random(vec2 st) {return fract(sin(dot(mod(st, 10.0), vec2(58.2894, 28.483))) * 43028.49);}

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

void main(void)
{
    vec2 pos = v_vPosition;
    pos.x = floor(pos.x / 2.0) * 2.0;
    pos /= vec2(800.0, 608.0);
    
    vec4 n = vec4(0.0);
    for (int i = 0; i < 3; i++) {
        vec3 col = v_vColour.rgb;
        float f = float(i);
        
        col = rgb2hsv(col);
        col.x = fract(col.x - 0.1 * f);
        col.y = col.y + 0.05 * f;
        col.z = col.z - 0.1 * f;
        col = hsv2rgb(col);
        
        f += 1.0;
        n += vec4(col, v_vColour.a) * step(random(pos + time + vec2(f / 3.0)), (strength - 0.01) / f);
    }
    gl_FragColor = n;
}
