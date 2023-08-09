module MIPS_TOP 
//----MIPS_TOP----//
#(parameter DATA_SIZE         = 32,
            OUT_SIZE          = DATA_SIZE,
            MEM_DEPTH         = 40000,
            CELL_WIDTH        = 32,
            FUN_SIZE          = 5,
            REG_ADDR_WIDTH    = 5,
            REG_WIDTH         = 32,
            INSTRC_WIDTH      = 32,
            OP_CODE_WIDTH     = 6,
            FUNCT_WIDTH       = 6,
            IMM_WIDTH         = 16,
            ALUOP_WIDTH       = 4
)
(
      input  CLK,RST
);

/*********************** ALU *************************/
wire               [OP_CODE_WIDTH-1:0]          Op;
wire               [FUNCT_WIDTH-1:0]            Funct;
wire                                            Zero;
wire               [DATA_SIZE-1:0]              SrcA,SrcB;
wire               [FUN_SIZE-1:0]               ALUControl;
wire               [OUT_SIZE-1:0]               ALUResult_1;
wire               [OUT_SIZE-1:0]               ALUResult_2;
wire               [OUT_SIZE-1:0]               ALUOut;
wire               [OUT_SIZE-1:0]               ALUOut_;
/*********************** Register File ***************/
wire              [REG_ADDR_WIDTH-1 : 0]        A1;
wire              [REG_ADDR_WIDTH-1 : 0]        A2;
wire              [REG_ADDR_WIDTH-1 : 0]        A3;
wire              [REG_ADDR_WIDTH-1 : 0]        A4;
wire              [REG_WIDTH-1:0]               WD3;
wire              [CELL_WIDTH-1:0]              WD;
wire              [CELL_WIDTH-1:0]              RD;
wire              [REG_WIDTH-1:0]               RD1;
wire              [REG_WIDTH-1:0]               RD2;  
wire              [REG_WIDTH-1:0]               RD3; 
/*********************** Program Counter **************/
wire             [CELL_WIDTH-1:0]                PC;
wire             [CELL_WIDTH-1:0]                PC_comp;
/*********************** hi & li registers ************/
wire             [CELL_WIDTH-1:0]                hi;
wire             [CELL_WIDTH-1:0]                lo;
/*********************** MUX Signals ******************/
wire                                            IorD;
wire                                            MemWrite;
wire                                            IRWrite;
wire                                            PCEn;
wire               [1:0]                        ALUSrcA;
wire                                            RegWrite;
wire               [1:0]                        RegDst;
wire               [1:0]                        load_type;
wire               [1:0]                        store_type;
wire               [2:0]                        MemtoReg;
wire               [1:0]                        ALUSrcB;
wire               [1:0]                        PCSrc;
wire               [CELL_WIDTH-1:0]             SignImm;  

wire               [CELL_WIDTH-1:0]             Data;
wire               [CELL_WIDTH-1:0]             DATA;
wire               [CELL_WIDTH-1:0]             Instr;
wire               [CELL_WIDTH-1:0]             Out_Shifted;
wire                                            s_notz;
wire                                            unvalid;
wire                                            PCWrite;
wire                                            Branch;
wire              [CELL_WIDTH-1:0]              Out_Shifted_J;
wire              [CELL_WIDTH-1:0]              A_;


/* Control Unit */
Control_Unit #(
      .OP_CODE_WIDTH(OP_CODE_WIDTH),
      .FUN_SIZE(FUN_SIZE),
      .FUNCT_WIDTH(FUNCT_WIDTH)
) CU (
      .CLK(CLK),
      .RST(RST),
      .Op(Op),
      .Funct(Funct),
      .Zero(Zero),
      .Sign(Sign),
      .unvalid(unvalid),
      .IorD(IorD),
      .MemWrite(MemWrite),
      .IRWrite(IRWrite),
      .s_notz(s_notz),
      .PCEn(PCEn),
      .HLEN(HLEN),
      .PCWrite(PCWrite), 
      .Branch(Branch),
      .HEN(HEN),
      .LEN(LEN),
      .ALUSrcA(ALUSrcA),
      .RegWrite(RegWrite),
      .RegDst(RegDst),
      .MemtoReg(MemtoReg),
      .ALUSrcB(ALUSrcB),
      .PCSrc(PCSrc),
      .ALUControl(ALUControl),
      .load_type(load_type),
      .store_type(store_type));

/* Arithmatic and Logic Unit */
ALU #(
      .DATA_SIZE(CELL_WIDTH),
      .OUT_SIZE(CELL_WIDTH),
      .FUN_SIZE(FUN_SIZE)
) alu (
      .SrcA(SrcA),
      .SrcB(SrcB),
      .ALUControl(ALUControl),
      .Zero(Zero),
      .Sign(Sign),
      .CLK(CLK),
      .RST(RST),
      .ALUResult_1(ALUResult_1),
      .ALUResult_2(ALUResult_2),
      .ALUOut(ALUOut),
      .ALUOut_(ALUOut_),
      .carry_out(carry_out),
      .overflow(carry_out),
      .unvalid(unvalid)
);

/* Compined Memory */
Memory #(
      .MEM_DEPTH(MEM_DEPTH),
      .CELL_WIDTH(CELL_WIDTH)
) mem (
      .A_(A_),
      .WD(WD),
      .WE(MemWrite),
      .CLK(CLK),
      .RST(RST),
      .RD(RD),
      .Instr(Instr),
      .Data(Data),
      .IRWrite(IRWrite)
);    

/* Register File */
Reg_File #(
      .REG_ADDR_WIDTH(REG_ADDR_WIDTH),
      .REG_WIDTH(REG_WIDTH)
) re (
      .A1(A1),
      .A2(A2),
      .A3(A3),
      .A4(A4),
      .instr(Instr),
      .WD3(WD3),
      .CLK(CLK),
      .RST(RST),
      .WE3(RegWrite),
      .RD1(RD1),
      .RD2(RD2),
      .RD3(RD3)
);

/* Immediate Extension */
Sign_Zero_Extend #(
      .CELL_WIDTH(CELL_WIDTH),
      .IMM_WIDTH(IMM_WIDTH)
) sign (
      .Instr(Instr[15:0]),
      .SignImm(SignImm),
      .s_notz(s_notz)
);

/* Immediate Shifter */
Shifter  #(
      .CELL_WIDTH(CELL_WIDTH)
) shift (
      .SignImm(SignImm),
      .Out_Shifted(Out_Shifted)
);

/* IorD MUX */
MUX_2_1 #(    
      .WIDTH(CELL_WIDTH)
) IORD_MUX (
      .I0(PC),
      .I1(ALUOut),
      .Sel(IorD),
      .Y(A_)
);

/* RegDst MUX */
MUX_4_1 #(    
      .WIDTH(REG_ADDR_WIDTH)
) REGDST_MUX (
      .I0(Instr[20:16]),
      .I1(Instr[15:11]),
      .I2(5'd31),
      .I3(5'd0),
      .Sel(RegDst),
      .Y(A4)
);

/* MemtoReg MUX */
MUX_8_1 #(    
      .WIDTH(CELL_WIDTH)
) MEMTOREG_MUX (
      .I0(ALUOut),
      .I1(DATA),
      .I2({Instr[IMM_WIDTH-1:0],16'b0}),
      .I3(PC),
      .I4(hi),
      .I5(lo),
      .I6(32'd0),
      .I7(32'd0),
      .Sel(MemtoReg),
      .Y(WD3)
);

/* ALUSrcA MUX */
MUX_4_1 #(    
      .WIDTH(CELL_WIDTH)
) AKUSRCA_MUX (
      .I0(PC),
      .I1(RD1),
      .I2(RD3),
      .I3(32'd0),
      .Sel(ALUSrcA),
      .Y(SrcA)
);

/* PCSrc MUX */
MUX_4_1 #(    
      .WIDTH(CELL_WIDTH)
) PCSRC_MUX (
      .I0(ALUResult_1),
      .I1(ALUOut),
      .I2(Out_Shifted_J),
      .I3(32'd0),
      .Sel(PCSrc),
      .Y(PC_comp)
);

/*load MUX*/
MUX_4_1 LOAD_MUX (
      .I0(Data),
      .I1({24'b0,Data[7:0]}),
      .I2({16'b0,Data[15:0]}),
      .I3(Data),
      .Sel(load_type),
      .Y(DATA));

/*store MUX*/
MUX_4_1 STORE_MUX (
      .I0(RD2),
      .I1({24'b0,RD2[7:0]}),
      .I2({16'b0,RD2[15:0]}),
      .I3(RD2),
      .Sel(store_type),
      .Y(WD));


/* PC Register */
D_FF #(
      .WIDTH(REG_WIDTH)  
) PC_FF (
      .CLK(CLK),
      .RST(RST),
      .EN(PCEn | PCWrite),
      .D(PC_comp),
      .Q(PC)
);

/* Immediate Shifter for J instruction */
Shifter_Jump #(
      .CELL_WIDTH(CELL_WIDTH)
) shift_j ( 
      .Instr(Instr[25:0]),
      .PC(PC),
      .Out_Shifted_J(Out_Shifted_J)
);

/* ALUSrcB MUX */
MUX_4_1 #(    
      .WIDTH(CELL_WIDTH)
) AKUSRCB_MUX (
      .I0(RD2),
      .I1(32'd4),
      .I2(SignImm),
      .I3(Out_Shifted),
      .Sel(ALUSrcB),
      .Y(SrcB)
);

/* High and Low Registers */
hi_lo_reg #(
      .SIZE(CELL_WIDTH)
) HI_LO ( 
      .ALUResult_1(ALUOut),
      .ALUResult_2(ALUOut_),
      .RST(RST),
      .CLK(CLK),
      .HLEN(HLEN),
      .LEN(LEN),
      .HEN(HEN),
      .RD1(RD1),
      .hi(hi),
      .lo(lo)
);
                 
/* Assign Funct and Op from Instruction */                 
assign Funct = Instr[5:0];
assign Op = Instr[31:26];
endmodule