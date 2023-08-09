
module Sign_Zero_Extend 
#( parameter CELL_WIDTH = 32,
             IMM_WIDTH = 16
)
(
    input  wire [IMM_WIDTH-1:0]  Instr,
    input  wire                  s_notz,
    output reg  [CELL_WIDTH-1:0] SignImm
);

always@(*)
 begin
    if(s_notz)
      if (Instr[15]) 
          SignImm = {16'b1111111111111111,Instr};
      else
          SignImm = {16'b0,Instr};
    else
        SignImm = {16'b0,Instr}; 
 end 
endmodule

/*
  SignImm is a combinational function of Instr
  and will not change while the current instruction is being processed, so
  there is no need to dedicate a register to hold the constant value.
*/