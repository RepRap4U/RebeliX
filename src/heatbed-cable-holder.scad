// RebeliX
//
// heatbed-cable-holder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

delka = 25;
sirka = M6_head_diameter + 3;
vyska = M6_head_height+2+3;

module holder_base(){
	cube([sirka,delka,vyska]);
}

module holder_cuts(){
	// Zlabek pro kabel
	translate([sirka/2,-0.1,6+M6_head_height+2]) rotate([-90,0,0]) cylinder(r=6,h=delka+1,$fn=32);
    // Otvor pro M6 sroub
	translate([sirka/2,delka/2,2]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30);
	translate([sirka/2,delka/2,-0.1]) cylinder(r = 3.05, h = 10, $fn = 30);
	// Otvor pro ZIP pasku
	translate([sirka/2,5.5,9]) rotate([90,0,0]) zip_paska(6.5);
	translate([sirka/2,delka-5.5+3.5,9]) rotate([90,0,0]) zip_paska(6.5);	
}

module zip_paska(r_vnejsi){
  difference(){
    cylinder(r=r_vnejsi,h=3.5,$fn=32);
    cylinder(r=r_vnejsi-2,h=3.5,$fn=32);
  }
}

difference(){
  holder_base();
  holder_cuts();
}