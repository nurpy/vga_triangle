module boundingBox #(
    parameter WIDTH = 10
) (
    input wire [WIDTH-1:0] vertex_ax,
    input wire [WIDTH-1:0] vertex_ay,
    input wire [WIDTH-1:0] vertex_bx,
    input wire [WIDTH-1:0] vertex_by,
    input wire [WIDTH-1:0] vertex_cx,
    input wire [WIDTH-1:0] vertex_cy,
    output wire [WIDTH-1:0] min_x,
    output wire [WIDTH-1:0] max_x,
    output wire [WIDTH-1:0] min_y,
    output wire [WIDTH-1:0] max_y
);
    // Calculate the minimum and maximum x and y coordinates
always_comb begin
    min_x = vertex_ax < vertex_bx ? (vertex_ax < vertex_cx ? vertex_ax : vertex_cx) : (vertex_bx < vertex_cx ? vertex_bx : vertex_cx);
    min_y = vertex_ay < vertex_by ? (vertex_ay < vertex_cy ? vertex_ay : vertex_cy) : (vertex_by < vertex_cy ? vertex_by : vertex_cy);
    max_x = vertex_ax < vertex_bx ? (vertex_bx < vertex_cx ? vertex_cx : vertex_bx) : (vertex_ax < vertex_cx ? vertex_cx : vertex_ax);
    max_y = vertex_ay < vertex_by ? (vertex_by < vertex_cy ? vertex_cy : vertex_by) : (vertex_ay < vertex_cy ? vertex_cy : vertex_ay);

end



endmodule