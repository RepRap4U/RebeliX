// RebeliX
//
// Drzak 40mm ventilatoru pro extruder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

module fan40_holes(){
  rotate([90,0,0]) translate([20,20,0]){
	cylinder(r=19,h=20,$fn=64,center=true);
	translate([-16,-16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);
	translate([16,-16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);
	translate([16,16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);
	translate([-16,16,0]) cylinder(r=1.3,h=20,$fn=16,center=true);	
  }
}

module fan_base(){
  translate([0,0,0]) cube([40,6,14]);
  translate([0,0,0]) cube([40,12,6.5]);
}

module fan_cuts(){
  translate([-0.1,6,6.5]) rotate([-50,0,0]) cube([50,12,6]);
  // Pridelani na extruder
  translate([40/2 - 11,0,9]) rotate([90,0,0]) cylinder(r=1.6,h=20,$fn=16,center=true);
  translate([40/2 + 11,0,9]) rotate([90,0,0]) cylinder(r=1.6,h=20,$fn=16,center=true);
  // Zapusteni sroubu
  translate([40/2 - 11,4,9]) rotate([-90,0,0]) cylinder(r=3,h=10,$fn=32);
  translate([40/2 + 11,4,9]) rotate([-90,0,0]) cylinder(r=3,h=10,$fn=32);
  // Seriznuti rohu
  translate([0,-0.1,7]) rotate([0,-45,0]) cube([10,10,10]);
  translate([2,0,7+6.5/2]) cube([7,20,7],center=true);
  translate([0,0,8.5]) rotate([0,45,0]) cube([5,20,5],center=true);
  translate([40,-0.1,7]) rotate([0,-45,0]) cube([10,10,10]);
  // Seriznuti drazku ventilatoru
  translate([0,10,0]) cube([40,11,10]);
}

module fan_holder(){
difference(){
  fan_base();
  fan_cuts();
  translate([0,7,7]) rotate([-150,0,0]) fan40_holes();
}
}

rotate([90,0,0]) fan_holder();