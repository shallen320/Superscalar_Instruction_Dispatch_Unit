module multi_tb();
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
  wire [39:0]multout;
  
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
  
  multi M1 (
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
    .multout(multout)
  );
  
  initial begin
    clk=0;
    reg1=32'h0022;
    reg2=32'h0004;
    instbus1={`M0,`MULTI,`A0,`R2,`R3};
    instbus2={`M1,`MULTI,`LD0,`R1,`R2};
    #20 loadbus={`LD0,32'h0034};
    #10 addbus={`A0,32'h1122}; loadbus='hz;
    #10 addbus='hz;
  end



  always 
    #5 clk=~clk;


endmodule