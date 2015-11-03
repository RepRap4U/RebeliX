// Greg's Wade Extruder. 
// It is licensed under the Creative Commons - GNU GPL license. 
//  2010 by GregFrost
// Extruder based on prusa git repo.
// http://www.thingiverse.com/thing:6713
// modified for i3 by vlnofka <vlnofka@gmail.com>
// modified for RebeliX X2 by Martin Neruda <http://www.reprap4u.cz>

include<../../../configuration.scad>
include<../../inc/functions.scad>

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Define the hotend_mounting style you want by specifying hotend_mount=style1+style2 etc.
//e.g. wade(hotend_mount=groovemount+peek_reprapsource_mount);
j_head_groovemount=1;
3draty_groovemount=2;
rebel_groovemount=4;

default_extruder_mount=1;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

mounting_holes_legacy=1;
mounting_holes_symmetrical=2;
default_mounting_holes=mounting_holes_symmetrical;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

wade(hotend_mount=default_extruder_mount,
	mounting_holes=default_mounting_holes);
translate([-30,40,0]) wadeidler();	

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Parameters defining the wade body:

wade_body_offset = 3;
elevation = 9;
wade_block_height=55+elevation;
wade_block_width=24 - wade_body_offset;
wade_block_depth=28;

m3_diameter = 3.4;
m3_nut_diameter = 6.1+0.3;
m3_washer_diameter = 6.9;

m4_diameter = 4.8;
m4_nut_diameter = 8.3;

block_bevel_r=6;

base_thickness=12;
base_length=66;
base_leadout=22;
base_extra_depth=3; //zmeneno puvodne 0

nema17_hole_spacing=31; 
nema17_width=1.7*25.4;
nema17_support_d=nema17_width-nema17_hole_spacing;

screw_head_recess_diameter=7.2;
screw_head_recess_depth=3;

motor_mount_rotation=0;
motor_mount_translation=[46.78,50.78+elevation,0];
motor_mount_thickness=9;

large_wheel_translation=[50.5-(7.4444+32.0111+0.25),34+elevation,0];

drive_gear_hole=9+3.6;
hole_for_625=16.3;
625_diameter=22;
625_height = 5;

block_top_right=[wade_block_width,wade_block_height];

layer_thickness=layer_height;
filament_diameter=2;
filament_feed_hole_d=(filament_diameter*1.1)/cos(180/8);
hobbing_depth=0.3;
echo ("filament_feed_hole_d", filament_feed_hole_d);

//This is the distance from the centre of the filament to the centre of the hobbed bolt.
filament_feed_hole_offset=8/2-hobbing_depth+filament_diameter/2;

echo ("filament_feed_hole_offset", filament_feed_hole_offset);

idler_nut_trap_depth=7.5;
idler_nut_thickness=4;

gear_separation=7.4444+32.0111+0.25;

function motor_hole(hole)=[
	motor_mount_translation[0],
	motor_mount_translation[1]]+
	rotated(45+motor_mount_rotation+hole*90)*nema17_hole_spacing/sqrt(2);

// Parameters defining the idler.

filament_pinch=[
	large_wheel_translation[0]-filament_feed_hole_offset-filament_diameter/2,
	large_wheel_translation[1],
	wade_block_depth/2];
idler_axis=filament_pinch-[625_diameter/2,0,0];
idler_fulcrum_offset=625_diameter/2+3.5+m3_diameter/2;
idler_fulcrum=idler_axis-[0,idler_fulcrum_offset,0];
idler_corners_radius=4; 
idler_height=12;
idler_625_diameter=625_diameter+2;
idler_625_height=9;
idler_mounting_hole_across=8;
idler_mounting_hole_up=15;
idler_short_side=wade_block_depth-2;
idler_hinge_r=m3_diameter/2+3.5;
idler_hinge_width=6.5;
idler_end_length=(idler_height-2)+5;
idler_mounting_hole_diameter=m3_diameter+0.25;
idler_mounting_hole_elongation=1;
idler_long_top=idler_mounting_hole_up+idler_mounting_hole_diameter/2+idler_mounting_hole_elongation+2.5;
idler_long_bottom=idler_fulcrum_offset;
idler_long_side=idler_long_top+idler_long_bottom;
idler_bearing_offset = 3.5;

		 r_big = 9;
		r_small = 8;

module bearing_washer()
{
	difference()
	{
		cylinder(r=hole_for_625/2-0.05,h=1);
		translate([0,0,-1])
		cylinder(r=8,h=3);
	}
}

module wade(
	hotend_mount=default_extruder_mount,
	mounting_holes=default_mounting_holes)
{
	difference ()
	{
		union()
		{		
			// The wade block.
			translate([wade_body_offset,0,0])
			cube([wade_block_width,wade_block_height,wade_block_depth]);

			// Filler between wade block and motor mount.
			translate([10-2,0,0])
			cube([wade_block_width,
				wade_block_height,
				motor_mount_thickness]);

			// Round the ends of the base
			translate([base_length-base_leadout -10,0,0])
			cylinder(r=base_thickness/2,h=wade_block_depth+base_extra_depth,$fn=64);

			translate([-base_leadout + 10,0,0])
			cylinder(r=base_thickness/2,h=wade_block_depth+base_extra_depth,$fn=64);

			//Provide the bevel betweeen the base and the wade block.
			render()
			difference()
			{
				translate([-block_bevel_r+wade_body_offset,0,0])
				cube([block_bevel_r*2+wade_block_width,
					base_thickness/2+block_bevel_r,wade_block_depth+base_extra_depth]);				
				translate([-block_bevel_r+wade_body_offset,block_bevel_r+base_thickness/2])
				cylinder(r=block_bevel_r,h=wade_block_depth+base_extra_depth,$fn=60);
				translate([wade_block_width+block_bevel_r-3+wade_body_offset,
					block_bevel_r-3+base_thickness/2])
				cylinder(r=block_bevel_r-3,h=wade_block_depth+base_extra_depth,$fn=60);
				translate([wade_block_width+wade_body_offset,
					block_bevel_r-3+base_thickness/2])
				cube([2*(block_bevel_r-3),2*(block_bevel_r-3),wade_block_depth+base_extra_depth]);
				translate([wade_block_width+block_bevel_r-3+wade_body_offset,base_thickness/2])
				cube([2*(block_bevel_r-3),2*(block_bevel_r-3),wade_block_depth+base_extra_depth]);
				
			}
			// "Domecek" pro idler
			translate([wade_body_offset,0,0]) difference(){
				//#translate([-15,22,0]) cube([15,10,wade_block_depth]);
				translate([-18,21.8,0]) cube([18,10,wade_block_depth]);
				translate([-12,28,1.6]) cube([12,27,25]);
				translate([-18,12,-0.1]) rotate([0,0,45]) cube([10,10,30]);
			}
			
			//The base.
			translate([-base_leadout+10,-base_thickness/2,0])
			cube([base_length-20,base_thickness,wade_block_depth+base_extra_depth]);
			//Base aligement helper
			translate([-base_leadout+26,-0.5+4,wade_block_depth+base_extra_depth])
			cube([20,3.4,layer_thickness*5]);
			

			motor_mount ();
		}

		// Otvory pro srouby na pridelani trysky
		translate([large_wheel_translation[0]-filament_feed_hole_offset + 13,10,wade_block_depth/2]) rotate([-90,0,0]) 
		  nut_insert_hole();
		translate([large_wheel_translation[0]-filament_feed_hole_offset - 13,8,wade_block_depth/2]) rotate([-90,180,0]) 
		  nut_hole(); 

		translate([large_wheel_translation[0]-filament_feed_hole_offset + 12,0,8])
		rotate([0,180,0]) 
		  cylinder(r=1.3,h=40,$fn=16,center=false);

		translate([large_wheel_translation[0]-filament_feed_hole_offset - 10,0,8]) 
		rotate([0,180,0]) 
		  cylinder(r=1.3,h=40,$fn=16,center=false);
		  
		
		block_holes(mounting_holes=mounting_holes);
		motor_mount_holes ();

		translate([large_wheel_translation[0]-filament_feed_hole_offset,
			-base_thickness/2,wade_block_depth/2])
		rotate([-90,0,0])
		{
			if (in_mask (hotend_mount,j_head_groovemount))
				groovemount_holes (16.2);
			if (in_mask (hotend_mount,3draty_groovemount))
				groovemount_holes (16.2);
			if (in_mask (hotend_mount,rebel_groovemount))
				groovemount_holes (16.4);	
		}
	}
}

function in_mask(mask,value)=(mask%(value*2))>(value-1); 

module block_holes(mounting_holes=default_mounting_holes)
{
echo("bhmh", mounting_holes)
	//Round off the top of the block. 
	translate([0,wade_block_height-block_bevel_r,-1])
	render()
	difference()
	{
		translate([-1,0,0])
		cube([block_bevel_r+1,block_bevel_r+1,wade_block_depth+2]);
		translate([block_bevel_r,0,0])
		cylinder(r=block_bevel_r,h=wade_block_depth+2,$fn=40);
	}
	
	//carriage mountig holes
	translate([-24.5+64+4,-0.5,3]) {
		translate([-55,0,0]) {
			translate([0,0,(wade_block_depth+base_extra_depth)/2+6+layer_thickness]) cylinder(r=m3_diameter/2, h=wade_block_depth+base_extra_depth, center=true, $fn=20);
			translate([0, 0, 1]) cylinder(r=m3_washer_diameter/2, h=10.1, center=true, $fn=20);
		}
		
		translate([-15,0,0]) {
			translate([0,0,(wade_block_depth+base_extra_depth)/2+6+layer_thickness]) cylinder(r=m3_diameter/2, h=wade_block_depth+0.2+base_extra_depth, center=true, $fn=20);
			translate([0, 0, 1]) cylinder(r=m3_washer_diameter/2, h=10.1, center=true, $fn=20);
		}
	}

	translate(large_wheel_translation)
	{

			// Open the top to remove overhangs and to provide access to the hobbing.
			translate([-wade_block_width-1,0,19])
			cube([wade_block_width,
				wade_block_height-large_wheel_translation[1]+1,
				wade_block_depth]);
		
			translate([0,0,-1])
			b625(h=625_height+1);
			
			// Vyrez pro lozisko
			translate([0,-hole_for_625/2,625_height]) rotate([0,180,0]) cube([30,hole_for_625,10]);
		
			translate([0,0,23])
			b625(h=625_height);
		
			translate([-11.5,1,625_height+3])
			b625(h=wade_block_depth);
		
			// Zkraceni dilu
			translate([-15,-22.3/2,-0.1]) cube([7,50,wade_block_depth+1]);
			translate([-10,-hole_for_625/2,23]) cube(10,10,9);
			
			translate([0,0,625_height+layer_thickness])
			cylinder(r=drive_gear_hole/2,h=wade_block_depth-(8+layer_thickness)+2,$fn=64);	
			
			// Vyrez pro vsunuti hnaciho kolecka
			translate([-9,-9.4/2,625_height+layer_thickness])
			cube([9,9.4,20]);
			
			// Nabeh pro tisk previsu
			translate([0,drive_gear_hole/2,625_height+layer_thickness+5]) rotate([-45,0,180])cube([15,6,5]);
			translate([0,-drive_gear_hole/2,625_height+layer_thickness+5]) rotate([135,0,180])cube([15,6,5]);
			
			
			// Vyrez pro hnaci sroub
			translate([0,drive_gear_hole/2,625_height+layer_thickness]) rotate([0,0,180])cube([15,drive_gear_hole,5]);				

			// Filament feed.
			translate([-filament_feed_hole_offset,0,wade_block_depth/2])
			rotate([90,0,0])
			rotate(360/16)
			cylinder(r=filament_feed_hole_d/2,h=wade_block_depth*3+elevation,center=true,$fn=16);	

			// Otvor pro vstup filamentu
			translate([-filament_feed_hole_offset,50,wade_block_depth/2])
			rotate([90,0,0])
			rotate(360/16)
			cylinder(r=filament_feed_hole_d/2,h=wade_block_depth*3+elevation,center=true,$fn=16);		
			
			// Nabeh pro filament
			translate([-filament_feed_hole_offset,-4,wade_block_depth/2])
			rotate([90,0,0])
			cylinder(r1=filament_feed_hole_d/2+0.5,r2=filament_feed_hole_d/2,h=4,center=true,$fn=18);	
		    
			translate([-filament_feed_hole_offset,20,wade_block_depth/2])
			rotate([90,0,0])
			cylinder(r1=filament_feed_hole_d/2+0.5,r2=filament_feed_hole_d/2,h=4,center=true,$fn=18);

	}

	// Idler mounting holes and nut traps.
	for (idle=[-1,1])
	{
		translate([wade_body_offset,
			idler_mounting_hole_up+large_wheel_translation[1],
			wade_block_depth/2+idler_mounting_hole_across*idle])
		rotate([0,90,0])
		{
			rotate([0,0,180/8])
			translate([0,0,-1])
			cylinder(r=(m3_diameter+0.6)/2,h=wade_block_depth,$fn=16);	
			rotate([0,0,180/6])
			translate([0,0,wade_block_width-idler_nut_trap_depth+0.4])
			cylinder(r=m3_nut_diameter/2,h=idler_nut_thickness-0.8,$fn=6);	

			translate([0,10/2,wade_block_width-idler_nut_trap_depth+idler_nut_thickness/2])
			cube([m3_nut_diameter*cos(30),10,idler_nut_thickness-0.8],center=true);
		}
	}
}

module motor_mount()
{
	linear_extrude(height=motor_mount_thickness)
	{
		barbell (motor_hole(1),motor_hole(2),nema17_support_d/2, nema17_support_d/2,20,160);
		barbell (motor_hole(2),motor_hole(3),nema17_support_d/2, nema17_support_d/2,20,160);

		// Connect block to top of motor mount.
		barbell(block_top_right-[0,15],motor_hole(1),5,nema17_support_d/2,100,60);

		//Connect motor mount to base.
		barbell([base_length-base_leadout-10,
			0],motor_hole(3),base_thickness/2,
			nema17_support_d/2,100,70);
	}
}

module motor_mount_holes()
{
	radius=4/2;
	slot_left=1;
	slot_right=1;

	{
		translate([0,0,screw_head_recess_depth+layer_thickness])
		for (hole=[0:3])
		translate([motor_hole(hole)[0],motor_hole(hole)[1],0])
		rotate([0,0,25])
		{
			translate([-slot_left,0,0])
			cylinder(h=motor_mount_thickness-screw_head_recess_depth,r=radius,$fn=16);
			translate([slot_right,0,0])
			cylinder(h=motor_mount_thickness-screw_head_recess_depth,r=radius,$fn=16);

			translate([-slot_left,-radius,0])
			cube([slot_left+slot_right,radius*2,motor_mount_thickness-screw_head_recess_depth]);
		}

		translate([0,0,-1])
		for (hole=[0:3])
		translate([motor_hole(hole)[0],motor_hole(hole)[1],0])
		rotate([0,0,25])
		{
			translate([-slot_left,0,0])
			cylinder(h=screw_head_recess_depth+1,
				r=screw_head_recess_diameter/2,$fn=16);
			translate([slot_right,0,0])
			cylinder(h=screw_head_recess_depth+1,
				r=screw_head_recess_diameter/2,$fn=16);

			translate([-slot_left,-screw_head_recess_diameter/2,0])
			cube([slot_left+slot_right,
				screw_head_recess_diameter,
				screw_head_recess_depth+1]);
		}
	}
}

module wadeidler() 
{

bearing_rod_diameter = 5;

	difference(){
	  cube([24,45,8+3]);
	  union(){
	    translate([12,15,0]){
          // Hlavni rezy
		  difference(){
		    cube([625_height+4,24,25], center= true);
		    translate([-(625_height+4)/2-0.1,0,11-idler_bearing_offset]) rotate([0,90,0])
		    cylinder(r1=9,r2=4, h=2.1);
		    translate([(625_height+4)/2+0.1,0,11-idler_bearing_offset]) rotate([0,-90,0])
		    cylinder(r1=9,r2=4, h=2.1);
		  }
		  cube([625_height,24,25], center= true);
		  // Vyrez pro odklopeni
		  translate([-12.1,30,11]) rotate([0,90,0]) cylinder(r=9,h=25); 
  
		  // Osicka pro lozisko
		  translate([-10,0,11-idler_bearing_offset])rotate([0,90,0])cylinder(r=bearing_rod_diameter/2+0.1, h=20, $fn=16);
		  translate([-10,-bearing_rod_diameter/2-0.1,11-idler_bearing_offset]) cube([20,bearing_rod_diameter+0.2,6]);
		  // Otvory pro srouby
		  translate([8,16,-1])cylinder(r=2.2, h=24, $fn=20);
		  translate([-8,16,-1])cylinder(r=2.2, h=24, $fn=20);

		  translate([8,15,-1])cylinder(r=2.2, h=24, $fn=20);
		  translate([-8,15,-1])cylinder(r=2.2, h=24, $fn=20);
		}
	  }
	}	
}

module b625(h=5)
{
	translate([0,0,h/2]) cylinder(r=hole_for_625/2,h=h,center=true,$fn=60);
}

module barbell (x1,x2,r1,r2,r3,r4) 
{
	x3=triangulate (x1,x2,r1+r3,r2+r3);
	x4=triangulate (x2,x1,r2+r4,r1+r4);
	render()
	difference ()
	{
		union()
		{
			translate(x1)
			circle (r=r1);
			translate(x2)
			circle(r=r2);
			polygon (points=[x1,x3,x2,x4]);
		}
		
		translate(x3)
		circle(r=r3,$fa=5);
		translate(x4)
		circle(r=r4,$fa=5);
	}
}

function triangulate (point1, point2, length1, length2) = 
point1 + 
length1*rotated(
atan2(point2[1]-point1[1],point2[0]-point1[0])+
angle(distance(point1,point2),length1,length2));

function distance(point1,point2)=
sqrt((point1[0]-point2[0])*(point1[0]-point2[0])+
(point1[1]-point2[1])*(point1[1]-point2[1]));

function angle(a,b,c) = acos((a*a+b*b-c*c)/(2*a*b)); 

function rotated(a)=[cos(a),sin(a),0];

//========================================================
// Modules for defining holes for hotend mounts:
// These assume the extruder is verical with the bottom filament exit hole at [0,0,0].
module nut_insert_hole(m3_nut_diameter=6.5){
	cylinder(r=m3_nut_diameter/2,h=3,$fn=6,center=true);
	translate([0,0,-10]) cylinder(r=1.5,h=40,$fn=16,center=true);
    translate([5,0,0]) cube([10,m3_nut_diameter*cos(30),3],center=true);
}

module nut_hole(m3_nut_diameter=6.5){
	cylinder(r=m3_nut_diameter/2,h=10,$fn=6,center=true);
	translate([0,0,-15]) cylinder(r=1.5,h=40,$fn=16,center=true);
}

module groovemount_holes (extruder_recess_d=16.2)
{	
	extruder_recess_h=5;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1,$fn=64);
}