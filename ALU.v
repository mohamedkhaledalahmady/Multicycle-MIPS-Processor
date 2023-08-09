//missing: unsigned instrucions + overflow + carry
//----ALU----//
module ALU #(parameter DATA_SIZE = 32,
                       OUT_SIZE = DATA_SIZE,
                       FUN_SIZE = 5)(

input   wire   [DATA_SIZE-1:0]     SrcA,SrcB,
input   wire   [FUN_SIZE-1:0]      ALUControl,
input   wire                       CLK,
input   wire                       RST,
output  wire                       Zero,Sign,
output  reg    [OUT_SIZE-1:0]      ALUResult_1,
output  reg    [OUT_SIZE-1:0]      ALUResult_2,
output  reg    [OUT_SIZE-1:0]      ALUOut,
output  reg    [OUT_SIZE-1:0]      ALUOut_,
output  reg                        carry_out, //new  but not yet implemented
output  reg                        overflow,   //new but not yet implemented
output  reg   			   unvalid
);
 wire signed [DATA_SIZE-1:0] SrcA_,SrcB_;
 assign SrcA_ = SrcA;
 assign SrcB_ = SrcB;

reg   [OUT_SIZE-1:0]    OUT  ;   
integer                 i    ;
reg   [2*OUT_SIZE-1:0] M_out;
 
always @ (posedge CLK or negedge RST)
 begin
    if (!RST) 
      begin 
        ALUOut <= 0;
        ALUOut_<= 0;
      end
    else
      begin
        ALUOut <= ALUResult_1;
        ALUOut_ <= ALUResult_2;
      end    
 end

        
               
always @ (*)
 begin
   //default value:
   ALUResult_1 = 1'b0;
   ALUResult_2 = 1'b0;
   M_out='b0;
   unvalid = 1'b0;
    case (ALUControl)
      //R-type              
     'd0: ALUResult_1 = SrcA_ + SrcB_ ;   //jr (A=$ra, B=$0 ALUResult_1=A+B)
     
     'd1: ALUResult_1 = SrcA_ - SrcB_ ; //sub
     'd2: ALUResult_1 = SrcA_ & SrcB_ ;            //and
     'd3: ALUResult_1 = SrcA_ | SrcB_ ;            //or
     'd4: ALUResult_1 = SrcA_ ^ SrcB_ ;           //xor
     'd5: ALUResult_1 = ~(SrcA_ | SrcB_) ;        //nor
     'd6: ALUResult_1 = SrcB_ << SrcA_ ; //sll (rd= rt<<shamt)
     'd7: ALUResult_1 = SrcB_ >> SrcA_ ; //srl (rd= rt>>shamt)
     'd8: 
      begin //sra
       ALUResult_1 = SrcB_ >> SrcA_ ;
       for(i = 0 ; i < SrcA_ ; i = i + 1)
       ALUResult_1[OUT_SIZE-1-i] = SrcB_[DATA_SIZE-1] ;
      end 
     ///////////////////////////syscall   
     /////////////////////////////break
     'd9:
      begin//mult  ({hi,lo} = rs * rt)
      M_out=SrcB_ * SrcA_;
     {ALUResult_1,ALUResult_2}=SrcB_ * SrcA_;
      end                        
 
     'd10:
      begin// div (lo=rs/rt) (hi=rs%rt)
	if(SrcB != 0)     // checking that B!=0
	  begin
             ALUResult_2 = SrcA_ / SrcB_ ;
             ALUResult_1 = SrcA_ % SrcB_ ;
	  end
	else
          begin
             ALUResult_2 = 0;
             ALUResult_1 = 0;
	     unvalid = 1;
	  end
      end     
     'd11:  
      begin //slt
       if (SrcA_ < SrcB_)
         ALUResult_1 = 1'b1;
       else
         ALUResult_1 = 1'b0;
        end                                                 
      'd12:
      begin//multu  ({hi,lo} = rs * rt)
      M_out=SrcB * SrcA;
     {ALUResult_1,ALUResult_2}=SrcB * SrcA;
      end 
      'd13:
      begin// divu (lo=rs/rt) (hi=rs%rt)
	if(SrcB!=0)
		begin
         	 ALUResult_2 = {1'b0,SrcA} / {1'b0,SrcB} ;
        	 ALUResult_1 = {1'b0,SrcA} % {1'b0,SrcB} ;  
		end 
	else
		begin
         	 ALUResult_2 = 0 ;
        	 ALUResult_1 = 0 ;
		 unvalid = 1 ;
		end
      end  
      'd14: ALUResult_1 = {1'b0,SrcA} + {1'b0,SrcB} ;   //ADDu
     
     'd15: ALUResult_1 = {1'b0,SrcA} - {1'b0,SrcB}  ; //sub
     'd16:  
      begin //sltu
       if ({1'b0,SrcA} < {1'b0,SrcB})
         ALUResult_1 = 1'b1;
       else
         ALUResult_1 = 1'b0;
        end 
      'd17: 
      begin //slt
       if (SrcA < SrcB)
         ALUResult_1 = 1'b1;
       else
         ALUResult_1 = 1'b0;
        end   
        default: ALUResult_1 = 1'b0;
    endcase
    
 end

assign Zero = (ALUResult_1) ? 1'b0 : 1'b1 ;
assign Sign = (ALUResult_1[DATA_SIZE-1]);
endmodule
/*overflow
       if((SrcA__[DATA_SIZE-1] && SrcB_[DATA_SIZE-1] && !ALUResult_1[OUT_SIZE-1]
       ) || ( !SrcA_[DATA_SIZE-1] && !SrcB[DATA_SIZE-1] && ALUResult_1[OUT_SIZE-1]) )
        overflow = 1'b1 ;
       else
        overflow = 1'b0 ;

*/