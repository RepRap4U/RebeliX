// RebeliX
//
// y-rod-holder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

width = 48;
height = 18;
base_thickness = 7;
thickness = 17.5;
rod_diameter = 8;

module y_rod_holder_base(){
  cube([width,thickness,height]);
}

module y_cuts(){
  // Vyrez pro hlinikovy profil
  translate([width+0.1,0.5,(height/2)+4]) rotate([0,0,180]) cube([50,2,10]);
  translate([width+0.1,0.5,0]) rotate([0,0,180]) cube([50,2,(height/2)-4]);
  
  // Vyrez pro 8mm tyc
  translate([width/2,thickness - 1.6,-0.1]) cylinder(h=(height/2)+5,r=(rod_diameter/2)+0.1,$fn = 32);
  // Zkosene hrany
  translate([0,base_thickness-1.5,-0.1]) rotate([0,0,34]) cube([30,10,20]);
  translate([width,base_thickness-1.5,-0.1]) rotate([0,0,56]) cube([10,30,20]);
  // Otvory pro M6 srouby
  translate([8.5,0,height/2]) rotate([-90,0,0]) cylinder(h=40,r=3.1,$fn = 32,center=true);
  translate([width-8.5,0,height/2]) rotate([-90,0,0]) cylinder(h=40,r=3.1,$fn = 32,center=true);
  
  translate([8.5,base_thickness,height/2]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = 20, $fn = 30);
  translate([width-8.5,base_thickness,height/2]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = 20, $fn = 30);
 
  translate([width-8.5-M6_head_diameter/2,base_thickness,0]) cube([M6_head_diameter,10,height/2]);
  translate([8.5-M6_head_diameter/2,base_thickness,0]) cube([M6_head_diameter,10,height/2]);
  
  // Otvor pro zip pasku
  translate([width/2,thickness - 1.6,height/2 - 3]) difference(){
    cylinder(r=8.5,h=3,$fn=64);
    cylinder(r=6.5,h=3.1,$fn=64);
  }
}

rotate([180,0,0]) 
difference(){
	y_rod_holder_base();
	y_cuts();
}	