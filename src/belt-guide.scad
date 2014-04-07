// PRUSA iteration3
// 623 bearing belt guide
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include <../configuration.scad>

wall= 2*extrusion_width;
clearence= 0.1; 

module belt_guide_base(){
 cylinder(r=5+clearence+2*wall, h=5-0.7, $fn=60);
 //cylinder(r=6.5+wall+clearence, h=5-0.2, $fn=50);
 cylinder(r=6.5+wall+clearence+2*wall, h=0.6, $fn=60);
}

module belt_guide_holes(){
 translate([0,0,2.2]) cylinder(r=5+clearence, h=10, $fn=60);
 translate([0,0,-1]) cylinder(r=5+wall+clearence-2*wall, h=10, $fn=60);
}

// Final part
module belt_guide(){
 difference(){
  belt_guide_base();
  belt_guide_holes();
 }
}

belt_guide();