// RebeliX
//
// RUMBA drzak
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
tloustka = 6;
tloustka_steny = 3;
// solid_plate = 0 => otvory skrz
// solid_plate = 1 => prvni 2 vrstvy vyplnene na 100%
solid_plate = 0;
// Vyska sloupku
sloupek = 13;
PCB_thickness = 2;
// Radius zakulacenych rohu
corner_rad = 6;
// Sirka hlinikoveho profilu
profile_width = 30;

mount_holes = [
	[4, 3.5, 0],
	[4 + 36,3.5, 0],
	[4,vyska - 3.5, 0],
	[sirka - 8/2,vyska - 3.5, 0]
];

mount_sloupek = [
	[4, rohy_prumer/2 - 3 + 1.5/2 , 0],
	[4 + 36,rohy_prumer/2 - 3 + 1.5/2, 0],
	[4,vyska-rohy_prumer/2 + 3 - 1.5/2, 0],
	[sirka - 8/2,vyska-rohy_prumer/2 + 3 - 1.5/2, 0]
];

mount_holes_offset = [0,0,0];

cover_corners = [
	[rohy_prumer/2 - 3,rohy_prumer/2 - 3,0],
	[sirka-rohy_prumer/2 + 3,rohy_prumer/2 - 3,0],
	[sirka-rohy_prumer/2 + 3,vyska-rohy_prumer/2 + 3,0],
	[rohy_prumer/2 - 3,vyska-rohy_prumer/2 + 3,0]
];

zip_position = [
	[sirka/2 - 15,82.5 - 15/2 + 1,tloustka/2],
	[sirka/2,82.5 - 45  + 15,tloustka/2],
	[sirka/2 + 20,82.5 - 45,tloustka/2],
];

module holder_base(length)
{
  translate([0,0,0]) rounded_box(length,profile_width,tloustka,corner_rad,1,1,1,1);
  translate([-length/2 + profile_width/2,0,tloustka/2]) rotate([0,0,90]) drazka(profile_width);
}

module holder_cuts(length)
{
  // Otvor pro M6 srouby
  translate([-length/2 + profile_width/2,0,0]) cylinder(d=M6_dia, h=30, $fn = 32, center=true);
}

module wire_holder_base(pocet_pozic,delka)
{
	translate([0,0,0]) rounded_box(delka,pocet_pozic*15,tloustka,corner_rad,1,1,1,1);
}

module wire_holder_cuts(pocet_pozic,delka)
{
	for(i=[0:15:pocet_pozic*15 - 15])
	{
		translate([0,-(pocet_pozic*15)/2 + 15/2 + i,tloustka/2 + 2]) rotate([0,90,0]) zip_paska(6);
	}
}

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
  
  // Sloupky pro srouby
  for (a = mount_holes)
  translate(a+mount_holes_offset)
  {
	cylinder(d=8,h=tloustka + sloupek,$fn=32);
	cylinder(d=10,h=tloustka,$fn=32);
  } 
  
  for (a = mount_sloupek)
  translate(a+mount_holes_offset)
  {
	translate([0,0,(tloustka + sloupek)/2]) cube([8,3.5 -(-rohy_prumer/2 - 0.5),tloustka + sloupek],center=true);
  } 
  
  // Zarazky pro elektroniku
  translate([0,-4/2,(tloustka + sloupek)/2 + PCB_thickness/2])
  {
	translate(mount_sloupek[0]) cube([8,3.5 -(-rohy_prumer/2 - 0.5) - 4,tloustka + sloupek + PCB_thickness],center=true);
	
	translate(mount_sloupek[1]) cube([8,3.5 -(-rohy_prumer/2 - 0.5) - 4,tloustka + sloupek + PCB_thickness],center=true);
  }
  
  translate([0,4/2,(tloustka + sloupek)/2 + PCB_thickness/2])
  {
	translate(mount_sloupek[2]) cube([8,3.5 -(-rohy_prumer/2 - 0.5) - 4,tloustka + sloupek + PCB_thickness],center=true);
	
	translate(mount_sloupek[3]) cube([8,3.5 -(-rohy_prumer/2 - 0.5) - 4,tloustka + sloupek + PCB_thickness],center=true);
  } 
  
  // Sloupky pro podepreni elektroniky
  translate(mount_holes[0] + [0,43,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
  translate(mount_holes[1] + [14 + 12.5/2,13.5 + 12/2,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
  translate(mount_holes[0] + [10,84,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
  translate(mount_holes[1] + [14 + 12.5/2,13.5 + 12/2,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
  translate(mount_holes[1] + [14 + 12.5/2,13.5 + 12/2 + 46.5,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
  translate(mount_holes[1] + [-6,61,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
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
	  
	  // Pozice pro zip pasky
	  for(a = zip_position)
	  translate(a)
	  {
	    wire_holder_base(1,8);
	  }	
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
	translate(a+[0,0,30/2 + 8/2 + layer_height]+mount_holes_offset)
	cylinder(d=3.4,h=30,$fn=16,center=true);
	
	translate(a+[0,0,0]+mount_holes_offset)
	cylinder(d=6,h=8,$fn=32,center=true);
  }
}

module RUMBA_holder()
{
  offset_spodni = 35;
  offset_horni = 10;
  
  difference()
  {
    union()
    {
	  obvod();
	  mrizka();
	  
	  // Pridelani na profil
	  translate([-(profile_width + 20)/2,vyska - profile_width/2 - offset_horni,tloustka/2]) holder(profile_width + 20);
	  
	  translate([-(profile_width + 20)/2,profile_width/2 + offset_spodni,tloustka/2]) holder(profile_width + 20);
	  
	  translate([-20/2,profile_width/2 + offset_spodni + profile_width,tloustka/2]) cube([20,profile_width + 5,tloustka],center=true);
	  
	  translate([sirka + 5,6*15/2,tloustka/2]) wire_holder(6,9);
	  
	  // Drzak kabelu od extruderu
	  translate([sirka/2 + 15,vyska + 20/2,tloustka/2]) rounded_box(20,20,tloustka,corner_rad,0,1,1,0);
    }	
  otvory();
  
  // Zip pasky
  for(a = zip_position)
  translate(a)
  {
    wire_holder_cuts(1,8);
  }	

  translate([sirka/2 + 15,vyska + 15/2 + 8,tloustka]) rotate([90,0,0]) zip_paska(6);
  translate([sirka/2 + 15,vyska + 2,tloustka]) rotate([90,0,0]) zip_paska(6);
  translate([sirka/2 + 15,vyska + 20/2,tloustka + 2 + 10/2 + 2]) rotate([90,0,0]) cylinder(r=10,h=20 + rohy_prumer + 1,$fn=32,center=true);
  
  
  translate([-10,vyska - offset_horni - 5,tloustka + 2]) rotate([90,0,0]) zip_paska(6);
  translate([-10,vyska - offset_horni - 25,tloustka + 2]) rotate([90,0,0]) zip_paska(6);
  translate([sirka/2,vyska - 20 - 5,-tloustka + 1]) mirror([1,0,0]) scale([0.7,0.7,1]) text_RebeliX(tloustka);
  }
}  

module holder(length)
{
  difference()
  {
	holder_base(length);
	holder_cuts(length);
  }
}

module wire_holder(pocet_pozic=1,delka=12)
{
  difference()
  {
	wire_holder_base(pocet_pozic,delka);
	wire_holder_cuts(pocet_pozic,delka);
  }
}

RUMBA_holder();