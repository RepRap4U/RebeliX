// RebeliX
//
// z-bottom
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Rebel II and Prusa i3


include <../configuration.scad>

// Mezera mezi motorem a soucastkou (tlumi prenaseni vibraci)
space = 0.6;

height = motor_length + space + 6;

// Posun motoru do strany
motor_offset = 0; 

module z_bottom_base(){
 translate([0,0,0]) cube([42.3+5,42.3+z_base_offset,6]);
 translate([0,0,0]) cube([42.3+5,z_base_offset,height]);
 translate([0,0,0]) cube([5,42.3+z_base_offset,height>=34+space+6 ? 34+space+6 : height]);
 translate([2.5+21.3-4+motor_offset,-2,0]) cube([8,3,height]);
}

module z_bottom_cuts(){
 difference(){
   translate([15,10+z_base_offset,-0.1]) rotate([0,0,0]) cube([50,50,10]);
   translate([5+4.35-0.2,21.3+z_base_offset-12-0.15,-0.1]) rotate([0,0,0]) cylinder(r = 8, h = 20, $fn = 30);
 }
 translate([5+4.35-1/2,21.3+z_base_offset-12-1/2,layer_height]) rotate([0,0,45/2]) cube([10,1,10]); 
 
 translate([2.5+21.3-15+motor_offset,0,-0.1]) rotate([0,0,-220]) cube([30,15,height+1]);
 translate([2.5+21.3+15+motor_offset,0,-0.1]) rotate([0,0,-45]) cube([15,15,height+1]); 

 translate([42.3+6,6+z_base_offset,-0.1]) rotate([0,0,45]) cube([10,10,height]);
 translate([15,42.3+z_base_offset-3,-0.1]) rotate([0,0,45]) cube([10,10,height]);
 translate([-5,42.3+z_base_offset-9,-0.1]) rotate([0,0,45]) cube([20,10,height]);
 
 translate([-0.1,42.3+z_base_offset,6]) rotate([45,0,0]) cube([10,70,50]); 
 
 // Otvor pro kabely motoru  
 translate([5+21.3-5,5,height-9-4.5]) cube([10,20,30]); 
 translate([5+21.3,5,height+1]) rotate([0,45,0]) cube([5,30,5]); 
 translate([5+21.3-7,5,height+1]) rotate([0,45,0]) cube([5,30,5]);

 // Vyrez pro profilovou matku 
 translate([2.5+21.3+motor_offset,-3,(height-6)/2]) cube([10,6,profile_nut_width],center=true);
 
 // Seriznuti pro snazsi tisk
 if(profile_nut_width != 0)
 {
   translate([2.5+21.3+motor_offset - 30/2,0,(height-6)/2 + profile_nut_width/2]) rotate([180-40,0,0]) cube([30,3,8]); 
 }
}

module z_bottom_holes(){

 // Otvor pro hlazenou tyc 8mm
 translate([5+4.35-0.2,21.3+z_base_offset-12-0.15,-0.1]) rotate([0,0,0]) cylinder(r = rod_8mm_d/2, h = 20, $fn = 30);

 // Otvory pro motor
 translate([5+5.65,z_base_offset+5.65,-0.1]){
	translate([31,0,0]) cylinder(h = 20, r=1.9, $fn=30);
	translate([0,31,0]) cylinder(h = 20, r=1.9, $fn=30);
 }
 // Otvor pro prisroubovani do hlinikoveho profilu
 translate([2.5+21.3+motor_offset,z_base_offset-M6_head_height-2.5,(height-6)/2]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = 20, $fn = 30);
 translate([2.5+21.3+motor_offset,-3,(height-6)/2]) rotate([-90,0,0]) cylinder(r = M6_dia/2, h = 20, $fn = 30);
}

// Cela soucastka
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