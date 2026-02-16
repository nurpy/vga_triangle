package types_pkg;

    // Use signed logic so vector subtractions (like 1 - 5) 
    // result in -4 instead of a huge positive number
    localparam WIDTH = 10; // Width for the vector components
    typedef struct packed {
        logic signed [WIDTH-1:0] x;
        logic signed [WIDTH-1:0] y;
    } vector_t;

    // Function to perform vector subtraction
    function automatic vector_t sub_vec(input vector_t a, input vector_t b);
        vector_t res;
        res.x = a.x - b.x;
        res.y = a.y - b.y;
        return res;
    endfunction
    
    function automatic logic signed dot_prod(input vector_t a, input vector_t b);
        logic signed [WIDTH-1:0] res;
        res = a.x * b.x + a.y * b.y;
        return res;
    endfunction

endpackage