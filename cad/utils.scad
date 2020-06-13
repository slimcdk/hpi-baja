


linear_extrude(1) !main_frame_profile($fn=60);





module main_frame_profile() {
    
    bottom_fillet = 2;

    bottom_width = 89; // 89
    top_width = 108; // 108
    height=50;
    
    side_vector = [(top_width-bottom_width)/2, height];
    abs_half_side_vector = (side_vector + [bottom_width,0]) / 2;
    
    side_angle = atan2(side_vector[0],side_vector[1]);
    
    echo("wall angle", side_angle);
    
    #polygon([
        [-bottom_width/2,0],
        [bottom_width/2,0],
        [top_width/2,height],
        [-top_width/2,height],
    ]);
    
    
    fillet_corner = [bottom_width/2,0];
    fillet_corner_half_angle = (90+side_angle)/2;
    fillet_half_angle_vector = [-cos(fillet_corner_half_angle),sin(fillet_corner_half_angle)] * bottom_fillet;
    fillet_offset_scale = 1.3;
    fillet_orthocenter = fillet_corner + fillet_half_angle_vector * (fillet_offset_scale);
    

    color("lightblue") translate(fillet_orthocenter) circle(r=bottom_fillet);
    
    fillet_tangent_point1 = [fillet_orthocenter[0], 0];
    fillet_tangent_point2 = [fillet_orthocenter[0], fillet_orthocenter[1]];
      
    #polygon([fillet_corner, fillet_tangent_point1, fillet_tangent_point2, fillet_orthocenter]);
    /*
    polygon([
        [-abs_half_side_vector[0], abs_half_side_vector[1]],
        [abs_half_side_vector[0], abs_half_side_vector[1]],
        [top_width/2,height],
        [-top_width/2,height],
    ]); 
  
    
    _bottom_fillet = 2;
    _bottom_width = bottom_width - (_bottom_fillet*2) + 0.6;
    
    _top_fillet = 10;
    _top_width = top_width - (_bottom_fillet*2) - 0.65;

    _height = height-(_bottom_fillet*2);
    
    #translate([0,_bottom_fillet]) offset(r=_bottom_fillet) polygon([
        [-_bottom_width/2,0],
        [_bottom_width/2,0],
        [_top_width/2,_height],
        [-_top_width/2,_height],
    ]);
    */
}
