// RebeliX
//
// endstop-adjust
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

vyska = 6;
sirka_steny = 8;
delka_ramene = 10.5;
y_offset = 3.7;

module endstop_base(delka_ramen,vyska,sirka_steny){
    // Zakladna endstopu
	translate([delka_ramene,0,0]) cube([30,sirka_steny,16]);
	// Vyrez pro profil
	translate([15-4+delka_ramene,sirka_steny-1.5,0]) cube([8,3,16]);
	translate([0,0,0]) cube([delka_ramene+30,8,vyska]);
	// Kruh okolo sroubu
	translate([0,y_offset,0]) rotate([0,0,0]) cylinder(r=7,h=vyska,$fn=32);
}

module endstop_cuts(delka,vyska,sirka_steny){
	// Otvor pro M6 sroub
	translate([15+delka_ramene,M6_head_height,2+M6_head_diameter/2]) rotate([90,0,0]) cylinder(r=M6_head_diameter/2,h=10,$fn=30);
	translate([15+delka_ramene,0,2+M6_head_diameter/2]) rotate([-90,0,0]) cylinder(r=3.1,h=20,$fn=30);
	// Otvor pro M3 sroub
	translate([0,y_offset,0]) rotate([0,0,0]) cylinder(r=1.6,h=20,$fn=16,center=true);
	translate([0,y_offset,vyska-2.4]) cylinder(h = 2.5, r=3.3, $fn=6);		
	// Seriznuti rohu
	translate([delka_ramene,-0.1,vyska]) rotate([0,-55,0]) cube([20,10,10]);
	translate([30+delka_ramene,-0.1,vyska]) rotate([0,-35,0]) cube([10,10,20]);	
}

mirror([0,1,0]) difference(){
	endstop_base(34,7,8);
	endstop_cuts(15,7,8);
}