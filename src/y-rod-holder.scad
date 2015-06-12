// RebeliX
//
// y rod holder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

width = 42;
height = 18;
base_thickness = 7;
thickness = 17.5;
rod_diameter = M8_smooth_rod_diameter;

module y_rod_holder_base(){
  cube([width,base_thickness,height]);
  translate([width/2-8,0,0]) cube([16,thickness,height]);
}

module y_cuts(){
  // ALU hole
  translate([width+0.1,0.5,(height/2)+ALU_cut_width/2]) rotate([0,0,180]) cube([50,2,10]);
  translate([width+0.1,0.5,0]) rotate([0,0,180]) cube([50,2,(height/2)-ALU_cut_width/2]);
  
  // M8 rod hole
  translate([width/2,thickness - 1.6,-0.1]) cylinder(h=(height/2)+5,r=rod_diameter/2,$fn = 32);
  // Bevelled edges
  translate([width/2-8,thickness-2,-0.1]) rotate([0,0,45]) cube([10,10,20]);
  translate([width/2+8,thickness-2,-0.1]) rotate([0,0,45]) cube([10,10,20]);
  
  translate([0,base_thickness-1.5,-0.1]) rotate([0,0,45]) cube([10,10,20]);
  translate([width,base_thickness-1.5,-0.1]) rotate([0,0,45]) cube([10,10,20]);
  // M6 screws holes
  translate([6,-0.1,height/2]) rotate([-90,0,0]) cylinder(h=10,r=M6_diamater_horizontal/2,$fn = 32);
  translate([width-6,-0.1,height/2]) rotate([-90,0,0]) cylinder(h=10,r=M6_diamater_horizontal/2,$fn = 32);
  // Zip tie hole
  translate([5,base_thickness + 1.3,(height/2)-2])  cube([30,2.1,3.5]);
}

difference(){
	y_rod_holder_base();
	y_cuts();
}	
