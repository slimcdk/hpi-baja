


!front_hex_hub_fastner($fn=60);
translate([0,0,4.2]) front_hex_hub($fn=60);



module front_hex_hub() {
    
    difference() {
        
        // hub body
        union () {
            linear_extrude(6) circle(d=18);
            translate([0,0,6]) linear_extrude(12) circle(d=27.7, $fn=6); // calculate circumradius.
            translate([0,0,6+12]) linear_extrude(1) circle(d=15.5);
            translate([0,0,6+12+1]) linear_extrude(16) circle(d=12);
        }
        
        // center hole
        linear_extrude(6+12+1+16-4) circle(d=6.2); 
        translate([0,0,6+12+1+16-4]) linear_extrude(5) square(6, true);
    }
}


module front_hex_hub_fastner() {
    difference() {
        linear_extrude(4) circle(d=25);
        linear_extrude(4) circle(d=6.2);
        linear_extrude(2) circle(d=11.2, $fn=6);
    }
}