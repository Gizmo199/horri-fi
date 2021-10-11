angle += angle_rot;
spawn_speed = lerp(spawn_speed, 1, 0.2);
speed = spd * spawn_speed;

if ( point_in_circle(mouse_x, mouse_y, x, y, size*type*2) && mouse_check_button_pressed(mb_left) )
{
	instance_destroy();
	
	obj_control.shake = 5;
	score++;
}	

alpha = lerp(alpha, 1, 0.08);