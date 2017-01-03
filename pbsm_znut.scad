// PrintrBot Simple Metal 8mm Z Nut
// Increase resolution
$fn=50;

// Pull in nut/bolt library
include <nutsnbolts/cyl_head_bolt.scad>;

// Tolerance
buff = .5;

// Main dimensions
base_z = 55;
base_x = 40; 
base_y = 16;
void_y = base_y + 2;
void_x = base_x - 18;
void_z = (base_z * 1.5);

// Mounting holes
nema_dia = 4;
screw_dia = 3;
trap_depth = 2;

// Brass nut analog
bn_dia = 10;
bn_z = 15;
bn_f_z = 3.6;
bn_f_dia = 22;

module brass_nut()
{
    color("Goldenrod")
    {
        difference()
        {   
            union()
            {
                cylinder(h=bn_z, r=(bn_dia / 2), center=true);
                translate([0, 0, 5])
                    cylinder(h=bn_f_z, r=(bn_f_dia / 2), center=true);
            }   
            
            // Center opening
            cylinder(h=(bn_z + 5), r=4, center=true);
            
            // Screw holes
            translate([8, 0, 0])
                cylinder(h=(bn_z + 5), r=1.5, center=true);
            translate([-8, 0, 0])
                cylinder(h=(bn_z + 5), r=1.5, center=true);             
            translate([0, 8, 0])
                cylinder(h=(bn_z + 5), r=1.5, center=true);
            translate([0, -8, 0])
                cylinder(h=(bn_z + 5), r=1.5, center=true); 
        }
    }
}

module nema_mount()
{
    translate([8, 0, -14])
        rotate([90, 0, 0])
            cylinder(h=(base_y * 1.5), r=(nema_dia / 2), center=true);
    
    translate([-23, 0, -14])
        rotate([90, 0, 0])
            cylinder(h=(base_y * 1.5), r=(nema_dia / 2), center=true);
     
    translate([8, 0, -45])
        rotate([90, 0, 0])
            cylinder(h=(base_y * 1.5), r=(nema_dia / 2), center=true);
    
    translate([-23, 0, -45])
        rotate([90, 0, 0])
            cylinder(h=(base_y * 1.5), r=(nema_dia / 2), center=true);    
}

module body()
{
    cube([base_x, base_y, base_z], center=true);
}

module brass_void()
{
    cylinder(h=(base_z * 3), r=((bn_dia / 2) + (buff / 2)), center=true);
}

module mounting_holes()
{
    translate([8, 0, 0])
        cylinder(h=(bn_z + 5), r=(screw_dia / 2), center=true);

    translate([-8, 0, 0])
    {
        cylinder(h=(bn_z + 5), r=(screw_dia / 1.8), center=true);  
        translate([0, 0, -4.8])
            rotate([0, 0, 90])
                nutcatch_parallel("M3", l=trap_depth);
    }
}

module outer_shape()
{
    translate([-7.5, -1.8, -24])
    {
        difference()
        {
            body();
        
            translate([0, 0, -24])
                cube([void_x, void_y, void_z], center=true);
        }
    }
}

module z_nut()
{
    difference()
    {
        outer_shape();
        brass_void();
        nema_mount();
        mounting_holes();
    }
}

// Rendering
//brass_nut();
rotate([90, 180, 0]) // Rotate for final STL export
difference()
{
    z_nut();
    
    translate([-8, -22.5, -30]) rotate([90, 0, 90])
        cylinder(h=55, r=17, center=true);      
}
// EOF
