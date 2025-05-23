//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vPosition;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vPosition = in_Position.xy;
    v_vColour = in_Colour;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~/*
    Cool (but currently unfeasible) ideas:
    - Add a faint glow to each of the lines and make it pulse to the beat
    - Actually pass the audio spectrum to the shader to animate the line more
*/

float plot(float x, float y, float t) {
    t /= 2.0;
    return step(x, y + t) - step(x, y - t);
}

float smoothplot(float x, float y, float t, float s) {
    t /= 2.0;
    s /= 2.0;
    return smoothstep(x - t - s, x - t, y) - smoothstep(x + t, x + t + s, y);
}

float zigzag(float val) {return min(fract(val) * 2.0, 1.0) - max(0.0, fract(val) * 2.0 - 1.0);}

float random(vec2 st) {return fract(sin(dot(mod(st, 10.0), vec2(58.2894, 28.483))) * 43028.49);}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

#define PI 3.14159
#define TAU 6.28318

/*
    In case this shader is too heavy on the hardware you can decrease the line count.
    When you do you might wanna up the final amplitude uniform value to 1.0 though.
    Also, you'll have to remove the extra hardcoded array entries
*/
#define LINES 12

varying vec2 v_vPosition;
varying vec4 v_vColour;

uniform float time;
uniform float amplitude; // 0.8
uniform float offset;
uniform float opacity_add; // 0.0 - 0.7
uniform float saturation; // 0.75
uniform vec2 hue_range;
uniform float glow_opacity; // 0.1 - 0.2

void main(void)
{
    vec2 pos = v_vPosition;
    
    // temporary offset for the visualization (now permanent lol)
    pos.x -= 400.0;
    pos.x *= 2.0;
    pos.x += 400.0;
    pos.x += -offset;
    
    // does hardcoding random values actually help performance?
    //float rand_amp[LINES] = float[](
    //    0.9708, 0.7456, 0.9483, 0.8731, 0.6506, 0.7692, 0.6810, 0.6398, 0.9062, 0.6501, 0.8262, 0.6506);
    //float line_rand[LINES] = float[](
    //    0.0058, 0.8213, 0.4903, 0.0407, 0.0522, 0.1407, 0.9150, 0.0377, 0.2036, 0.8549, 0.3092, 0.3654);
    float rand_amp[LINES];
    rand_amp[0] = 0.9708;
    rand_amp[1] = 0.7456;
    rand_amp[2] = 0.9483;
    rand_amp[3] = 0.8731;
    rand_amp[4] = 0.6506;
    rand_amp[5] = 0.7692;
    rand_amp[6] = 0.6810;
    rand_amp[7] = 0.6398;
    rand_amp[8] = 0.9062;
    rand_amp[9] = 0.6501;
    rand_amp[10] = 0.8262;
    rand_amp[11] = 0.6506;
    
    float line_rand[LINES];
    line_rand[0] = 0.0058;
    line_rand[1] = 0.8213;
    line_rand[2] = 0.4903;
    line_rand[3] = 0.0407;
    line_rand[4] = 0.0522;
    line_rand[5] = 0.1407;
    line_rand[6] = 0.9150;
    line_rand[7] = 0.0377;
    line_rand[8] = 0.2036;
    line_rand[9] = 0.8549;
    line_rand[10] = 0.3092;
    line_rand[11] = 0.3654;
    
    vec4 col = vec4(0.0);
    
    for (int i = 0; i < LINES; i++)
    {
        float line_fraction = float(i) / float(LINES);
        float wav_amp = smoothstep(0.0, 1.0, amplitude * 1.2 + line_fraction * 0.2 - 0.2);
        
        float line_sat = smoothstep(0.0, 1.0, saturation * 1.6 + line_fraction * 0.6 - 0.6);
        vec3 line_col = hsv2rgb(vec3(fract(hue_range.x + zigzag(time * 0.1 + line_fraction) * hue_range.y), line_sat * 0.4, 1.0));
    
        float zig_amplitude = sin(8.0 + line_rand[i] * 6.0 + time * 2.0 + pos.x / 32.0) * 32.0 + 8.0;
        zig_amplitude *= rand_amp[i];
        float zig_frequency = pos.x / (48.0 + sin(pos.x / 48.0 + time) * 2.0);
        zig_frequency *= rand_amp[LINES - i - 1];
        float zig = zigzag((time * (1.0 + 3.0 * (line_rand[i] * 0.25 + 0.75))) + zig_frequency) * zig_amplitude;
        
        float wav_time = time * (line_rand[i] * 0.25 + 0.75) * 2.0;
        float wav_falloff_falloff = sin(wav_time + line_fraction * TAU) * 0.5 + 0.5;
        float wav_falloff = smoothplot(pos.x, 400.0, 0.0, 1600.0) * wav_falloff_falloff * wav_amp;
        float wav = sin(pos.x / 800.0 * PI) * 425.0 * wav_falloff;
        
        float line = plot(pos.y + zig, 80.0 + wav, 2.0);
        float line_glow = (smoothplot(pos.y + zig, 80.0 + wav, 2.0, 64.0) - line) * glow_opacity;
        col += vec4((line + line_glow) * line_col, line + line_glow);
    }
    
    col.a /= 4.0 - opacity_add;
    
    gl_FragColor = col * v_vColour;
}

