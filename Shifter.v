
module Shifter 
#( parameter CELL_WIDTH = 32
)
(
    input  wire [CELL_WIDTH-1:0]  SignImm,
    output wire [CELL_WIDTH-1:0]  Out_Shifted
);

    assign Out_Shifted = SignImm << 2 ;

endmodule






