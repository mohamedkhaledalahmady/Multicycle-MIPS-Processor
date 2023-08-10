//----register_file----//
module Reg_File 
#( parameter REG_ADDR_WIDTH = 5,
             REG_WIDTH = 32
)
(
    input   [REG_ADDR_WIDTH-1 : 0]      A1,A2,A3,A4,
    input   [REG_WIDTH-1:0]             WD3,
    input   [REG_WIDTH-1:0]             instr,
    input                               CLK,RST,WE3,
    output reg  [REG_WIDTH-1:0]         RD1,RD2,RD3
);

reg   [REG_WIDTH-1:0]    REG    [0:REG_WIDTH-1];
integer i;       

always @ (posedge CLK or negedge RST)
begin
    if (!RST) begin
      for (i=0;i<REG_WIDTH;i=i+1)
        REG[i] <= 32'b0;
    RD1 <= 0;
    RD2 <= 0; 
    RD3 <= 0;   
    end
    else
    begin
       RD1 <= REG [A1];
       RD2 <= REG [A2];
       if(((instr[5:0]==6'b0)||(instr[5:0]==6'b000010)||(instr[5:0]==6'b000011))&&(instr[31:26]==6'b0))
         RD3<=A3;
       else
         RD3 <= REG [A3];
       if ((WE3 ==  1) && (A4 !=5'b0))
       REG[A4] <= WD3; 
    end
end
assign A1=instr[25:21];
assign A2=instr[20:16];
assign A3=instr[10:6];

endmodule