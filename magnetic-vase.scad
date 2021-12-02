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
  dodecahedron(70);
  dodecahedron(62);
  translate([0,0,35]) cube([100,100,12],center=true);
  rotate([116.565,0,0]) translate([0, 0, 34]) {
	for(a=[0,72,144,216,288]) rotate([0,0,a+90]) translate([15,0,-1.19]) cylinder_outer(h=2.2, r=5.5, fn=36);
  }
}