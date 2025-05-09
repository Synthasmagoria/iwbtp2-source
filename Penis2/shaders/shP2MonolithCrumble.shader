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

uniform sampler2D noise_tex;
uniform vec2 noise_tl;
uniform vec2 noise_br;
uniform vec2 tl;
uniform vec2 br;

uniform float crumble_factor;
uniform float crack_factor;
uniform float stain_factor;

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

void main()
{
    vec2 st = (v_vTexcoord - tl) / (br - tl);
    vec2 noise_texcoord = st * (noise_br - noise_tl) + noise_tl;
    vec4 noise = texture2D(noise_tex, noise_texcoord);
    
    float cracks = 1.0 - smoothstep(0.2, 0.0, noise.r) * (crack_factor * 2.0 + (1.0 - st.y) - 1.0);
    cracks = clamp(cracks, 0.0, 1.0);
    float crumble = step(crumble_factor, noise.g);
    float stain = 1.0 - (0.4 * step(1.0 - noise.b, stain_factor));
    
    vec4 img = texture2D(gm_BaseTexture, v_vTexcoord);
    img.rgb = img.rgb * stain;
    //img.rgb = img.rgb * (1.0 - 0.2 * stain_factor);
    img.rgb = rgb2hsv(img.rgb);
    img.g = max(img.g - 0.5 * stain_factor, 0.0);
    img.rgb = hsv2rgb(img.rgb);
    img.rgb = img.rgb * (1.0 - 0.4 * (1.0 - cracks));
    
    gl_FragColor = vec4(img.rgb * cracks, img.a * crumble);
}

