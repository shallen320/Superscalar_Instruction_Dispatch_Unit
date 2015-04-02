module top_tb;
  reg clk;
  wire stall1;
  wire stall2;
  reg [31:0]data_in;
  wire [7:0]storesig;
  wire [31:0]data_out;
  wire [31:0]inst1;
  wire [31:0]inst2;
  wire [39:0]instbus1;
  wire [39:0]instbus2;
  wire [39:0]multbus;
  wire [39:0]loadbus;
  wire [39:0]addbus;
  wire [31:0]reg0;
  wire [31:0]reg1;
  wire [31:0]reg2;
  wire [31:0]reg3;
  
  instque I1 (clk, stall1, stall2, inst1, inst2);
  dispatch D1 (clk, inst1, inst2, addbus, multbus, loadbus, storesig, 
              instbus1, instbus2, stall1, stall2);
  register R1 (clk, loadbus, multbus, addbus, instbus1, instbus2, 
              reg0, reg1, reg2, reg3);
  loadunit L1 (clk, data_in, instbus1, instbus2, loadbus);
  storeunit S1 (clk, data_out, storesig, reg0, reg1, reg2, reg3, 
            instbus1,instbus2, addbus, multbus, loadbus);
  adder A1 (clk, reg0, reg1, reg2, reg3, loadbus, multbus, addbus, instbus1,
             instbus2, addbus);
  multi M1 (clk, reg0, reg1, reg2, reg3, loadbus, multbus, addbus, instbus1,
            instbus2, multbus);
  
  initial begin
    R1.reg2=23'h34;
    R1.reg0=23'h57;
    clk=0;
    data_in=32'h00000022;
  end
  
  always
    #5 clk=~clk;
    
endmodule
    
  