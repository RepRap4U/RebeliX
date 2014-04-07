// Vyska vrstvy pro tisknuti dilu [mm]
layer_height = 0.3; //Slic3r->Print Settings->Layers and perimeters->Layer height

// Rezerva prumeru hlavy sroubu [mm]
spare = 1;
// Prumer hlavy M6 sroubu (pricte se rezerva) [mm]
M6_head_diameter = 10.6+spare;
//M6_head_diameter = 12+spare;

// Vyska hlavy M6 sroubu (dulezite pro zapusteni hlavy sroubu do plastu) [mm]
M6_head_height = 3.6;
//M6_head_height = 4.5;

// Delka motoru (ovlivni dily pro osy Z a Y)
//SX17-1003LQFE (doporuceno hlavne na osu Z)
motor_length = 29.5;
//SX17-1003 (doporuceno hlavne na osu Z)
//motor_length = 34;
//SX17-1005
//motor_length = 40;
//SX17-0905 - zde je jiz problem s velkou vyskou motoru na ose Z - musi se upravit endstop-holder
//motor_length = 48;

// Sirka vytlacovaneho materialu [mm]
extrusion_width = 0.66; //Slic3r->Print Settings->Advanced->Default extrusion width

/// Vyberte typ remenu ******************************************************

// GT2 
belt_tooth_distance = 2;
belt_tooth_ratio = 0.5;

// T2.5
//belt_tooth_distance = 2.5;
//belt_tooth_ratio = 0.68;