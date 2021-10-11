# horri-fi
A Lo-Fi Horror shader for Game Maker Studio 2

Using Horri-Fi is simple and easy to use! Here is how quick you can set everything up!

1.) Create event of our 'render' object put this:

	horrifi_enable(true);

	horrifi_bloom_set(true,26.56,0.30,0.72);
	horrifi_chromaticab_set(true,0.64);
	horrifi_scanlines_set(true,0.10);
	horrifi_vhs_set(true,0.10);
	horrifi_vignette_set(true,0.30,0.87);
	horrifi_crt_set(false,2);
	horrifi_noise_set(true,0.17);
	
2.) In the 'Draw GUI' event of our 'render' object put this:

	horrifi_set();
	draw_surface(application_surface, 0, 0);
	horrifi_reset();
	
3.) Thats it! Play around with the different parameters using 'horrifi_*ELEMENT_set()'! 

Horri-Fi includes many 7 different 'elements' to the shader that you can easily toggle
on or off as well as dynamically change any value using the set functions! These include:

-Scanlines
-Noise
-VHS distortion
-Bloom
-Vignette
-Chromatic abberation
-CRT TV curve

Special thanks to Xor for his inspiriation and incredible shader knowledge!
Without him this shader wouldn't be possible so make sure to follow/like/and donate to him:

Twitter: @XorDev
Website: gmshaders.com
Ko-fi: https://ko-fi.com/xor
YT: https://www.youtube.com/c/XorDev
