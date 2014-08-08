// RebeliX
//
// z endstop holder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

difference(){
	cube([16,27,18], center = false);
	union() {
		translate([-0.1,6.5,10])cube([1.5,27,11]);
		
		// Otvory pro ZIP pasku
		translate([-0.1,12,13]) rotate([0,90,0]) cylinder(r=1.5, h = 10, $fn=30);
		translate([-0.1,22,13]) rotate([0,90,0]) cylinder(r=1.5, h = 10, $fn=30);
		
		translate([4.1,22,13]) rotate([90,0,0]) cylinder(r=1.5, h = 10, $fn=30);
		
		translate([16/2-3.3,10,-0.1])cube(size = [6.6,25,26]);
		translate([16/2,8,-0.1])cylinder(h = 30, r=4.2, $fn=30);

		//translate([4.6,10,-0.1])rotate([0,0,3])cube([3,20,26]);
		translate([8.4,10,-0.1])rotate([0,0,-3])cube([3,20,26]);
		
		translate([16-5,26-5,-0.1])cube([10,10,30]);
		
		translate([-0.1,17,4])rotate([0,90,0])cylinder(h = 30, r=1.6, $fn=30);
		translate([-0.1,17,4])rotate([0,90,0])cylinder(h = 2.5, r=3, $fn=6);	
	}
}

