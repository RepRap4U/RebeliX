// RebeliX
//
// y motor
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Rebel II

include <../configuration.scad>

base_thickness = 8;
motor_base_thickness = 5;

module y_motor_base(){
	difference(){
      translate([0,0,0]) cube([42.3+base_thickness,42.3+4,motor_length+motor_base_thickness]);
      translate([base_thickness,4,motor_base_thickness]) cube([60,60,60]);
	}
	// Voditko do hlinikoveho profilu	
	translate([-2,15-4,0]) cube([4,8,motor_length+motor_base_thickness]);
}

module y_motor_cuts(){			
	translate([base_thickness,5,29.5+7]) rotate([-35,0,-90]) cube([10,70,40]);	
	translate([base_thickness,5,29.5+7]) rotate([0,0,-90]) cube([10,70,40]);	
	
	translate([base_thickness+21.3-8,21.3+4-8,-0.1]) cube([40,40,10]);
	translate([base_thickness+21.3,21.3+4-11.8,-0.1]) cube([25,15,10]);		
	
	translate([base_thickness+42.3,13,-0.1]) rotate([0,0,45]) cube([10,10,10,]);
	translate([base_thickness+9,42.3+4,-0.1]) rotate([0,0,-45]) cube([10,10,10,]);	
	
	// Otvor na kabely motoru
	translate([-4,-0.1,motor_length+motor_base_thickness-9.5]) cube([40,60,10]);
	translate([-0.1,4+21.3+5,motor_length+motor_base_thickness-9.5]) rotate([-45,0,0]) cube([10,40,40]);	
	
	translate([0,42.3,-0.1]) rotate([0,0,45]) cube([10,10,motor_length+motor_base_thickness]);

	// Vyrez pro vedeni kabelu od motoru Z (dolni vedeni)
	translate([0,5,-0.1]) cylinder(r=3.5,h=motor_length+motor_base_thickness+1,$fn=20);
	translate([3.5,5,-0.1]) rotate([0,0,180]) cube([10,10,motor_length+motor_base_thickness+1]);
}	

module y_motor_holes(){
	// Otvor pro prisroubovani do hlinikoveho profilu
	translate([base_thickness-M6_head_height,15,16]) rotate([0,90,0]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30);
	translate([-3,15,16]) rotate([0,90,0]) cylinder(r = 3.05, h = 10, $fn = 30);

	// Otvory pro motor
	translate([base_thickness+5.65,4+5.65,-0.1]){
		translate([0,0,-0.1]) cylinder(h = 20, r=1.9, $fn=30);
		translate([31,0,-0.1]) cylinder(h = 20, r=1.9, $fn=30);
		translate([0,31,-0.1]) cylinder(h = 20, r=1.9, $fn=30);
		// Korekce pozice motoru - napinani remenu
		translate([0+2,0,-0.1]) cylinder(h = 20, r=1.9, $fn=30);
		translate([31+2,0,-0.1]) cylinder(h = 20, r=1.9, $fn=30);
		translate([0+2,31,-0.1]) cylinder(h = 20, r=1.9, $fn=30);
		
		translate([0,0-1.9,-0.1]) cube([1.9,2*1.9,10]);
		translate([31,0-1.9,-0.1]) cube([1.9,2*1.9,10]);
		translate([0,31-1.9,-0.1]) cube([1.9,2*1.9,10]);		
	}	
	// Vyrez pro stred motoru
	translate([base_thickness+21.3,4+21.3,-0.1]) cylinder(r = 11.8,h = 10,$fn = 64);
}

difference(){
	y_motor_base();
	y_motor_cuts();
	y_motor_holes();
}	