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
float mod289_f(in float x) {
  return x - floor(x * (1. / 289.)) * 289.;
}

vec2 mod289_v2(in vec2 x) {
  return x - floor(x * (1. / 289.)) * 289.;
}

vec3 mod289_v3(in vec3 x) {
  return x - floor(x * (1. / 289.)) * 289.;
}

vec4 mod289_v4(in vec4 x) {
  return x - floor(x * (1. / 289.)) * 289.;
}

float permute_f(in float x) {
     return mod289_f(((x * 34.) + 1.)*x);
}

vec3 permute_v3(in vec3 x) {
  return mod289_v3(((x*34.0)+1.0)*x);
}

vec4 permute_v4(in vec4 x) {
     return mod289_v4(((x * 34.) + 1.)*x);
}

float taylorInvSqrt_f(in float r) {
  return 1.79284291400159 - 0.85373472095314 * r;
}

vec4 taylorInvSqrt_v4(in vec4 r) {
  return 1.79284291400159 - 0.85373472095314 * r;
}

float snoise(in vec3 v) {
    const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
    const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

    // First corner
    vec3 i  = floor(v + dot(v, C.yyy) );
    vec3 x0 =   v - i + dot(i, C.xxx) ;

    // Other corners
    vec3 g = step(x0.yzx, x0.xyz);
    vec3 l = 1.0 - g;
    vec3 i1 = min( g.xyz, l.zxy );
    vec3 i2 = max( g.xyz, l.zxy );

    //   x0 = x0 - 0.0 + 0.0 * C.xxx;
    //   x1 = x0 - i1  + 1.0 * C.xxx;
    //   x2 = x0 - i2  + 2.0 * C.xxx;
    //   x3 = x0 - 1.0 + 3.0 * C.xxx;
    vec3 x1 = x0 - i1 + C.xxx;
    vec3 x2 = x0 - i2 + C.yyy; // 2.0*C.x = 1/3 = C.y
    vec3 x3 = x0 - D.yyy;      // -1.0+3.0*C.x = -0.5 = -D.y

    // Permutations
    i = mod289_v3(i);
    vec4 p = permute_v4( permute_v4( permute_v4(
                i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
            + i.y + vec4(0.0, i1.y, i2.y, 1.0 ))
            + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));

    // Gradients: 7x7 points over a square, mapped onto an octahedron.
    // The ring size 17*17 = 289 is close to a multiple of 49 (49*6 = 294)
    float n_ = 0.142857142857; // 1.0/7.0
    vec3  ns = n_ * D.wyz - D.xzx;

    vec4 j = p - 49.0 * floor(p * ns.z * ns.z);  //  mod(p,7*7)

    vec4 x_ = floor(j * ns.z);
    vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)

    vec4 x = x_ *ns.x + ns.yyyy;
    vec4 y = y_ *ns.x + ns.yyyy;
    vec4 h = 1.0 - abs(x) - abs(y);

    vec4 b0 = vec4( x.xy, y.xy );
    vec4 b1 = vec4( x.zw, y.zw );

    //vec4 s0 = vec4(lessThan(b0,0.0))*2.0 - 1.0;
    //vec4 s1 = vec4(lessThan(b1,0.0))*2.0 - 1.0;
    vec4 s0 = floor(b0)*2.0 + 1.0;
    vec4 s1 = floor(b1)*2.0 + 1.0;
    vec4 sh = -step(h, vec4(0.0));

    vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
    vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;

    vec3 p0 = vec3(a0.xy,h.x);
    vec3 p1 = vec3(a0.zw,h.y);
    vec3 p2 = vec3(a1.xy,h.z);
    vec3 p3 = vec3(a1.zw,h.w);

    //Normalise gradients
    vec4 norm = taylorInvSqrt_v4(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
    p0 *= norm.x;
    p1 *= norm.y;
    p2 *= norm.z;
    p3 *= norm.w;

    // Mix final noise value
    vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
    m = m * m;
    return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1),
                                dot(p2,x2), dot(p3,x3) ) );
}

float snoise_repeated(vec3 st, vec2 off_step, int iter) {
	float n = 0.0;
	for (int i = 0; i < iter; i++) {
		float f = float(i) + 1.0;
		n += (1.0 / f) * snoise(vec3(st.xy * pow(2.0, f) - off_step * f, st.z));
	}
	return n;
}

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

varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform vec2 center;
uniform float time;
uniform float hollow_factor;
uniform vec2 image_scale;

#define CLOUD_LAYER_SPACING 2.0
#define CLOUD_LAYER_FADE 6.0
#define HUE_CHANGE -0.1

void main()
{
	float t = time * 0.5;
	
    vec2 off = vec2(1.3, 1.7);
	float r = 15.0;
	vec2 pos = (v_vPosition - center) * (1.0/image_scale) + center;
	vec2 dir = normalize(pos - center);
	float dist = distance(center, pos);
	
	vec3 middle_color = rgb2hsv(v_vColour.rgb);
	middle_color = hsv2rgb(vec3(fract(middle_color.r - 0.1 * 3.0), middle_color.gb));
	float middle_alpha = 1.0 - min(hollow_factor, 1.0);
	vec4 col = vec4(middle_color, smoothstep(r - 3.0, 0.0, dist) * middle_alpha);
	
	for (int i = 2; i >= 0; i--) {
		float f = float(i);
		float cir = smoothstep(
			r - f * CLOUD_LAYER_SPACING,
			r - f * CLOUD_LAYER_SPACING - CLOUD_LAYER_FADE,
			dist);
		vec2 pos_distortion = dir * (1.0 - cir) * 0.3;
		vec2 uv = (pos - center) / 32.0;
		uv = uv + vec2(t * 0.25, 0.0) + pos_distortion;
		float n = snoise_repeated(vec3(uv * (f * 0.25 + 1.0) + 50.0 * f, t * 0.75), vec2(1.3, 1.7), 3);
		vec4 ncol = vec4((n * 0.5 + 0.5) * v_vColour.rgb, cir * smoothstep(0.0, 0.5, n));
		ncol.rgb = rgb2hsv(ncol.rgb);
		ncol.r = fract(ncol.r + HUE_CHANGE * f);
		ncol.rgb = hsv2rgb(ncol.rgb);
		float a = 1.0 - clamp(hollow_factor - (3.0 - f), 0.0, 1.0);
		ncol.a *= a;
		col = col * (1.0 - ncol.a) + ncol;
	}
	
	gl_FragColor = col;
}
