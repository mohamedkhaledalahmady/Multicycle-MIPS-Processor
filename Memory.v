module Memory 
#( parameter MEM_DEPTH = 40000,
             CELL_WIDTH = 32
)
(
    input   [CELL_WIDTH-1:0]            A_,WD,
    input                               WE,CLK,RST,
    input				                           IRWrite,
    output wire [CELL_WIDTH-1:0]        RD,
    output reg  [CELL_WIDTH-1:0]        Instr,
    output reg  [CELL_WIDTH-1:0]        Data
);

reg  [CELL_WIDTH-1:0]   MEM  [0:MEM_DEPTH-1];
integer i;

always @ (posedge CLK or negedge RST)
begin
    if (!RST) begin
        for (i=0;i<=MEM_DEPTH;i=i+1)
            MEM[i]<=0;
	    Instr <= 0;
	    Data  <= 0;
    end
    else begin
        if(IRWrite)
            Instr <= RD ;
        Data<= RD ;
        if(WE)
            MEM[A_] <= WD;
    end
end
assign RD = MEM[A_];
endmodule
