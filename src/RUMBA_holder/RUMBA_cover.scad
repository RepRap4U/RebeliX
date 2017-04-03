// RebeliX
//
// RUMBA vrchni kryt
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../../configuration.scad>
include <../inc/honeycomb.scad>
include <../inc/functions.scad>
use <../inc/text_RebeliX.scad>

sirka = 75;
vyska = 135;
rohy_prumer = 5;
tloustka = 2.5;
tloustka_steny = 3;
// solid_plate = 0 => otvory skrz
// solid_plate = 1 => prvni 2 vrstvy vyplnene na 100%
solid_plate = 1;
// Vyska sloupku
sloupek = 0;

mount_holes = [
	[4, 3.5, 0],
	[4 + 36,3.5, 0],
	[4,vyska - 3.5, 0],
	[sirka - 8/2,vyska - 3.5, 0]
];

mount_holes_offset = [0,0,0];

cover_corners = [
	[rohy_prumer/2 - 3,rohy_prumer/2 - 3,0],
	[sirka-rohy_prumer/2 + 3,rohy_prumer/2 - 3,0],
	[sirka-rohy_prumer/2 + 3,vyska-rohy_prumer/2 + 3,0],
	[rohy_prumer/2 - 3,vyska-rohy_prumer/2 + 3,0]
];

module obvod(length)
{ 
  difference()
  {
	hull()
	{
	  for (a = cover_corners)
	  translate(a)
	  {
		cylinder(r=rohy_prumer/2,h=tloustka,$fn=32);
	  } 
	}	
	translate([tloustka_steny,tloustka_steny,solid_plate == 0 ? -0.1 : 2*layer_height]) cube([sirka-2*tloustka_steny,vyska-2*tloustka_steny,tloustka+1]);
  }
  // Otvory pro srouby
  for (a = mount_holes)
  translate(a+mount_holes_offset)
  {
	// Sloupek
	cylinder(d=8,h=tloustka + sloupek,$fn=32);
  } 
}

module mrizka()
{
  intersection()
  {
    union()
	{
      // Honeycomb(length, width, height, cell_size, wall_thickness);
      translate([0,0,0]) honeycomb(sirka, vyska, tloustka, 8, 1.2);
	  // Pole pro text
	  translate([0,vyska - 20 - 15,0]) cube([sirka,20,tloustka]);
	}
	hull()
	{
	  for (a = cover_corners)
	  translate(a)
	  {
	    cylinder(r=rohy_prumer/2,h=tloustka,$fn=32);
	  }
	}
  }
}

module otvory()
{
  for (a = mount_holes)
  {
    // Otvory pro srouby
	translate(a+[0,0,-0.1]+mount_holes_offset)
	cylinder(d=4.3,h=tloustka+sloupek + 1,$fn=16);
  }
}


module RUMBA_cover()
{ 
  difference()
  {
    union()
    {
	  obvod();
	  mrizka();
    }	
  otvory();

  // Napis
  translate([sirka/2,vyska - 20 - 5,tloustka - 1.5]) mirror([0,0,0]) scale([0.7,0.7,1]) text_RebeliX(tloustka);
  }
}  

RUMBA_cover();