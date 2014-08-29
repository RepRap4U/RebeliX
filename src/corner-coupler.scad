// RebeliX
//
// corner coupler
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Rebel II

include <../configuration.scad>

// Postacuji i 4 mm
base_thickness = 5;

module corner_coupler(diameter=M6_diameter/2,width=30,length=60,height=base_thickness,embed=1.5,cut_width=ALU_cut_width){
	difference(){
		union(){
			//Zakladni blok
			cube([length,width,height],center=true);

			//Zapusteni do profilu
			translate([-length/4,0,height/2])cube([cut_width,width,embed*2],center=true);
			translate([width/2+0.5,0,height/2])cube([width-1,cut_width,embed*2],center=true);
		}
		//Diry na srouby
		translate([-length/4,0,embed/2])cylinder(h=height+embed+0.1,r=diameter,$fs=0.5,center=true);
		translate([width/2,0,embed/2])cylinder(h=height+embed+0.1,r=diameter,$fs=0.5,center=true);

		//Seriznuti rohu
		translate([0,-width/2-2.5, -height/2-0.1]) 
		rotate([45,0,0]) 
		cube([length+0.1,5, 5],center=true);

		translate([0,width/2+2.5, -height/2-0.1]) 
		rotate([45,0,0]) 
		cube([length+0.1,5, 5],center=true);

		translate([length/2+2.5,0, -height/2-0.1]) 
		rotate([0,45,0]) 
		cube([5,width+0.1, 5],center=true);

		translate([-length/2-2.5,0, -height/2-0.1]) 
		rotate([0,45,0]) 
		cube([5,width+0.1, 5],center=true);

	}
}

corner_coupler();

