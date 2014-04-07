// RebeliX
//
// y idler
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Rebel II

include <../configuration.scad>

wall = 5;
height = 28;
depth = 25;
width = M6_head_diameter+2*wall;
base_thickness = 8;

module y_idler_base(){
	cube([width,depth,height]);
}

module y_idler_cuts(){
	// Vyrez pro lozisko
	translate([wall,base_thickness,-0.1]) cube([M6_head_diameter,depth,height+1]);
	// Otvor pro sroub na lozisko
	translate([-0.1,depth-5,9]) rotate([0,90,0]) cylinder(r = 1.6, h = width+1, $fn = 30);
	// Otvor na prisroubovani do kombistojky
	translate([width/2,-0.1,3+15]) rotate([-90,0,0]) cylinder(r = 3.1, h = depth, $fn = 30);
	// Otvor pro zahloubeni M6 sroubu
	translate([width/2,base_thickness-M6_head_height,3+15]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = depth, $fn = 30);
	// Vyrez pro profil
	translate([-0.1,-0.1,3]) cube([width+1,1.1,15-4]);
	translate([-0.1,-0.1,3+15+4]) cube([width+1,1.1,15-4]);
	translate([-0.1,1,3+15-4]) rotate([160,0,0]) cube([30,3,8]); 
	// Otvor na matku
	translate([-0.1,depth-5,9]) rotate([0,90,0]) cylinder(h = 2.5, r=3, $fn=6);	
	// Setreni plastem
	translate([-0.1,1,0]) rotate([115,0,0]) cube([width+1,6,6]);
	translate([-0.1,depth,13]) rotate([45,0,0]) cube([width+1,depth+2,height]);
	translate([-0.1,depth-2,0]) rotate([-20,0,0]) cube([width+1,10,10]);
	
	// Lozisko
	%translate([5,depth-5,9]) rotate([0,90,0]) cylinder(r = 11, h = width-10, $fn = 30);
}

difference(){
	y_idler_base();
	y_idler_cuts();
}	