// RebeliX
//
// Zadni kryt zdroje 12V / 240W zadni cast
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../../../configuration.scad>
use <../../inc/text_RebeliX.scad>

sirka = 98.5+0.9;
sirka_vnitrni = 90.7;
vyska = 23;
hloubka = 45;
tloustka_steny = 2;
plech_tloustka = 2 + 0.4;

hloubka_dilu = hloubka + 2*tloustka_steny + 1.5;

module power_base(){
	translate([0,0,0]) cube([sirka,hloubka_dilu+15,tloustka_steny]);

	translate([0,hloubka_dilu-tloustka_steny+15,0]) cube([sirka,tloustka_steny+1,vyska]);
		
	translate([0,3.5+30,0]) cube([2.5+tloustka_steny,hloubka_dilu-3.5-15,vyska]);
	translate([sirka-2.5-tloustka_steny,3.5+55,0]) cube([2.5+tloustka_steny,hloubka_dilu-3.5-40,vyska]);

	// Vystuzeni krabicky
	translate([1.9,hloubka_dilu+15,0]) rotate([0,0,0]) rotate([0,0,-90]) cube([5,5,vyska]);
	translate([sirka-1.9,hloubka_dilu+15,0]) rotate([0,0,180]) cube([5,5,vyska]);
	translate([1.9,hloubka_dilu-3-tloustka_steny+15,tloustka_steny]) cube([sirka-2*1.9,3,2]);
}

module power_cuts(){
    // Vyrez pro zdroj
	intersection(){
	  translate([45,hloubka_dilu+10,vyska/2 - 5]) cube([sirka-52,19,vyska]);
	  translate([45+(sirka-52)/2,hloubka_dilu+10,vyska]) rotate([90,0,0]) cylinder(r=25,h=19,$fn=32,center=true);
	}
	
	// Otvor pro srouby na pridelani krytu
	translate([sirka - 9, 10.5 - 1,6+tloustka_steny]) cylinder(r=1.8,h=200,$fn=16,center=true);
	translate([sirka - 9, 10.5 + 1,6+tloustka_steny]) cylinder(r=1.8,h=200,$fn=16,center=true);
	translate([sirka - 9, 10.5,0]) cube([2*1.8,2*1,10],center=true); 
	
	translate([sirka - 69, 8 - 1,6+tloustka_steny]) cylinder(r=1.8,h=200,$fn=16,center=true);
	translate([sirka - 69, 8 + 1,6+tloustka_steny]) cylinder(r=1.8,h=200,$fn=16,center=true);
    translate([sirka - 69, 8,0]) cube([2*1.8,2*1,10],center=true); 
	
	for(i=[10 : 10 : sirka]){
	  translate([i,hloubka_dilu + 5,0]) cylinder(r=1.8,h=10,$fn=16,center=true);
	  translate([i,hloubka_dilu - 10,0]) cylinder(r=1.8,h=10,$fn=16,center=true);
	  translate([i - 1.8,hloubka_dilu - 10,-5]) cube([1.8*2,15,10]);
	}	

	translate([0,15,-0.1]) rotate([0,0,200]) cube([30,20,10]);
	translate([sirka,15,5]) rotate([180,0,-20]) cube([30,20,10]);
	

	// Text RebeliX
	translate([sirka/2,25,-0.1]) rotate([0,0,-180]) mirror([1,0,0]) text_RebeliX(3*layer_height+0.1);
}

module kryt_zdroje_zadni(){
	difference(){
	  power_base();
	  power_cuts();
	}
}

kryt_zdroje_zadni();