module MUX_2_1 #(
    parameter WIDTH = 32
) (
    input [WIDTH-1:0] I0, I1,
    input Sel,
    output [WIDTH-1:0] Y
);
    assign Y = Sel ? I1 : I0;    
endmodule