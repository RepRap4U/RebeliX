// PRUSA Mendel  
// y LM8UU holder
// GNU GPL v3
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <../configuration.scad>

/**
 * @id bushing
 * @name Bushing
 * @category Printed
 * @id bushing
 */ 
 
y_linear_bearings();

// Linear bushing options

m3_diameter = M3_diameter;
lm8uu_diameter=15;
lm8uu_length=24;
lm8uu_radius = lm8uu_diameter / 2;
block_height = 2*lm8uu_length+17;

//cut_corners(true, false, true, false); 

module cut_corners(lf,lb,rf,rb){
	difference(){
	lm8uu_bearing_holder();
	if(lf) translate(v=[(10)-3,(-28.5/2)+3,0]) rotate(a=[0,0,45]) rotate(a=[35,0,0]) translate(v=[0,-5,0]) cube(size = [20,10,20], center = true);
	if(lb)translate(v=[(-10)+3,(-28.5/2)+3,0]) rotate(a=[0,0,-45]) rotate(a=[35,0,0]) translate(v=[0,-5,0]) cube(size = [20,10,20], center = true);
	mirror([ 0, 1, 0 ]){
	if(rf)translate(v=[(10)-3,(-28.5/2)+3,0]) rotate(a=[0,0,45]) rotate(a=[35,0,0]) translate(v=[0,-5,0]) cube(size = [20,10,20], center = true);
	if(rb)translate(v=[(-10)+3,(-28.5/2)+3,0]) rotate(a=[0,0,-45]) rotate(a=[35,0,0]) translate(v=[0,-5,0]) cube(size = [20,10,20], center = true);
	}
}
//lm8uu_bearing_holder();
}

module linear_holder_base(length){
	
difference(){
union(){
//main block
//translate(v=[-(lm8uu_radius+2.5)/2,0,block_height/2]) cube(size = [lm8uu_radius+2.5,lm8uu_diameter+5,block_height], center = true);
translate(v=[-5,0,length/2]) cube(size = [10,20,length], center = true);

//holder for main block in x-end
// leaving it out now
//translate(v=[0,0,0]) cylinder(h = length, r=10, $fn=60);

//translate(v=[-5,0,15.8/2]) cube(size = [12,23,15.8], center = true);
//translate(v=[0,0,0]) cylinder(h = block_height, r=lm8uu_radius+2.5, $fn=60);
}
//main axis
translate(v=[0,0,-2]) cylinder(h = length+4, r=(lm8uu_diameter+0.8)/2, $fn=50);
// not needed for zip tie
//main cut
//translate(v=[10,0,length/2]) cube(size = [20,14,length+4], center = true);
//smooth entry cut
//translate(v=[12,0,length/2]) rotate(a=[0,0,45]) cube(size = [20,20,length+4], center = true);
}
}

module y_linear_bearings(){
	difference(){
		union(){
translate(v=[0,0,1.5]) cube(size = [26,14,3], center = true);
translate(v=[-13,0,0])rotate(a=[0,0,30])cylinder(h = 3, r=7, $fn=6);
translate(v=[13,0,0])rotate(a=[0,0,30])cylinder(h = 3, r=7, $fn=6); 
}

translate(v=[-14,0,-0.1])cylinder(r=m3_diameter/2, h=10, $fn = 16);
translate(v=[14,0,-0.1])cylinder(r=m3_diameter/2, h=10, $fn = 16);

//hack
translate(v=[0,14.25,4.5]) rotate(a=[90,0,0]) translate(v=[0,9.5,0]) rotate(a=[0,0,90]){
	translate(v=[0,0,lm8uu_length/2+0.5]) ziptie();
}
}
cut_corners(true, true, true, true); 
}

lm8uu_holder_length = lm8uu_length+4.5;
lm8uu_holder_width= lm8uu_diameter+5;

module lm8uu_bearing_holder(){
translate(v=[0,14.25,4.5])rotate(a=[90,0,0])translate(v=[0,9.5,0]) rotate(a=[0,0,90]){

difference(){
	union(){
		linear_holder_base(lm8uu_length+4.5);
		translate(v=[-10-2,0,lm8uu_holder_length/2]) cube(size = [4,20,lm8uu_holder_length], center = true);
	}
	translate(v=[0,0,12.5]) ziptie();
}


translate(v=[-(10-5.5)/2-5.5,0,0.75]) cube(size = [10-5.5,20,1.5], center = true);
translate(v=[-(10-5.5)/2-5.5,0,lm8uu_length+3.75]) cube(size = [10-5.5,20,1.5], center = true);

}
}


module ziptie(){
difference(){
translate(v=[0,0,0]) cylinder(h = 3.9, r=lm8uu_diameter);
translate(v=[0,0,0]) cylinder(h = 5, r=lm8uu_diameter-3, $fn=50);
translate(v=[0,0,3]) cylinder(h = 1, r1=lm8uu_diameter-3, r2=lm8uu_diameter, $fn=50);
}}




