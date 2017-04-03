// RebeliX
//
// x_carrige_cable_holder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>
include <inc/functions.scad>

length = 35;

module holder_base()
{
  translate([2,0,0]) rounded_box(8,32,10,3,0,0,1,1);
  translate([length/2,0,0]) rounded_box(length,17,10,3,0,0,1,1);
}

module holder_cuts()
{
  // Otvory pro souby
  for(i=[10,-10])
  {
    translate([0,i,0]) rotate([0,90,0]) cylinder(r=3.2/2, h=20, $fn=16,center=true);
    translate([6/2 + 40/2 - 3,i,0]) rotate([0,90,0]) cylinder(r=6/2, h=40, $fn=16,center=true);
  }
  
  // Vyrez pro kabely
  translate([10,0,10/2]) rotate([0,90 - 5,0]) cylinder(r=10/2, h=60, $fn=32,center=true);
  
  // Otvory pro zip pasky
  for(i=[6:12:30])
  {
    translate([i,0,2]) rotate([0,90 - 0,0]) zip_paska(6);
  }
}

module x_carrige_cable_holder()
{
  difference()
  {
    holder_base();
    holder_cuts();
  }
}

x_carrige_cable_holder();