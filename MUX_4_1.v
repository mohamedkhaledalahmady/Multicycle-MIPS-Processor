module MUX_4_1 #(
    parameter WIDTH = 32
) (
    input [WIDTH-1:0] I0, I1, I2, I3,
    input [1:0] Sel,
    output [WIDTH-1:0] Y
);
    wire [WIDTH-1:0] T0, T1;
    MUX_2_1 #(.WIDTH(WIDTH)) M0 (.I0(I0), .I1(I1), .Sel(Sel[0]), .Y(T0));
    MUX_2_1 #(.WIDTH(WIDTH)) M1 (.I0(I2), .I1(I3), .Sel(Sel[0]), .Y(T1));
    MUX_2_1 #(.WIDTH(WIDTH)) M2 (.I0(T0), .I1(T1), .Sel(Sel[1]), .Y(Y));

endmodule