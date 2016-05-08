// RebeliX
//
// y-idler
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

// Lozisko 624
bearing_width = 5;

wall = 5;
height = 28;
depth = 25;
width = 2*bearing_width+2*wall+3;
base_thickness = 8;

module y_idler_base(){
	cube([width,depth,height]);
}

module y_idler_cuts(){
	difference(){
	  // Vyrez pro lozisko
	  translate([wall,base_thickness,-0.1]) cube([width-2*wall,depth,height+1]);
	  // Mezera pro loziska
	  translate([wall-0.1,depth-7,7.7]) rotate([0,90,0]) cylinder(r1=5,r2=3.1,h=1.6);
	  translate([width-wall+0.1,depth-7,7.7]) rotate([0,-90,0]) cylinder(r1=5,r2=3.1,h=1.6);
	}
	// Otvor pro sroub na lozisko
	translate([width/2,depth-7,7.7]) rotate([0,90,0]) cylinder(r = 2.2, h = width+1, $fn = 30,center=true);
	translate([width,depth-7,7.7]) rotate([0,90,0])cylinder(r=3.9,h=wall+0.6,$fn=32,center=true);
	
	// Otvor na prisroubovani do kombistojky
	translate([width/2,-0.1,3+15]) rotate([-90,0,0]) cylinder(r = M6_dia/2, h = depth, $fn = 30);
	// Otvor pro zahloubeni M6 sroubu
	translate([width/2,base_thickness-M6_head_height+2,3+15]) rotate([-90,0,0]) cylinder(r = M6_head_diameter/2, h = depth, $fn = 30);
	// Vyrez pro hlinikovy profil
	translate([-0.1,-0.1,3]) cube([width+1,1.1,15-4]);
	translate([-0.1,-0.1,3+15+4]) cube([width+1,1.1,15-4]);
	translate([-0.1,1,3+15-4]) rotate([180 - 40,0,0]) cube([30,3,8]); 
	// Otvor na matku
	translate([-0.1,depth-7,7.7]) rotate([0,90,0]) cylinder(h = 3.5, r=3.9, $fn=6);	
	// Setreni plastem
	translate([-0.1,1,0]) rotate([115,0,0]) cube([width+1,6,6]);
	translate([-0.1,depth,13]) rotate([45,0,0]) cube([width+1,depth+2,height]);
	translate([-0.1,depth-2,0]) rotate([-20,0,0]) cube([width+1,10,10]);
	
	// Vyrez pro profilovou matku 
    translate([width/2,-6/2 + 1,3+15]) cube([profile_nut_width,6,10],center=true);
	
	// Lozisko
	%translate([wall+1.5,depth-7,7.7]) rotate([0,90,0]) cylinder(r = 6.5, h = 2*bearing_width, $fn = 30);
}

difference(){
	y_idler_base();
	y_idler_cuts();
}	