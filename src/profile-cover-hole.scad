// RebeliX
//
// profile-cover-hole
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

// Vyska "zobacku" pro zasunuti do profilu
height = 6;

// Delka hrany pro zasunuti do profilu
edge = 10.1;

module profile_cover_base()
{
  cube([30,30,4*layer_height],center=true);
  translate([0,0,height/2]) cube([edge,edge,height],center=true);
}

module profile_cover_cuts()
{
  translate([edge/2,-edge/2,height-0.5]) rotate([0,-30,0]) cube([5,edge,5]);
  translate([-edge/2,-edge/2,height-0.5]) rotate([0,-60,0]) cube([5,edge,5]);
  translate([-edge/2,edge/2,height-0.5]) rotate([30,0,0]) cube([edge,5,5]);
  translate([-edge/2,-edge/2,height-0.5]) rotate([60,0,0]) cube([edge,5,5]);
  // Otvor pro napajeci kabely
  cube([edge-4*extrusion_width-0.1,edge-4*extrusion_width-0.1,4*height], center=true);
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