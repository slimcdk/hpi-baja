
use <utils.scad>;


WALL_THICKNESS = 3;


steering_servo_box_assembly(55);



module steering_servo_box_assembly(length) {
    intersection() {
        translate([0, -150/2, -5]) linear_extrude(34+5) square([length+20, 150]);
        difference() {
            steering_servo_box(length, $fn=60);
            
            // Assembly screw holes
            for (pos=[[12, bottom_width_no_fillet()/2], [length-12, bottom_width_no_fillet()/2], [12, -bottom_width_no_fillet()/2], [length-12, -bottom_width_no_fillet()/2]]) { 
                translate([pos[0], pos[1], 15]) linear_extrude(height()) circle(d=3, $fn=30);
                translate([pos[0], pos[1], 40]) linear_extrude(20) circle(d=3.5, $fn=30);
                translate([pos[0], pos[1], 36]) linear_extrude(3) circle(d=8, $fn=30);
            }
        }
    }
}


module steering_servo_box(length) {
    difference() {
        union() {
            difference() {
                rotate([0,-90,180]) linear_extrude(length) inside_frame_profile(offsets=[0,0,0]);
                translate([WALL_THICKNESS, 0]) rotate([0,-90,180]) linear_extrude(length-WALL_THICKNESS*2) inside_frame_profile(offsets=[34+2,0,WALL_THICKNESS]);
                translate([55,0,3]) rotate([0,0,90]) jumbo_servo_cutout();
            }
            
            // bottom stands
            translate([13,68/2,0]) rotate([180,0,0]) linear_extrude(4) circle(d=5, $fn=30);
            translate([13,-68/2,0]) rotate([180,0,0]) linear_extrude(4) circle(d=5, $fn=30);

            // mounting wings
            translate([0,0,height()]) mounting_wing(length, thickness=10);
            
            *translate([0,0,height()]) sealing_ledge(size=[length, top_width_no_fillet()]);
        }
        
        // fillets under wing 1 and 3
        translate([0, (top_width_no_fillet()+1)/2,0]) rotate([0, 0, -90]) linear_extrude(3+height()) fillet(5, 90);
        translate([0, -(top_width_no_fillet()+1)/2,0]) rotate([0, 0, 0]) linear_extrude(3+height()) fillet(5, 90);
        
    }
    //#translate([55,0,4]) rotate([0,0,90]) jumbo_servo();
}



module sealing_ledge(size=[0,0]) {
    translate([0, -size[1]/2, 0]) linear_extrude(10) difference() {
        square(size);
        translate([10,10]/2) square(size-[10,10]);
        
    }
}



module mounting_wing(length, thickness=6) {
       
    pad_od=12;
    pad_id=7;
    cross_pad_dist = 128;
    
    pad1=[11, cross_pad_dist/2];
    pad2=[11+43, cross_pad_dist/2];
    pad3=[11, -cross_pad_dist/2];
    pad4=[11+43, -cross_pad_dist/2];
    
    // constrain back of wing 2 and 4
    pads_back = length > (pad2[0]+pad_od) ? (pad2[0]+pad_od) : length;
    
    // wing edge around compartment
    difference() {
        rotate([0,-90,180]) linear_extrude(length) polygon([
            [0, top_width_no_fillet()/2],
            [thickness, -tan(90-wall_angle())*thickness+(top_width_no_fillet()/2)],
            [thickness, tan(90-wall_angle())*thickness-(top_width_no_fillet()/2)],
            [0, -top_width_no_fillet()/2]
        ]);
        
        translate([WALL_THICKNESS,0,0]) rotate([0,-90,180]) linear_extrude(length-WALL_THICKNESS*2) polygon([
            [0, top_width_no_fillet()/2-WALL_THICKNESS],
            [thickness, -tan(90-wall_angle())*thickness+(top_width_no_fillet()/2)-WALL_THICKNESS],
            [thickness, tan(90-wall_angle())*thickness-(top_width_no_fillet()/2)+WALL_THICKNESS],
            [0, -top_width_no_fillet()/2+WALL_THICKNESS]
        ]);
    }
    
    intersection() {
        difference() {
            linear_extrude(thickness) {
                for (pos=[pad1,pad2,pad3,pad4]) translate(pos) circle(d=pad_od);

                // pad 1 wing
                polygon([
                    [0, top_width_no_fillet()/2],
                    [pad1[0]-pad_od/2, pad1[1]],
                    [pad1[0]+pad_od/2, pad1[1]],
                    [pad1[0]*2, top_width_no_fillet()/2],
                ]);
                
                // pad 2 wing
                polygon([
                    [pads_back, top_width_no_fillet()/2],
                    [pad2[0]-pad_od, top_width_no_fillet()/2],
                    [pad2[0]-pad_od/2, pad2[1]],
                    [pad2[0]+pad_od/2, pad2[1]],
                ]);
                
                // pad 3 wing
                polygon([
                    [0, -top_width_no_fillet()/2],
                    [pad3[0]-pad_od/2, pad3[1]],
                    [pad3[0]+pad_od/2, pad3[1]],
                    [pad3[0]*2, -top_width_no_fillet()/2],
                ]);
                
                // pad 4 wing
                polygon([
                    [pads_back, -top_width_no_fillet()/2],
                    [pad4[0]-pad_od, -top_width_no_fillet()/2],
                    [pad4[0]-pad_od/2, pad4[1]],
                    [pad4[0]+pad_od/2, pad4[1]],
                ]);
            }
            
            // throughhole on all pads
            for (pos=[pad1,pad2,pad3,pad4]) translate(pos) linear_extrude(thickness) circle(d=pad_id);
        }
        
        // Fix position and extrusion of wings
        union() {
            translate([pad1[0], pad1[1], 3]) linear_extrude(3) square([pad1[0]*2, 20], true);
            translate([pad2[0], pad2[1], 0]) linear_extrude(3) square([pad1[0]*3, 20], true);
            translate([pad3[0], pad3[1], 3]) linear_extrude(3) square([pad1[0]*2, 20], true);
            translate([pad4[0], pad4[1], 0]) linear_extrude(3) square([pad1[0]*3, 20], true);
        }
    }
}



module jumbo_servo_cutout() {
    linear_extrude(31) {
        polygon([
            [66.5/2, 0],
            [66.5/2, 42],
            [82.5/2, 42],
            [82.5/2, 58],
            [-82.5/2, 58],
            [-82.5/2, 42],
            [-66.5/2, 42],
            [-66.5/2, 0]
        ]);
    }
    
    // Mounting holes
    for (p=[[75/2,42,7], [75/2,42,31-7], [-75/2,42,7], [-75/2,42,31-7] ]) translate(p) rotate([90,0,0]) linear_extrude(15) circle(d=3, $fn=30);
    
    // Wire groove
    translate([66/2,2,31/2-7/2]) linear_extrude(7) square([9,40]);
    translate([66/2,WALL_THICKNESS,31/2-7/2]) linear_extrude(30) square([9,3]);
}


module jumbo_servo() {
    linear_extrude(30) {
        polygon([
            [66/2, 0],
            [66/2, 50],
            [41/2, 58],
            [-41/2, 58],
            [-66/2, 50],
            [-66/2, 0]
        ]);
        translate([-82/2, 42, 0]) square([82, 4]);
    } 
}