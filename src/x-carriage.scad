// PRUSA iteration3
// x carriage
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include <../configuration.scad>
use <inc/bearing.scad>
x_rod_distance = 45;

module x_carriage_base(){
 // Small bearing holder
 translate([-33/2,+2,0]) rotate([0,0,90]) horizontal_bearing_base(1);
 hull(){
     // Long bearing holder
     translate([-33/2,x_rod_distance+2,0]) rotate([0,0,90]) horizontal_bearing_base(2);
     // Belt holder base
     translate([-36,20,0]) cube([39,16,17]);
    }
     // Base plate
 translate([-38,-11.5,0]) cube([39+4,68,7+1.5]);

}

module x_carriage_beltcut(){
 position_tweak=-1.2;
 // Cut in the middle for belt
 translate([-2.5-16.5+1,19,7]) cube([4.5,13,15]);
 // Cut clearing space for the belt
 translate([-39,5,7]) cube([50,13,15]);
 // Belt slit
 translate([-50,21.5+10,6]) cube([67,0.7,15]);
 // Smooth entrance
 translate([-56,21.7+10,16.5]) rotate([45,0,0]) cube([67,15,15]);
 // Teeth cuts
   for ( i = [0 : 33] ){											  //cube([1,1.7,15]) GT2 a cube([1.7,1.7,15]) T2.5
	translate([15-i*belt_tooth_distance+position_tweak,21.9+8,6+1.5]) cube([belt_tooth_ratio*belt_tooth_distance,1.7,15]);
   }
}

module x_carriage_holes(){
 // Small bearing holder holes cutter
  translate([-33/2,2,0]) rotate([0,0,90]) horizontal_bearing_holes(1);
 // Long bearing holder holes cutter
  translate([-33/2,x_rod_distance+2,0]) rotate([0,0,90]) horizontal_bearing_holes(2);
  // Extruder mounting holes
  translate([-16.5+15,24,-1])cylinder(r=M3_diameter/2, h=20, $fn=32);
  translate([-16.5+15,24,10])cylinder(r=M3_nut_diameter/2, h=20, $fn=6); 
  translate([-16.5-15,24,-1])cylinder(r=M3_diameter/2, h=20, $fn=32);
  translate([-16.5-15,24,10])cylinder(r=M3_nut_diameter/2, h=20, $fn=6); 	
}

module x_carriage_fancy(){
 // Top right corner
 translate([13.5,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,45]) translate([0,-15,0]) cube([30,30,20]);
 // Bottom right corner
 translate([0,5,0]) translate([0,-11.5,-1]) rotate([0,0,-45]) translate([0,-15,0]) cube([30,30,20]);
 // Bottom ĺeft corner
 translate([-33,5,0]) translate([0,-11.5,-1]) rotate([0,0,-135]) translate([0,-15,0]) cube([30,30,20]);
 // Top left corner
 translate([-33-13.5,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,135]) translate([0,-15,0]) cube([30,30,20]);	
}

// Final part
module x_carriage(){
 difference(){
  x_carriage_base();
  x_carriage_beltcut();
  x_carriage_holes();
  x_carriage_fancy();
 }
}

x_carriage();
