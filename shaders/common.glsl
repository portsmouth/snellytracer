
#extension GL_EXT_draw_buffers : require
//#extension GL_EXT_frag_depth : require
precision highp float;

#define M_PI 3.1415926535897932384626433832795

/// GLSL float point pseudorandom number generator, from
/// "Implementing a Photorealistic Rendering System using GLSL", Toshiya Hachisuka
/// http://arxiv.org/pdf/1505.06022.pdf
float rand(inout vec4 rnd) 
{
    const vec4 q = vec4(   1225.0,    1585.0,    2457.0,    2098.0);
    const vec4 r = vec4(   1112.0,     367.0,      92.0,     265.0);
    const vec4 a = vec4(   3423.0,    2646.0,    1707.0,    1999.0);
    const vec4 m = vec4(4194287.0, 4194277.0, 4194191.0, 4194167.0);
    vec4 beta = floor(rnd/q);
    vec4 p = a*(rnd - beta*q) - beta*r;
    beta = (1.0 - sign(p))*0.5*m;
    rnd = p + beta;
    return fract(dot(rnd/m, vec4(1.0, -1.0, 1.0, -1.0)));
}

/// Distance field utilities

float sdBox(vec3 X, vec3 bounds)                     
{                                     
	vec3 d = abs(X) - bounds;
		return min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0));     
} 


// Union
float opU( float d1, float d2 )
{
    return min(d1,d2);
}

// Subtraction
float opS(float A, float B)
{
    return max(-B, A);
}

// Intersection
float opI( float d1, float d2 )
{
    return max(d1,d2);
}