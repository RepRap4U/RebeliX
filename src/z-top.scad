// RebeliX
//
// z top
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Rebel II and Prusa i3

include <../configuration.scad>

height = 50;

module z_top_base()
{
  translate([z_motor_offset,0,0]) cube([37.3,8,height]);
  translate([0,0,0]) cube([3.5+5.65 + 31/2,32,8]);
  translate([0,0,0]) cube([2*7.65,32,12]);
  translate([0,0,0]) cube([30,8,12]);
  translate([3.5+4.35+14.45-4+z_motor_offset,-2,31]) cube([8,3,height-31]);
  translate([3.5+4.35+14.45-15+z_motor_offset,-2,15-4]) cube([30,3,8]); 
  translate([3.5+4.35-0.2,21.3+z_base_offset-12-0.15,29/2]) cylinder(r = 7.65, h = 29, $fn = 50,center=true);
  translate([3.5+4.35-0.2,(21.3+z_base_offset-12-0.15)/2,29/2]) cube([5,21.3+z_base_offset-12-0.15,29],center=true);
  translate([3.5+5.65 + 31/2, z_base_offset+5.65 + 31/2,8/2]) cylinder(r=19/2, h=8, $fn=64,center=true);
  translate([3.5+5.65 + 31/2, z_base_offset+5.65 + 31/2,8 + 0.5/2 ]) cylinder(r1=19/2, r2 = 18/2, h=9 - 8.5  , $fn=64,center=true);
}

module z_top_cuts(){
 // Vyrez pro stahnuti
 translate([3.5+4.35-0.2+1/2,8+16,layer_height]) rotate([0,0,90]) cube([10,1,30]); 
 
 // Seriznuti pro snazsi tisk
 translate([3.5+4.35+14.45-15+z_motor_offset,0,15-4]) rotate([180 - 40,0,0]) cube([30,3,8]);
 translate([3.5+4.35+14.45-15+z_motor_offset,0,31]) rotate([180 - 40,0,0]) cube([30,3,8]);
 if(profile_nut_width != 0)
 {
   translate([3.5+4.35+14.45-15+z_motor_offset,0,height-10+profile_nut_width/2]) rotate([180 - 40,0,0]) cube([30,3,8]); 
 }   
 // Seriznute hrany
 translate([3.5+4.35+14.45-15+z_motor_offset,-0.1,height-3]) rotate([0,-45,0]) cube([10,10,10]);
 translate([3.5+4.35+14.45+15+z_motor_offset,-0.1,height-3]) rotate([0,-45,0]) cube([10,10,10]);
 translate([0,32-0.6,-0.1]) rotate([0,0,45]) cube([10,10,20]); 
    
 translate([0,32,12-0.6]) rotate([45,0,0]) cube([20,32,5]);    
    
 translate([-1,-4,-0.1]) rotate([0,0,45]) cube([5,5,height]); 
 translate([z_motor_offset,9,12]) rotate([0,-12,180]) cube([10,10,60]);  
 
 // Vyrez pro profilovou matku
 translate([3.5+4.35+14.45+z_motor_offset,-3,15]) cube([profile_nut_width,6,10],center=true);
 translate([3.5+4.35+14.45+z_motor_offset,-3,height-10]) cube([10,6,profile_nut_width],center=true);
}

module z_top_holes(){
 // Otvory pro prisroubovani do hlinikoveho profilu
 translate([3.5+4.35+14.45+z_motor_offset,8-M6_head_height,15]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30);
 translate([3.5+4.35+14.45+z_motor_offset,8-M6_head_height,height-10]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30);		
 translate([3.5+4.35+14.45+z_motor_offset,-3,15]) rotate([-90,0,0]) cylinder(r = M6_dia/2, h = 10, $fn = 30);
 translate([3.5+4.35+14.45+z_motor_offset,-3,height-10]) rotate([-90,0,0]) cylinder(r = M6_dia/2, h = 10, $fn = 30);
 // Otvor pro hlazenou tyc 8mm
 translate([3.5+4.35-0.2,21.3+z_base_offset-12-0.15,-0.1]) rotate([0,0,0]) cylinder(r = rod_8mm_d/2, h = 80, $fn = 50,center=true);

 // Jisteni M8 tyce
 translate([-0.1,27,12/2]) rotate([0,90,0])
 {   
   translate([0,0,0])cylinder(r=1.7,h=8,$fn=16); 
   translate([0,0,0])cylinder(r=1.2,h=17,$fn=16);   
   translate([0,0,-2]) cylinder(r=3.1, h=4,$fn=16);
 } 
 
 // Vyrez pro ochranu M5 tyce 
 translate([3.5+5.65 + 31/2, z_base_offset+5.65 + 31/2,0]) cylinder(r=12/2, h=40, $fn=64,center=true); 
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
