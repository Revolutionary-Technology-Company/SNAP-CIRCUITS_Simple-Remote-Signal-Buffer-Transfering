// Parameters for the Split Flip-Flop Rubber Pipe
$fn = 100;
pipe_radius = 15;        // Outer radius of the rubber pipe (mm)
pipe_wall = 4;           // Wall thickness (mm)
half_length = 50;        // Length of one half of the pipe (mm)
wire_radius = 1.0;       // Radius of the aluminum wire groove (mm)
pitch = (half_length * 2) / 3; // 2/3 ratio pitch calculation

module main_half_pipe() {
    difference() {
        // Main structural cylinder
        cylinder(h=half_length, r=pipe_radius);
        
        // Inner hollow core
        translate([0, 0, -1])
            cylinder(h=half_length + 2, r=pipe_radius - pipe_wall);
            
        // Helical wire groove (2/3 pitch ratio)
        for (z = [0 : 0.5 : half_length]) {
            // Rotates twice per three length segments
            angle = (z / pitch) * 360; 
            rotate([0, 0, angle])
                translate([pipe_radius - 0.2, 0, z])
                    sphere(r=wire_radius);
        }
        
        // Flat center-facing splitting cut & input slot alignment
        translate([-pipe_radius*2, -pipe_radius*2, half_length - 2])
            cube([pipe_radius*4, pipe_radius*4, 3]);
    }
    
    // Internal alignment mechanical detent for the center interface
    translate([0, pipe_radius - pipe_wall/2, half_length - 2])
        cylinder(h=2, r=1.5);
}

// Render one half of the design
main_half_pipe();
