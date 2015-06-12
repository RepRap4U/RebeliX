// RebeliX
//
// z bottom
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Rebel II and Prusa i3


include <../configuration.scad>

// Space between stepper and the part (less vibrations)
space = 0.6;

height = motor_length + space;

// Same value as in z_top (minimum 13)
base_offset = 13; 

// Stepper side offset
motor_offset = 0; 

module z_bottom_base(){
 translate([0,0,0]) cube([42.3+5,42.3+base_offset,6]);
 translate([0,0,0]) cube([42.3+5,base_offset,height<=34+space ? 34+space+6 : height+6]);
 translate([0,0,0]) cube([5,42.3+base_offset,(height>=34+space)||(height<=34+space) ? 34+space+6 : height+6]);
 translate([2.5+21.3-4+motor_offset,-2,0]) cube([8,3,height<=34+space ? 34+space+6 : height+6]);
}

module z_bottom_cuts(){
 translate([15,10+base_offset,-0.1]) rotate([0,0,0]) cube([50,50,10]);
 translate([7.5,21.3+base_offset-0.5,layer_height]) cube([10,1,10]); 
 
 translate([2.5+21.3-15+motor_offset,0,-0.1]) rotate([0,0,-220]) cube([30,15,height<=34+space ? 34+space+8 : height+8]);
 translate([2.5+21.3+15+motor_offset,0,-0.1]) rotate([0,0,-45]) cube([15,15,height<=34+space ? 34+space+8 : height+8]); 

 translate([42.3+6,6+base_offset,-0.1]) rotate([0,0,45]) cube([10,10,height+8]);
 translate([15,42.3+base_offset-3,-0.1]) rotate([0,0,45]) cube([10,10,height+8]);
 translate([-5,42.3+base_offset-9,-0.1]) rotate([0,0,45]) cube([20,10,height+8]);
 
 translate([-0.1,42.3+base_offset,6]) rotate([45,0,0]) cube([10,70,50]); 
 
 // Stepper wires hole
 //translate([5+21.3-5,5,height+6-7]) cube([10,30,30]); 
 translate([5+21.3-5,5,height+6-9]) cube([10,20,30]); 
 translate([5+21.3,5,height<=34+space ? 34+space+7 : height+7]) rotate([0,45,0]) cube([5,30,5]); 
 translate([5+21.3-7,5,height<=34+space ? 34+space+7 : height+7]) rotate([0,45,0]) cube([5,30,5]);
}

module z_bottom_holes(){

 // M8 rod hole
 translate([5+4.35,21.3+base_offset,-0.1]) rotate([0,0,0]) cylinder(r = M8_smooth_rod_diameter_catch/2, h = 20, $fn = 30);

 // Stepper hole
 translate([5+5.65,base_offset+5.65,-0.1]){
	translate([0,0,0]) cylinder(h = 20, r=M3_diameter/2, $fn=16);
	translate([31,0,0]) cylinder(h = 20, r=M3_diameter/2, $fn=16);
	translate([0,31,0]) cylinder(h = 20, r=M3_diameter/2, $fn=16);
 }
 // ALU mount holes
 translate([2.5+21.3+motor_offset,base_offset-M6_head_height-2.5,height/2]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = 20, $fn = 30);
 translate([2.5+21.3+motor_offset,-3,height/2]) rotate([-90,0,0]) cylinder(r = M6_diamater_horizontal/2, h = 20, $fn = 30);
}

// Whole part
module z_bottom(){
 difference(){
  z_bottom_base();
  z_bottom_cuts();
  z_bottom_holes();
 }
 translate([0,-13,0]) mirror([0,1,0]) difference(){
  z_bottom_base();
  z_bottom_cuts();
  z_bottom_holes();
 }
}

z_bottom();
