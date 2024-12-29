

// Private variables
HEIGHT = 50;

TOP_WIDTH_NO_FILLET = 108;
BOTTOM_WIDTH_NO_FILLET = 90;

TOP_FILLET_RADIUS = 5;
BOTTOM_FILLET_RADIUS = 2;


// Public prameters
function height() = HEIGHT;
function bottom_width_no_fillet() = BOTTOM_WIDTH_NO_FILLET;
function top_width_no_fillet() = TOP_WIDTH_NO_FILLET;
function bottom_fillet_radius() = BOTTOM_FILLET_RADIUS;
function top_fillet_radius() = TOP_FILLET_RADIUS;

function wall_angle() = 90+atan2((top_width_no_fillet()-bottom_width_no_fillet())/2, height());


inside_frame_profile();


module fillet(r, a=90) {
    p1 = [r,0];
    p2 = [sin(90-a)*r, sin(a)*r];
    dist = sqrt( pow(p2[0]-p1[0], 2) + pow(p2[1]-p1[1] ,2) );
    cr = (dist/2) / sin( (180-a)/2 );

    difference() {
        polygon([[0,0],p1,p2]);
        translate([r,cr]) circle(r=cr);
    }
}

module inside_frame_profile(offsets=[0,0,0]) {
          
    bottom_offset = offsets[0];
    top_offset = offsets[1];
    side_offset = offsets[2];

    right_bottom =  [bottom_offset,     -bottom_width_no_fillet()/2 + (sin(90-wall_angle())*bottom_offset) + side_offset];
    right_top =     [height()-top_offset, -top_width_no_fillet()/2    - (sin(90-wall_angle())*top_offset)    + side_offset];
    left_top =      [height()-top_offset,  top_width_no_fillet()/2    + (sin(90-wall_angle())*top_offset)    - side_offset];
    left_bottom =   [bottom_offset,      bottom_width_no_fillet()/2 - (sin(90-wall_angle())*bottom_offset) - side_offset];
    
    difference() {
        polygon([right_bottom, right_top, left_top, left_bottom]);
        translate([0,bottom_width_no_fillet()/2]) rotate([0,0,-90]) fillet(bottom_fillet_radius(), wall_angle(), $fn=60);
        translate([0,-bottom_width_no_fillet()/2]) rotate([0,0,-90]) mirror([1,0,0]) fillet(bottom_fillet_radius(), wall_angle(), $fn=60);
    }
}