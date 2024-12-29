
use <utils.scad>;


WALL_THICKNESS = 3;

battery_box_assembly(150+WALL_THICKNESS*2);


module battery_box_assembly(length) {
    battery_box(length);
    
}


module battery_box(length) {
    difference() {
        rotate([0,-90,180]) linear_extrude(length) inside_frame_profile(offsets=[0,0,0]);
        translate([WALL_THICKNESS, 0]) rotate([0,-90,180]) linear_extrude(length-WALL_THICKNESS*2) inside_frame_profile(offsets=[10+2,0,WALL_THICKNESS]);
    }
}
