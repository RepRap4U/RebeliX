// RebeliX
//
// spool center
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz


// Vhodne pro 1 kg papirove civky "plasty Mladec"
// Prumer otvoru v civce
spool_hole = 49.4;

union() {
    difference()
    {
	    union ()
	    {
		    cylinder(4.5, (spool_hole/2)+0.75, (spool_hole/2)+0.25,$fn=64);
		    cylinder(h=1, r=(spool_hole/2)+8,$fn=64);
	    }
	    translate([0,0,-0.1]) cylinder (h=13,r=4.2);
		for ( i = [0 : 45 : 360] ){
		    translate([sin(i)*(spool_hole/3),cos(i)*(spool_hole/3),-0.1]) cylinder(h=13,r=(spool_hole/2)/5);
		}
    }
}
