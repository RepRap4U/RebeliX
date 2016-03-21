// RebeliX
//
// profile-cover-hole
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

// Vyska "zobacku" pro zasunuti do profilu
height = 6;

module profile_cover_base()
{
	cube([30,30,4*layer_height],center=true);
	translate([0,0,height/2]) cube([10,10,height],center=true);
}

module profile_cover_cuts()
{
	translate([5,-10/2,height-0.5]) rotate([0,-30,0]) cube([5,10,5]);
	translate([-5,-10/2,height-0.5]) rotate([0,-60,0]) cube([5,10,5]);
	translate([-10/2,5,height-0.5]) rotate([30,0,0]) cube([10,5,5]);
	translate([-10/2,-5,height-0.5]) rotate([60,0,0]) cube([10,5,5]);
	// Otvor pro napajeci kabely
	cube([10-4*extrusion_width-0.1,10-4*extrusion_width-0.1,4*height], center=true);
	
}

module profile_cover_hole()
{
	difference()
	{
	  profile_cover_base();
	  profile_cover_cuts();
	}
}
	
profile_cover_hole();		