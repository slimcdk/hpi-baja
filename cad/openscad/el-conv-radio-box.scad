
use <utils.scad>;


WALL_THICKNESS = 3;


radio_box_assembly(length=66);



module radio_box_assembly(length) {
    box(length);
}


module box(length) {
    difference() {
        rotate([0,-90,180]) linear_extrude(length) inside_frame_profile(offsets=[0,0,0]);
        translate([WALL_THICKNESS, 0]) rotate([0,-90,180]) linear_extrude(length-WALL_THICKNESS*2) inside_frame_profile(offsets=[10+2,0,WALL_THICKNESS]);
        orange_bracket_cutout($fn=60);
    }
}


module orange_bracket_cutout() {
    union() {
        _orange_bracket_cutout();
        mirror ([0,1,0]) _orange_bracket_cutout();
    }
    
    // angled part
    translate([25, 83/2]) linear_extrude(4) {
        angle = 135;
        fillet(5, angle);
        polygon([
            [0,0],
            [-25, -tan(angle)*25],
            [-25,0]
        ]);
    }
}


module _orange_bracket_cutout() {
    
    // Bracket cutout
    linear_extrude(4) difference() {
        square([66, bottom_width_no_fillet()/2]);
        
        // Center hole cutout
        translate([39,0]) {
            circle(d=37.5);
            square([66-39, 37.5/2]);
        }
        
        // Cutout along the edge
        translate([0, bottom_width_no_fillet()/2-(bottom_width_no_fillet()-83)/2]) square([66, (bottom_width_no_fillet()-83)/2]);
    }
    
    // Screws cutout
    linear_extrude(10) {
        translate([57, 60/2]) circle(d=12);
        translate([0,60/2-12/2]) square([57, 12]);
        
        translate([12, 56/2]) circle(d=12);
        translate([0,56/2-12/2]) square([12, 12]);
    }
}
