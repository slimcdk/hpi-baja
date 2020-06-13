

// variables
box_size = [70,60,40];




receiver_box();


module receiver_box() {
    
    difference() {
        linear_extrude(box_size[2]) square([box_size[0],box_size[1]]);
        translate([2,2,2]) linear_extrude(box_size[2]) square([box_size[0],box_size[1]]-[4,4]);
    }
    
    translate([0,0,box_size[2]]) rotate([0,90,0]) linear_extrude(box_size[0]) sealing_profile();
    translate([0,box_size[1],box_size[2]]) rotate([0,90,-90]) linear_extrude(box_size[1]) sealing_profile();
    translate([box_size[0],0,box_size[2]]) rotate([0,90,90]) linear_extrude(box_size[1]) sealing_profile();
    translate([box_size[0],box_size[1],box_size[2]]) rotate([0,90,180]) linear_extrude(box_size[0]) sealing_profile();
}


module sealing_profile() {
    
    polygon([[0,0], [6,0],[0,4]]);
    
}