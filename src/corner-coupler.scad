// RebeliX
//
// corner coupler
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Rebel II

// Postacuji i 4 mm
base_thickness = 5;

difference(){
	union(){
		cube([60,30,base_thickness], center = false);
		translate([11,0,0])cube([8,30,base_thickness+1.5]);
		translate([60,30/2-4,0])rotate(90,0,0)cube([8,30,base_thickness+1.5]);
		}
		
		translate([11+4,30/2,-0.1])cylinder(h=10,r=3.1,$fn=32);
		translate([60-30/2,30/2,-0.1])cylinder(h=10,r=3.1,$fn=32);
}
