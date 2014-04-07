// RebeliX
//
// cable_holder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

width = 13;
height = 7;

// Vyrez v hlinikovem profilu
space = 8.2;

difference(){
  union(){
	cube([width,2*extrusion_width,height]);
	translate([width/2 - space/2+0.1,2*extrusion_width,0]) cube([2*extrusion_width,2*extrusion_width+2.2,height]);
	translate([width/2 + space/2 - 2*extrusion_width-0.1,2*extrusion_width,0]) cube([2*extrusion_width,2*extrusion_width+2.2,height]);

	translate([width/2 - space/2 + 2*extrusion_width+0.1,2*extrusion_width + 2.4 + 2*extrusion_width,0]) rotate([0,0,-180]) cube([2.5,2*extrusion_width,height]);
	translate([width/2 + space/2 - 2*extrusion_width-0.1,2*extrusion_width + 2.4,0]) cube([2.5,2*extrusion_width,height]);
	}
	// Seriznuti "pacicek"
	translate([0,2*extrusion_width,-0.1]) rotate([0,0,57]) cube([width,width,width]);
	translate([width,2*extrusion_width,-0.1]) rotate([0,0,33]) cube([width,width,width]);
}	

