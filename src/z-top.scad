// RebeliX
//
// z top
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Rebel II and Prusa i3

include <../configuration.scad>

height = 50;

 // Hodnota musi byt stejna i v z_bottom (minimum 13)
base_offset = 13;

// Posun motoru do strany
motor_offset = 0;

module z_top_base(){
 translate([3.5+4.35+14.45-15+motor_offset,0,0]) cube([30,8,height]);
 translate([0,0,0]) cube([15,30+base_offset,6]);
 translate([0,0,0]) cube([3.5,22+base_offset,7+6]);
 translate([15,8,0]) cube([10,10,6]);
 translate([0,0,0]) cube([30,ALU_cut_width_horizontal,6+20]);
 translate([3.5+4.35+14.45-ALU_cut_width_horizontal/2+motor_offset,-2,31]) cube([ALU_cut_width_horizontal,3,height-31]);
 translate([3.5+4.35+14.45-15+motor_offset,-2,15-ALU_cut_width_horizontal/2]) cube([30,3,ALU_cut_width_horizontal]); 
}

module z_top_cuts(){
 translate([3.5+4.35+14.45-15+motor_offset,-0.1,6+20]) rotate([0,-135,0]) cube([10,10,30]);
 translate([-0.1,22+base_offset,6]) rotate([45,0,0]) cube([10,10,20]);
 translate([0,38+base_offset-12,-0.1]) rotate([0,0,45]) cube([10,10,10]);
 translate([15,38+base_offset-12,-0.1]) rotate([0,0,45]) cube([10,10,10]);
 translate([7.5,21.3+base_offset-0.5,layer_height]) cube([10,1,10]); 
 translate([-1,-4,-0.1]) rotate([0,0,45]) cube([5,5,height]);

 translate([3.5+4.35+14.45-15+motor_offset,-0.1,height-3]) rotate([0,-45,0]) cube([10,10,10]);
 translate([3.5+4.35+14.45+15+motor_offset,-0.1,height-3]) rotate([0,-45,0]) cube([10,10,10]);
 
 translate([25,8,-0.1]) rotate([0,0,45]) cube([10,14,10]); 
 
 // Seriznuti pro snazsi tisk
 translate([3.5+4.35+14.45-15+motor_offset,0,15-4]) rotate([160,0,0]) cube([30,3,8]);
 translate([3.5+4.35+14.45-15+motor_offset,0,31]) rotate([160,0,0]) cube([30,3,8]); 
}

module z_top_holes(){
 // Otvory pro prisroubovani do hlinikoveho profilu
 translate([3.5+4.35+14.45+motor_offset,8-M6_head_height,15]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30);
 translate([3.5+4.35+14.45+motor_offset,8-M6_head_height,height-10]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30);		
 translate([3.5+4.35+14.45+motor_offset,-3,15]) rotate([-90,0,0]) cylinder(r = M6_diamater_horizontal/2, h = 10, $fn = 30);
 translate([3.5+4.35+14.45+motor_offset,-3,height-10]) rotate([-90,0,0]) cylinder(r = M6_diamater_horizontal/2, h = 10, $fn = 30);
 // Otvor pro hlazenou tyc 8mm
 translate([3.5+4.35,21.3+base_offset,layer_height]) rotate([0,0,0]) cylinder(r = M8_smooth_rod_diameter_catch/2, h = 20, $fn = 30);
}

// Cela soucastka
module z_top(){
 difference(){
  z_top_base();
  z_top_cuts();
  z_top_holes();
 }
 
 translate([0,-13,0]) mirror([0,1,0]) difference(){
  z_top_base();
  z_top_cuts();
  z_top_holes();
 }
}

z_top();
