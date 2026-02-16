import types_pkg::*;
module baryCoordinates #(
    WIDTH = 10
) (
    input wire [WIDTH-1:0] vertex_ax,
    input wire [WIDTH-1:0] vertex_ay,
    input wire [WIDTH-1:0] vertex_bx,
    input wire [WIDTH-1:0] vertex_by,
    input wire [WIDTH-1:0] vertex_cx,
    input wire [WIDTH-1:0] vertex_cy,
    input wire [WIDTH-1:0] point_px,
    input wire [WIDTH-1:0] point_py,
    input clk,
    output reg [WIDTH-1:0] alpha,
    output reg [WIDTH-1:0] beta,
    output reg [WIDTH-1:0] gamma
);

vector_t a, b, c, p;
vector_t ab, ac, ap;
vector_t temp1, temp2;
vector_t nac, nab;
vector_t q1, q2, d1, d2;
logic ready=0;
always_comb begin
    ready=0;
    a.x = vertex_ax;
    a.y = vertex_ay;
    b.x = vertex_bx;
    b.y = vertex_by;
    c.x = vertex_cx;
    c.y = vertex_cy;
    p.x = point_px;
    p.y = point_py;

    ab = sub_vec(b,a);
    ac = sub_vec(c,a);
    ap = sub_vec(p,a);
    nac = '{a.y - c.y , c.x - a.x};
    nab = '{a.y - b.y , b.x - a.x};
    q1=dot_prod(nac,ap);
    q2=dot_prod(nac,ab);
    d1=dot_prod(nab,ap);
    d2=dot_prod(nab,ac);
    ready=1;
end
reg state;
reg i_start
always_ff @(posedge clk) begin
    if(rst) begin
        alpha <= 0;
        beta <= 0;
        gamma <= 0;
    end else begin
        if(ready) begin
            case(state) 
                0: begin
                    i_start <= 1;
                    
                end
                1:begin
                    i_start <= 1;
                    
                end
                    
            endcase
        end

    end
    
end

qdiv #(
    //Parameterized values
	.Q                 (15),
    .N                 (32)
) u_qdiv (
    .i_dividend        (i_dividend),
    .i_divisor         (i_divisor),
    .i_start           (i_start),
    .i_clk             (i_clk),
    .o_quotient_out    (o_quotient_out),
    .o_complete        (o_complete),
    .o_overflow        (o_overflow)
);



    
endmodule