// RebeliX
//
// endstop_X_Y-holder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

rod_dia = 8.2;
height = 12;
endstop_width = 16;

module endstop_base()
{
  translate([5.5/2,0,0]) cube([rod_dia + 9.5,endstop_width, height], center=true);
}


module endstop_cuts()
{
  nut_offset = 2.5;
  
  // Vyrez pro M8 tyc
  cylinder(r=rod_dia/2, h = 12 + 0.01, $fn = 32, center = true);
  
  // Otvory pro pridelani endstopu
  translate([-rod_dia/2,9.5/2,0]) rotate([0,90,0]) cylinder(r=2.2/2,h=8,$fn=16,center=true);
  translate([-rod_dia/2 ,-9.5/2,0]) rotate([0,90,0]) cylinder(r=2.2/2,h=8,$fn=16,center=true);

  // Vyrez pro nasazeni na M8 tyc
  translate([rod_dia,0.2,0]) rotate([0,0,3]) cube([2*rod_dia,rod_dia - 1,height + 0.01], center=true);
  translate([rod_dia,-0.2,0]) rotate([0,0,-3]) cube([2*rod_dia,rod_dia - 1,height + 0.01], center=true);
  
  // Vyrez pro M3
  translate([rod_dia/2 + nut_offset,-endstop_width/2,0]) rotate([90,30,0]) nut(6.6,2.5);
  translate([rod_dia/2 + nut_offset,0,0]) rotate([90,0,0]) cylinder(r=3.3/2,h=endstop_width + 0.01,$fn=16,center=true);
  translate([rod_dia/2 + nut_offset,endstop_width/2,0]) rotate([90,0,0]) cylinder(r=7/2,h=5,$fn=32,center=true);
}


module nut(nut_diameter=6.6,nut_height=3){
	cylinder(r=nut_diameter/2,h=2*nut_height,$fn=6,center=true);
}

module endstop()
{
  difference()
  {
	endstop_base();
    endstop_cuts();
  }
}

endstop();