// RebeliX
//
// z top
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Rebel II and Prusa i3

include <../configuration.scad>

height = 50;

 // Hodnota musi byt stejna i v z_bottom
base_offset = 11;

// Posun motoru do strany
motor_offset = 0;

module z_top_base(){
 translate([motor_offset,0,0]) cube([37.3,8,height]);
 translate([0,0,0]) cube([2*7.65,32,12]);
 translate([18,0,0]) rotate([0,0,45]) cube([10,20,8]);
 translate([0,0,0]) cube([30,8,12]);
 translate([3.5+4.35+14.45-4+motor_offset,-2,31]) cube([8,3,height-31]);
 translate([3.5+4.35+14.45-15+motor_offset,-2,15-4]) cube([30,3,8]); 
}

module z_top_cuts(){
 // Vyrez pro stahnuti
 translate([3.5+4.35-0.2+1/2,8+16,layer_height]) rotate([0,0,90]) cube([10,1,10+7]); 
 
 // Seriznuti pro snazsi tisk
 translate([3.5+4.35+14.45-15+motor_offset,0,15-4]) rotate([160,0,0]) cube([30,3,8]);
 translate([3.5+4.35+14.45-15+motor_offset,0,31]) rotate([160,0,0]) cube([30,3,8]); 
    
 // Seriznute hrany
 translate([3.5+4.35+14.45-15+motor_offset,-0.1,height-3]) rotate([0,-45,0]) cube([10,10,10]);
 translate([3.5+4.35+14.45+15+motor_offset,-0.1,height-3]) rotate([0,-45,0]) cube([10,10,10]);
 translate([0,32-0.6,-0.1]) rotate([0,0,45]) cube([10,10,20]); 
 translate([2*7.65,32-0.6,-0.1]) rotate([0,0,45]) cube([10,10,20]); 
 translate([2*7.65,8,12-0.6]) rotate([0,-45,0]) cube([10,32,10]);
 translate([0,8,12-0.6]) rotate([0,-45,0]) cube([10,32,10]); 
    
 translate([0,32,12-0.6]) rotate([45,0,0]) cube([15,32,10]);    
    
 translate([-1,-4,-0.1]) rotate([0,0,45]) cube([5,5,height]); 
 translate([motor_offset,9,12]) rotate([0,-12,180]) cube([10,10,60]);   
}

module z_top_holes(){
 // Otvory pro prisroubovani do hlinikoveho profilu
 translate([3.5+4.35+14.45+motor_offset,8-M6_head_height,15]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30);
 translate([3.5+4.35+14.45+motor_offset,8-M6_head_height,height-10]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30);		
 translate([3.5+4.35+14.45+motor_offset,-3,15]) rotate([-90,0,0]) cylinder(r = 3.05, h = 10, $fn = 30);
 translate([3.5+4.35+14.45+motor_offset,-3,height-10]) rotate([-90,0,0]) cylinder(r = 3.05, h = 10, $fn = 30);
 // Otvor pro hlazenou tyc 8mm
 translate([3.5+4.35-0.2,21.3+base_offset-12-0.15,-0.1]) rotate([0,0,0]) cylinder(r = rod_8mm_d/2, h = 40, $fn = 50,center=true);

 // Jisteni M8 tyce
 translate([-0.1,27,12/2]) rotate([0,90,0]){   
   translate([0,0,15/2+4]) rotate([0,0,90]) cylinder(r=3.3,h=30,$fn=6); 
   cylinder(r=1.7,h=30,$fn=16);    
   cylinder(r=3.1, h=4,$fn=16);
 }    
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
