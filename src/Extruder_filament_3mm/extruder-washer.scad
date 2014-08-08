// RebeliX
//
// extruder washer
// GNU GPL v3
// Martin Neruda
// http://www.reprap4u.cz

//height = 3.2;
//height = 2;
//height = 3.5;
height = 3.8;

difference(){
	cylinder(r=8.5, h=height, $fn=60);
	translate([0,0,-0.1]) cylinder(r=4.3, h=4, $fn=40);
}	