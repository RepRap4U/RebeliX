// RebeliX
//
// x-motor
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>

// Vertikalni korekce
v_corr = 0; //0.65;

x_rod_distance = 45 + v_corr;
motor_width = 42.3;
height = 13.5;
length = x_rod_distance+12;
pulley_diameter = 16;
// Tloustka endstopu (pro umisteni k motoru)
endstop_width = 6.5;

module x_motor_base(){
  cube([motor_width,length + 1,height],center=true);
  // Drzak Z endstopu
  translate([-motor_width/2,-length/2 -9,-height/2]) cube([25,10,5]);
  // Poutko na nacvaknuti k x-end  
  for(i = [4 : 4 : 8]){
	translate([-motor_width/2 - x_holder_position,-2,-height/2]){
		translate([0,-i,0]) cylinder(r=3,h=2-layer_height,$fn=32);
		translate([0,-i,0]) cylinder(r=2,h=5,$fn=32);
		translate([0,-3-i,0]) cube([5+x_holder_position,2*3,2-layer_height]);
		
		translate([-3,-8,0]) cube([5,2*2,2-layer_height]);
		translate([-2,-8,0]) cube([2*2,4,5]);
	}
  }
}

module x_motor_cuts(){
  translate([-motor_width/2+2,-length/2 + 6,height/2 - 1]) rod_cuts();
  translate([-motor_width/2+1,length/2 - 6,height/2 - 1]) rod_cuts();
  // Prisroubovani motoru
  translate([15.5,15.5,0])
  {
    translate([0,0,0]) cylinder(r=1.9,h=30,$fn=32,center=true);
	translate([2,0,0]) cylinder(r=1.9,h=30,$fn=32,center=true);
	translate([1,0,0]) cube([2,2*1.9,30],center=true);
	
	translate([-31,-31,0]) cylinder(r=1.9,h=30,$fn=32,center=true);
	translate([-29,-31,0]) cylinder(r=1.9,h=30,$fn=32,center=true);
	translate([-30,-31,0]) cube([2,2*1.9,30],center=true);
	
	translate([-31,0,0]) cylinder(r=1.9,h=30,$fn=32,center=true);
	translate([-29,0,0]) cylinder(r=1.9,h=30,$fn=32,center=true);
	translate([-30,0,0]) cube([2,2*1.9,30],center=true);
  }
  // Vyrez pro motor
  cylinder(r=11.5,h=30,$fn=64,center=true);
  // Vyrez pro remen
  translate([0,-11.5,-height/2 - 0.1]) cube([30,2*11.5,30]);
  
  // Vyrez pro endstop
  translate([0,-length/2 - 10,-height/2 - 1]) cube([30,30,20]);
  
  // Setreni plastem
  translate([-motor_width/2 - 0.1,-11.5,0]) cube([30,2*11.5,30]);
  // Serizle hrany
  translate([0,11.5,height/2+2.5]) rotate([45,0,0]) cube([motor_width + 1,5,5],center=true);
  translate([0,-11.5,height/2 + 2.5]) rotate([45,0,0]) cube([motor_width + 1,5,5],center=true);

  // Otvory pro pridelani ZIP pasky sroubky
  translate([-motor_width/2 + 5,-length/2 -2.5,0])
  cylinder(r=1.2,h=30,$fn=16,center=true);
  translate([-motor_width/2 + 15,-length/2 -2.5,0])
  cylinder(r=1.2,h=30,$fn=16,center=true);
  
  // Seriznuti drzaku na Z-endstop
  translate([-motor_width/2 -0.1,-length/2-9,-height/2 + 3.5]) rotate([45,0,0]) cube([25,10,5]); 
}

module rod_cuts(){
  // 8mm tyc
  translate([0,0,0]) rotate([0,90,0]) cylinder(r=4.1, h=100, $fn=32,center=true);
  // Vyrez pro ZIP pasky
  for( i = [12 : 18 : 36])
  {
    translate([i,0,0]) rotate([0,90,0]) difference()
	{
       cylinder(r=6.6, h=3.5, $fn=32, center=true);
	   cylinder(r=5, h=4, $fn=32, center=true);
    }
  }	
}

module endstop() {
  difference(){
    union(){
      // Telo endstopu
      translate([0,0,0]) color("blue") cube([10,20,endstop_width], center=true);
      // Vyvody
	  translate([-9,7,0]) cube([8,3,4],center=true);
      translate([-9,-7,0]) cube([8,3,4],center=true);
      // Spinac
      translate([5,7,0]) cube([3,3,4],center=true);
    }
  // Otvory pro zip pasku
  translate([-2,5,0]) cylinder(r=1.5,h=10,$fn=16,center=true);
  translate([-2,-5,0]) cylinder(r=1.5,h=10,$fn=16,center=true);
  }
  
}

module x_motor(){
  difference() {
    x_motor_base();
    x_motor_cuts();
  }
}  

x_motor();

// X-endstop
%translate([15,-length/2 + 6,height/2 - 2*4.1]) endstop();
// Z-endstop
%translate([-(motor_width - 2)/2 + 9,-length/2 -4.5,-height/2 -endstop_width/2]) mirror([1,0,0]) rotate([0,0,-90]) endstop();