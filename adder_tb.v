module adder_tb();
  reg clk;
  reg [31:0]reg0;
  reg [31:0]reg1;
  reg [31:0]reg2;
  reg [31:0]reg3;
  reg [39:0]loadbus;
  reg [39:0]multbus;
  reg [39:0]addbus;
  reg [39:0]instbus1;
  reg [39:0]instbus2;
  wire [39:0]addout;
  
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
  
  adder A1 (
    .clk(clk),
    .reg0(reg0),
    .reg1(reg1),
    .reg2(reg2),
    .reg3(reg3),
    .loadbus(loadbus),
    .multbus(multbus),
    .addbus(addbus),
    .instbus1(instbus1),
    .instbus2(instbus2),
    .addout(addout)
  );
  
  initial begin
    clk=0;
    reg1=32'h0022;
    reg2=32'h2345;
    instbus1={`A0,`ADD,`M0,`R2,`R3};
    instbus2={`A1,`ADD,`LD0,`R1,`R2};
    #10 instbus1={`A2,`ADD,`A0,`LD0,`R1};
    #10 loadbus={`LD0,32'h0034};
    #10 multbus={`M0,32'h1122}; loadbus='hz;
    #10 multbus='hz;
  end

  initial begin
    #60 addbus=40'h2000003467;
    #10 addbus='bz;
  end

  always 
    #5 clk=~clk;
    
endmodule