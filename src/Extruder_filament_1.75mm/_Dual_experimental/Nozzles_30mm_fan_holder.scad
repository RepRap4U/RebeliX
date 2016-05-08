// RebeliX
//
// Drzak na dva hotendy pro 30mm fan
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <settings.scad>

extrusion_width = 0.6;

HE_l = 25;

nozzle_position = nozzle_distance/2 >= HE_d/2 ? nozzle_distance/2 : HE_d/2;

module nozzles_fan_base()
{
	// Chladice 1
	translate([-nozzle_position,0,0]) cylinder(r=HE_d/2 + width,h=HE_l + 0.6,$fn=64,center=true);
	// Chladice 2
	translate([nozzle_position,0,0]) cylinder(r=HE_d/2 + width,h=HE_l + 0.6,$fn=64,center=true);
	// Fan 30x30 mm
	translate([0,HE_d/2,0]) cube([30,10,HE_l + 5],center=true);
}

module nozzles_fan_cuts()
{
	// Chladice 1
	translate([-nozzle_position,0,2*extrusion_width]) HE();
	// Chladice 2
	translate([nozzle_position,0,2*extrusion_width]) HE();
	// Vnitrni vyrez
	translate([0,0,2*extrusion_width]) cube([nozzle_distance,HE_d,HE_l],center=true);
	
	// Vyrez pro ventilator
	hull()
	{
	  intersection()
	  {
	    translate([0,HE_d/2 + 10/2,0]) rotate([90,0,0]) cylinder(r=15,h=2,$fn=64,center=true);
	    translate([0,HE_d/2 + 10/2,0]) cube([30 - 5*extrusion_width ,2,30 - 5*extrusion_width],center=true);
	  }
	  intersection()
	  {
	    translate([0,HE_d/2 + 1.5 ,0]) rotate([90,0,0]) cylinder(r=14.5,h=1,$fn=64,center=true);
	    translate([0,HE_d/2 + 1.5,0]) cube([28,1,HE_l - 5*extrusion_width],center=true);
	  }
	}
	intersection()
	{
	  translate([0,HE_d/2 - 0.3 ,0]) rotate([90,0,0]) cylinder(r=14.5,h=4,$fn=64,center=true);
	  translate([0,HE_d/2 - 0.3,0]) cube([HE_l + 3,4,HE_l - 5*extrusion_width],center=true);
	}
	// Seriznuti drzaku
	translate([0,-HE_d + 4,0]) cube([100,HE_d,HE_l + 1],center=true);
	
	translate([-100/2,HE_d/2 + 0.8,-HE_l/2]) rotate([180,0,0]) cube([100,HE_d,HE_l]);
	translate([-100/2,HE_d/2 + 0.8,HE_l/2]) rotate([90,0,0]) cube([100,HE_d,HE_l]);
	
	translate([-100/2,HE_d/2 + 0.8,-HE_l/2]) rotate([180 + 55,0,0]) cube([100,HE_d,HE_l]);
	translate([-100/2,HE_d/2 + 0.8,HE_l/2]) rotate([35,0,0]) cube([100,HE_d,HE_l]);
	
	translate([25/2,13,25/2]) rotate([90,0,0]) cylinder(r=1,h=5,$fn=16,center=true);
	translate([25/2,13,-25/2]) rotate([90,0,0]) cylinder(r=1,h=5,$fn=16,center=true);
	translate([-25/2,13,25/2]) rotate([90,0,0]) cylinder(r=1,h=5,$fn=16,center=true);
	translate([-25/2,13,-25/2]) rotate([90,0,0]) cylinder(r=1,h=5,$fn=16,center=true);
}

module HE()
{
  difference()
  {
    union()
	{
      cylinder(r=HE_d/2 + 0.01 - 0.1,h=HE_l,$fn=64,center=true);
      cylinder(r=7/2,h=HE_l + 20,$fn=64,center=true);
      translate([0,-20/2,0]) cube([7,20,HE_l + 20],center=true);
	}
	difference()
	{
	  translate([0,0,-HE_l/2 + 3.5/2 + 9.4 + extrusion_width]) cylinder(r=HE_d/2 + 1,h=3.5,$fn=64,center=true);
	  translate([0,0,-HE_l/2 + 3.5/2 + 9.4 + extrusion_width]) cylinder(r=HE_d/2 - 1,h=4,$fn=64,center=true);
	}
  }	
}


module nozzles_fan_30mm()
{
  difference()
  {
	nozzles_fan_base();
	nozzles_fan_cuts();
  }
}

rotate([-90,0,0]) 
nozzles_fan_30mm();

