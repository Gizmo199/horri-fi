if ( type-- > 0 )
{
	repeat(4-type)
	{	
		var ins = instance_create_layer(x, y, layer, obj_asteroid);
		ins.type = type;
		ins.spawn_speed = 10;
	}
}	