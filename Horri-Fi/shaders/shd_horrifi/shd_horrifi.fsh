#define SAMPLES 32.

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float enable[7];

uniform float time;
uniform float seed;
uniform float noise_strength;
uniform float chab_intensity;
uniform float vhs_strength;
uniform float scan_strength;

uniform vec2 curve;
uniform vec2 texel;
uniform vec2 vignette;
uniform vec3 bloom;

// Noise
float noise(vec2 uv)
{
	return fract(sin(uv.x*12.9898+uv.y*78.233)*43758.5453*seed*.01);
}

// VHS
vec4 vhs(vec2 uv)
{
	vec2 tcoord = uv;
	tcoord.x+=sin(time*noise(uv));
	return texture2D( gm_BaseTexture, tcoord)*vhs_strength;	
}

// Vignette
float vig(vec2 uv)
{
	uv *= 1. - uv;
	return ( pow(uv.x*uv.y*vignette.x*10.,vignette.y) );
}

// Chromatic abberation
vec3 chromatic(vec2 uv, float offset)
{
	float _r	= ( v_vColour * texture2D( gm_BaseTexture, vec2(uv.x+offset, uv.y))).r;
	float _g	= ( v_vColour * texture2D( gm_BaseTexture, uv)).g;
	float _b	= ( v_vColour * texture2D( gm_BaseTexture, vec2(uv.x-offset, uv.y))).b;
	return vec3(_r,_g,_b);
}

// Bloom
vec4 blur(vec2 uv)
{
	float total = 0.;
	float rad=1.;
	mat2 ang = mat2(.73736882209777832,-.67549037933349609,.67549037933349609,.73736882209777832);
	vec2 point = normalize(fract(cos(uv*mat2(195,174,286,183))*742.)-.5)*(bloom.x/sqrt(SAMPLES));
	vec4 amount = vec4(0);
	
	for ( float i=0.; i<SAMPLES; i++ )
	{
		point*=ang;
		rad+=1./rad;
		vec4 samp = texture2D(gm_BaseTexture, uv + point * (rad-1.) * texel);
		
		float mul = 1.;
		float lum = ( samp.r+samp.g+samp.b )/3.;
		if ( lum < bloom.z ){ mul = 0.; }
		
		amount += samp*(1./rad)*mul;
		total+=(1./rad);
	}
	amount /= total;
	return amount*bloom.y;
}

// TV Curve
vec2 crt_curve( vec2 uv )
{
	uv = uv*2.-1.;
	vec2 uvoff = abs(uv.xy) / vec2(curve.x, curve.y);
	uv = uv + uv * uvoff * uvoff;
	uv = uv * .5 + .5;
	return uv;
}

void main()
{	
	// CRT 
	vec2 mainUv = v_vTexcoord;
	if ( enable[6] == 1. ) mainUv = crt_curve(v_vTexcoord);
	
	// Base coloring
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, mainUv);
	
	// Chromatic abberation
	if ( enable[1] == 1. ) gl_FragColor.rgb = chromatic(mainUv, chab_intensity * 0.01);
	
	// Scanlines
	if ( enable[4] == 1. ) gl_FragColor.rgb *= (1.-scan_strength)+(sin(mainUv.y*1024.)*scan_strength);
	
	// Bloom
	if ( enable[0] == 1. ) gl_FragColor.rgb += blur(mainUv).rgb;
	
	// Noise
	if ( enable[2] == 1. ) gl_FragColor.rgb += noise(mainUv)*noise_strength;
	
	// VHS
	if ( enable[5] == 1. ) gl_FragColor += vhs(mainUv);
	
	// Vignette
	if ( enable[3] == 1. ) gl_FragColor.rgb *= vig(mainUv);
	
	// Cutoff edges
	if ( enable[6] == 1. )
	{
		if ( mainUv.x<0.||mainUv.y<0.||mainUv.x>1.||mainUv.y>1. )
		{
			gl_FragColor *= vec4(vec3(0.), 1.);	
		}
	}
	
}

