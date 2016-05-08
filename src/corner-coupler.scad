// RebeliX
//
// corner-coupler
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Rebel II

include <../configuration.scad>

module drazka()
{
  distance = M6_dia >= profile_nut_width ? M6_dia : profile_nut_width;
  
  translate([-30/2+4,0,0]) cylinder(r=4,h=coupler_thickness+1.5,$fn=32,center=true);
  translate([-distance/2-4,0,0]) cylinder(r=4,h=coupler_thickness+1.5,$fn=32,center=true);
  translate([-distance/4 - 7.5,0,0]) cube([7 - distance/2,8,coupler_thickness+1.5],center=true);
	
  translate([30/2-4,0,0])cylinder(r=4,h=coupler_thickness+1.5,$fn=32,center=true);
  translate([distance/2+4,0,0])cylinder(r=4,h=coupler_thickness+1.5,$fn=32,center=true);
  translate([distance/4 + 7.5,0,0]) cube([7 - distance/2,8,coupler_thickness+1.5],center=true);
}

module corner_coupler()
{
  difference()
  {
	union()
	{
	  cube([60,30,coupler_thickness]);
	  translate([15,30/2,(coupler_thickness+1.5)/2]) rotate([0,0,90]) drazka();
	  translate([45,30/2,(coupler_thickness+1.5)/2]) drazka();
	}
		
	// Otvory pro srouby
	translate([15,30/2,0])cylinder(h=20,r=M6_dia/2,$fn=32,center=true);
	translate([45,30/2,0])cylinder(h=20,r=M6_dia/2,$fn=32,center=true);
		
	// Zalomene hrany
	translate([-1,-0.1,-5]) rotate([0,-45,0]) cube([5,40,5]);
	translate([61,-0.1,-5]) rotate([0,-45,0]) cube([5,40,5]);
	translate([-0.1,-1,-5]) rotate([45,0,0]) cube([70,5,5]);
	translate([-0.1,31,-5]) rotate([45,0,0]) cube([70,5,5]);
  }
}

corner_coupler();
