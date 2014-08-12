include <../configuration.scad>

module bottom_holder_base(vyska,sirka,delka){
	// Drzak arduina
	translate([15-8.5,0,0]) cube([sirka,delka,vyska]);
	// Pridelani do profilu
	translate([0,delka-6,0]) cube([30,6,20]);
	// Vodici lista
	translate([15-4,delka,0]) cube([8,2,20]);
}

module top_holder_base(vyska,sirka,delka){
	// Drzak arduina
	translate([-5,0,0]) cube([sirka,delka,vyska]);
	// Pridelani do profilu
	translate([0,delka-6,0]) cube([30,6,20]);
	// Vodici lista
	translate([15-4,delka,0]) cube([8,2,20]);
}

module bottom_holder_cuts(vyska,delka,vyrez_sirka){
	translate([-3.5,3,vyska-3]) cube([vyrez_sirka,1.9,5]);
	// Otvor pro M6 sroub
	translate([15,delka-6+M6_head_height,vyska+M6_head_diameter/2]) rotate([90,0,0]) cylinder(r=M6_head_diameter/2,h=10,$fn=30);
	translate([15,0,vyska+M6_head_diameter/2]) rotate([-90,0,0]) cylinder(r=3.1,h=20,$fn=30);
	// Setreni plastem
	translate([0,0,vyska]) rotate([0,-55,0]) cube([30,30,30]);
	translate([30,0,vyska]) rotate([0,-35,0]) cube([30,30,30]);	
}

module top_holder_cuts(vyska,delka,vyrez_sirka){
	translate([-3.5,3,-0.1]) cube([vyrez_sirka,1.9,5]);
	// Otvor pro M6 sroub
	translate([15,delka-6+M6_head_height,vyska+M6_head_diameter/2]) rotate([90,0,0]) cylinder(r=M6_head_diameter/2,h=10,$fn=30);
	translate([15,0,vyska+M6_head_diameter/2]) rotate([-90,0,0]) cylinder(r=3.1,h=20,$fn=30);
	// Setreni plastem
	translate([0,0,vyska]) rotate([0,-55,0]) cube([30,30,30]);
	translate([30,0,vyska]) rotate([0,-35,0]) cube([30,30,30]);	
	translate([vyrez_sirka-2,-0.1,vyska-1]) rotate([0,-45,0]) cube([10,20,10]);
	translate([-5,-0.1,vyska-1]) rotate([0,-45,0]) cube([10,20,10]);
}


difference(){
	bottom_holder_base(6,19,15);
	bottom_holder_cuts(6,15,40);
}

translate([0,20,0]) difference(){
	top_holder_base(6,43,15);
	top_holder_cuts(6,15,40);
}	