module D_FF #(
    parameter WIDTH = 32
) (
    input CLK, RST, EN,
    input [WIDTH-1:0] D,
    output reg [WIDTH-1:0] Q
);
    
    always @(posedge CLK, negedge RST) begin
        if (!RST) begin
            Q <= {WIDTH{1'b0}};
        end
        else if (EN) begin
            Q <= D;
        end
    end
endmodule