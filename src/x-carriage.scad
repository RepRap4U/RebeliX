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
v_corr = 0.65;//0.65

// Prumer ocek pro pridelani extruderu
extr_mount_diam = 9;

module screw_hole(m3_head_diameter=6){
	cylinder(r=m3_head_diameter/2,h=10,$fn=32);
	translate([0,0,0.001]) rotate([180,0,0]) cylinder(r=1.6,h=20,$fn=16,center=true);
}

module x_carriage_base(){
 // Dolni drzak lozisek
 translate([0,-v_corr,0]) rotate([0,0,90]) horizontal_bearing_base(2);
 // Horni drzak lozisek
 translate([0,x_rod_distance,0]) rotate([0,0,90]) horizontal_bearing_base(2);
 // Drzak remenu
 translate([-part_width/2,17,0]) cube([part_width,21,17]);
 // Zakladna
 translate([-part_width/2,-12,0]) cube([part_width,69,7+1.5]);
 // Ouska pro pridelani dual extruderu
 for(i=[-1,1]){
   translate([i*(part_width/2 - extr_mount_diam/2),x_rod_distance+12 + 3,7/2]) cylinder(r=extr_mount_diam/2,h=7,$fn=32,center=true);
   translate([i*(part_width/2 - extr_mount_diam/2),x_rod_distance+12 + 3/2,7/2]) cube([extr_mount_diam,3,7],center=true);
   
   translate([i*(part_width/2 - extr_mount_diam/2 + 2),-12-v_corr,7/2]) cylinder(r=extr_mount_diam/2 -2,h=7,$fn=32,center=true);
 }
 translate([0,x_rod_distance+12 + 3,7/2]) cube([part_width-extr_mount_diam,extr_mount_diam,7],center=true);
 translate([0,-12-v_corr,7/2]) cube([part_width-extr_mount_diam + 4,extr_mount_diam - 4,7],center=true);
}

module x_carriage_beltcut(){
 position_tweak=-1.5;
 // Vyrez pro zbytek remenu
 translate([-3/2,13,10.5]) cube([3,16,15]);
 // Vyrez pro volny pohyb remenu
 translate([-35,7.5,7]) cube([70,11,15]);
 translate([-35,0,8.5]) cube([70,11,15]);
 translate([-35,8,7]) rotate([45,0,0]) cube([70,11,15]);
 // Vyrez pro remen
 translate([-30,x_rod_distance-17.75+1.5,10.5]) cube([60,0.9,15]); //puvodne 0.8
 // Nabeh pro snadnejsi zasunuti remenu
 translate([-34,x_rod_distance-17.75+1.8+0.2,16.2]) rotate([45,0,0]) cube([68,15,15]);
 // Zuby
   for ( i = [0 : 33] ){
	translate([35-i*belt_tooth_distance+position_tweak,x_rod_distance-17.75+1.5-1.6,10.5]) cube([belt_tooth_ratio*belt_tooth_distance,1.7,15]);
   }
}

module x_carriage_holes(){
  // Vyrez pro spodni dve LM8UU loziska
  translate([0,-v_corr,0]) rotate([0,0,90]) horizontal_bearing_holes(2);
  // Vyrez pro horni dve LM8UU loziska
  translate([0,x_rod_distance,0]) rotate([0,0,90]) horizontal_bearing_holes(2);
  // Zarez pro pridelani extruderu
  translate([-40,x_rod_distance+12-30,-0.1]) cube([80,4,2.6]);
  // Otvory pro pridelani extruderu
  translate([0,x_rod_distance+12-34,-0.1]){
	translate([8,0,0])cylinder(r=1.7, h=20, $fn=32);
	translate([8,0,10])rotate([0,0,30]) cylinder(r=3.3, h=20, $fn=6);
	translate([20,0,0])cylinder(r=1.7, h=20, $fn=32);
	translate([20,0,10]) rotate([0,0,30]) cylinder(r=3.3, h=20, $fn=6);
  }
  translate([0,x_rod_distance+12-34,-0.1]){
	translate([-8,0,0])cylinder(r=1.7, h=20, $fn=32);
	translate([-8,0,10]) rotate([0,0,30]) cylinder(r=3.3, h=20, $fn=6);
	translate([-20,0,0])cylinder(r=1.7, h=20, $fn=32);
	translate([-20,0,10]) rotate([0,0,30]) cylinder(r=3.3, h=20, $fn=6);
  }
  
 for(i=[-1,1])
 {
   translate([-i*(part_width/2 - extr_mount_diam/2),x_rod_distance+12 + 3,3]) screw_hole();
   translate([-i*(part_width/2 - extr_mount_diam - 9),x_rod_distance+12 + 6,8/2]) rotate([0,0,0]) zip_paska(5);
   translate([-i*(part_width/2 - extr_mount_diam - 9),x_rod_distance+12 + 10.5,8/2]) rotate([0,0,0]) cylinder(r=6.5,h=30,$fn=32,center=true);
   translate([-i*(part_width/2 - extr_mount_diam - 9 - 6.5),x_rod_distance+12 + 10.5,8/2]) cube([2*6.5,2*6.5,30],center=true);
   
   translate([-i*(part_width/2 - extr_mount_diam - 4.5),-12 - 1 - v_corr,8/2]) rotate([0,0,0]) zip_paska(4);
   translate([-i*(part_width/2 - extr_mount_diam - 4.5),-19.5 - v_corr,8/2]) rotate([0,0,0]) cylinder(r=7,h=30,$fn=32,center=true);
 } 
}

module zip_paska(r_vnejsi){
  difference(){
    cylinder(r=r_vnejsi,h=3.5,$fn=32,center=true);
    cylinder(r=r_vnejsi-2,h=3.5,$fn=32,center=true);
  }
}

module x_carriage_fancy(){
 // Setreni plastem
 translate([-part_width/2,17,15]) rotate([45,0,0]) cube([part_width,10,10]);
 translate([-part_width/2-1.5,17,15]) rotate([0,-40,0]) cube([10,40,10]);
 translate([part_width/2+1.5,17,15]) rotate([0,-50,0]) cube([10,40,10]);
}

// Cela soucastka
module x_carriage(){
 difference(){
  x_carriage_base();
  x_carriage_beltcut();
  x_carriage_holes();
  x_carriage_fancy();
 }
}

x_carriage();