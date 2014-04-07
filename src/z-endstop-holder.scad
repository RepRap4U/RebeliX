// RebeliX
//
// z endstop holder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

difference(){
	cube([16,21,18], center = false);
	union() {
		translate([14.6,-0.1,8])cube([1.5,22,11]);
		
		translate([10,5,11]) rotate([0,90,0]) cylinder(r=0.7, h = 10, $fn=30);
		translate([10,15,11]) rotate([0,90,0]) cylinder(r=0.7, h = 10, $fn=30);
		
		translate([16/2-3.3,10,-0.1])cube(size = [6.6,25,26]);
		translate([16/2,8,-0.1])cylinder(h = 30, r=4.2, $fn=30);

		translate([4.6,10,-0.1])rotate([0,0,3])cube([3,15,26]);
		translate([8.4,10,-0.1])rotate([0,0,-3])cube([3,15,26]);

		translate([-0.1,21-5,4])rotate([0,90,0])cylinder(h = 16, r=1.6, $fn=30);
		translate([16-2.4,21-5,4])rotate([0,90,0])cylinder(h = 2.5, r=3, $fn=6);	
	}
}

