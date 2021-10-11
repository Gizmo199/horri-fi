repeat(irandom_range(15,20))
{
	instance_create_layer(random(room_width),random(room_height),layer,obj_asteroid);	
}

view_visible[0]=true;
view_enabled[0]=true;
view_set_hport(view_camera[0], room_height);
view_set_wport(view_camera[0], room_width);

shake = 0;
