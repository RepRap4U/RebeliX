// RebeliX
//
// x-carriage-dual
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Prusa i3 x carriage

include <../configuration.scad>
use <inc/bearing.scad>

x_rod_distance = 45;

// Sirka extruderu
part_width = 52;

// Vertikalni korekce
v_corr = 0.65;


module x_carriage_base(){
 // Dolni drzak lozisek
 translate([0,-v_corr,0]) rotate([0,0,90]) horizontal_bearing_base(2);
 // Horni drzak lozisek
 translate([0,x_rod_distance,0]) rotate([0,0,90]) horizontal_bearing_base(2);
 // Drzak remenu
 translate([-part_width/2,17,0]) cube([part_width,21,17]);
 // Zakladna
 translate([-part_width/2,-12,0]) cube([part_width,69,7+1.5]);
 // Zobacek pro pridelani extruderu
 translate([-25,x_rod_distance+12,0]) cube([50,2,2.5]);

}

module x_carriage_beltcut(){
 position_tweak=-1.5;
 // Cut in the middle for belt
 translate([-3/2,13,10.5]) cube([3,16,15]);
 // Cut clearing space for the belt
 translate([-35,7.5,7]) cube([70,11,15]);
 translate([-35,0,8.5]) cube([70,11,15]);
 translate([-35,8,7]) rotate([45,0,0]) cube([70,11,15]);
 // Belt slit
 translate([-30,x_rod_distance-17.75+1.5,10.5]) cube([60,0.9,15]); //puvodne 0.8
 // Smooth entrance
 translate([-34,x_rod_distance-17.75+1.8+0.2,16.2]) rotate([45,0,0]) cube([68,15,15]);
 // Teeth cuts
   for ( i = [0 : 33] ){
	translate([35-i*belt_tooth_distance+position_tweak,x_rod_distance-17.75+1.5-1.6,10.5]) cube([belt_tooth_ratio*belt_tooth_distance,1.7,15]);
   }
}

module x_carriage_holes(){
  // Long bottom bearing holder holes cutter
  translate([0,-v_corr,0]) rotate([0,0,90]) horizontal_bearing_holes(2);
  // Long top bearing holder holes cutter
  translate([0,x_rod_distance,0]) rotate([0,0,90]) horizontal_bearing_holes(2);
  // Zarez pro pridelani extruderu
  translate([-40,x_rod_distance+12-30,-0.1]) cube([80,3.7,2.6]);
  // Extruder mounting holes
  translate([0,x_rod_distance+12-34,-0.1]){
	translate([5,0,0])cylinder(r=1.7, h=20, $fn=32);
	translate([5,0,10])rotate([0,0,30]) cylinder(r=3.3, h=20, $fn=6);
	translate([20,0,0])cylinder(r=1.7, h=20, $fn=32);
	translate([20,0,10]) rotate([0,0,30]) cylinder(r=3.3, h=20, $fn=6);
  }
  translate([0,x_rod_distance+12-34,-0.1]){
	translate([-5,0,0])cylinder(r=1.7, h=20, $fn=32);
	translate([-5,0,10]) rotate([0,0,30]) cylinder(r=3.3, h=20, $fn=6);
	translate([-20,0,0])cylinder(r=1.7, h=20, $fn=32);
	translate([-20,0,10]) rotate([0,0,30]) cylinder(r=3.3, h=20, $fn=6);
  }
}

module x_carriage_fancy(){
 // Horni pravy roh
 translate([part_width/2,x_rod_distance+12-2.5,-0.1]) rotate([0,0,45]) cube([30,30,20]);
 // Horni levy roh
 translate([-part_width/2,x_rod_distance+12-2.5,-0.1]) rotate([0,0,45]) cube([30,30,20]);
 // Dolni pravy roh
 translate([part_width/2,-12+3.5-v_corr,-0.1]) rotate([0,0,-135]) cube([30,30,20]);
 // Dolni levy roh
 translate([-part_width/2,-12+3.5-v_corr,-0.1]) rotate([0,0,-135]) cube([30,30,20]);
 // Setreni plastem
 translate([-part_width/2,17,15]) rotate([45,0,0]) cube([part_width,10,10]);
 translate([-part_width/2-1.5,17,15]) rotate([0,-40,0]) cube([10,40,10]);
 translate([part_width/2+1.5,17,15]) rotate([0,-50,0]) cube([10,40,10]);
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
