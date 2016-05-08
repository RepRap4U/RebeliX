// RebeliX
//
// Drzak pro 30mm fan na chlazeni vytisku
//
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Based on "modular hotend bowden mount incl. fan duct and light" by toolson 
// http://www.thingiverse.com/thing:953811

module dual_fan_base()
{
  import("inc/Fan_duct_30x30mm_base.stl", convexity=10);
}

module dual_fan_cuts()
{
  translate([9.5,32/2,45]) rotate([0,-30,0]) cube([10,15,25],center=true);
  // Otvor pro pridelani
  translate([0,32/2,40]) rotate([0,60,0]) cylinder(r=3.2/2,h=20,$fn=16,center=true);
  translate([0,32/2,33]) rotate([0,60,0]) cylinder(r=3.2/2,h=20,$fn=16,center=true);
  translate([0,32/2,36.5]) rotate([0,60,0]) cube([6,3.2,20],center=true);
  // Zmenseni
  translate([8,32/2,59.6]) rotate([0,-30,0]) cube([40,44,20],center=true);
}

module fan_object()
{
  difference()
  {
	dual_fan_base();
	dual_fan_cuts();
  }
}

fan_object();