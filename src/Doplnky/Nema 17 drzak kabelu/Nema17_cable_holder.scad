// RebeliX
//
// Drzak kabelu nacvaknutelny na motor NEMA17
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../../../configuration.scad>

tloustka_steny = 2;
// 0503 LQEF
//vyska_kraje = 11.4;
// 1003 LQEF, 1005 LQEF
vyska_kraje = 12;

vyska_dilu = vyska_kraje+2.65+1.25;

module holder_base(){
  cube([42.3+2*tloustka_steny,42.3+2*tloustka_steny,vyska_dilu],center=true);
}

module holder_cuts(){
  difference(){
    translate([0,0,2]) cube([42.3,42.3,vyska_dilu - 1.3],center=true);
    // Rohy
    translate([34.5/2,42.3/2,-6]) rotate([0,0,-45]) cube([10,10,14]); 
	translate([-34.5/2,42.3/2,-6]) rotate([0,0,135]) cube([10,10,14]);
    translate([34.5/2,-42.3/2,-6]) rotate([0,0,-45]) cube([10,10,14]);
	translate([-34.5/2,-42.3/2,-6]) rotate([0,0,135]) cube([10,10,14]);	
	// Packy
	translate([34.5/2-1.7,42.3/2,vyska_dilu/2 - 1.25]) rotate([0,0,-45]) cube([10,10,10]);
	translate([-34.5/2+1.7,42.3/2,vyska_dilu/2 - 1.25]) rotate([0,0,135]) cube([10,10,10]);
	translate([34.5/2-1.7,-42.3/2,vyska_dilu/2 - 1.25]) rotate([0,0,-45]) cube([10,10,10]);
	translate([-34.5/2+1.7,-42.3/2,vyska_dilu/2 - 1.25]) rotate([0,0,135]) cube([10,10,10]);
  } 
  translate([33.5/2+tloustka_steny,42.3/2+tloustka_steny,-10]) rotate([0,0,-45]) cube([10,10,vyska_dilu + 5]);
  translate([-33.5/2-tloustka_steny,42.3/2+tloustka_steny,-10]) rotate([0,0,135]) cube([10,10,vyska_dilu + 5]);
  translate([33.5/2+tloustka_steny,-42.3/2-tloustka_steny,-10]) rotate([0,0,-45]) cube([10,10,vyska_dilu + 5]);
  translate([-33.5/2-tloustka_steny,-42.3/2-tloustka_steny,-10]) rotate([0,0,135]) cube([10,10,vyska_dilu + 5]);	
  // Setreni plastem
  translate([42.3/2,0,0]) cylinder(r=24/2,h=20,center=true);
  translate([0,42.3/2,0]) cylinder(r=24/2,h=20,center=true);
  translate([0,-42.3/2,0]) cylinder(r=24/2,h=20,center=true);
  translate([-42.3/2,0,0]) cylinder(r=24/2,h=20,center=true);
  // Otvor pro ZIP pasku
  translate([0,0,-13.5]) difference(){
    rotate([90,0,0]) cylinder(r=9,h=3,$fn=32,center=true);
	rotate([90,0,0]) cylinder(r=7,h=4,$fn=32,center=true);
  
  }
}

module nema17_cable_holder(){
	difference(){
	  holder_base();
	  holder_cuts();
	}
}

nema17_cable_holder();	