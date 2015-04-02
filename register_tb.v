module register_tb;
  reg clk;
  reg [39:0]loadbus;
  reg [39:0]multbus;
  reg [39:0]addbus;
  reg [39:0]instbus1;
  reg [39:0]instbus2;
  wire [31:0]reg0;
  wire [31:0]reg1;
  wire [31:0]reg2;
  wire [31:0]reg3;
  
  `define LOAD 8'h01
  `define STORE 8'h02
  `define ADD 8'h03
  `define MULTI 8'h04
  `define R0 8'h10
  `define R1 8'h11
  `define R2 8'h12
  `define R3 8'h13
  `define A0 8'h20
  `define A1 8'h21
  `define A2 8'h22
  `define M0 8'h30
  `define M1 8'h31
  `define LD0 8'h40
  `define LD1 8'h41
  `define ST0 8'h50
  `define ST1 8'h51
  
  register R1(
    .clk(clk),
    .loadbus(loadbus),
    .multbus(multbus),  
    .addbus(addbus),
    .instbus1(instbus1),
    .instbus2(instbus2),
    .reg0(reg0),
    .reg1(reg1),
    .reg2(reg2),
    .reg3(reg3)
  );
  
  initial begin
    clk=0;
    #10 instbus1={`M0,`ADD,`R1,`A0,`R2};
    #10 instbus2={`LD0,`LOAD,16'h0,`R1};
  end
  
  
  initial begin
    #10 multbus={`M0,32'h34561234};
    #10 multbus=0; loadbus={`LD0,32'habcede23};
    #10 loadbus=0;
  end
  
  always
    #5 clk=~clk;
    
endmodule