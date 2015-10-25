// RebeliX
//
// x-ends
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Prusa i3 x-end

include <../configuration.scad>
use <inc/x-end.scad>

height = 58;
width = 21;
bearing_width = 5;  

module x_end_idler_base(){
 x_end_base();
}

module x_end_idler_right_holes(){
 difference(){
   x_end_holes();
   // Nabeh pro loziska idleru
   translate([-1.6-width/2-11/2-0.6,-26,30.25]) rotate([0,90,0]) cylinder(r1=5,r2=3.1,h=1);
   translate([-1.6-width/2+11/2+0.8,-26,30.25]) rotate([0,-90,0]) cylinder(r1=5,r2=3.1,h=1);
 }
 // Prisroubovani loziska 2x624
 translate([-1.6,-26,30.25]) rotate([0,-90,0]) cylinder(r=3.8,h=2,$fn=32,center=true);
 translate([-1.5-width+3.4,-26,30.25])rotate(a=[0,-90,0])cylinder(h = 3.5, r=3.9, $fn=6);
 translate([0,-26,30.25]) rotate(a=[0,-90,0]) cylinder(h = 40, r=2.2, $fn=30);
} 
 
module x_end_idler_left_holes(){
	x_end_holes();
	// Otvory pro nacvaknuti k x-motor
	translate([-width-8,-32.5+x_holder_position,height/2 + 2]){
	  translate([0,0,0]) rotate([0,90,0]) cylinder(h = 10, r=2.3, $fn=30);
	  translate([0,0,10]) rotate([0,90,0]) cylinder(h = 10, r=2.3, $fn=30);
	  translate([5,-2.3,0]) cube([5,2*2.3,10]);
	}
} 
 
 
// Prava cast
module x_end_idler_right(){
  difference(){
    x_end_idler_base();
    x_end_idler_right_holes();
  }
}

// Leva cast
module x_end_idler_left(){
  difference(){
	x_end_idler_base();
	x_end_idler_left_holes();
  }
}

x_end_idler_left();
translate([20,0,0]) mirror([1,0,0]) x_end_idler_right();

