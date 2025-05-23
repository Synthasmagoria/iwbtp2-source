//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec4 v_vColour;
varying vec2 v_vPosition;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vPosition = in_Position.xy;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vPosition;
varying vec4 v_vColour;

uniform float time;
uniform vec2 resolution;
//uniform sampler2D backbuffer;
uniform float reach;
uniform float color_change;
uniform float value_clip;

#define PI 3.14159

float smoothplot(float x, float y, float t, float s) {return smoothstep(x - t - s, x - t, y) - smoothstep(x + t, x + t + s, y);}

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}


float sq(float x) {
    return x*x;
}

vec2 calc2(vec2 p, float i, int j, float time) {
    return vec2(
        0.1 / (i) * sin(i * 10.0 * p.y + time + cos((time / (24. * (i + float(j) * 30.0))) * i)),
        0.1 / (i) * cos(i * 10.0 * p.x + time + sin((time / (24. * (i + float(j) * 30.0))) * i)));
}

float calc1(vec2 p, int j, float time) {
    p += calc2(p, 1.0, j, time);
    p += calc2(p, 2.0, j, time);
    p += calc2(p, 3.0, j, time);
    p += calc2(p, 4.0, j, time);
    return sin(75.0*sq(p.x)) + sin(75.0*sq(p.y));
}

void main(void)
{
    vec2 p = v_vPosition / resolution.x * 0.7;
    
    vec3 col = vec3(calc1(p, 1, time), calc1(p, 2, time), calc1(p, 3, time));

    vec2 pos = v_vPosition;
    float wav = sin(pos.x / 32.0 / PI + cos(pos.x / 24.0 + time) + time);
    float boundary_up = (608.0 - 38.0) + wav * 16.0;
    float boundary_down = 38.0  + wav * 16.0;
    float boundary = step(boundary_up, pos.y) + step(pos.y, boundary_down);
    
    float distortion = 
        smoothplot(boundary_up, pos.y, reach, 32.0) +
        smoothplot(boundary_down, pos.y, reach, 32.0);
    
    vec2 uv = v_vPosition / resolution;
    gl_FragColor = texture2D(gm_BaseTexture, fract(uv + col.xy * 0.01 * distortion));
    
    vec3 hsv = rgb2hsv(gl_FragColor.rgb);
    hsv.g += 0.5 + fract(col.b) * 0.1;
    hsv.r = fract(0.3 + fract(col.r) * color_change);
    
    hsv.b = clamp(hsv.b + fract(col.g * 2.0 - 0.5) * 0.1, 0.0, 1.0);
    float clip = smoothstep(-0.2 + value_clip, -0.01 + value_clip, hsv.b);
    hsv.b *= clip;
    
    hsv = hsv2rgb(hsv);
    
    gl_FragColor = mix(gl_FragColor, vec4(hsv, 1.0), distortion);
}
