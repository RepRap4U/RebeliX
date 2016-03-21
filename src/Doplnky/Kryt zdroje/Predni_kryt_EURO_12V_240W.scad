// RebeliX
//
// Predni kryt zdroje 12V / 240W
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../../../configuration.scad>
use <../../inc/text_RebeliX.scad>

sirka = 99.4;
vyska = 29;
hloubka = 45;
tloustka_steny = 2;
plech_tloustka = 2.4;

hloubka_dilu = hloubka + 2*tloustka_steny + 1.5;

module euro_konektor(){
  difference(){
    cube([27.8,19.8,10],center=true);
    translate([7.5,19.8/2,-10]) rotate([0,0,-45]) cube([20,20,20]);
	translate([-7.5,19.8/2,-10]) rotate([0,0,135]) cube([20,20,20]);
  }
  // Otvory pro srouby
  translate([20,0,0]) cylinder(r=1.2,h=20,$fn=16,center=true);
  translate([-20,0,0]) cylinder(r=1.2,h=20,$fn=16,center=true);
}


module power_base(){
	translate([0,0,0]) cube([sirka,hloubka_dilu+15,tloustka_steny]);
	translate([0,hloubka_dilu-tloustka_steny+15,0]) cube([sirka,tloustka_steny+1,vyska]);
	difference(){
	  union(){
	    translate([0,3.5+15,0]) cube([2.5+tloustka_steny,hloubka_dilu-3.5,vyska]);
	    translate([sirka-2.5-tloustka_steny,3.5+15,0]) cube([2.5+tloustka_steny,hloubka_dilu-3.5,vyska]);
	  }
	  translate([-0.1,15,0]) cube([plech_tloustka,19+0.1,vyska+1]);
	  translate([sirka-plech_tloustka,15,0]) cube([plech_tloustka+0.1,19,vyska+1]);
	}
	// Vyztuhy
	translate([1.9,hloubka_dilu+15,0]) rotate([0,0,0]) rotate([0,0,-90]) cube([5,5,vyska]);
	translate([sirka-1.9,hloubka_dilu+15,0]) rotate([0,0,180]) cube([5,5,vyska]);
	translate([1.9,hloubka_dilu-3-tloustka_steny+15,tloustka_steny]) cube([sirka-2*1.9,3,2]);
	// Nozicky na zacvaknuti do zdroje
	translate([1.3,3.5+4.3+15,tloustka_steny+12.1]) rotate([0,8,0]) cube([2,3.8,vyska-tloustka_steny-12.1]);
	translate([sirka-2.4,3.5+4.3+15,tloustka_steny+12.1]) rotate([0,-8,0]) cube([1,3.8,vyska-tloustka_steny-12.1]);
	
	translate([-3,0,0]) cube([3,40,19]);
	translate([sirka,0,0]) cube([3,40,19]);
	
	// Sloupky pro srouby EURO konektoru
	translate([73+20,hloubka_dilu+3,tloustka_steny-0.1]) rotate([0,0,0]) cylinder(r1=4.5,r2=3,h=5,$fn=32);
	translate([73-20,hloubka_dilu+3,tloustka_steny-0.1]) rotate([0,0,0]) cylinder(r1=4.5,r2=3,h=5,$fn=32);
}

module power_cuts(){
    // Vyrez pro zdroj
	translate([0,15,21]) cube([sirka,19,40]);
	// Otvor pro srouby k pridelani na zdroj
	translate([sirka/2,7,6+tloustka_steny]) rotate([0,90,0]) cylinder(r=1.8,h=200,$fn=16,center=true);
    translate([sirka/2,9.5,6+tloustka_steny]) rotate([0,90,0]) cylinder(r=1.8,h=200,$fn=16,center=true);
    translate([sirka/2,7+2.5/2,6+tloustka_steny]) cube([200,2.5,2*1.8],center=true);
    // Zkoseni
	translate([0,40,-0.1]) rotate([0,0,135]) cube([10,10,vyska]);
	translate([sirka,40,-0.1]) rotate([0,0,-45]) cube([10,10,vyska]);
	// Vyrez pro EURO konektor
	translate([73,hloubka_dilu+3,0]) rotate([180,0,0]) euro_konektor();
	// Vyrez pro vypinac
	translate([0,52,13]) rotate([0,90,0]) cube([19.2,13,10],center=true);
	// Text RebeliX
	translate([sirka/2,28,-0.1]) rotate([0,0,-180]) mirror([1,0,0]) text_RebeliX(3*layer_height+0.1);
	// Setreni plastem
	translate([sirka/2,0,0]) rotate([0,0,-90]) cube([30,sirka-20,10],center=true);
	translate([sirka/2-(sirka-20)/2,15,-0.1]) rotate([0,0,-110]) cube([30,20,10]);
	translate([sirka/2+(sirka-20)/2,15,-0.1]) rotate([0,0,200]) cube([30,20,10]);

}

module kryt_zdroje(){
	difference(){
	  power_base();
	  power_cuts();
	}
}

kryt_zdroje();