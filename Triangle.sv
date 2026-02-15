module Triangle #(parameter WIDTH = 10) (
    input wire [WIDTH-1:0] vertex_a,
    input wire [WIDTH-1:0] vertex_b,
    input wire [WIDTH-1:0] vertex_c,
    output wire done
);
    // Check the triangle inequality theorem
