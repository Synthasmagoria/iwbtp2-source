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

uniform sampler2D backbuffer;
uniform sampler2D noise_tex;
uniform vec2 noise_tl;
uniform vec2 noise_br;
uniform float time;

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

void main()
{
    vec4 slugs = texture2D(gm_BaseTexture, v_vTexcoord);
    vec4 result = vec4(vec3(1.0), (slugs.r + slugs.g + slugs.b) / 3.0);
    
    vec2 noise_sample = fract(v_vPosition / 256.0) * (noise_br - noise_tl) + noise_tl;
    vec4 n = texture2D(noise_tex, noise_sample);
    vec2 distortion_dir = vec2(n.r, n.b) * 2.0 - 1.0;
    float distortion_amplitude = (1.0 - slugs.r) * slugs.a * 0.2;
    
    vec4 screen = texture2D(backbuffer, fract(v_vTexcoord + distortion_dir * distortion_amplitude));
    
    vec3 distorted_col = rgb2hsv(screen.rgb);
    distorted_col.r = fract(distorted_col.r + slugs.a * 4.0 * sin((v_vTexcoord.x + v_vTexcoord.y + n.x + n.y) + time));
    distorted_col.g += min(distorted_col.g + slugs.a * 6.0, 1.0);
    distorted_col.b += min(distorted_col.b + slugs.a * 3.0, 1.0);
    screen.rgb = mix(screen.rgb, hsv2rgb(distorted_col), (1.0 - slugs.r) * slugs.a * 2.0);
    
    gl_FragColor = screen * (1.0 - result.a) + vec4(result.rgb * result.a, result.a);
}

