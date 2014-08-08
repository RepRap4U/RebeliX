// RebeliX
//
// extruder idler
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Inspired by Prusa i3


module extruder_idler_base(){
 translate([0,0,0]) cube([24,45,8+3]);
}

module extruder_idler_holes(){
 translate([12,15,0]){
  // Main cutout
  difference(){
  cube([11,24,25], center= true);
  translate([-5.6,0,11-4])rotate([0,90,0])cylinder(r1=9,r2=6, h=2.1);
  translate([5.6,0,11-4])rotate([0,-90,0])cylinder(r1=9,r2=6, h=2.1);
  }
  cube([7,24,25], center= true);
  // Vyrez pro odklopeni
  translate([-12.1,30,11]) rotate([0,90,0]) cylinder(r=9,h=25); 
  
  // Idler shaft
  translate([-10,0,11-4])rotate([0,90,0])cylinder(r=4.2, h=20);
  translate([-10,-4.1,11-4]) cube([20,8.2,6]);
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