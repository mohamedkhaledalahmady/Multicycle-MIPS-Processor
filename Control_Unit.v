//----Control_unit----//
module Control_Unit
#( parameter OP_CODE_WIDTH  = 6, 
             FUNCT_WIDTH    = 6,
             FUN_SIZE       = 5
) 
(
    input CLK, RST,
    input [OP_CODE_WIDTH-1:0] Op,
    input [FUNCT_WIDTH-1:0] Funct,
    input Zero,Sign,unvalid,
    output reg IorD, MemWrite, IRWrite,s_notz,
    output reg PCEn,RegWrite,HLEN,HEN,LEN,
    output reg [2:0]     MemtoReg,
    output reg     PCWrite, Branch,     
    output reg [1:0] ALUSrcB, ALUSrcA, PCSrc,RegDst,load_type,store_type,
    output wire [FUN_SIZE-1:0]  ALUControl);
    
    
    
//    /* Internal Signals */
   reg [3:0] ALUOp;

    ALU_Decoder A0
    (
        .ALUOP(ALUOp),
        .Funct(Funct),
        .ALUControl(ALUControl)
    );


    /* Instructions OpCode  */
    localparam LW       = 6'b100011;
    localparam LB       = 6'b100000;
    localparam LH       = 6'b100001;
    localparam SW       = 6'b101011;
    localparam SB       = 6'b101000;
    localparam SH       = 6'b101001;
    localparam R_TYPE   = 6'b000000;
    localparam BEQ      = 6'b000100;
    localparam ADDI     = 6'b001000;
    localparam ADDIU    = 6'b001001;
    localparam SLTI     = 6'b001010;
    localparam SLTIU    = 6'b001011;
    localparam ANDI    	= 6'b001100;
	localparam ORI    	= 6'b001101;
	localparam XORI    	= 6'b001110;
    localparam LUI      = 6'b001111;
    
    // Instructions with Shamt Funct 
    localparam SLL      = 6'b000000;
    localparam SRL      = 6'b000010;
    localparam SRA      = 6'b000011;
    
    localparam J        = 6'b000010;
    localparam JR       = 6'b001000;
    localparam JALR     = 6'b001001;
    localparam MFHI     = 6'b010000;
    localparam MTHI     = 6'b010001;
    localparam MFLO     = 6'b010010;
    localparam MTLO     = 6'b010011;
    localparam MULT     = 6'b011000;
    localparam MULTU    = 6'b011001;
    localparam DIV      = 6'b011010;
    localparam DIVU     = 6'b011011;
    localparam BLTZ     = 6'b000001;
    localparam BLEZ     = 6'b000110;
    localparam BGTZ     = 6'b000111;
    localparam BNE      = 6'b000101;
    

    /* Binary State Encoding */    
    localparam S0       = 5'b00000;  // Reset
    localparam S1       = 5'b00001;  // Deocde
    localparam S2       = 5'b00010;  // MemAdr
    localparam S3       = 5'b00011;  // MemRead
    localparam S4       = 5'b00100;  // MemWriteback
    localparam S5       = 5'b00101;  // MemWrite
    localparam S6       = 5'b00110;  // Execute
    localparam S_6_1    = 5'b00111;  // Jump register
    localparam S_6_2    = 5'b01000;  // Jump and link
    localparam S_6_3    = 5'b01001;  // Move from high
    localparam S_6_4    = 5'b01010;  // Move to high
    localparam S_6_5    = 5'b01011;  // Move from low
    localparam S_6_6    = 5'b01100;  // Move to low
    localparam S_6_7    = 5'b01101;  // Mult
    localparam S_6_8    = 5'b01110;  // Multu
    localparam S_6_9    = 5'b01111;  // Div
    localparam S_6_10   = 5'b10000;  // Divu
    localparam S7       = 5'b10001;  // ALU Writeback
    localparam S8       = 5'b10010;  // Branch
    localparam S9       = 5'b10011;  // ADDI Execute
    localparam S10      = 5'b10100;  // ADDI Writeback
    localparam S11      = 5'b10101;  // Jump
    localparam S_0_1    = 5'b10110;  // Reset

    /* Define States Variables */
    localparam NUMBER_STATES = 4;
    reg [NUMBER_STATES:0] Current_State, Next_State;

    /* State Transition */
    always @(posedge CLK or negedge RST) begin
        if (!RST) begin
            Current_State <= S0;
        end
        else
            Current_State <= Next_State;
    end

    /* Next State Logic &  Output Logic */
    always @(*) begin
        /* Default Values to prevent unintential latch */
            IorD        = 1'b0;
            ALUSrcA     = 2'b00;
            ALUSrcB     = 2'b00;
            ALUOp       = 2'b00;
            PCSrc       = 2'b00;
            IRWrite     = 1'b0;
            PCWrite     = 1'b0;
            RegDst      = 2'b00;
            MemtoReg    = 3'b000;
            RegWrite    = 1'b0;       
            PCEn        = 1'b0;
            Branch      = 1'b0;
            MemWrite    = 1'b0;
            HLEN        = 1'b0;
            HEN         = 1'b0;
            LEN         = 1'b0;
            s_notz      = 1'b0;
        case (Current_State)
           S0 : begin
            /* Output Logic */
            IorD    = 1'b0;
            ALUSrcA = 2'b00;
            ALUSrcB = 2'b01;
            ALUOp   = 2'b00;
            PCSrc   = 2'b00;
            IRWrite = 1'b1;
            PCWrite = 1'b1;
            /* Next State Logic */
              Next_State = S1;
           end
            S_0_1 : begin
            MemtoReg = 3'b010;
            RegWrite = 1'b1;
            RegDst = 2'b00; 
            Next_State = S0; // check   
            end 
           S1 : begin
            /* Output Logic */
            ALUSrcA = 2'b00;
            ALUSrcB = 2'b11;
            ALUOp   = 2'b00;
            /* Next State Logic */
            case (Op)
                LW      : Next_State = S2;
                LB      : Next_State = S2;
                LH      : Next_State = S2;
                SW      : Next_State = S2; 
                SB      : Next_State = S2;
                SH      : Next_State = S2;
                R_TYPE  : Next_State = S6; 
                BEQ     : Next_State = S8; 
                BNE     : Next_State = S8;
                BLTZ    : Next_State = S8;
                BLEZ	: Next_State = S8;
                BGTZ	: Next_State = S8;
                ADDI    : Next_State = S9;
                ANDI    : Next_State = S9;
		        ORI     : Next_State = S9;
		        XORI    : Next_State = S9;
                ADDIU   : Next_State = S9;
                SLTI    : Next_State = S9;
                SLTIU   : Next_State = S9;
                J       : Next_State = S11; 
                LUI     : Next_State = S_0_1;
                default: Next_State = S0;
            endcase
           end
           S2 : begin
            /* Output Logic */
            ALUSrcA = 2'b01;
            ALUSrcB = 2'b10;
            ALUOp   = 2'b00;
            /* Next State Logic */
            case (Op)
                LW      : Next_State = S3; 
                LB      : Next_State = S3; 
                LH      : Next_State = S3; 
                SW      : Next_State = S5; 
                SB      : Next_State = S5; 
                SH      : Next_State = S5; 
                default: Next_State = S0;
            endcase           
           end
           S3 : begin
            /* Output Logic */            
            IorD    = 1'b1;
            /* Next State Logic */
            Next_State = S4;                      
           end
           S4 : begin
            /* Output Logic */
            case (Op)
                LW: load_type = 2'b00;
                LB: load_type = 2'b01;
                LH: load_type = 2'b10;
                default: load_type = 2'b00;
            endcase            
            RegDst      = 2'b00;
            MemtoReg    = 3'b001;
            RegWrite    = 1'b1;  
            /* Next State Logic */
            Next_State = S0;                
           end
           S5 : begin
            /* Output Logic */            
            IorD        = 1'b1;
            MemWrite    = 1'b1;  
            case (Op)
                SW: store_type = 2'b00; 
                SB: store_type = 2'b01;
                SH: store_type = 2'b10;
                default: store_type = 2'b00;
            endcase
            /* Next State Logic */
            Next_State = S0;                
           end
          S6 : begin
                /* Output Logic */
                if(Funct == SLL || Funct == SRL || Funct == SRA)            
                ALUSrcA = 2'b10;
                else
                ALUSrcA = 2'b01;
                ALUSrcB = 2'b00;
                ALUOp   = 4'b1001;
                /* Next State Logic */
                case (Funct)
                    JR: begin
                         PCSrc = 2'b00;
                         PCWrite = 1'b1;
                         Next_State = S0;
                        end
                    JALR:begin
                         PCSrc = 2'b00;
                      	 	PCWrite = 1'b1;
                          RegDst = 2'b10;
                  	       MemtoReg = 3'b011;
                	       	 RegWrite = 1'b1;
                         Next_State = S0;
                        end
                     
                    MFHI:begin    //[rd] = hi  
                RegDst = 2'b01;
                MemtoReg = 3'b100;
                RegWrite = 1'b1;
                Next_State = S0; 
                end 
                    MTHI: Next_State = S_6_4;
                    MFLO: begin    // [rd] = lo
                RegDst = 2'b01;
                MemtoReg = 3'b101;
                RegWrite = 1'b1;
                Next_State = S0;
                end 
                    MTLO: Next_State = S_6_6;
                    MULT: Next_State = S_6_7;
                    MULTU:Next_State = S_6_8;
                    DIV : Next_State = S_6_9; 
                    DIVU: Next_State = S_6_10;
                    default: Next_State = S7;
                endcase
		end
                S_6_4 : begin    // hi = [rs]
                HEN = 1'b1;
                Next_State = S0; 
                end 
                S_6_6 : begin    // lo = [rs]
                LEN = 1'b1;
                Next_State = S0; 
                end
                S_6_7 :begin    // MULT
                ALUSrcA = 2'b01; 
                ALUSrcB = 2'b00;
                ALUOp   = 4'b1001;
                HLEN = 1'b1;
                Next_State = S0;
                end
                S_6_8 :begin    //Multu
                ALUSrcA = 2'b01; 
                ALUSrcB = 2'b00;
                ALUOp   = 4'b1001;
                HLEN = 1'b1;
                Next_State = S0;
                end
                S_6_9 :begin    //DIV
                ALUSrcA = 2'b01; 
                ALUSrcB = 2'b00;
                ALUOp   = 4'b1001;
                HLEN = 1'b1;
                Next_State = S0;
                end
                S_6_10 :begin    //DIVu
                ALUSrcA = 2'b01; 
                ALUSrcB = 2'b00;
                ALUOp   = 4'b1001;
                HLEN = 1'b1;
                Next_State = S0;
                end
           S7 : begin
            /* Output Logic */            
            RegDst      = 2'b01;
            MemtoReg    = 3'b000;
            RegWrite    = 1'b1;
            ALUSrcA     = 2'b01; 
            ALUSrcB     = 2'b00;
            ALUOp       = 4'b1001;
            /* Next State Logic */
            Next_State = S0;                 
           end
           S8 : begin
            /* Output Logic */            
            ALUSrcA     = 2'b01;
            ALUSrcB     = 2'b00;
            ALUOp       = 2'b01;
            PCSrc       = 2'b01;
            Branch      = 1'b1; 
            /* Next State Logic */
            Next_State = S0;                 
           end
           S9 : begin
            /* Output Logic */            
            ALUSrcA     = 2'b01;
            ALUSrcB     = 2'b10;
			case (Op)
				ADDI: 		ALUOp	= 4'b0000;
				ANDI: 		ALUOp	= 4'b0010;
				ORI: 		ALUOp	= 4'b0011;
				XORI: 		ALUOp	= 4'b0100;
                ADDIU:      ALUOp   = 4'b1010;
                SLTI:       ALUOp   = 4'b1011;
                SLTIU:      ALUOp   = 4'b1100;   
				default: 	ALUOp	= 4'b0000;
			endcase
            /* Next State Logic */
            Next_State = S10;             
           end
           S10 : begin
            /* Output Logic */            
            RegDst      = 1'b0;
            MemtoReg    = 1'b0;
            RegWrite    = 1'b1;
            /* Next State Logic */
            Next_State = S0;             
           end
           S11 : begin
            /* Output Logic */            
            PCSrc       = 2'b10;
            PCWrite     = 1'b1;
            /* Next State Logic */
            Next_State = S0;                 
            end
           default : begin
            /* Output Logic */            
            IorD        = 1'b0;
            ALUSrcA     = 2'b00;
            ALUSrcB     = 2'b00;
            ALUOp       = 2'b00;
            PCSrc       = 2'b00;
            IRWrite     = 1'b0;
            PCWrite     = 1'b0;
            RegDst      = 1'b0;
            MemtoReg    = 1'b0;
            RegWrite    = 1'b0;       
            PCEn        = 1'b0;
            Branch      = 1'b0;
            MemWrite    = 1'b0;
            /* Next State Logic */
            Next_State = S0;                 
            end
        endcase
        /* Logic For PCEn */
        case (Op)
            BLTZ: PCEn = (Branch & Sign & ~Zero);
            BLEZ: PCEn = (Branch & Sign) | (Branch & Zero);
            BGTZ: PCEn = (Branch & ~Sign & ~Zero);
            BEQ: PCEn = (Branch & Zero);
		       	BNE: PCEn = (Branch & ~Zero);
            J: PCEn = PCWrite;
            JALR: PCEn = PCWrite;
            JR: PCEn = PCWrite;
            default: PCEn = 0; 
        endcase
        /* Logic For s_notz */
        case (Op)
            ADDI:     s_notz = 1'b1;
            ADDIU:    s_notz = 1'b0;   
            SLTI:     s_notz = 1'b1;
            SLTIU:    s_notz = 1'b0;   
            default:  s_notz = 0; 
        endcase
        
    end

endmodule