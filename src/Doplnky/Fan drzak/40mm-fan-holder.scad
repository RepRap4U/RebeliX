// RebeliX
//
// Drzak 40mm ventilatoru pro extruder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

vyska = 20;
offset_fan = 5;

module fan40_holes()
{
  rotate([90,0,0]) translate([20,20,0])
  {
	cylinder(r=19,h=20,$fn=64,center=true);
	translate([-16,-16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);
	translate([16,-16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);
	translate([16,16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);
	translate([-16,16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);	
  }
}

module fan_base()
{
  hull()
  {
    translate([40/2 + 11 + offset_fan,0,vyska-6.5]) rotate([-90,0,0]) cylinder(r=4,h=8,$fn=16);
    translate([40/2 - 11  + offset_fan,0,vyska-6.5]) rotate([-90,0,0]) cylinder(r=4,h=8,$fn=16);
    translate([40/2 - 15 + offset_fan,0,0]) cube([30,8,6.5]);
  }
  translate([0,0,0]) cube([40,12+3,6.5]);
}

module fan_cuts()
{
  translate([-0.1,6+3,6.5]) rotate([-38,0,0]) cube([50,12,6]);
  // Pridelani na extruder
  translate([40/2 + 11 + offset_fan,0,vyska-6.5]) rotate([90,0,0]) cylinder(r=1.6,h=20,$fn=16,center=true);
  translate([40/2 - 11 + offset_fan,0,vyska-6.5]) rotate([90,0,0]) cylinder(r=1.6,h=20,$fn=16,center=true);
  // Zapusteni sroubu
  translate([40/2 + 11 + offset_fan,6,vyska-6.5]) rotate([-90,0,0]) cylinder(r=3,h=10,$fn=32);
  translate([40/2 - 11 + offset_fan,6,vyska-6.5]) rotate([-90,0,0]) cylinder(r=3,h=10,$fn=32);
  // Seriznuti rohu
  translate([0,-0.1,vyska-7]) rotate([0,-45,0]) cube([10,10,10]);
  // Seriznuti drazku ventilatoru
  translate([-1,0,2]) rotate([240,0,0]) cube([50,11,10]);
}

module fan_holder()
{
  difference()
  {
    fan_base();
    fan_cuts();
    translate([0,6+3,7]) rotate([-128,0,0]) fan40_holes();
  }
}

rotate([90,0,0]) fan_holder();