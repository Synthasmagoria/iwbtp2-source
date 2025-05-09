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

uniform vec2 px;
uniform float time;

float random(vec2 st) {return fract(sin(dot(mod(st, 10.0), vec2(58.2894, 28.483))) * 43028.49);}

float sample_value(sampler2D tex, vec2 uv) {
    vec3 col = texture2D(tex, uv).rgb;
    return (col.r + col.b + col.g) / 3.0;
}

void main()
{
    vec2 uv = v_vTexcoord;
    float val = sample_value(gm_BaseTexture, uv + random(uv + time) * px);
    float radius = 1.0 + val * 4.0;
    vec2 u = vec2(0.0, -px.y) * radius;
    vec2 d = vec2(0.0, px.y) * radius;
    vec2 l = vec2(-px.x, 0.0) * radius;
    vec2 r = vec2(px.x, 0.0) * radius;
    float val_u = sample_value(gm_BaseTexture, uv + u);
    float val_d = sample_value(gm_BaseTexture, uv + d);
    float val_l = sample_value(gm_BaseTexture, uv + l);
    float val_r = sample_value(gm_BaseTexture, uv + r);
    float dif =
        distance(val_u, val) +
        distance(val_d, val) +
        distance(val_l, val) +
        distance(val_r, val);
    float outline = step(0.1, dif);
    
    vec4 img = texture2D(gm_BaseTexture, uv);
    img.rgb = mix(
        max(vec3(0.0), img.rgb + (sin(time * 4.0 + val + uv.y) * 0.2 * val)),
        vec3(0.0),
        smoothstep(0.7, 1.0, uv.y));
    gl_FragColor = img + outline * 0.15 * (1.0 + (1.0 - val));
}

