// RebeliX
//
// j-head mount
// GNU GPL v3
// Martin Neruda
// http://www.reprap4u.cz

difference(){
	cube([60,20,7.4]);
	translate([30,10,4.4]) cylinder(r=8.5,h=3.1,$fn=30);
	translate([30-8.5,-0.1,4.4]) cube([17,10,3.1]);
		
	translate([30,10,-0.1]) cylinder(r=6.1,h=10,$fn=30);
	translate([30-6.1,-0.1,-0.1]) cube([12.2,10,10]);
	
	// Otvory pro prisroubovani
	translate([30-24,10,-0.1]) cylinder(r=2.5,h=10,$fn=30);
	translate([-0.1,10-2.5,-0.1]) cube([6,5,10]);
		
	translate([30+24,10,-0.1]) cylinder(r=2.5,h=10,$fn=30);
	translate([30+24,10-2.5,-0.1]) cube([7,5,10]);
	
	// Seriznute rohy
	translate([2.5,0,-0.1]) rotate([0,0,135]) cube([5,5,10]);
	translate([60-2.5,0,-0.1]) rotate([0,0,-45]) cube([5,5,10]);
	translate([60,20-2.5,-0.1]) rotate([0,0,45]) cube([5,5,10]);
	translate([2.5,20,-0.1]) rotate([0,0,135]) cube([5,5,10]);
}	