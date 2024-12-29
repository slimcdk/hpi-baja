mounting_holes = [

    // holes in back
    [-47/2, 0],
    [47/2, 0],
    
    // left side holes (from back to front)
    [80-4, 35+8.5],
    [80-4, 35+8.5+40],
    
    // right side holes (from back to front)
    [-68+4, 35+8.5],
    [-68+4, 35+8.5+25],
    
    // esc holes
    [13.5+5, 35+29],
    [13.5+5, 35+29+57.5],
    [13.5+5+50, 35+29],
    [13.5+5+50, 35+29+57.5],

];

points = [
    [0,-5],
    [62/2,-5],
    [62/2,35],
    [80, 35],
    [80, 35+95],
    [80-19, 35+95],
    [80-19, 35+120],
        
    // motor wire cutout
    [-6, 35+120],
    [-6, 100],
    [-6-9, 100],
    [-6-9, 35+120],
    
    [-68+19, 35+120],
    [-68+19, 35+95],
    [-68, 35+95],

    [-68, 35],
    [-62/2,35],
    [-62/2,-5],
];


difference() {
    union() {
        linear_extrude(2) polygon(points);
        for (delta=[-68+7/2, 80-7/2]) translate([delta, 88+30, -3.8]) linear_extrude(3.8) square([7, 24], center=true);
    }
    
    for (delta=[-68+7/2, 80-7/2]) translate([delta, 88+30, -3.8]) linear_extrude(10) circle(d=3, $fn=30);
    for (hole=mounting_holes) translate(hole) linear_extrude(10) circle(d=3, $fn=30);
    
    // gearbox cutout
    translate([0,57+16/2]) linear_extrude(1.2)  square([27,16],center=true);
}

    



