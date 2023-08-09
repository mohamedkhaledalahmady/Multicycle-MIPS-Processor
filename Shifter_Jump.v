
module Shifter_Jump 
#( parameter CELL_WIDTH = 32
)
(
    input  wire [25:0]              Instr,
    input  wire [CELL_WIDTH-1:0]    PC,
    output wire [CELL_WIDTH-1:0]    Out_Shifted_J
);

assign Out_Shifted_J = {PC[CELL_WIDTH-1:28],Instr << 2} ;
endmodule