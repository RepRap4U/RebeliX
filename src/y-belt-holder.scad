// PRUSA iteration3
// y-belt-holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include <../configuration.scad>

height = 14;

module belt_holder_base(){
 translate([-33-8.5,0,-1]) cube([33,15,height]); 
 //translate([-33-8.5,11,-1]) cube([33,15,16]);
 translate([-33-8.5,11,-1]) cube([33,25,height]);
 //translate([-50,22,-1]) cube([50,4,16]);
 translate([-51,29,-1]) cube([52,7,height]); 
}

module belt_holder_beltcut(){
 echo(belt_tooth_ratio*belt_tooth_distance);
 position_tweak=-1.1;
 // Belt slit
 translate([-66,-0.5+10,height/2 - 3.2 -1]) cube([67,0.55+0.20,15]);
 // Smooth insert cutout
 translate([-66,-0.5+10,height-3]) rotate([45,0,0]) cube([67,15,15]);
 // Individual teeth
for ( i = [0 : 23] ){
  translate([0-i*belt_tooth_distance+position_tweak,-0.5+8.5,height/2 - 3.2 -1]) cube([belt_tooth_ratio*belt_tooth_distance,1.7,15]);
 }
 // Middle opening
 translate([-2-25,-1,height/2 - 3.2 - 1]) cube([4,11,15]);	
 
 translate([-33-8.5+33/2-20/2,17,-2]) cube([20,13,20]);
}

module belt_holder_holes(){
 translate([-4.5,0.1,height/2 - 1]) rotate([-90,0,0]) cylinder(h=50, r=1.7, $fn=16);
 translate([-45.5,0.1,height/2 - 1]) rotate([-90,0,0]) cylinder(h=50, r=1.7, $fn=16);
 // Vyrez pro hlavicku M3 sroubku
 translate([-4.5,32,height/2 - 1]) rotate([90,0,0]) cylinder(h=50, r=3.8, $fn=32);
 translate([-45.5,32,height/2 - 1]) rotate([90,0,0]) cylinder(h=50, r=3.8, $fn=32);
}

// Final part
module belt_holder(){
 difference(){
  belt_holder_base();
  belt_holder_beltcut();
  belt_holder_holes();
 }
}

belt_holder();