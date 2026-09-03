// Parameters for the Split Flip-Flop Rubber Pipe with Bubble End Socket
$fn = 100;
pipe_radius = 15;             // Outer radius of the rubber pipe (mm)
pipe_wall = 4;                // Wall thickness (mm)
half_length = 50;             // Length of one half of the pipe (mm)
wire_radius = 1.0;            // Radius of the aluminum wire groove (mm)
pitch = (half_length * 2) / 3;// 2/3 ratio pitch calculation

// New parameters for the Melted Aluminum Ball Terminal Housing
bubble_pocket_radius = 3.5;   // Pocket to house the melted aluminum ball
insulation_clearance = 1.5;   // Space for a high-temp ceramic sleeve

module main_half_pipe_with_bubble_pocket() {
    difference() {
        // Main structural natural rubber cylinder
        cylinder(h=half_length, r=pipe_radius);
        
        // Inner hollow core
        translate([0, 0, -1])
            cylinder(h=half_length + 2, r=pipe_radius - pipe_wall);
            
        // Helical wire groove (2/3 pitch ratio)
        for (z = [0 : 0.5 : half_length]) {
            angle = (z / pitch) * 360; 
            rotate([0, 0, angle])
                translate([pipe_radius - 0.2, 0, z])
                    sphere(r=wire_radius);
        }
        
        // Flat center-facing splitting cut
        translate([-pipe_radius*2, -pipe_radius*2, half_length - 2])
            cube([pipe_radius*4, pipe_radius*4, 3]);

        // CRITICAL: Thermal isolation pocket for the melted aluminum bubble termination
        // Placed exactly where the helical wire path reaches the center split line
        rotate([0, 0, (half_length / pitch) * 360])
            translate([pipe_radius - 0.2, 0, half_length - 2])
                sphere(r = bubble_pocket_radius + insulation_clearance);
    }
}

// Render the modified structural half
main_half_pipe_with_bubble_pocket();
