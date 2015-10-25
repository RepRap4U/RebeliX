// RebeliX
//
// Drzak LED pasku na 40mm ventilator
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../../../configuration.scad>


module fan_40mm(){
	// 40 mm ventilator
	translate([0,0,-32/2]) rotate([0,90,0]) cylinder(r=1.1,h=21,$fn=16,center=true);
	translate([0,0,32/2]) rotate([0,90,0]) cylinder(r=1.1,h=21,$fn=16,center=true);
	translate([0,-32/2,0]) rotate([0,90,0]) cylinder(r=39/2,h=21,$fn=64,center=true);
}

module LED_holder(){
  difference(){
    union(){
	  cube([50,16,4]);
	
	}
    translate([50/2 - 2,4,0]) rotate([0,90,0]) fan_40mm();
	// Seriznuti hran
	translate([4,0,-0.1]) rotate([0,0,130]) cube([10,10,10]);
	translate([45,-4,-0.1]) rotate([0,0,-40]) cube([10,10,10]);
	// Otvor pro Zip pasku
	translate([44,4,0]) cylinder(r=1.6,h=10,$fn=16,center=true);
	translate([50,4,0]) cylinder(r=1.6,h=10,$fn=16,center=true);
	
  }
}

LED_holder();

