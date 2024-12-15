board_depth = 65;
board_width = 67;
cable_diameter = 7.3;
wall_thickness = 1.6;
board_clearance = 0.5;

inner_x = board_depth + cable_diameter + wall_thickness + 2 * board_clearance;
inner_y = board_width + 2 * board_clearance;

base_x = inner_x + 2 * wall_thickness;
base_y = inner_y + 2 * wall_thickness;
base_z = wall_thickness + 8;

initial_offset = wall_thickness + board_clearance;

$fn = 40;