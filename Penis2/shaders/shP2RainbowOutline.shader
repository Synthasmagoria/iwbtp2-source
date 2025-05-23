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
uniform float frequency;
uniform vec2 pixel_size;
uniform float speed;

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
    vec2 u = vec2(0.0, -pixel_size.y);
    vec2 l = vec2(-pixel_size.x, 0.0);
    vec2 d = vec2(0.0, pixel_size.y);
    vec2 r = vec2(pixel_size.x, 0.0);
    vec2 uv = v_vTexcoord;
    vec4 up = texture2D(gm_BaseTexture, uv + u);
    vec4 left = texture2D(gm_BaseTexture, uv + l);
    vec4 down = texture2D(gm_BaseTexture, uv + d);
    vec4 right = texture2D(gm_BaseTexture, uv + r);
    //vec4 upup = texture2D(gm_BaseTexture, uv + u * 2.0);
    //vec4 leftleft = texture2D(gm_BaseTexture, uv + l * 2.0);
    //vec4 downdown = texture2D(gm_BaseTexture, uv + d * 2.0);
    //vec4 rightright = texture2D(gm_BaseTexture, uv + r * 2.0);
    //vec4 up_left = texture2D(gm_BaseTexture, uv + u + l);
    //vec4 up_right = texture2D(gm_BaseTexture, uv + u + r);
    //vec4 down_left = texture2D(gm_BaseTexture, uv + d + l);
    //vec4 down_right = texture2D(gm_BaseTexture, uv + d + r);
    float outline_a = step(1.0, up.a + left.a + down.a + right.a/* + upup.a + leftleft.a + downdown.a + rightright.a*/);
    vec4 outline = vec4(hsv2rgb(vec3(fract(time * speed + (v_vPosition.x * 0.5 + v_vPosition.y) * frequency / 32.0), 0.5, 1.0)), outline_a);
    vec4 img = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = img + outline * (1.0 - img.a);
}

