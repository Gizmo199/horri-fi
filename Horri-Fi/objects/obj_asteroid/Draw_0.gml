draw_set_color(c_white);
draw_set_alpha(alpha);
for ( var i=0; i<array_length(point); i++ )
{
	var li = i-1;
	if ( i == 0 ) { li = array_length(point)-1; }
	
	point[i].x = dcos(point[i].pdir+angle)*point[i].dis * type;
	point[i].y= dsin(point[i].pdir+angle)*point[i].dis * type;
	point[li].x = dcos(point[li].pdir+angle)*point[li].dis * type;
	point[li].y = dsin(point[li].pdir+angle)*point[li].dis * type;
	
	draw_line(x + point[i].x, y + point[i].y, x + point[li].x, y + point[li].y);
}
draw_set_alpha(1);