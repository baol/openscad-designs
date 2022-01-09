/* [Box] */
// Distance between parallel faces of the outer dodecahedron
diameter_out = 70.0;
// Distance between parallel faces of the inner dodecahedron
diameter_in = 62.0;

/* [Magnet holes (optional)] */
holes = true;
hole_number = 5;
hole_depth = 3.0;
hole_diameter = 11.0;
hole_distance = 16.0;

hole_deg = 360/hole_number;

module dodecahedron(height) {
	scale([height,height,height]) {
		intersection() { 
			cube([2,2,1], center = true); 
			intersection_for(i=[0:4]) { 
				rotate([0,0,72*i])
					rotate([116.565,0,0])
					cube([2,2,1], center = true); 
			}
		}
	}
}

module cylinder_outer(h, r, fn) {
	fudge = 1/cos(180/fn);
	cylinder(h=h,r=r*fudge,$fn=fn);
}

difference() {
  dodecahedron(diameter_out);
  dodecahedron(diameter_in);
  translate([0,0,diameter_out/2]) cube([2*diameter_out,2*diameter_out,diameter_out-diameter_in],center=true);
  if(holes)
    rotate([116.565,0,0]) translate([0, 0, diameter_out/2-hole_depth]) {
        for(a=[0:hole_number])
            rotate([0,0,(a*hole_deg)+90])
            translate([hole_distance,0,0])
            cylinder_outer(h=hole_depth, r=hole_diameter/2, fn=36);
    }
}
