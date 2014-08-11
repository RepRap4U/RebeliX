// Sliding Project box V1.2, now with screw holes!
// John Newman, 25th November 2011
// Edited by Martin Neruda (neruda@reprap4u.cz)

//
// A parameterised enclosure for electronic projects, with support for PCB slots, Screw holes and blocks
// and apertures in the lid and 'top' end.
// The lid slides on, which holds your PCB(s) in.
// Apertures are added with code in the modules "HoleInLid" and "HoleInEnd". See the comments.

// Outside dimensions of the box, and other structural dimensions

OutL = 120;		// Length in mm (puvodne 107)
OutW = 65.5 ; 	// Width in mm
OutD = 62	;		// Depth in mm
WallT = 2.1	;	// Wall thickness (mm)

// PCB supports are defined by the distance to the underside of the PCB, from the top external of the box.
// Supports for the PCB are ribs above and below
PCBgap = 2 ;	// Slot size for PCB to slide into
PCB1 = 38 ;		// Position of first PCB (0 if none)
PCB2 = 0;		// Position of second PCB (0 if none)
PCB3 = 0 ;		// Position of third PCB (0 if none)

// Screw fasteners are positioned by defining their centre , below the top external surface
// They will be positioned on either side at that height. You have to make sure they are not in a PCB slot!
Screws1 = 58 ;	// Position of screws
Screws2 = 6;	// Second set of screws
// Optionally specify the screw hole diameter, to have the holes 'printed'. Otherwise drill them...
ScrewH = 1.0 ;	// Screw hole diameter, in base
ScrewL = 0.0 ;	// Screw hole diameter, in lid

// More obscure parameters
BRad = 4 ;		// Radius of curvature, box edges (mm)
// For wide boxes (>50/60mm) you may want to use this, or make WallT larger for rigidity.
Ridge = 0.5;		// Depth of reinforcing ridge at end of base. 0 to suppress, is WallT multiplier. (not mm!) e.g 1.5

Sdepth = 1.0 ;	// Depth of support ribs for Lid and PCB (mm)
Swidth = 1.4;
// Bevelled ridge to hold lid on (in mm)
RHeight = 3 ;	// Top ridge height
RWidth = 2 ;	// Top ridge width (out over the box)
// Plastic blocks to screw into
ScrewD = 10 ;	// Depth of screw block (which the screw goes into)
ScrewW = 6 ;	// Width of Screw block, and of countersink in lid

Allow = 0.5;		// Allowance for fit of the lid. A gap around it, and elsewhere.


// *******************************  View / render options ********************************

// Print Box on on it's own
//translate([0,0,OutL/2-WallT]) rotate([0,-90,90]) pbox() ;  	// Rotate and position for printing

// Print Lid on it's own
//translate([0,0,OutD/2]) pboxlid() ;					// Rotate and position for printing


// Print both together (if they fit!)

difference(){
	union(){
		translate([0,-OutW/2-5,OutD/2]) pboxlid();
		translate([-OutL/2+2,-OutW+2,0]) cube([14,5,OutD-10]);		
	}
	union(){
		translate([-OutL/2-0.1,-13,OutD/2-22]) cube([10,10,20]);
		translate([-OutL/2-0.1,-13,OutD/2-12]) rotate([0,90,0])cylinder(h=10,r=10);
	}
}

difference(){
	union(){
	translate([0,OutD/2+5,OutL/2-WallT]) rotate([0,-90,90]) pbox();
	translate([-4,OutD+2*WallT+0.2,0]) cube([8,2,30]);
	translate([-4,OutD+2*WallT+0.2,60]) cube([8,2,30]);
	}
	union(){
	  // Reset hole
	  translate([OutW/2-6,37,38]) rotate([0,90,0]) cylinder(h=10,r=3);
	  // Holes for Arduino Mega2560
	  translate([-OutW/2+6,OutD+6,0]) rotate([90,0,0]){
	  // Holes for zip ties
	  translate([-10,110,43]) rotate([0,90,0])
	  cylinder(h=10,r=1.8,$fn=16);
	  translate([-10,110,52]) rotate([0,90,0])
	  cylinder(h=10,r=1.8,$fn=16);
	  
	  translate([-10,70,43]) rotate([0,90,0])
	  cylinder(h=10,r=1.8,$fn=16);
	  translate([-10,70,52]) rotate([0,90,0])
	  cylinder(h=10,r=1.8,$fn=16);
	  
	  translate([-10,30,43]) rotate([0,90,0])
	  cylinder(h=10,r=1.8,$fn=16);
	  translate([-10,30,52]) rotate([0,90,0])
	  cylinder(h=10,r=1.8,$fn=16);
	}
	// Mounting holes
	translate([0,OutD,15]) rotate([-90,0,0]) cylinder(r = 3.05, h = 20, $fn = 30);
	translate([0,OutD,75]) rotate([-90,0,0]) cylinder(r = 3.05, h = 20, $fn = 30);	
	// Hole for X motor and endstop cables
	translate([0,OutD+1,OutD/2-8]) rotate([90,0,0]) cube([50,60,7]);
	}
}


// ***************  Your modules to add apertures to  ***************************

// These two modules are where you can put function calls to create holes
// You should use the functions shown in comments, where the
// parameters are in measured from the top left (outside dimension) when looking at the surface (ext).
// Do a test, you'll see how it goes.
// X is across, Y is down, W is x width, D is y depth.

// Called by pboxlid to make any required holes in the lid face
module HoleInLid() {
//	lidround(x,y,w);		// for round holes, X & Y give the centre
//	lidrect(x,y,w,d);		// for rectangular holes, X & Y give the top left corner
// Vent slots	
for (i = [15: 8 : 95] )
{
	lidrect(OutW/2-13/2,i,13,4);
	lidrect(OutW/2-13/2-13-4,i,13,4);
	lidrect(OutW/2-13/2+13+4,i,13,4);
}
	lidrect(OutW/2-13/2,7,13,4);
	lidrect(OutW/2-13/2,103,13,4);
}


// Called by pbox to make any required holes in the end of the box
module HoleInEnd() {
//	endround(x,y,w);		// for round holes, X & Y give the centre
//	endrect(x,y,w,d);		// for rectangular holes, X & Y give the top left corner
	endrect(38,27,24,10); // Power connector
	endrect(43,24,2.5,4) ; // 'teeth'
	endrect(54.5,24,2.5,4) ;
	endrect(42,36,10,14) ; // DC socket
	endrect(11,38,14,12); // USB connector

   // Vent slots
   translate([0,0,0]) {
	endrect(3.4,12,12.7,4);
	endrect(18.7,12,12.7,4);
	endrect(34,12,12.7,4);
	endrect(49.1,12,12.7,4);

	endrect(3.4,18,12.7,4);
	endrect(18.7,18,12.7,4);
	endrect(34,18,12.7,4);
	endrect(49.1,18,12.7,4);

	endrect(3.4,6,12.7,4);
	endrect(18.7,6,12.7,4);
	endrect(34,6,12.7,4);
	endrect(49.1,6,12.7,4);
	}

	// Hole for Y, Z motor and endstop cables
	endrect(32,53,30,6);

}


// **************** Main Box and Lib modules  *************************

// The Project Box
module pbox() {
	blen = OutL-WallT*2 ;		// Len of box w/o endplate
	rheight = WallT * Ridge ;	// Ridge height, if any
	slen = OutW-WallT*2+0.2  ;	// Lib support at end length
	union () {
		difference() {
			rotate ([0,90,0]) roundedBox(OutD,OutW,blen,BRad,$fn=40) ;
			translate([WallT*2,0,WallT*2]) rotate ([0,90,0]) roundedBox(OutD+(WallT*2),OutW-(WallT*2),OutL,BRad) ;
			HoleInEnd() ;
		}
		topridge() ;		// Add a ridge around the top to hold the lid on
		// Add support to hold the lid up at the sides
		support(OutD/2-RHeight-0.5) ;		
		// Support the end of the lid
		translate([-(OutL/2-WallT*2+0.1),OutW/2-WallT-0.1,OutD/2-RHeight-0.6-Sdepth]) rotate([0,0,-90]) cube([slen,Swidth,Sdepth]) ;
		// Optional reinforcing ridge
		if (Ridge != 0) {
			translate([OutL/2-WallT,-OutW/2+BRad,-OutD/2+WallT+rheight-0.1]) rotate([0,180,0]) halfslab(rheight*2,OutW-BRad*2,rheight) ;
		}
		if (PCB1 != 0) {
			support(OutD/2 - PCB1) ;	// Support under the PCB
			support(OutD/2 - (PCB1 - Sdepth - PCBgap)) ;	// Support over the PCB
		}
		if (PCB2 != 0) {
			support(OutD/2 - PCB2) ;	// Support under the PCB
			support(OutD/2 - (PCB2 - Sdepth - PCBgap)) ;	// Support over the PCB
		}
		if (PCB3 != 0) {
			support(OutD/2 - PCB3) ;	// Support under the PCB
			support(OutD/2 - (PCB3 - Sdepth - PCBgap)) ;	// Support over the PCB
		} 
		if (Screws1 != 0) {
			translate([OutL/2-WallT,OutW/2-ScrewW/2-Allow,OutD/2-Screws1]) rotate([0,-90,0]) sblock(ScrewW,ScrewH,ScrewD) ;
			translate([OutL/2-WallT,-(OutW/2-ScrewW/2)+Allow,OutD/2-Screws1]) rotate([0,90,180]) sblock(ScrewW,ScrewH,ScrewD) ;
		}
		if (Screws2 != 0) {
			translate([OutL/2-WallT,OutW/2-ScrewW/2-Allow,OutD/2-Screws2]) rotate([0,-90,0]) sblock(ScrewW,ScrewH,ScrewD) ;
			translate([OutL/2-WallT,-(OutW/2-ScrewW/2)+Allow,OutD/2-Screws2]) rotate([0,90,180]) sblock(ScrewW,ScrewH,ScrewD) ;
		}
	}
}

// Sliding lid for Box
module pboxlid() {
	wid = OutW-(WallT*2)-Allow ;
	dadj = Allow ;			// Depth adjustment of end plate, seems to help...
	union() {
		difference() {
			translate([0,0,0]) rotate ([0,90,0]) roundedBox(OutD-dadj,OutW,OutL,BRad) ;
			translate([-(OutL/2-WallT*2),-(OutW+5)/2,-(OutD/2+2.5)]) cube([OutL+5,OutW+5,OutD+5]) ;
			// Hollow out end plate
			//translate([-(OutL/2-WallT),-(OutW/2)+ScrewW+Allow+WallT,-(OutD/2)+0.1]) cube([10,OutW-(ScrewW+WallT+Allow)*2,OutD-WallT*3]) ;
			translate([-(OutL/2-WallT),-(OutW/2)+ScrewW+Allow,-(OutD/2)+0.1]) cube([10,OutW-(ScrewW+Allow)*2,OutD-WallT*3]) ;
			// Support wedge
			//translate([WallT*2-OutL/2+0.1,-(OutW/2)+ScrewW+Allow+WallT-0.1,OutD/2-WallT])
			//		rotate([0,180,0]) halfslab(WallT,OutW-(ScrewW+WallT+Allow-0.1)*2,WallT*2) ; 
			translate([WallT*2-OutL/2+0.1,-(OutW/2)+ScrewW+Allow-0.1,OutD/2-WallT])
					rotate([0,180,0]) halfslab(WallT,OutW-(ScrewW+Allow-0.1)*2,WallT*2) ; 
			// Screw countersinks as req
			if (Screws1 != 0) {
				translate([0.3-OutL/2,OutW/2-ScrewW/2-Allow,-OutD/2+Screws1]) rotate([0,90,0]) countersink() ;
				translate([0.3-OutL/2,-(OutW/2-ScrewW/2)+Allow,-OutD/2+Screws1]) rotate([0,90,0])  countersink() ;
			}
			if (Screws1 != 0 && ScrewL != 0) {
				translate([-(OutL/2 + 2),OutW/2-ScrewW/2-Allow,-OutD/2+Screws1])
					rotate([0,90,0]) cylinder(WallT*4,ScrewL/2,ScrewL/2,$fn=8) ;
				translate([-(OutL/2 + 2),-(OutW/2-ScrewW/2)+Allow,-OutD/2+Screws1])
					rotate([0,90,0]) cylinder(WallT*4,ScrewL/2,ScrewL/2,$fn=8) ;
			}
			if (Screws2 != 0) {
				translate([0.3-OutL/2,OutW/2-ScrewW/2-Allow,-OutD/2+Screws2]) rotate([0,90,0]) countersink() ;
				translate([0.3-OutL/2,-(OutW/2-ScrewW/2)+Allow,-OutD/2+Screws2]) rotate([0,90,0])  countersink() ;
			}
			if (Screws2 != 0 && ScrewL != 0) {
				translate([-(OutL/2 + 2),OutW/2-ScrewW/2-Allow,-OutD/2+Screws2])
					rotate([0,90,0]) cylinder(WallT*4,ScrewL/2,ScrewL/2,$fn=8) ;
				translate([-(OutL/2 + 2),-(OutW/2-ScrewW/2)+Allow,-OutD/2+Screws2]) 
					rotate([0,90,0]) cylinder(WallT*4,ScrewL/2,ScrewL/2,$fn=8) ;
			}
		}
		render() {
			translate([-(OutL/2-0.1),0,-OutD/2+RHeight]) rotate([180,0,0]) platform(RHeight,wid,wid-(RWidth*2),OutL-WallT-Allow) ;
		}
	}
}

// ****************** Worker modules  ************************

module countersink() {
	difference() {
		union() {
			cylinder(WallT,ScrewW/2,1) ;
			translate([0,0,-(WallT-0.1)]) cylinder(WallT,ScrewW/2,ScrewW/2) ;
		}
	}
}

// Platform bevelled on three sides
// Parameters are height, width at base, width at top and length
module platform(h,wb,wt,l) {
	difference() {
		polyhedron (points=[[0,-(wb/2),0],[l,-(wb/2),0],[l,(wb/2),0],[0,(wb/2),0], [0,-(wt/2),h],[l,-(wt/2),h],[l,(wt/2),h],[0,(wt/2),h] ], 
			triangles=[[0,1,5],[0,5,4],[1,2,6],[1,6,5],[2,3,7],[2,7,6],[0,4,7],[0,7,3],[4,5,6],[4,6,7],[3,2,1],[3,1,0],]) ;
		translate([l/2-(RWidth+Allow),0,h/2-WallT]) cube([l,wt-1,h],true) ;
		translate([l-RWidth,-(OutW/2+4),RHeight]) rotate([0,90,0]) halfslab(RHeight,OutW+8,RWidth) ;
		HoleInLid() ;			// Call user code for aperature
	}
}

// Block for Screws
module sblock(outs,ins,len) { 
	cone = 20 ;
	outr = outs/2 - 1.8;
	inr = ins/2 ;
	outL = outr * 0.87;
	outS = outr/2 ;
	inL = inr * 0.87 ;
	inS = inr /2 ;
	difference() {
		union() {
			cylinder(len,outs/2,outs/2) ;
			translate([0,0,len-((sin(cone)*outs/2))]) rotate([-cone,0,0],[0,0,len]) cylinder((outs/2)/tan(cone),outs/2,0) ;
		}
		if (ins !=0) {
			translate([0,0,-2]) cylinder(h=10,r=1);
		}
	}
}


// size is a vector [w, h, d]
module roundedBox(width, height, depth, radius) {
	size=[width, height, depth];
	cube(size - [2*radius,0,0], true);
	cube(size - [0,2*radius,0], true);
	for (x = [radius-size[0]/2, -radius+size[0]/2],
		y = [radius-size[1]/2, -radius+size[1]/2]) {
		translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
	}
}

//  Kind of triangle cross section beam w->X; d->Y; h->Z
module halfslab(w,d,h) {
	polyhedron ( points = [[0, 0, h], [0, d, h], [0, d, 0], [0, 0, 0], [w, 0, h], [w, d, h]], 
		triangles = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);
}

// Top ridge which retains the lid
module topridge() {
	blen = 0 ;
	translate([(OutL-WallT*2)/2-0.1, -(OutW/2-WallT+0.1),(OutD/2)-(RHeight+0.1)]) rotate([0,0,90]) halfslab(RWidth+0.2, OutL-(WallT*3), RHeight ) ;
	translate([-(OutL-WallT*4)/2+0.1, (OutW/2-WallT+0.1),(OutD/2)-(RHeight+0.1)]) rotate([0,0,-90]) halfslab(RWidth+0.2, OutL-(WallT*3), RHeight ) ;

	translate([-(OutL/2-WallT*2+0.1),- (OutW/2-WallT+0.1),(OutD/2)-(RHeight+0.1)]) rotate([0,0,0]) halfslab(RWidth+0.2, OutW-(WallT*2), RHeight ) ;
}

// Support ridge for lid or PCB
module support(top) {
	translate([0,-(OutW/2-(WallT-0.1)),top]) rib() ;
	translate([0,(OutW/2-(WallT-0.1)-Swidth),top]) rib() ;
}

//Rib of support
module rib() {
	len = OutL - (WallT*3) - Allow ;			// Allow for 1 wall thickness at one end, 2 at the other, and an Allowance
	translate([-len/2 +0.1,0,-Sdepth]) cube([len,Swidth,Sdepth]) ;
}

module endround(x,y,w) {
	translate([-(10+OutL-WallT*4)/2,OutW/2-x,OutD/2-y]) rotate([0,90,0]) cylinder(10,w/2,w/2) ;
}

module endrect(x,y,w,d) {
	translate([-(10+OutL-WallT*4)/2,OutW/2-w-x,OutD/2-y]) rotate([0,90,0]) cube([d,w,10]) ;
}

module lidround(x,y,w) {
	translate([OutL-y,OutW/2-x,-10]) cylinder(20,w/2,w/2) ;
}

module lidrect(x,y,w,d) {
	translate([OutL-d-y,OutW/2-w-x,-8]) cube([d,w,20]) ;
}
