include <shared.scad>

lid_height = 30;
lid_clearance = 0.2;

color("blue")
difference() {
    linear_extrude(height = lid_height) {
        offset(wall_thickness+lid_clearance) {
            translate([-initial_offset, -initial_offset]) square([base_x, base_y]);
        }
    }
    linear_extrude(height = base_z) {
        offset(wall_thickness+lid_clearance) {
            translate([-board_clearance, -board_clearance]) square([inner_x, inner_y]);
        }
    }
    translate([0,0,base_z]) linear_extrude(height = lid_height-base_z-wall_thickness) {
        offset(0.5 * wall_thickness) {
            translate([-board_clearance, -board_clearance]) square([inner_x, inner_y]);
        }
    }
    screwHeadM3(initial_offset, wall_thickness, base_y, lid_clearance);
    translate([base_y / 2 - initial_offset - 6.5, -initial_offset-wall_thickness-lid_clearance, 0]) cube(size = 3);
    // Cable coutout
    translate([board_depth + initial_offset,-5,0]) cube([cable_diameter-0.1,10,wall_thickness-0.3+cable_diameter/2]);
    rotate([90, 0, 0]) translate([board_depth + initial_offset + cable_diameter/2,wall_thickness-0.3+cable_diameter/2,0]) cylinder(d=cable_diameter, h=5);
    translate([14.5-initial_offset,base_y-initial_offset, 4.5]) cube([6, 3, 3]);
    translate([base_x - 20.5 - initial_offset,base_y-initial_offset, 4.5]) cube([6, 3, 3]);
}

// M3 DIN965
module screwHeadM3(initial_offset, wall_thickness, base_y, lid_clearance) {
    screw_hole_cylinderhead_spacing = 0.1;   // Extra radius of hole around screw head.
    screw_hole_countersunk_delta = 0.2;      // Extra depth of countersunk screw hole.
    r2 = 5.6 / 2 + screw_hole_cylinderhead_spacing;
    r1 = 3 / 2 + screw_hole_cylinderhead_spacing;
    h = 1.65 + screw_hole_countersunk_delta;
  
    y_offset = initial_offset - h + wall_thickness + lid_clearance;
    rotate([90, 0, 0]) translate([base_y / 2 - initial_offset - 5, wall_thickness + 2, y_offset]) cylinder(r1 = r1, r2 = r2, h = h);
}