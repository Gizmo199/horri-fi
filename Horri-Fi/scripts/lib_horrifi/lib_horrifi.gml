global.__horriFi = 
{
	#region Main System
	
		enabled		: true,
		time		: 0,
		
	#endregion
	#region Parameter Structs
		// Vignette settings
		vignette :
		{
			enabled : false,
			strength : .25,
			intensity : .5
		},
		
		// Noise settings
		noise :
		{
			enabled : false,
			strength : .1
		},
		
		// Chromatic abberation settings
		chromatic_abberation : 
		{
			enabled : false,
			strength : .3
		},
		
		// Bloom
		bloom : 
		{
			enabled : false,
			radius : 8,
			intensity : 1,
			threshold : 0.8
		},
	
		// VHS Distortion
		vhs :
		{
			enabled : false,
			strength : .5
		},
	
		// Scanlines
		scanlines : 
		{
			enabled : false,
			strength : .25
		},
		
		// CRT Curve
		crt :
		{
			enabled : false,
			curve : 2
		},
	#endregion
	#region Shader Uniforms
	
		uniEnable	: shader_get_uniform(shd_horrifi, "enable"),
		uniTime		: shader_get_uniform(shd_horrifi, "time"),
		uniSeed		: shader_get_uniform(shd_horrifi, "seed"),
		uniTexel	: shader_get_uniform(shd_horrifi, "texel"),
		uniVig		: shader_get_uniform(shd_horrifi, "vignette"),
		uniNstr		: shader_get_uniform(shd_horrifi, "noise_strength"),
		uniChab		: shader_get_uniform(shd_horrifi, "chab_intensity"),
		uniBloom	: shader_get_uniform(shd_horrifi, "bloom"),
		uniScanStr	: shader_get_uniform(shd_horrifi, "scan_strength"),
		uniVhs		: shader_get_uniform(shd_horrifi, "vhs_strength"),
		uniCurve	: shader_get_uniform(shd_horrifi, "curve"),
		
	#endregion
	#region Functions
	
		render : function()
		{
			var _w, _h, _s;
			_s = surface_get_texture(application_surface);
			_w = texture_get_texel_width(_s);
			_h = texture_get_texel_height(_s);
			
			if ( !enabled ) exit;
			// Set shader
			shader_set(shd_horrifi);
		
			// Enable effects
			shader_set_uniform_f_array( uniEnable, 
				[ 
					bloom.enabled, 
					chromatic_abberation.enabled, 
					noise.enabled, 
					vignette.enabled,
					scanlines.enabled,
					vhs.enabled,
					crt.enabled
				]
			);
		
			// Set effects parameters
			shader_set_uniform_f(uniTexel, _w, _h);
			shader_set_uniform_f(uniTime, time++);
			shader_set_uniform_f(uniSeed, 1+random(100));
			shader_set_uniform_f(uniVig, vignette.intensity, vignette.strength);
			shader_set_uniform_f(uniNstr, noise.strength);
			shader_set_uniform_f(uniChab, chromatic_abberation.strength);
			shader_set_uniform_f(uniBloom, bloom.radius, bloom.intensity, bloom.threshold);
			shader_set_uniform_f(uniScanStr, scanlines.strength);
			shader_set_uniform_f(uniVhs, vhs.strength);
			shader_set_uniform_f(uniCurve, crt.curve, crt.curve);
		},
		
		// Resetting
		reset : function()
		{
			if ( enabled ) shader_reset();
		}
		
	#endregion
}

// Main functions
function horrifi_enable(onoff)
{
	///@func horrifi_enable(enable)
	global.__horriFi.enabled = onoff;
}
function horrifi_is_enabled()
{
	return global.__horriFi.enabled;
}	
function horrifi_set()
{
	global.__horriFi.render();	
}
function horrifi_reset()
{	
	global.__horriFi.reset();
}

// Bloom functions
function horrifi_bloom_enable(onoff)
{
	///@func horrifi_bloom_enable(enable)
	global.__horriFi.bloom.enabled = onoff;
}
function horrifi_bloom_radius(rad)
{
	///@func horrifi_bloom_radius(radius)
	global.__horriFi.bloom.radius = rad;
}
function horrifi_bloom_intensity(int)
{
	///@func horrifi_bloom_intensity(intensity)
	global.__horriFi.bloom.intensity = int;
}	
function horrifi_bloom_threshold(thresh)
{
	///@func horrifi_bloom_threshold(threshold)
	global.__horriFi.bloom.threshold = thresh;
}
function horrifi_bloom_is_enabled()
{
	return global.__horriFi.bloom.enabled;	
}
function horrifi_bloom_get_radius()
{
	return global.__horriFi.bloom.radius;	
}
function horrifi_bloom_get_intensity()
{
	return global.__horriFi.bloom.intensity;	
}
function horrifi_bloom_get_threshold()
{
	return global.__horriFi.bloom.threshold;	
}
function horrifi_bloom_set(e,r,i,t)
{
	///@func horrifi_bloom_set(enabled, radius, intensity, threshold)
	horrifi_bloom_enable(e);
	horrifi_bloom_radius(r);
	horrifi_bloom_intensity(i);
	horrifi_bloom_threshold(t);
}
	
// Chromatic Abberation functions
function horrifi_chromaticab_enable(onoff)
{
	///@func horrifi_chromaticab_enable(enable)
	global.__horriFi.chromatic_abberation.enabled = onoff;
}	
function horrifi_chromaticab_strength(str)
{
	///@func horrifi_chromaticab_strength(strength)
	global.__horriFi.chromatic_abberation.strength = str;
}
function horrifi_chromaticab_is_enabled()
{
	return global.__horriFi.chromatic_abberation.enabled;
}
function horrifi_chromaticab_get_strength()
{
	return global.__horriFi.chromatic_abberation.strength;	
}
function horrifi_chromaticab_set(e,s)
{
	///@func horrifi_chromaticab_set(enable, strength)
	horrifi_chromaticab_enable(e);
	horrifi_chromaticab_strength(s);
}

// Noise functions
function horrifi_noise_enable(onoff)
{
	///@func horrifi_noise_enable(enable)
	global.__horriFi.noise.enabled = onoff;
}	
function horrifi_noise_strength(str)
{
	///@func horrifi_noise_strength(strength)
	global.__horriFi.noise.strength = str;
}
function horrifi_noise_is_enabled()
{
	return global.__horriFi.noise.enabled;
}
function horrifi_noise_get_strength()
{	
	return global.__horriFi.noise.strength;
}
function horrifi_noise_set(e, s)
{
	///@func horrifi_noise_set(enable, strength)
	horrifi_noise_enable(e);
	horrifi_noise_strength(s);
}

// Vignette functions
function horrifi_vignette_enable(onoff)		
{
	///@func horrifi_vignette_enable(enable)	
	global.__horriFi.vignette.enabled=onoff
}
function horrifi_vignette_strength(str)		
{
	///@func horrifi_vignette_strength(strength)	
	global.__horriFi.vignette.strength = str;
}
function horrifi_vignette_intensity(int)	
{
	///@func horrifi_vignette_intensity(intensity)
	global.__horriFi.vignette.intensity = int;
}
function horrifi_vignette_is_enabled()		
{
	return global.__horriFi.vignette.enabled;
}
function horrifi_vignette_get_strength()	
{
	return global.__horriFi.vignette.strength;
}
function horrifi_vignette_get_intensity()	
{
	return global.__horriFi.vignette.intensity;
}
function horrifi_vignette_set(e,s,i)
{
	///@func horrifi_vignette_set(enable, strength, intensity)
	horrifi_vignette_enable(e);
	horrifi_vignette_strength(s);
	horrifi_vignette_intensity(i);
}

// VHS functions
function horrifi_vhs_enable(onoff)
{
	///@func horrifi_vhs_enable(enable)
	global.__horriFi.vhs.enabled = onoff;
}	
function horrifi_vhs_strength(str)
{
	///@func horrifi_vhs_strength(strength)
	global.__horriFi.vhs.strength = str;
}
function horrifi_vhs_is_enabled()
{
	return global.__horriFi.vhs.enabled;	
}
function horrifi_vhs_get_strength()
{
	return global.__horriFi.vhs.strength;	
}
function horrifi_vhs_set(e,s)
{
	///@func horrifi_vhs_set(enable, strength)
	horrifi_vhs_enable(e);
	horrifi_vhs_strength(s);
}

// Scanlines functions
function horrifi_scanlines_enable(onoff)
{
	///@func horrifi_scanlines_enable(enable)
	global.__horriFi.scanlines.enabled = onoff;
}	
function horrifi_scanlines_strength(str)
{
	///@func horrifi_scanlines_strength(strength)
	global.__horriFi.scanlines.strength = str;
}
function horrifi_scanlines_is_enabled()
{
	return global.__horriFi.scanlines.enabled;	
}
function horrifi_scanlines_get_strength()
{
	return global.__horriFi.scanlines.strength;	
}
function horrifi_scanlines_set(e,s)
{
	///@func horrifi_scanlines_set(enable, strength)
	horrifi_scanlines_enable(e);
	horrifi_scanlines_strength(s);
}

// CRT functions
function horrifi_crt_enable(onoff)
{
	///@func horrifi_crt_enable(enable)
	global.__horriFi.crt.enabled = onoff;
}	
function horrifi_crt_curve(str1)
{
	///@func horrifi_crt_curve(strength)
	global.__horriFi.crt.curve = str1;
}
function horrifi_crt_is_enabled()
{
	return global.__horriFi.crt.enabled;	
}
function horrifi_crt_get_curve()
{
	return global.__horriFi.crt.curve;	
}
function horrifi_crt_set(e,s1)
{
	///@func horrifi_crt_set(enable, curve)
	horrifi_crt_enable(e);
	horrifi_crt_curve(s1);
}