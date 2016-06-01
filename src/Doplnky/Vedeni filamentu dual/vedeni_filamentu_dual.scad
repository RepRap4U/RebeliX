include <../../../configuration.scad>


height = 8;  
offset = 14;
edge_length = 70;

module vedeni_filamentu_base()
{
  cube([edge_length/2,edge_length/2,height],center=true);
  
  rotate([0,0,45]) cube([offset/2, sqrt(2*edge_length*edge_length), height],center=true);
  rotate([0,0,-45]) cube([offset/2, sqrt(2*edge_length*edge_length), height],center=true);
  
  for(i=[0 : 90 : 360])
  {
    rotate([0,0,i])
    {
      translate([edge_length/2,edge_length/2 - (edge_length/3)/2 + offset/4,0])cube([offset/2,edge_length/3,height],center=true);
      translate([edge_length/2  - (edge_length/3)/2 + offset/4,edge_length/2,0])cube([edge_length/3,offset/2,height],center=true);
    
	}
  }
  
  // Pridelani do profilu
  translate([edge_length/2  - (edge_length/3)/2 + offset/4,edge_length/2, 25/2 - height/2]) cube([edge_length/3,offset/2,25],center=true);
  translate([edge_length/2  - (edge_length/3)/2 + offset/4,edge_length/2 + offset/4, -height/2 + 15]) cube([edge_length/3,2,8],center=true);
    
  translate([-edge_length/2  + (edge_length/3)/2 - offset/4,edge_length/2, 25/2 - height/2]) cube([edge_length/3,offset/2,25],center=true);
  translate([-edge_length/2  + (edge_length/3)/2 - offset/4,edge_length/2 + offset/4, -height/2 + 15]) cube([edge_length/3,2,8],center=true);

  // Ocko pro vedeni filamentu
  translate([edge_length/2 - offset/2,-edge_length/2 + offset/2,-height/2]) cylinder(r=offset/2,h=height,$fn=32); 
  translate([-edge_length/2 + offset/2,-edge_length/2 + offset/2,-height/2]) cylinder(r=offset/2,h=height,$fn=32); 
  
  // Vyztuzeni
  rotate([0,0,90]) translate([edge_length/2 - offset/4 - height/2 + 0.1,edge_length/2,height/2])cube([height,offset/2,2*height],center=true);
  rotate([0,0,360]) translate([edge_length/2,edge_length/2 - offset/4 - height/2 + 0.1,height/2])cube([offset/2,height,2*height],center=true);
}

module vedeni_filamentu_cuts()
{

  translate([edge_length/2 - offset/2,-edge_length/2 + offset/2,-height/2]) rotate([33,15,0]) cylinder(r=4/2,h=50,$fn=32,center=true);
  translate([-edge_length/2 + offset/2,-edge_length/2 + offset/2,-height/2]) rotate([33,-15,0]) cylinder(r=4/2,h=50,$fn=32,center=true);

  cube([edge_length/2-offset,edge_length/2-offset,height + offset],center=true);
    
  // Otvory pro M6 srouby
  translate([edge_length/2  - (edge_length/3)/2 + offset/4,edge_length/2 - offset/4 - 5 + 2.6, -height/2 + 15]) rotate([90,0,0]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30, center=true);
  translate([edge_length/2  - (edge_length/3)/2 + offset/4,edge_length/2, -height/2 + 15]) rotate([90,0,0]) cylinder(r = M6_dia/2, h = 30, $fn = 30, center=true);
   
  translate([-edge_length/2  + (edge_length/3)/2 - offset/4,edge_length/2 - offset/4 - 5 + 2.6, -height/2 + 15]) rotate([90,0,0]) cylinder(r = M6_head_diameter/2, h = 10, $fn = 30, center=true);
  translate([-edge_length/2  + (edge_length/3)/2 - offset/4,edge_length/2, -height/2 + 15]) rotate([90,0,0]) cylinder(r = M6_dia/2, h = 30, $fn = 30, center=true); 
  
  // Vyrez pro profilovou matku
  translate([edge_length/2  - (edge_length/3)/2 + offset/4,edge_length/2 + offset/4 + 3, -height/2 + 15]) cube([profile_nut_width,6,10],center=true);
  translate([-edge_length/2  + (edge_length/3)/2 - offset/4,edge_length/2 + offset/4 + 3, -height/2 + 15]) cube([profile_nut_width,6,10],center=true);
	
  // Seriznuti pro snazsi tisk
  translate([-(edge_length + 10)/2,edge_length/2 + offset/4 , -height/2 + 15 - 4]) rotate([-40,0,0]) cube([edge_length + 10,6,10]);
  
  // Vyztuzeni
  translate([0,edge_length/2 -offset/4 - height,height/2+height]) rotate([0,90,0]) cylinder(r=height,h=edge_length + 10,$fn=32,center=true);
}

module vedeni_filamentu()
{
  difference()
  {
	vedeni_filamentu_base();
	vedeni_filamentu_cuts();
  }

}

vedeni_filamentu();
