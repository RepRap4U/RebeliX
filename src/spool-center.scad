// RebeliX
//
// spool center
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

// Prumer otvoru v civce
spool_hole_big = 74; // "plasty Mladec"
spool_hole_small = 31; // "MK Floria"

union() {
    difference()
    {
	    union ()
	    {
		    cylinder(h=4.5,r=(spool_hole_big/2),$fn=64);
		    cylinder(h=1.5, r=(spool_hole_big/2)+4,$fn=64);
			cylinder(h=8,r=(spool_hole_small/2),$fn=64);
	    }
	    translate([0,0,-0.1]) cylinder (h=13,r=4.4,$fn=30);
		for ( i = [0 : 45 : 360] ){
		    translate([sin(i)*(spool_hole_big/2.5),cos(i)*(spool_hole_big/2.5),-0.1]) cylinder(h=13,r=(spool_hole_big/8.5));
			translate([sin(i)*(spool_hole_big/2),cos(i)*(spool_hole_big/2),-0.1]) rotate([0,0,i]) cube([2*(spool_hole_big/8.5),2*(spool_hole_big/8.5),10],center=true);
			translate([sin(i+10)*(spool_hole_big/1.7),cos(i+10)*(spool_hole_big/1.7),-0.1]) rotate([0,0,i+45]) cube([5,5,5],center=true);
			translate([sin(i-10)*(spool_hole_big/1.7),cos(i-10)*(spool_hole_big/1.7),-0.1]) rotate([0,0,i+45]) cube([5,5,5],center=true);
		}		
		translate([0,0,3]) cylinder(h=10,r=(spool_hole_small-12)/2);
    }
}
