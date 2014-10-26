// RebeliX
//
// extruder idler
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Prusa i3

bearing_diameter = 16.3;
bearing_width  = 5;
bearing_rod_diameter = 5;
bearing_offset = 3.5;

module extruder_idler_base(){
 translate([0,0,0]) cube([24,45,8+3]);
}

module extruder_idler_holes(){
 translate([12,15,0]){
  // Main cutout
  difference(){
	cube([bearing_width+4,24,25], center= true);
	translate([-(bearing_width+4)/2-0.1,0,11-bearing_offset])rotate([0,90,0])
	cylinder(r1=9,r2=4, h=2.1);
	translate([(bearing_width+4)/2+0.1,0,11-bearing_offset])rotate([0,-90,0])
	cylinder(r1=9,r2=4, h=2.1);
  }
  cube([bearing_width,24,25], center= true);
  // Vyrez pro odklopeni
  translate([-12.1,30,11]) rotate([0,90,0]) cylinder(r=9,h=25); 
  
  // Idler shaft
  translate([-10,0,11-bearing_offset])rotate([0,90,0])cylinder(r=bearing_rod_diameter/2+0.1, h=20, $fn=16);
  translate([-10,-bearing_rod_diameter/2-0.1,11-bearing_offset]) cube([20,bearing_rod_diameter+0.2,6]);
  // Screw holes
  translate([8,16,-1])cylinder(r=2.2, h=24, $fn=20);
  translate([-8,16,-1])cylinder(r=2.2, h=24, $fn=20);

  translate([8,15,-1])cylinder(r=2.2, h=24, $fn=20);
  translate([-8,15,-1])cylinder(r=2.2, h=24, $fn=20);
 }
}


// Idler final part
module idler(){
 difference(){
  extruder_idler_base();
  extruder_idler_holes();
 }
}

idler();