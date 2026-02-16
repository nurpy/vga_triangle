import types_pkg::*;


module Triangle #(parameter WIDTH = 10) (
    input wire [WIDTH-1:0] vertex_ax,
    input wire [WIDTH-1:0] vertex_ay,
    input wire [WIDTH-1:0] vertex_bx,
    input wire [WIDTH-1:0] vertex_by,
    input wire [WIDTH-1:0] vertex_cx,
    input wire [WIDTH-1:0] vertex_cy,
    input clk,
    input rst,
    output busy,
    output reg done,
);
wire [WIDTH-1:0] min_x, max_x, min_y, max_y;
assign busy = iter_x <= max_x && iter_y <= max_y && !done; // Busy while iterating through the bounding box
boundingBox #(
    .WIDTH        (10)
) u_boundingBox (
    .vertex_ax    (vertex_ax),
    .vertex_ay    (vertex_ay),
    .vertex_bx    (vertex_bx),
    .vertex_by    (vertex_by),
    .vertex_cx    (vertex_cx),
    .vertex_cy    (vertex_cy),
    .min_x        (min_x),
    .max_x        (max_x),
    .min_y        (min_y),
    .max_y        (max_y)
);

reg [WIDTH-1:0] iter_x, iter_y;
reg draw_pixel; // Signal to indicate whether to draw the pixel at (iter_x, iter_y)
//Iteration logic to go through the bounding box
always_ff @(posedge clk) begin
    if (rst) begin
        iter_x <= min_x;
        iter_y <= min_y;
        done <= 0;
    end else begin
        if (draw_pixel) begin
            iter_x <= iter_x < max_x ? iter_x+1 : min_x;
            iter_y <= iter_x == max_x ?  (iter_y < max_y ? iter_y+1 : min_y ) : iter_y ;
            done <= iter_x == max_x && iter_y == max_y;
        end
    end
end

always_ff




endmodule
    // Check the triangle inequality theorem
