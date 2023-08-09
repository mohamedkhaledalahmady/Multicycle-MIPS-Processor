
module hi_lo_reg #(parameter SIZE = 32)
(
input  wire    [SIZE-1:0]      ALUResult_1,
input  wire    [SIZE-1:0]      ALUResult_2,
input  wire                    RST,CLK,HLEN,HEN,LEN,
input  wire    [SIZE-1:0]      RD1,
output reg     [SIZE-1:0]      hi,
output reg     [SIZE-1:0]      lo);

always @ (posedge CLK or negedge RST)
begin
    if (!RST) 
    begin
	hi<= 0;
	lo<= 0;
    end
    else
        if(HLEN) 
          begin
            hi <= ALUResult_1;
            lo <= ALUResult_2;
          end
	if(HEN)
	   begin
		hi <= ALUResult_1;
	   end
   if(LEN)
	   begin
		lo <= ALUResult_1;
	   end

end
endmodule

