if ( irandom_range(-100,1) )
{
	instance_create_layer(random(room_width),random(room_height),layer,obj_asteroid);		
}

shake = lerp(shake, 0, 0.1);
var shk = irandom_range(-shake*5, shake*5);
camera_set_view_pos(view_camera[0], shk, shk);

horrifi_chromaticab_strength((.25+obj_control.shake*.75)*.5);