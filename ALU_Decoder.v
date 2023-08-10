//----ALU_DECODER----//
module ALU_Decoder #(parameter ALUOP_width = 4, 
                               funct_width = 6,
                               ALUControl_width = 5 )(

input  wire [ALUOP_width-1:0]      ALUOP,
input  wire [funct_width-1:0]      Funct,
output reg  [ALUControl_width-1:0] ALUControl);

always@(*)
 begin
   case(ALUOP)
    'b0000: ALUControl = 'd0 ;//add
    'b0001: ALUControl = 'd1 ;//sub
    'b0010: ALUControl = 'd2 ;//and
    'b0011: ALUControl = 'd3 ;//or
    'b0100: ALUControl = 'd4 ;//xor
    'b0101: ALUControl = 'd5 ;//nor
    'b0110: ALUControl = 'd6 ;//sl
    'b0111: ALUControl = 'd7 ;//sr
    'b1000: ALUControl = 'd8 ;//sra
    'b1001: //R-type
     begin
       case(Funct)
       'd0:  ALUControl  = 'd6 ;
       'd2:  ALUControl  = 'd7 ;
       'd3:  ALUControl  = 'd8 ;
       'd4:  ALUControl  = 'd6 ;
       'd6:  ALUControl  = 'd7 ;
       'd7:  ALUControl  = 'd8 ;
       'd8:  ALUControl  = 'd0 ;
       'd9:  ALUControl  = 'd0 ;
       'd16: ALUControl  = 'd0 ;
       'd17: ALUControl  = 'd0 ;
       'd18: ALUControl  = 'd0 ;
       'd19: ALUControl  = 'd0 ;
       'd24: ALUControl  = 'd9 ;
       'd25: ALUControl  = 'd12 ; //Multu
       'd26: ALUControl  = 'd10 ;
       'd27: ALUControl  = 'd13 ; //divu
       'd32: ALUControl  = 'd0 ; 
       'd33: ALUControl  = 'd14 ; // addu
       'd34: ALUControl  = 'd1 ;
       'd35: ALUControl  = 'd15 ; // subu
       'd36: ALUControl  = 'd2 ;
       'd37: ALUControl  = 'd3 ;
       'd38: ALUControl  = 'd4 ;
       'd39: ALUControl  = 'd5 ;
       'd42: ALUControl  = 'd11 ; //slt
       'd43: ALUControl  = 'd16 ; //sltu
       default: ALUControl  = 'd0 ;
       endcase
     end
     'b1010:  ALUControl = 'd14;
     'b1011:  ALUControl = 'd11;
     'b1100:  ALUControl = 'd16;
   default: ALUControl  = 'd0 ;
   endcase
 end
 endmodule