// Herringbone extruder gears
// GNU GPL v3
// Václav 'ax' Hůla <axtheb@gmail.com>
// Josef Průša <josefprusa@me.com>

// ThingDoc entry
/**
 * @name Greg's Large Gear
 * @id large-gear
 */
 
/**
 * @name Greg's Small Gear
 * @id small-gear
 */

include <../../../configuration.scad>
include <../inc/metric.scad>
include <../inc/functions.scad>
use <../inc/parametric_involute_gear_v5.0.scad>



m3_diameter = 3.5;
m3_nut_diameter = 6;//5.8;

gear_distance = 40;

translate([0,0,gear_width / 2 + 3]) rotate([0,180,0]) small();
//%translate([gear_distance, 0, 0]) rotate([0, 180, 92]) big(); //this should touch, teeth should mesh
translate([-gear_distance - 10, 10, 0]) big();

gear_width=12;
teeth_small=15;
teeth_big=49;
teeth_twist=400;
circular_pitch = (gear_distance * 180 * 2) / (teeth_small + teeth_big);
echo (circular_pitch);

module small(){
    difference() {
        union() {
            mirror([0, 0, 1 ]) gear (number_of_teeth=teeth_small,
                    circular_pitch=circular_pitch,
                    gear_thickness = gear_width/2,
                    rim_thickness = gear_width/2,
                    hub_thickness = 0,
                    hub_diameter = 18,
                    bore_diameter = 0,
                    circles=0,
                    twist = teeth_twist/teeth_small);
            gear (number_of_teeth=teeth_small,
                    circular_pitch=circular_pitch,
                    gear_thickness = gear_width/2,
                    rim_thickness = gear_width,
                    hub_thickness = 0,
                    hub_diameter = 18,
                    bore_diameter = 0,
                    circles=0,
                    twist = teeth_twist/teeth_small*2);
            //hub. Two part to make it thicker
            translate([0, 0, gear_width / 2 + 0.5]) {
                cylinder(r1=8, r2=11, h=2.5);
            }
            translate([0, 0, gear_width / 2 + 3]) {
                cylinder(r=11, h=6);
            }
        }
        //bore
        translate([0, 0, -gear_width / 2 -0.1]) cylinder(r=5.1 / 2, h=gear_width + 9.2 + 1,$fn=32);

        translate([0, 0, gear_width / 2 + 4.5]) rotate([0, 90, 0]) {
            cylinder(r=m3_diameter / 2, h=20,$fn=16);
            translate([0, 0, 5]) nut(m3_nut_diameter, 2.6, false);
            translate([-10, -m3_nut_diameter / 2, 5]) cube([10, m3_nut_diameter, 2.6]);
        }
    }
}

hole_size=6.6;

module big(){
    difference() {
        union(){
            mirror([0, 0, 1]) gear (number_of_teeth=teeth_big,
                    circular_pitch=circular_pitch,
                    gear_thickness = gear_width/2,
                    rim_thickness = gear_width/2,
                    hub_thickness = 0,
                    hub_diameter = 0,
                    bore_diameter = 0,
                    circles=0,
                    twist = teeth_twist/teeth_big);
            gear (number_of_teeth=teeth_big,
                    circular_pitch=circular_pitch,
                    gear_thickness = gear_width/2,
                    rim_thickness = gear_width/2,
                    hub_thickness = 0,
                    hub_diameter = 18,
                    bore_diameter = 18,
                    circles=0,
                    twist = teeth_twist/teeth_big); 
			
			//threaded bolt trap
			difference()
			{
			  translate([0, 0, -gear_width / 2]) 
				cylinder(r1=20, r2=8, h=7 + layer_height * 9,$fn=64);
			  translate([0, 0, -gear_width / 2 + layer_height * 6 + 4]) 
				nut(8, h=8);
			  translate([0, 0, -gear_width / 2 - 0.1]) 
				cylinder(r=5.2 / 2, h=gear_width + 9.2,$fn=32);
			}
        }
        //reduce mass
        difference()
		{
		  translate([0, 0, 3 - gear_width / 2]) rotate([0, 0, 90]) 
				cylinder(r1=24, r2=28, h=gear_width - layer_height * 9 + 1, $fn=36);
          translate([0, 0, -gear_width / 2]) 
				cylinder(r1=20, r2=8, h=7 + layer_height * 9,$fn=64);
		
		
		}
		//bore
        translate([0, 0, -gear_width / 2 - 0.1]) cylinder(r=5.1 / 2, $fn = 32,h=gear_width + 9.2);
        for (hole=[0:5]) {
            rotate([0, 0, 360 / 6 * hole + 30]) translate([17,0,-10]) rotate(12) {
                cylinder(r=hole_size, h=20);
                cube([hole_size, hole_size, 20]);
            }
        }

    }
}
