// RebeliX
//
// heatbed-nut
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

// Prumer celeho drzadla
diameter = 16;
// Prumer zoubku na kole
tooth_diameter = 2.4;

difference(){
	cylinder(r=diameter/2,h=3.5, center=true);
	for ( i = [0 : 30 : 360] ){
	  rotate([0,0,i]){
		translate([diameter/2 + 0.2,0,0]) cylinder(r=tooth_diameter/2,h=6, $fn=16,center=true);
	  }
	}
	translate([0,0,-0.5]) cylinder(r=3.3,h=2.4,$fn=6);
	translate([0,0,0]) cylinder(r=1.7,h=10,$fn=16, center=true);
}	