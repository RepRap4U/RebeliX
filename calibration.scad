include <./configuration.scad>

difference(){
	union(){
		cube([36,30,5]);
		translate([0,23,0])cube([35,10,20]);
		translate([M6_diameter*2+8,20,0])cube([ALU_cut_width_horizontal,11,20]);
	}
	translate([M6_diameter,M6_diameter+M3_diameter+5,-1])cylinder(r=M6_diameter/2,h=7,$fn=32);
	translate([M6_diameter,M3_diameter+2,-1]){
		cylinder(r=M3_diameter/2,h=7,$fn=16);	
		translate([0,0,3.5])cylinder(r=M3_nut_diameter/2,h=2.6,$fn=6);
	}
	translate([M6_diameter+M8_smooth_rod_diameter_catch+0.5,M8_smooth_rod_diameter+3,layer_height])cylinder(h=7,r=M8_smooth_rod_diameter/2,$fn = 30);
	translate([34.5,M8_smooth_rod_diameter+3,-1])cylinder(h=7,r=M8_smooth_rod_diameter/2,$fn = 32);
	
	translate([M6_diameter+4,34,10]) 
	rotate([90,0,0]){
		cylinder(h = 15, r=M3_diameter_horizontal/2, $fn=30);
		cylinder(h = 4, r=M3_nut_diameter_horizontal/2, $fn=6);
	}

	translate([M6_diameter*2+8+ALU_cut_width/2,34,12]) 
	rotate([90,0,0]){
		cylinder(r = M6_diamater_horizontal/2, h = 15, $fn = 30);
		cylinder(r = M6_head_diameter/2, h = 4, $fn = 30);
	}
}

translate([M6_diameter*2+8,0,0])cube([ALU_cut_width,M6_diameter*2+8,7]);

