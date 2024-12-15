include <shared.scad>

standoff_coordinates = [
    [4, 4],
    [61, 4],
    [61, 63],
    [9.5, 63.5]
];
standoff_height = 5.7;

color("gray")
difference() {
    linear_extrude(height = base_z) {
        offset(wall_thickness) {
            translate([-board_clearance, -board_clearance]) square([inner_x, inner_y]);
        }   
    }

    // Inner coutout
    translate([-board_clearance,-board_clearance,wall_thickness]) cube([inner_x, inner_y, base_z]);

    // Cable coutout
    translate([board_depth + initial_offset,-5,wall_thickness]) cube([cable_diameter,10,base_z]);

    // Adhesive tape cutouts
    tapeCutouts(base_x, base_y, wall_thickness, board_clearance, initial_offset);

    // Screw hole
    bottomScrew(initial_offset, wall_thickness, standoff_height, base_y);
}

// Cable guide
translate([board_depth + board_clearance,-wall_thickness,wall_thickness]) cube([wall_thickness,20,base_z - wall_thickness]);

// Stand-offs
for (i = standoff_coordinates) {
    translate([i.x,i.y, wall_thickness]) standoffM3(standoff_height);
}

// Bottom screw
difference() {
    translate([base_y / 2 - initial_offset - 9, -(initial_offset), wall_thickness]) cube([8,standoff_height + 1,standoff_height]);
    bottomScrew(initial_offset, wall_thickness, standoff_height, base_y);
}

translate([15-initial_offset,base_y-initial_offset, 5]) cube([5, 2, 2]);
translate([base_x - 20 - initial_offset,base_y-initial_offset, 5]) cube([5, 2, 2]);


% color("red") rotate(90) translate([0,-board_depth,wall_thickness + standoff_height - 3.23]) import("../KiCad/opentherm-thermostat.stl");


module tapeCutouts(base_width, base_depth, wall_thickness, board_clearance, initial_offset) {
    heigth = 0.3;
    depth = 10;
    width = base_width - 10;

    translate([-(initial_offset) + 5, -(initial_offset) + 5, 0]) cube([width, depth, heigth]);

    translate([-(initial_offset) + 5, -(initial_offset) + base_depth - 5 - depth, 0]) cube([width, depth, heigth]); 
}

module standoffM3(h) {
    min_wall = 1.6;
    hole_diameter = 4;
    diameter = hole_diameter+2*min_wall+0.8;
    difference() {
        cylinder(h = h, d=diameter);
        cylinder(h = h+1, d=hole_diameter);
    }
}


module bottomScrew(initial_offset, wall_thickness, standoff_height, base_y) {
    y_offset = initial_offset - standoff_height; 
    rotate([90, 0, 0]) translate([base_y / 2 - initial_offset - 5, wall_thickness + 2, y_offset]) cylinder(h=10, d=4);
}