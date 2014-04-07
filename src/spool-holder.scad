// RebeliX
//
// spool holder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Rebel II

include <../configuration.scad>

height = 105;
thickness = 25;
width = height;

module drzak_zakladna(){
  translate([0,0,0]) cube([width,height,thickness]);
  translate([width-15-4,-2,0]) cube([8,3,thickness]);
}

module drzak_rezy(){
  translate([width-30,0,-0.1]) rotate([0,0,130]) cube([200,width,40]);
  translate([-0.1,10,6]) cube([width,height,40]);
  intersection(){
    translate([width,10,-0.1]) rotate([0,0,40]) cube([height,height+35,40]);
    translate([30,0,-0.1]) cube([width,height+0.1,40]);
  }
  // Otvor pro sroub M6
  translate([width-15,7,15]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30);
  translate([width-15,-4,15]) rotate([-90,0,0]) cylinder(r = 3.05, h = 20, $fn = 30);
  // Otvor pro tyc M8
  translate([15,height-5,-0.1]) cylinder(r = 4.2, h = 20, $fn = 30);
  translate([15-4.2,height-5,-0.1]) cube([8.4,10,20]);
  // Setreni plastem
  translate([width-30,15,-0.1]) rotate([0,0,40]) cube([10,height-15,20]);
 }

// Cela soucastka
module drzak_civky(){
 translate([-60,70,0]) rotate([0,0,-40]) 
 difference(){
   drzak_zakladna();
   drzak_rezy();
   
 }
 translate([-25,80,0]) rotate([0,0,-140]) mirror([1,0,0]) difference(){
  drzak_zakladna();
  drzak_rezy();
 }
}

drzak_civky();
