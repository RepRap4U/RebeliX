// PRUSA Mendel  
// y LM8UU holder
// GNU GPL v3
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <../configuration.scad>

/**
 * @id bushing
 * @name Bushing
 * @category Printed
 * @id bushing
 */ 
 
y_linear_bearings();

// Linear bushing options

m3_diameter = 3.5;
lm8uu_diameter=15;
lm8uu_length=24;
lm8uu_radius = lm8uu_diameter / 2;
block_height = 2*lm8uu_length+17;

//cut_corners(true, false, true, false); 

module cut_corners(lf,lb,rf,rb)
{
  difference()
  {
	lm8uu_bearing_holder();
	if(lf) translate([(10)-3,(-28.5/2)+3,0]) rotate(a=[0,0,45]) rotate(a=[35,0,0]) translate([0,-5,0]) cube(size = [20,10,20], center = true);
	if(lb)translate([(-10)+3,(-28.5/2)+3,0]) rotate(a=[0,0,-45]) rotate(a=[35,0,0]) translate([0,-5,0]) cube(size = [20,10,20], center = true);
	mirror([ 0, 1, 0 ])
	{
	  if(rf)translate([(10)-3,(-28.5/2)+3,0]) rotate(a=[0,0,45]) rotate(a=[35,0,0]) translate([0,-5,0]) cube(size = [20,10,20], center = true);
	  if(rb)translate([(-10)+3,(-28.5/2)+3,0]) rotate(a=[0,0,-45]) rotate(a=[35,0,0]) translate([0,-5,0]) cube(size = [20,10,20], center = true);
	}
  }
}

module linear_holder_base(length)
{	
difference()
  {
    translate([-6,0,length/2]) cube(size = [16,22,length], center = true);

    translate([0,0,-2]) cylinder(h = length+4, r=lm8uu_diameter/2, $fn=50);
  }
}

module y_linear_bearings()
{
  difference()
  {
	union()
	{
	  translate([0,0,1.5]) cube(size = [26,14,3], center = true);
	  translate([-13,0,0])rotate(a=[0,0,30])cylinder(h = 3, r=7, $fn=6);
	  translate([13,0,0])rotate(a=[0,0,30])cylinder(h = 3, r=7, $fn=6); 
	}
	translate([-14,0,-0.1])cylinder(r=m3_diameter/2, h=10, $fn = 16);
	translate([14,0,-0.1])cylinder(r=m3_diameter/2, h=10, $fn = 16);

	//hack
	translate([0,14.25,4.5]) rotate(a=[90,0,0]) translate([0,9.5,0]) rotate(a=[0,0,90])
	{
	  translate([-2,0,12.5]) ziptie();
	}
  }
  
  cut_corners(true, true, true, true); 
}

lm8uu_holder_length = lm8uu_length+4.5;
lm8uu_holder_width= lm8uu_diameter+5;

module lm8uu_bearing_holder()
{
  translate([0,14.25,4.5])rotate(a=[90,0,0])translate([0,9.5,0]) rotate(a=[0,0,90])
  {
	difference()
	{
	  union()
	  {
		linear_holder_base(lm8uu_length+4.5);
		translate([-10-2,0,lm8uu_holder_length/2]) cube(size = [4,20,lm8uu_holder_length], center = true);
	  }
	  
	  translate([-2,0,12.5]) ziptie();
	  translate([-14+3,14,14.25]) rotate([0,90,0]) cylinder(r=7/2, h=30, $fn = 32);
	  translate([-14+3,-14,14.25]) rotate([0,90,0]) cylinder(r=7/2, h=30, $fn = 32);
	}
	translate([-(10-5.5)/2-5.5,0,0.75]) cube(size = [10-5.5,20,1.5], center = true);
	translate([-(10-5.5)/2-5.5,0,lm8uu_length+3.75]) cube(size = [10-5.5,20,1.5], center = true);
  }
}

module ziptie()
{
  difference()
  {
	translate([0,0,0]) cylinder(h = 3.9, r=12.5, $fn=50);
	translate([0,0,0]) cylinder(h = 5, r=10, $fn=50);
  }
}




