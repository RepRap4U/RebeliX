// RebeliX
//
// spool-bearing
// GNU GPL v3
// Martin Neruda
// http://www.reprap4u.cz

height = 15;

difference(){
	union(){
		cylinder(r=7.5, h=height, $fn=60, center=true);
		translate([0,0,-height/2]) cylinder(r=14, h=2, $fn=60);
	}
	cylinder(r=4.3, h=height+1, $fn=40,center=true);
}	