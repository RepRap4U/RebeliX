// RebeliX
//
// profile cover
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

difference(){
	union(){
		cube([30,30,4*layer_height]);
		translate([15-4.75,15-4.75,0]) cube([9.5,9.5,5]);
	}	
	// Pitch
	translate([0,15-5,4.7]) rotate([45,0,0]) cube([40,3,3]);
	translate([0,15+5,4.7]) rotate([45,0,0]) cube([40,3,3]);
	translate([15-5,0,4.7]) rotate([45,0,90]) cube([40,3,3]);
	translate([15+5,0,4.7]) rotate([45,0,90]) cube([40,3,3]);
}	
