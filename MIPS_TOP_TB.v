//----MIPS_TOP_TB----//
`timescale 1ns/1ns
module MIPS_TOP_TB();
   reg                      CLK, RST;

   
   parameter FILENAME = "Input_MEM.txt"; //file is used to write the program in
   parameter filename ="programs_check.txt";
   //task is used to display the test case number
   task display_test_case_number (input [5:0] num);  
        begin  
          $display("Test case number %d", num);
        end  
    endtask 
     
    //task is used to display that the tast case is passed
    task display_test_case_passed (input [5:0] num);  
        begin  
          $display("Test case number %d passed", num);
        end  
    endtask
    
    //task is used to display that the tast case is faild
    task display_test_case_faild (input [5:0] num);  
        begin  
          $display("Test case number %d faild", num);
        end  
     endtask 
  
  integer i;
//start of the stimulus       
  initial
    begin
      CLK=1'b0;
      RST=1'b0;
      #25
      RST=1'b1;
      // Load data from the file into memory
      $readmemh(FILENAME, DUT.mem.MEM);

//TEST 1---------------------------------------------------------------------------------------------------------------------------------      
      display_test_case_number(1);
      #80
      if (DUT.re.REG[16]==5)
        display_test_case_passed(1);
      else
        display_test_case_faild(1);
//TEST 2---------------------------------------------------------------------------------------------------------------------------------       
      display_test_case_number(2);
      
#80
     
if (DUT.re.REG[8]==-12)
        display_test_case_passed(2);
      else
        display_test_case_faild(2);
//TEST 3---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(3);
      
#80
     
if (DUT.re.REG[17]==-7)
        display_test_case_passed(3);
      else
        display_test_case_faild(3);
//TEST 4---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(4);
     
 #80
    
 if (DUT.mem.MEM[4000]==-7)
        display_test_case_passed(4);
      else
        display_test_case_faild(4);
//TEST 5---------------------------------------------------------------------------------------------------------------------------------
     
 display_test_case_number(5);
     
 #80
    
 if (DUT.re.REG[18]==3)
        display_test_case_passed(5);
      else
        display_test_case_faild(5);
      #10
//TEST 6---------------------------------------------------------------------------------------------------------------------------------
     
 display_test_case_number(6);
      
#80 // TODO: load require 5 cycles (100ns) how !!
     
if (DUT.re.REG[10]==-7)
        display_test_case_passed(6);
      else
        display_test_case_faild(6);
//TEST 7---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(7);
      
#80
     
if (DUT.re.REG[19]==10)
        display_test_case_passed(7);
      else
        display_test_case_faild(7);
//TEST 8---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(8);
      
#80
     
if (DUT.re.REG[20]==160)
        display_test_case_passed(8);
      else
        display_test_case_faild(8);
//TEST 9---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(9);
      
#80
     
if (DUT.re.REG[21]==5)
        display_test_case_passed(9);
      else
        display_test_case_faild(9);
//TEST 10---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(10);
      
#80
     
if (DUT.re.REG[22]==-1)
        display_test_case_passed(10);
      else
        display_test_case_faild(10);
//TEST 11---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(11);
      
#80
     
if (DUT.re.REG[9]==5120)
        display_test_case_passed(11);
      else
        display_test_case_faild(11);
//TEST 12---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(12);
      
#80
     
if (DUT.re.REG[11]==5)
        display_test_case_passed(12);
      else
        display_test_case_faild(12);
//TEST 13---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(13);
      
#80
     
if (DUT.re.REG[12]==5)
        display_test_case_passed(13);
      else
        display_test_case_faild(13);
//TEST 14---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(14);
      
#80
     
if (DUT.HI_LO.hi==5)
        display_test_case_passed(14);
      else
        display_test_case_faild(14);
//TEST 15---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(15);
      
#80
     
if (DUT.HI_LO.lo==-12)
        display_test_case_passed(15);
      else
        display_test_case_faild(15);
//TEST 16---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(16);
      
#80
     
if ({DUT.HI_LO.hi,DUT.HI_LO.lo}==25)
        display_test_case_passed(16);
      else
        display_test_case_faild(16);
//TEST 17---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(17);
      
#80
     
if ({DUT.HI_LO.hi,DUT.HI_LO.lo}==-60)
        display_test_case_passed(17);
      else
        display_test_case_faild(17);
//TEST 18---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(18);
      
#60
     
if (DUT.re.REG[13]==-1)
        display_test_case_passed(18);
      else
        display_test_case_faild(18);
//TEST 19---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(19);
      
#60
     
if (DUT.re.REG[14]==-60)
        display_test_case_passed(19);
      else
        display_test_case_faild(19);
//TEST 20---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(20);
      
#80
     
if ((DUT.HI_LO.hi==0)&&(DUT.HI_LO.lo==32))
        display_test_case_passed(20);
      else
        display_test_case_faild(20);
//TEST 21---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(21);
      
#80
     
if (DUT.re.REG[15]==0)
        display_test_case_passed(21);
      else
        display_test_case_faild(21);
//TEST 22---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(22);
      
#80
     
if (DUT.re.REG[24]==160)
        display_test_case_passed(22);
      else
        display_test_case_faild(22);
//TEST 23---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(23);
      
#80
     
if (DUT.re.REG[15]==165)
        display_test_case_passed(23);
      else
        display_test_case_faild(23);
//TEST 24---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(24);
      
#80
     
if (DUT.re.REG[24]==0)
        display_test_case_passed(24);
      else
        display_test_case_faild(24);
//TEST 25---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(25);
      
#80
     
if (DUT.re.REG[15]==-166)
        display_test_case_passed(25);
      else
        display_test_case_faild(25);
//TEST 26---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(26);
      
#80
     
if (DUT.re.REG[24]==1)
        display_test_case_passed(26);
      else
        display_test_case_faild(26);
//TEST 27---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(27);
      
#80
     
if (DUT.re.REG[15]==0)
        display_test_case_passed(27);
      else
        display_test_case_faild(27);
//TEST 28---------------------------------------------------------------------------------------------------------------------------------
      
display_test_case_number(28);
      
#80    
if (DUT.re.REG[8]==-7)
        display_test_case_passed(28);
      else
        display_test_case_faild(28);
//TEST 29---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(29);
      
#80
     
if (DUT.re.REG[8]==12)
        display_test_case_passed(29);
      else
        display_test_case_faild(29);
//TEST 30---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(30);
      
#80
     
if ((DUT.HI_LO.hi==4)&&(DUT.HI_LO.lo==-35))
        display_test_case_passed(30);
      else
        display_test_case_faild(30);
//TEST 31---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(31);
      
#80
     
if ((DUT.HI_LO.hi==4)&&(DUT.HI_LO.lo==858993457))
        display_test_case_passed(31);
      else
        display_test_case_faild(31);
#60
#80
//TEST 32---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(32);
      
#80
     
if (DUT.re.REG[16]==190)
        display_test_case_passed(32);
      else
        display_test_case_faild(32);
#60
#80
//TEST 33---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(33);
      
#80     
if ((DUT.re.REG[16]==0)&&(DUT.re.REG[31]==152))
        display_test_case_passed(33);
      else
        display_test_case_faild(33);
#80
//TEST 34---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(34);
      
#80     
if ((DUT.re.REG[16]==0)&&(DUT.re.REG[17]==0))
        display_test_case_passed(34);
      else
        display_test_case_faild(34);

#80
//TEST 35---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(35);
      
#80     
if ((DUT.re.REG[16]==190)&&(DUT.re.REG[17]==0))
        display_test_case_passed(35);
      else
        display_test_case_faild(35);
#80
//TEST 36---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(36);
      
#80     
if ((DUT.re.REG[16]==190)&&(DUT.re.REG[17]==0))
        display_test_case_passed(36);
      else
        display_test_case_faild(36);
#80
#80
//TEST 37---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(37);
      
#80     
if ((DUT.re.REG[16]==190)&&(DUT.re.REG[17]==190)&&(DUT.re.REG[19]==0))
        display_test_case_passed(37);
      else
        display_test_case_faild(37);
#80
//TEST 38---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(38);
      
#80     
if ((DUT.re.REG[16]==190)&&(DUT.re.REG[17]==0)&&(DUT.re.REG[19]==0))
        display_test_case_passed(38);
      else
        display_test_case_faild(38);
#80
#80

//TEST 39---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(39);
      
#80     
if ((DUT.re.REG[16]==1)&&(DUT.re.REG[17]==1)&&(DUT.re.REG[18]==156))
        display_test_case_passed(39);
      else
        display_test_case_faild(39);
//TEST 40---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(40);
      
#80     
if (DUT.re.REG[18]==156)
        display_test_case_passed(40);
      else
        display_test_case_faild(40);
//TEST 41---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(41);
      
#80     
if (DUT.re.REG[18]==65535)
        display_test_case_passed(41);
      else
        display_test_case_faild(41);
 //TEST 42---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(42);
      
#80     
if (DUT.re.REG[18]==0)
        display_test_case_passed(42);
      else
        display_test_case_faild(42); 
//TEST 43---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(43);
      
#60     
if (DUT.re.REG[8]==10223616)
        display_test_case_passed(43);
      else
        display_test_case_faild(43); 
//---------------------------program_check--------------------------------
RST=1'b0;
#20
RST=1'b1;
display_test_case_number(44);
$readmemh(filename, DUT.mem.MEM);
#1440
if (DUT.mem.MEM[84]==7)
        display_test_case_passed(44);
      else
        display_test_case_faild(44); 
//---------------------------program_check--------------------------------
RST=1'b0;
#20
RST=1'b1;
display_test_case_number(45);
$readmemh("Factorial.txt", DUT.mem.MEM);
#7500
if (DUT.re.REG[12]==120)
        display_test_case_passed(45);
      else
        display_test_case_faild(45); 
//---------------------------program_check--------------------------------//
RST=1'b0;
#20
RST=1'b1;
$readmemh("Input_MEM2.txt", DUT.mem.MEM);
//TEST 46---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(46);
#80 
if (DUT.re.REG[5] == 257) 
        display_test_case_passed(46);
      else
        display_test_case_faild(46);

/*---test case2 dividing by zero case---//
see unvalid signal*/

//TEST 47---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(47);
#200
if (DUT.mem.MEM[10] == 1) 
	display_test_case_passed(47);
      else
        display_test_case_faild(47);

//TEST 48---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(48);
#100
if (DUT.mem.MEM[5] == 257) 
	display_test_case_passed(48);
      else
        display_test_case_faild(48);

//TEST 49---------------------------------------------------------------------------------------------------------------------------------    
display_test_case_number(49);
#100
if (DUT.mem.MEM[15] == 257) 
	display_test_case_passed(49);
      else
        display_test_case_faild(49);

//TEST 50---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(50); 
#100
if (DUT.re.REG[10] == 1) 
	display_test_case_passed(50);
      else
        display_test_case_faild(50);

//TEST 51---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(51); 
#100
if (DUT.re.REG[11] == 257) 
	display_test_case_passed(51);
      else
        display_test_case_faild(51);
//TEST 52---------------------------------------------------------------------------------------------------------------------------------    
display_test_case_number(52); 
#100
if (DUT.re.REG[12] == 257) 
	display_test_case_passed(52);
      else
        display_test_case_faild(52);
//TEST 53---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(53);  
#100
if (DUT.re.REG[0] == 32'b0) 
	display_test_case_passed(53);
      else
        display_test_case_faild(53);
//TEST 54---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(54);  
#100
if (DUT.re.REG[13] == 32'h00030000)
	display_test_case_passed(54);
      else
        display_test_case_faild(54);
//TEST 55---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(55); 
#100
if (DUT.re.REG[6] == 2) 	
	display_test_case_passed(55);
      else
        display_test_case_faild(55);

//TEST 56---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(56); 
#100
if (DUT.re.REG[7] == -5) 
	display_test_case_passed(56);
      else
        display_test_case_faild(56);
//TEST 57---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(57); 
#100
if (DUT.re.REG[8] == 32'h000100f1)
	display_test_case_passed(57);
      else
        display_test_case_faild(57);

//TEST 58---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(58); 
#100
if (DUT.re.REG[9] == 1) 
	display_test_case_passed(58);
      else
        display_test_case_faild(58);
//TEST 59---------------------------------------------------------------------------------------------------------------------------------   
display_test_case_number(59); 
#100
if (DUT.re.REG[14] == 1) 
	display_test_case_passed(59);
      else
        display_test_case_faild(59);

//---------------------------program_check--------------------------------
RST=1'b0;
#20
RST=1'b1;
display_test_case_number(60);
$readmemh("GCD.txt", DUT.mem.MEM);
#1500
if (DUT.re.REG[17]==17)
        display_test_case_passed(60);
      else
        display_test_case_faild(60); 
      #30
      $stop;
    end
                           
always #10  CLK=~CLK;
// instaniate design instance
 MIPS_TOP DUT
  (
   .CLK(CLK),
   .RST(RST)
  );
endmodule