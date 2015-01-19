// RebeliX
//
// spool bearing
// GNU GPL v3
// Martin Neruda
// http://www.reprap4u.cz

height = 15;

difference(){
	cylinder(r=7.5, h=height, $fn=60, center=true);
	translate([0,0,-0.1]) cylinder(r=4.5, h=30, $fn=40,center=true);
}	