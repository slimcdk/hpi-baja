

// general function
function circular_spread_points(quantity, radius) = [for(a = [0:360/quantity:360]) [radius * cos(a), radius * sin(a)]];

// specific functions
function pos_front_hex_hub_bolts() = circular_spread_points(3, 7);



wheel_hub_fastner($fn=60);
translate([0,0,4.2]) !front_hex_hub($fn=60);
translate([0,0,4.2+29.2]) front_hex_hub_fastner($fn=60);



module wheel_hub_fastner() {
    difference() {
        union() {
            linear_extrude(4) circle(d=27.7, $fn=6);
            //linear_extrude(4+6) circle(d=18);
        }
        
        // bolt holes    
        linear_extrude(10) for(pos=pos_front_hex_hub_bolts()) translate(pos) circle(d=4.4);
        linear_extrude(1) for(pos=pos_front_hex_hub_bolts()) translate(pos) circle(d=8);
    }
}


module front_hex_hub() {
    
    difference() {
        
        // hub body
        union () {
            linear_extrude(6) circle(d=18);
            translate([0,0,6]) linear_extrude(12) circle(d=27.7, $fn=6); // calculate circumradius.
            translate([0,0,6+12]) linear_extrude(1) circle(d=15.5);
            translate([0,0,6+12+1]) linear_extrude(16) circle(d=12);
        }
        
        // bolt holes
        linear_extrude(17) for(pos=pos_front_hex_hub_bolts()) translate(pos) circle(d=3.8);
        translate([0,0,10]) linear_extrude(3.2) for(a=[0:360/3:360]) rotate([0,0,a]) translate([3.2,-7.2/2,0]) square([15, 7.2]);
            
        linear_extrude(50) circle(d=6.2);
        linear_extrude(6) rotate([0,0,30]) circle(d=11.4, $fn=6);
    }
}


module front_hex_hub_fastner() {
    difference() {
        union() {
            //linear_extrude(6) circle(d=12);
            translate([0,0,6]) linear_extrude(2) circle(d=15.5);
        }
        
        // bolt holes
        linear_extrude(10) circle(d=6.2);
    }
    
}