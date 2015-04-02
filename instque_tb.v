module instque_tb;
  reg clk;
  reg stall1;
  reg stall2;
  wire [31:0]inst1;
  wire [31:0]inst2;
  
  instque I1 (
    .clk(clk),
    .stall1(stall1),
    .stall2(stall2),
    .inst1(inst1),
    .inst2(inst2)
  );
  
  initial begin
    clk=0;
    stall1=0;
    stall2=0;
    #10 stall1=1; stall2=1;
    #10 stall1=0;
    #10 stall2=0;
  end
  
  always
    #5 clk=~clk;
    
endmodule  