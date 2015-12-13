// CC BY-NC-SA
// (C) Ricky White Jan 2015.
//
// This file requires the files of the origional project to be unzipped into the same directory as this file.
//	Case_for_the_Full_Graphic_Smart_LCD_Controller.zip
// This is so the origional STL files can be used and modified by mods_for_display_case.scad
//
///////////////////////////////////////////////////////////////////////

// parameters
//---------------------------------------------------------------------
// The push button switch appears to be different heights on different boards.  on mine it measures 6mm from the bottom of the PCB to the top of the switch not pressed.
// This parameter will adjust both the putton size and the switch support in the front of the case
switch_height_from_board_base = 6;	// needed for my recent display board sources from aliexpress.



// Constants
orig_switch_height_from_board_base = 4;
delka_zobacku = 92;

// modification code
// Spplies SD card cutout and other modifications
//---------------------------------------------------------------------
module card_access_wall( height=15.7)
{
	$fa=0.01;

	translate([100,55,0])
	{
		// wall
		difference()
		{
			difference()
			{
				translate([50,0,0]) cylinder(height, d=100);
				translate([52,0,0]) cylinder(height, d=100);
				translate([8,-50,0])cube([100,200,40]);
			}
			translate([-7,-50,0]) cube([10,1000,30]);
		}

	translate([1.5,-20,0]) cube([2.5,40,height]);
	}



}


module card_access_cutout()
{
	$fa=0.01;

	translate([100,55,-1])
	{
		// wall
		translate([52,0,0]) cylinder(20, d=100);
		translate([52,0,1.86]) cylinder(3.5, d=103);
	}
}

module card_access_cutout_front()
{
	$fa=0.01;

	translate([100,55,-1])
	{
		// wall
		translate([52,0,0]) cylinder(20, d=100);
	}
}


// curved part of interlocking lip of case
module case_lip(oversize=3)
{
	$fa=0.01;
	translate([100,55,0.70]) translate([52,0,0.8])
	{
		difference()
		{
			difference()
			{
				cylinder(3.5, d=103+oversize);
				cylinder(3.5, d=103);
			}
			union()
			{
				translate([-46,-60,-1.20]) cube([100,120,5]);
				translate([-43.7,-60,0]) cube([100,120,10]);
			}
		}
	}
}

// ALlows shortening of the button guild for switched larger than the origional
module mask_button_guide()
{
	delta=switch_height_from_board_base - orig_switch_height_from_board_base;
	translate([45,4,6.4-delta])
	{
		cube([11,22,40]);
	}
}

module sloupek(vyska){
	difference(){
		cylinder(r=5/2,h=vyska,$fn=16,center=true);
		cylinder(r=2.4/2,h=vyska+1,$fn=16,center=true);
	}
}

module case_front()
{
	difference()
	{
		union()
		{
			difference()
			{
				translate([-142,-55,-11])	import("Case_for_the_Full_Graphic_Smart_LCD-Top_Case_FGD.stl", convexity=10);
				card_access_cutout_front();
			}
			translate([0,0,-0.4]) card_access_wall(16);
		}
		// slot
		translate([100,40,12.7])	cube([10,30,3]);
		// slot for lip of rear case
		translate([1,0,12.7]) case_lip(10);

		// shorteN switch post for taller switches
		mask_button_guide();
		
		// Text
		translate([95,95.5,-1.7]) rotate([0,0,90]) import("text_RebeliX.stl", convexity=10);
	}
	// Sloupky v rozich
	translate([4.1,4.1,2+7.6/2]) sloupek(7.6);
	translate([4.1,4.1+86.5,2+7.6/2]) sloupek(7.6);
	translate([4.1+99.5,4.1+86.5,2+7.6/2]) sloupek(7.6);
	translate([4.1+99.5,4.1,2+7.6/2]) sloupek(7.6);
	

}


module case_rear()
{
	difference()
	{
		union()
		{
			difference()
			{
				rotate([0,180,0]) translate([-276,-55,-24])
				{
				import("Case_for_the_Full_Graphic_Smart_LCD_Controller-Bottom_Case_FGD.stl", convexity=10);
				}
				card_access_cutout();

			}
			translate([0,0,4.37]) card_access_wall(6.5);
		}
		translate([107,10,-0.2]) cube([10,100,4.5]);
	}
	// For better print mounting holes
    translate([4,4,6]) cylinder(h=0.3,r=4);
	translate([4,90,6]) cylinder(h=0.3,r=4);
	translate([103,4,6]) cylinder(h=0.3,r=4);
	translate([103,90,6]) cylinder(h=0.3,r=4);

	difference()
	{
		case_lip();
		// Slot
		translate([90,40,1])	cube([20,30,4]);
	}
}



// Imports the origional button and scales it
// I print tyhe button narrow end down so it gets a nice finish from the glass bed of my printer.
// My prusa i3 deravitive printer is fine with the overhang required to do this.  yours may differ.
module button()
{
	delta=switch_height_from_board_base - orig_switch_height_from_board_base;
	orig_height = 10;		// height of origional button in STL
	new_height = orig_height-delta;	// new switch types will always be fatter than the origional (assumption)

	z_scale = new_height / orig_height;
	scale([1,1,z_scale])	rotate([-90,0,0]) 
	{
		import("Case_for_the_Full_Graphic_Smart_LCD_Controllerf-Kill_Button_FGD.stl", convexity=10);
	}
}

// Pridelani do profilu 
module base(){
	translate([0,0,0]) cube([7.2+1.8+3,delka_zobacku,10]);

}

module cuts(){
	translate([0,-0.1,10]) mirror([0,0,1]) rotate([0,40,0]) cube([2.2,delka_zobacku+1,6]);
	translate([-0.1,-0.1,10 - 1]) cube([2,delka_zobacku+1,3]);
	translate([-0.1,-0.1,1.2]) rotate([0,135,0]) cube([2,delka_zobacku+1,3]);
	translate([7.2+1.8+3,-0.1,10-1.5]) rotate([0,-40,0]) cube([2,delka_zobacku+1,6]);
}

module drazka(){
difference(){
	base();
	cuts();
}	
}





// Render
//----------------------------------------------------------------------------/
case_front();
//translate([108.6/2 - delka_zobacku/2,7.4+1.8+3,0.14]) rotate([0,0,-90]) drazka();
//rotate([180,0,0]) translate([0,0,-11]) case_rear();
//translate([100,0,10]) button();
