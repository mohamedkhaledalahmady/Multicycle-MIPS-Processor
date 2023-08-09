module MUX_8_1 #(
    parameter WIDTH = 32
) (
    input [WIDTH-1:0] I0, I1, I2, I3, I4, I5, I6, I7,
    input [2:0] Sel,
    output [WIDTH-1:0] Y
);
    wire [WIDTH-1:0] T0, T1;
    MUX_4_1 #(.WIDTH(WIDTH)) M00 (.I0(I0), .I1(I2), .I2(I4), .I3(I6), .Sel({Sel[2], Sel[1]}), .Y(T0));
    MUX_4_1 #(.WIDTH(WIDTH)) M02 (.I0(I1), .I1(I3), .I2(I5), .I3(I7), .Sel({Sel[2], Sel[1]}), .Y(T1));
    MUX_2_1 #(.WIDTH(WIDTH)) M03 (.I0(T0), .I1(T1), .Sel(Sel[0]), .Y(Y));

endmodule