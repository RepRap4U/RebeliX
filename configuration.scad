/*
	Konfiguracni soubor 3D tiskarny RebeliX X2
	
	Sledujte nas na:		  
			www.RepRap4U.cz
			www.facebook.com/RebeliX.cz
			https://twitter.com/reprap4u
			https://plus.google.com/+Reprap4uCz-3Dtiskarna-RebeliX
*/

/*================ Slic3r nastaveni ==========================*/

// Vyska vrstvy pro tisknuti dilu [mm]
layer_height = 0.3;

// Sirka vytlacovaneho materialu [mm]
extrusion_width = 0.66; //Slic3r->Print Settings->Advanced->Default extrusion width

/*==================== M6 sroub ==============================*/

// Rezerva prumeru hlavy sroubu [mm]
space = 1;

// Prumer hlavy M6 sroubu (pricte se rezerva) [mm]
M6_head_diameter = 10.6+space;
//M6_head_diameter = 12+space;

// Vyska hlavy M6 sroubu (dulezite pro zapusteni hlavy sroubu do plastu) [mm]
M6_head_height = 3.6;
//M6_head_height = 4.5;

// Delka sroubu M6 [mm]
// M6x12
M6_lenght = 12;

/*=================== Nastaveni dilu =========================*/

// Posun Z zakladny
z_base_offset = 11;

// Tloustka rohovych spojek
// 5 mm => sroub M6x14 s podlozkou
// 3 mm => sroub M6x12 s podlozkou
coupler_thickness = 5;

// Prumer 8mm tyce
rod_8mm_d = 8.2;

// Posun drzacku mezi x-motor a x-end
x_holder_position = 6.5;

/*======================== Motory ============================*/

// Delka motoru (ovlivni dily a delky tyci pro osy Z a Y)
//SX17-1003LQFE (doporuceno hlavne na osu Z)
//motor_length = 29.5;
//SX17-1003 (doporuceno hlavne na osu Z), SX17-0503LQEF
motor_length = 34;
//SX17-1005
//motor_length = 40;
//SX17-0905 - zde je jiz problem s velkou vyskou motoru na ose Z - musi se upravit endstop-holder
//motor_length = 48;

/*================ Remeny a remenicky ========================*/

// GT2 
belt_tooth_distance = 2;
belt_tooth_ratio = 0.5;

// T2.5
//belt_tooth_distance = 2.5;
//belt_tooth_ratio = 0.68;