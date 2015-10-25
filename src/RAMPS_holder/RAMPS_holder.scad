// RebeliX
//
// RAMPS mini drzak
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../../configuration.scad>

box_sirka = 72;
box_vyska = 52;
PCB_tloustka = 1.9;
holder_offset = 10;
offset_zakladny = 2;

module holder_base(vyska,sirka,delka,pozice){
	offset_zakladny = pozice == 1 ? offset_zakladny : -offset_zakladny;

	// Drzak Arduina
	translate([0,0,0]) cube([sirka,delka,vyska]);
	// Pridelani do profilu
	translate([sirka/2-15+offset_zakladny,delka-6.5,0]) cube([30,6.5+holder_offset,20]);
	// Vodici lista
	translate([sirka/2-4+offset_zakladny,delka-1,0]) cube([8,2+holder_offset,20]);
	// Vystuha
	translate([sirka/2+offset_zakladny,delka-6.4,7]) rotate([45,0,0]) cube([30,8,8], center=true);
}

module top_holder_cuts(vyska,delka,sirka,pozice){

	offset_zakladny = pozice == 1 ? offset_zakladny : -offset_zakladny;

	// Vyrez pro Arduino PCB
	translate([sirka/2 - 64/2 + offset_zakladny,box_vyska-8.1,-0.1]) cube([64,1.8,4]);
	// Vyrez pro RAMPS
	translate([box_sirka/2 + offset_zakladny,box_vyska-8-10-5.5-2.5,-0.1]) rotate([0,0,180]) cube([64,17+5,2*15], center=true);
	// Otvor pro M6 sroub
	translate([sirka/2+offset_zakladny,delka-6+M6_head_height+holder_offset-2.5,vyska+M6_head_diameter/2]) rotate([90,0,0]) cylinder(r=M6_head_diameter/2,h=30,$fn=64);
	translate([sirka/2+offset_zakladny,delka,vyska+M6_head_diameter/2]) rotate([90,0,0]) cylinder(r=3.1,h=50,$fn=30,center=true);
	// Vyrez vrchniho dilu
	if (pozice == 1) {	
		difference() {
		  translate([9,-0.1,-0.1]) cube([box_sirka-18,box_vyska-15,vyska+1]);
		  translate([0,9,0]) cube([box_sirka,11,1.5]);
		}
		// Zip pasky
		translate([-2,13.5,vyska/2 - 3.5/2]) zip_paska(7);
		translate([-2,30.5,vyska/2 - 3.5/2]) zip_paska(7);
		translate([13,box_vyska+1,vyska/2 - 3.5/2]) zip_paska(7);
		//Vyrez pro kabely
		translate([-8,13.5,-0.1]) cylinder(r=9,h=10,$fn=32);
		translate([-8,30.5,-0.1]) cylinder(r=9,h=10,$fn=32);
		translate([13,box_vyska+5,-0.1]) cylinder(r=6.5,h=10,$fn=32);
		// Vyrez pro kryci mrizku
		translate([box_sirka/2,3.5,vyska/2]) cube([box_sirka-4,2.8,vyska+0.1],center=true);
		translate([box_sirka/2,3.5-2.8,vyska/2]) cube([box_sirka+1,2.9,vyska+0.1],center=true);
		
		// Vyrez pro sroubky
		translate([box_sirka/2 - 66/2 + 3.5,5,vyska/2]) rotate([90,0,0]) cylinder(r=1.3,h=15,$fn=16,center=true);
		translate([box_sirka/2 + 66/2 - 3.5,3.5,vyska/2]) rotate([90,0,0]) cylinder(r=1.3,h=15,$fn=16,center=true);
	}
	// Vyrez spodni dil
	if (pozice == 0) {	
		difference(){
	      translate([8,-0.1,-0.1]) cube([box_sirka-16,box_vyska-7.2+PCB_tloustka,30]);
		  translate([0,8,0]) cube([box_sirka,8,1.5]);
	      translate([sirka/2+offset_zakladny,box_vyska,-0.1]) rotate([0,0,180]) cube([19,24,20], center=true);
		}
	// Vyrez pro kryci mrizku
	translate([box_sirka/2,3.5,0]) cube([box_sirka-4,2.8,vyska+2],center=true);
	// Zip pasky
	translate([box_sirka-13,box_vyska+2.5,vyska/2 - 3.5/2]) zip_paska(7);
	translate([sirka+2,13.5,vyska/2 - 3.5/2]) zip_paska(7);
	//Vyrez pro kabely
	translate([box_sirka-13,box_vyska+5.5,0]) cylinder(r=6.5,h=30,$fn=32,center=true);
	translate([sirka+8,13.5,-0.1]) cylinder(r=9,h=10,$fn=32);
	}

	// Uspora plastu
	// Seriznute rohy
	translate([sirka/2 - 15+offset_zakladny,delka-10,20-5]) rotate([0,-45,0]) cube([10,holder_offset+15,10]);
	translate([sirka/2 + 15+offset_zakladny,delka-10,20-5]) rotate([0,-45,0]) cube([10,holder_offset+15,10]);

	translate([0,-0.1,vyska-1.5]) rotate([0,-55,0]) cube([30,60,30]);
	translate([sirka,-0.1,vyska-1.5]) rotate([0,-35,0]) cube([30,60,30]);
	
	// Rohy zakladny
	translate([box_sirka/2 - 25,box_vyska,-0.1]) rotate([0,0,110]) cube([15,40,15]);
	translate([box_sirka/2 + 25,box_vyska,-0.1]) rotate([0,0,-20]) cube([40,15,15]);
	
}

module zip_paska(r_vnejsi){
  difference(){
    cylinder(r=r_vnejsi,h=3.5,$fn=32);
    cylinder(r=r_vnejsi-2,h=3.5,$fn=32);
  }
}

// Spodek
translate([0,0,0]) difference(){
	holder_base(7,box_sirka,box_vyska,0);
	top_holder_cuts(7,box_vyska,box_sirka,0);
}

// Vrsek
translate([0,box_vyska+holder_offset - 5,0]) difference(){
	holder_base(7,box_sirka,box_vyska,1);
	top_holder_cuts(7,box_vyska,box_sirka,1);
}
