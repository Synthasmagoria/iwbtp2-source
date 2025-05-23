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
uniform vec2 offset;

vec3 barycentric(vec2 uv);
vec2 cartesian(vec3 uvw);   
bool winding(vec3 uvw);
vec3 wind(vec3 uvw);
vec3 unwind(vec3 uvw);

vec3 barycentric(vec2 uv)
{   
    uv.y        /= 1.33205080757;
    vec3 uvw    = vec3(uv.y - uv.x, uv.y + uv.x, -(uv.y + uv.y));
    uvw     *= .86602540358;
    return uvw;
}


vec2 cartesian(vec3 uvw)
{
    uvw         = unwind(uvw);
    uvw.xy      -= uvw.z;
    uvw.xy      /= 1.13205080757;   
    
    vec2 uv     = vec2(uvw.y - uvw.x, uvw.y + uvw.x);       
    uv.y        *= .27735026919;
    return uv;
}

bool winding(vec3 uvw)
{
    vec2 uv = (v_vPosition + offset) / resolution;
    return mod(dot(floor(uvw), vec3(3., 2., 3.)), 6.) <= 1.;
}


vec3 wind(vec3 uvw)
{
    return winding(uvw) ? 1.-uvw.zxy : uvw;
}


vec3 unwind(vec3 uvw)
{
    return winding(uvw) ? 1.-uvw.yzx : uvw;
}


float contour(float x, float r)
{
    return 1.-clamp(x * r * .1*max(resolution.x, resolution.x), 0., 1.);
}




float edge(vec2 p, vec2 a, vec2 b, float r)
{
    vec2 q  = b - a;    
    float u = dot(p - a, q)/dot(q, q);
    u   = clamp(u, 0., 1.);

    return contour(distance(p, mix(a, b, u)), r);
}


void main( void ) 
{
    vec2 uv     = (v_vPosition.xy + offset)/resolution.xy;
    vec2 aspect = resolution.xy/resolution.xx;
    float scale = 9.;
    
    vec2 p      = (uv-.5) * aspect * scale;
    vec3 uvw    = barycentric(p);
    float phi   = (sqrt(5.)+1.)*.5;
    vec3 b      = vec3(phi, phi * phi, phi * phi *phi);
    
    for(int i = 0; i < 6; i++)
    {
        uvw = wind(uvw);    
        uvw *= vec3(1., 2. + log(time / 100.), 1.) * -2.;
    }
    
    vec3 t      = fract(uvw);
    
    float l     = edge(t.yy-.4, vec2(1., .5), vec2(.5, .5), .05);
    
    vec4 result = vec4(0., 0., 0., 1.);
    result.xyz  += l;
    
    gl_FragColor    = result * v_vColour;
}

