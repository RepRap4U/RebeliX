// RebeliX
//
// nozzle mount
// GNU GPL v3
// Martin Neruda
// http://www.reprap4u.cz

mount_height = 8;
mount_width = 25;
mount_length = 38;

// Z probe ?
// 1 = ANO
// 0 = NE
z_probe = 0;
// Prumer Z sondy
z_probe_dia = 18.4;
// Prumer matky pro prisroubovani sondy
z_probe_nut = 27;

epsilon = 0.01;

module nozzle_mount_base()
{
  if(z_probe)
  {
    translate([2 + z_probe_nut/4,0,0]) cube([mount_length + 4 + z_probe_nut/2,mount_width,mount_height],center=true);
	translate([mount_length/2 + 4 + z_probe_nut/2,0,0]) cylinder(r=mount_width/2,h=mount_height,$fn=32,center=true);
  }
  else
  cube([mount_length,mount_width,mount_height],center=true);
}

module nozzle_mount_cuts()
{
  translate([0,0,4.4]) cylinder(r=8.5,h=mount_height,$fn=30,center=true);
  translate([0,-mount_width/2,4.4]) cube([17,mount_width,mount_height],center=true);
	
  translate([0,0,-mount_height/2 - epsilon]) cylinder(r=6.1,h=mount_height,$fn=30);
  translate([0,-mount_width/2,-epsilon]) cube([12.2,mount_width,mount_height],center=true);
	
  // Otvory pro prisroubovani
  translate([-13,0,0]) cylinder(r=1.6,h=mount_height+1,$fn=30,center=true);
  translate([-13 - mount_width/2,0,0]) cube([mount_width,2*1.6,mount_height+1],center=true);
		
  translate([13,0,0]) cylinder(r=1.6,h=mount_height+1,$fn=30,center=true);
  translate([-13,0,-mount_height/2 + 4]) cylinder(r=7/2,h=mount_height,$fn=30); translate([-13 - mount_width,-7/2,-mount_height/2 + 4]) cube([mount_width,7,mount_height]);
	
  translate([13,0,-mount_height/2 + 4]) cylinder(r=7/2,h=mount_height,$fn=30);
  
  if(z_probe)
  {
    // Z probe
    translate([mount_length/2 + 4 + z_probe_nut/2,0,0]) cylinder(r=z_probe_dia/2,h=mount_height + 0.01,$fn=32,center=true); 
    echo("Nozzle X offset:",mount_length/2 + 4 + z_probe_nut/2);
  }
  else
  {
    translate([13 + mount_width/2,0,0]) cube([mount_width,2*1.6,mount_height+1],center=true);
	translate([13,-7/2,-mount_height/2 + 4]) cube([mount_width,7,mount_height]);
	// Seriznute rohy
	translate([mount_length/2,-mount_width/2,0]) rotate([0,0,45]) cube([5,5,mount_height + 1],center=true);
    translate([mount_length/2,mount_width/2,0]) rotate([0,0,135]) cube([5,5,mount_height + 1],center=true);
  }	
	
  // Seriznute rohy
  translate([-mount_length/2,mount_width/2,0]) rotate([0,0,135]) cube([5,5,mount_height + 1],center=true);
  translate([-mount_length/2,-mount_width/2,0]) rotate([0,0,-45]) cube([5,5,mount_height + 1],center=true);
}

module nozzle_mount()
{
  difference()
  {
    nozzle_mount_base();
	nozzle_mount_cuts();
  }
}

nozzle_mount();