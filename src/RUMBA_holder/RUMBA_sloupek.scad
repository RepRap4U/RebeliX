// RebeliX
//
// sloupek pro drzak elektroniky RUMBA
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../../configuration.scad>

length = 30;

module base()
{
  cube([length,8,7],center=true);
}

module cuts()
{
  translate([-length/2+7,0,0]) rotate([0,-90,0]) nut_hole();
  translate([length/2,0,0]) rotate([0,-90,0]) cylinder(r=2.4/2,h=20,$fn=16,center=true);
}

module nut_hole(nut_diameter=6.6)
{
	cylinder(r=nut_diameter/2,h=3,$fn=6,center=true);
    translate([15/2,0,0]) cube([15,nut_diameter*cos(30),3],center=true);
	translate([0,0,0]) cylinder(r=3.4/2,h=20,$fn=16,center=true);
}

module sloupek()
{
  difference()
  {
	base();
	cuts();
  }
}

for(i=[0:10:30])
{
  translate([0,i,0]) sloupek();
}