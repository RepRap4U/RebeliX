include <../configuration.scad>

module bottom_holder_base(height,width,length){
	// Arduino holder
	translate([15-8.5,0,0]) cube([width,length,height]);
	// Profile mount
	translate([0,length-6,0]) cube([30,6,20]);
	// Guide
	translate([15-4,length,0]) cube([8,2,20]);
}

module top_holder_base(height,width,length){
	// Arduino holder
	translate([-5,0,0]) cube([width,length,height]);
	// Profile mount
	translate([0,length-6,0]) cube([30,6,20]);
	// Guide
	translate([15-4,length,0]) cube([8,2,20]);
}

module bottom_holder_cuts(height,length,cutout_width){
	translate([-3.5,3,height-3]) cube([cutout_width,1.9,5]);
	// M6 screw hole
	translate([15,length-6+M6_head_height,height+M6_head_diameter/2]) rotate([90,0,0]) cylinder(r=M6_head_diameter/2,h=10,$fn=30);
	translate([15,0,height+M6_head_diameter/2]) rotate([-90,0,0]) cylinder(r=3.1,h=20,$fn=30);
	// Material saving
	translate([0,0,height]) rotate([0,-55,0]) cube([30,30,30]);
	translate([30,0,height]) rotate([0,-35,0]) cube([30,30,30]);	
}

module top_holder_cuts(height,length,cutout_width){
	translate([-3.5,3,-0.1]) cube([cutout_width,1.9,5]);
	// M6 screw hole
	translate([15,length-6+M6_head_height,height+M6_head_diameter/2]) rotate([90,0,0]) cylinder(r=M6_head_diameter/2,h=10,$fn=30);
	translate([15,0,height+M6_head_diameter/2]) rotate([-90,0,0]) cylinder(r=3.1,h=20,$fn=30);
	// Material saving
	translate([0,0,height]) rotate([0,-55,0]) cube([30,30,30]);
	translate([30,0,height]) rotate([0,-35,0]) cube([30,30,30]);	
	translate([cutout_width-2,-0.1,height-1]) rotate([0,-45,0]) cube([10,20,10]);
	translate([-5,-0.1,height-1]) rotate([0,-45,0]) cube([10,20,10]);
}


difference(){
	bottom_holder_base(6,19,15);
	bottom_holder_cuts(6,15,40);
}

translate([0,20,0]) difference(){
	top_holder_base(6,43,15);
	top_holder_cuts(6,15,40);
}	
