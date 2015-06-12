// RebeliX
//
// heatbed nut
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

// Diameter of the whole holder
diameter = 16;
// Tooth diameter
tooth_diameter = 2.4;

difference(){
	union(){
		cylinder(r=diameter/2,h=3, center=true);
		translate() cylinder(r=5, h=2, $fn = 30);
	}
	for ( i = [0 : 30 : 360] ){
		translate([sin(i)*diameter/2,cos(i)*diameter/2,-3]) cylinder(r=tooth_diameter/2,h=6, $fn=16);
	}
	translate([0,0,-1.6]) cylinder(r=M3_nut_diameter/2,h=2.4,$fn=6);
	translate([0,0,0.8+layer_height]) cylinder(r=M3_diameter/2,h=5,$fn=16);
}	
