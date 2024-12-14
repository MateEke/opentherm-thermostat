board_depth = 65;
board_width = 67;
cable_diameter = 7.3;
standoff_coordinates = [
    [4, 4],
    [61, 4],
    [61, 63],
    [9.5, 63.5]
];
standoff_height = 5.7;
wall_thickness = 1.6;
board_clearance = 0.5;

base_x = board_depth + cable_diameter + 3*wall_thickness + 2 * board_clearance;
base_y = board_width + 2*wall_thickness + 2 * board_clearance;
base_z = wall_thickness + 8;

inner_x = base_x - 2*wall_thickness;
inner_y = base_y - 2*wall_thickness;

initial_offset = wall_thickness + board_clearance;


difference() {
    // Base
    translate([-(initial_offset),-(initial_offset),0]) cube([base_x, base_y, base_z]);

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
    rotate([90, 0, 0]) translate([base_y / 2 - initial_offset - 5, wall_thickness + 2, y_offset]) cylinder(h=standoff_height, d=4);
}