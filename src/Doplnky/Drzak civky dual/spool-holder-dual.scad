// RebeliX
//
// spool-holder-dual
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../../../configuration.scad>

spool_d_max = 205;
d_min = spool_d_max - 30;
d_max = spool_d_max + 30;
height = 7;
height_holder = 20;
angle = 13;
d_rod = 16;

module spool_holder_base()
{
	intersection()
	{
	  union()
	  {
	    intersection()
	    {
	      difference()
	      {
	        cylinder(r=d_max/2,$fn=64,h=height,center=true);
	        cylinder(r=d_min/2,$fn=64,h=height+1,center=true);
	      }
	    translate([d_max/2,-d_max/2 - sin(angle)*spool_d_max/2,0]) cube([d_max,d_max,height],center=true);	
	    }
	    // Zakladna pro prisroubovani
	    translate([10/2,-spool_d_max/2,height_holder/2-height/2]) cube([10,(d_max-d_min)/2 + 5,height_holder],center=true);
	    translate([10,-spool_d_max/2,height/2]) rotate([0,0,0]) cube([2*height,(d_max-d_min)/2 + 5,2*height],center=true);
	    // Drazka do profilu
	    translate([0,-spool_d_max/2,height_holder/2 - height/2]) cube([3,8,height_holder],center=true);
	    // Zaobleni
	    d = ((d_max - d_min)/2 - d_rod)/2;
	    translate([cos(angle)*(spool_d_max/2 - d_rod) + d/2,- sin(angle)*spool_d_max/2,0]) cylinder(r=d/2 + 0.3,h=height,$fn=32,center=true);
	    translate([cos(angle)*(spool_d_max/2 + d_rod) - d/2,- sin(angle)*spool_d_max/2,0]) cylinder(r=d/2 + 0.3,h=height,$fn=32,center=true);
	  }
	  difference()
	  {
	    translate([0,0,-height/2 - 1]) cylinder(r=d_max/2,$fn=64,h=60);
	    translate([0,0,-height/2 - 1]) cylinder(r=d_min/2,$fn=64,h=60);
	  }
	}
}


module spool_holder_cuts()
{
  angle_a = 35;
  angle_b = 68;
  
  // Vyrez pro tyc s loziskem 
  rotate([0,0,-angle-5]) translate([spool_d_max/2,0,0]) cylinder(r=d_rod/2,h=30,$fn=32,center=true);
  
  intersection()
  {
    difference()
	{
      cylinder(r=spool_d_max/2 + d_rod/2,$fn=64,h=height + 1,center=true);
      cylinder(r=spool_d_max/2 - d_rod/2,$fn=64,h=height + 1,center=true);
    }
    rotate([0,0,-angle-5]) translate([spool_d_max/2,angle_b-angle_a,0]) cube([60,2*(angle_b-angle_a),height + 1],center=true);
  }
   
  // Odlehceni
  rotate([0,0,-angle_b]) translate([spool_d_max/2,0,0]) cylinder(r=14/2,h=30,$fn=32,center=true);
  rotate([0,0,-angle_a]) translate([spool_d_max/2,0,0]) cylinder(r=14/2,h=30,$fn=32,center=true);
  intersection()
  {
    difference()
	{
      cylinder(r=spool_d_max/2 + 7,$fn=64,h=height + 1,center=true);
      cylinder(r=spool_d_max/2 - 7,$fn=64,h=height + 1,center=true);
    }
    rotate([0,0,-angle_b]) translate([spool_d_max/2,angle_b-angle_a,0]) cube([60,2*(angle_b-angle_a),height + 1],center=true);
    rotate([0,0,-angle_a]) translate([spool_d_max/2,-angle_b+angle_a,0]) cube([60,2*(angle_b-angle_a),height + 1],center=true);
  }

  // Otvor pro M6 sroub
  translate([10/2 + 7,-spool_d_max/2,height/2 + M6_head_diameter/2]) rotate([0,90,0]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30, center=true);
  translate([0,-spool_d_max/2,height/2 + M6_head_diameter/2])rotate([0,90,0]) cylinder(r = M6_dia/2, h = 30, $fn = 30, center=true);
  
  // Vyztuzeni uchytu
  translate([10 + height,-spool_d_max/2,3*height/2]) rotate([90,0,0]) cylinder(r=height,h=(d_max-d_min)/2 + 5,$fn=32,center=true); 
  
  // Vyrez pro profilovou matku 
  translate([-3,-spool_d_max/2,height/2 + M6_head_diameter/2]) cube([6,10,profile_nut_width],center=true);
  
  // Seriznuti pro snazsi tisk
  if(profile_nut_width != 0)
  {
	translate([0,-spool_d_max/2 + 15,height/2 + M6_head_diameter/2 + profile_nut_width/2]) rotate([0,40,180]) cube([3,30,8]);
  }
}

module spool_holder()
{
  difference()
  {
    spool_holder_base();
    spool_holder_cuts();
  }
}

spool_holder();
translate([-30,30,0]) rotate([0,0,-100]) mirror([0,1,0]) spool_holder();   

// Testovaci civka
/*
%rotate([0,0,-angle-5]) translate([spool_d_max/2,0,height]) cylinder(r=spool_d_max/2,h=2,$fn=64,center=true);
%rotate([0,0,-angle-5]) translate([spool_d_max/2,0,0]) cylinder(r=d_rod/2,h=40,$fn=64,center=true);
*/
