type = 3;
size = 10;
angle = 0;
angle_rot = random_range(-5, 5);
direction = random(360);
spd = random_range(.25, 1.5);

spawn_speed = 1;

point = [];

var quality = irandom_range(5,10);
var dir = 0;
var increase = 360/quality;

for ( var i=0; i<quality; i++ )
{
	point[i]=
	{ 
		dis : other.size*random_range(.5,1.5),
		pdir : dir
	}	
	dir += increase;
}

alpha = 0;