// RebeliX
//
// Drzak pro dva hotendy
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <settings.scad>

nema17_width = 42.3;
base_width = 52;
base_height = 12;

base_extr_height = 9;

//carriage_mount_distance = 40;
carriage_mount_distance = 16;

epsilon = 0.01;

m3_nut_diameter=6.6;

extruder_recess_big_d=16.4; 
extruder_recess_big_h=4.8;
extruder_recess_small_d=12.4;
extruder_recess_small_h=4.6;

ext_base_offset = 7;

// Drive gear
drive_gear_outer_radius = 9.00 / 2;
drive_gear_hobbed_radius = 8 / 2;
drive_gear_hobbed_offset = 4;
drive_gear_length = 13;
drive_gear_tooth_depth = 0.35;

filament_diameter = 1.75; // 1.75, 3.00
filament_offset = [
	drive_gear_hobbed_radius + filament_diameter / 2 - drive_gear_tooth_depth,
	0,
	nozzle_distance/2 >= HE_d/2 ? nozzle_distance/2 : HE_d/2	
];

fan_offset = (base_width/2 - nozzle_distance/2 - 7/2) >= 15.5 ? 7/2 : (base_width/2 - nozzle_distance/2 - 16.5);

module groovemount_holes (extruder_recess_big_d=16.4, 
						  extruder_recess_big_h=4.8, 
						  extruder_recess_small_d=12.4,
						  extruder_recess_small_h=4.6,mount=0)
{	
  cylinder(r=extruder_recess_big_d/2,h=extruder_recess_big_h,$fn=64);
	  
  translate([0,0,extruder_recess_big_h])
    cylinder(r=extruder_recess_small_d/2,h=extruder_recess_small_h+epsilon,$fn=40);
	  
  translate([0,0,extruder_recess_big_h+extruder_recess_small_h])
	cylinder(r=extruder_recess_big_d/2,h=extruder_recess_big_h,$fn=64);
	  
  // Otvor pro filament
  translate([0,0,0]) cylinder(r=teflon_tube_diameter,h=30,$fn=16,center=true);  
	 
  // Vyrez pro zasunuti trysky
  if(mount)
  {
	translate([-extruder_recess_big_d/2,0,0]) 
	  cube([extruder_recess_big_d,20,extruder_recess_big_h]);
	  
	translate([-extruder_recess_small_d/2,0,extruder_recess_big_h])
	  cube([extruder_recess_small_d,20,extruder_recess_small_h+epsilon]);
	  
	translate([-extruder_recess_big_d/2,0,extruder_recess_big_h+extruder_recess_small_h])
	  cube([extruder_recess_big_d,20,extruder_recess_big_h]);
  }	
}

module holder_base()
{
  intersection()
  {
    cube([base_width,nema17_width - 5,base_height-5]);
    
	translate([base_width/2,(nema17_width - 5)/2,0])
	  cylinder(r=29,h=40,$fn=64,center=true);
  }  
  intersection()
  {
    union()
	{
	  translate([base_width/2,nema17_width/2 + ext_base_offset/2,base_height/2]) cube([base_width - 2*13,nema17_width + ext_base_offset,base_height],center=true);
      // Zobacek pro pridelani do x-carriage
   	  translate([base_width/2,nema17_width + ext_base_offset,3.6/2]) cube([base_width - 2*13,2.1,3.6],center=true);
	}
    translate([base_width/2,nema17_width - 10 + 45/2,base_height/2]) rotate([90,0,0]) 
	  cylinder(r=13.6,h=45,$fn=32,center=true);	
  }
  // Sloupky pro ventilatory
  intersection()
  {
	union()
	{
	  translate([fan_offset,nema17_width/2 - filament_offset[0],(base_height + 5)/2]) cube([7,14.8,base_height + 5],center=true);
	  translate([base_width - fan_offset,nema17_width/2 - filament_offset[0],(base_height + 5)/2]) cube([7,14.8,base_height + 5],center=true);
    }
	translate([base_width/2,nema17_width/2 - filament_offset[0],base_height - 6]) rotate([0,90,0]) cylinder(r=12,h=base_width+7-2*fan_offset+epsilon,$fn=32,center=true);
  }
  
}

module holder_holes()
{
  // Hotend 1
  translate([base_width/2 - filament_offset[2],nema17_width/2 - filament_offset[0],base_height - 5 - extruder_recess_big_h + epsilon]) groovemount_holes ();
  // Hotend 2
  translate([base_width/2 + filament_offset[2],nema17_width/2 - filament_offset[0],base_height - 5 - extruder_recess_big_h + epsilon]) groovemount_holes ();
  
  // Otvory pro matka - prisroubovani k x-carriage
  translate([base_width/2 - carriage_mount_distance/2,nema17_width-5 + ext_base_offset/2,3.6+4]) rotate([-90,90,180]) nut_hole(); 
  translate([base_width/2 + carriage_mount_distance/2,nema17_width-5 + ext_base_offset/2,3.6+4]) rotate([-90,90,180]) nut_hole();
  
  // Otvory pro pridelani drazaku trysek
  translate([base_width/2,nema17_width/2 - filament_offset[0] - HE_d/2,4]) rotate([180,0,0]) screw_hole();
  translate([base_width/2,nema17_width/2 - filament_offset[0] + HE_d/2,4]) rotate([180,0,0]) screw_hole();   
  
  // Vyrez pro maticku
  translate([fan_offset,nema17_width/2 - filament_offset[0],base_height - 2*epsilon]) 
  rotate([-90,0,-90]) nut_hole();
 
  translate([base_width - fan_offset,nema17_width/2 - filament_offset[0],base_height - 2*epsilon]) 
  rotate([90,0,-90]) nut_hole();
}

module nozzles_holder_base()
{ 
  intersection()
  {
	cube([4*filament_offset[2],nema17_width - 11,8]);
	translate([2*filament_offset[2],(nema17_width - 10 - 1)/2,0]) 
	  cylinder(r=2*filament_offset[2] + 3,h=40,$fn=64,center=true);
  }
}

module nozzles_holder_cuts()
{  
  // Hotend 1
  translate([filament_offset[2],nema17_width/2 - filament_offset[0],8+extruder_recess_big_h+epsilon]) rotate([0,180,90]) groovemount_holes(16.4,4.8,12.4,4.6,1);
  // Hotend 2
  translate([3*filament_offset[2],nema17_width/2 - filament_offset[0],8+extruder_recess_big_h+epsilon]) rotate([0,180,-90]) groovemount_holes(16.4,4.8,12.4,4.6,1);
  
  translate([2*filament_offset[2],nema17_width/2 - filament_offset[0] - HE_d/2,base_height-4]) cylinder(r=1.6,h=20,$fn=16,center=true);
  translate([2*filament_offset[2],nema17_width/2 - filament_offset[0] + HE_d/2,base_height-4]) cylinder(r=1.6,h=20,$fn=16,center=true);
  
  translate([2*filament_offset[2],nema17_width/2 - filament_offset[0] + HE_d/2,5]) rotate([180,0,0]) cylinder(r=3.3,h=10,$fn=6);
  translate([2*filament_offset[2],nema17_width/2 - filament_offset[0] - HE_d/2,5]) rotate([180,0,0]) cylinder(r=3.3,h=10,$fn=6);

  translate([0,27,0]) rotate([-60,0,0]) cube([base_width,10,10]);
}

module nut_hole(m3_nut_diameter=6.5)
{
	cylinder(r=m3_nut_diameter/2,h=3,$fn=6,center=true);
	translate([0,0,-5]) cylinder(r=1.5,h=20,$fn=16,center=true);
    translate([5,0,0]) cube([10,m3_nut_diameter*cos(30),3],center=true);
}

module screw_hole(m3_head_diameter=6.2)
{
	cylinder(r=m3_head_diameter/2,h=10,$fn=32);
	translate([0,0,-layer_height]) rotate([180,0,0]) cylinder(r=1.6,h=10,$fn=16);
}

module fan40_holes()
{
  rotate([90,0,0]) translate([0,0,0])
  {
	cylinder(r=19,h=20,$fn=64,center=true);
	translate([-16,-16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);
	translate([16,-16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);
	translate([16,16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);
	translate([-16,16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);	
  }
}


module holder()
{
  difference()
  {
    holder_base();
    holder_holes();
  }
}

module nozzles_holder()
{
  difference()
  {
	nozzles_holder_base();
	nozzles_holder_cuts();
  }
}

holder();
translate([-5,0,8]) rotate([180,0,180]) 
nozzles_holder();