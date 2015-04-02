module storeunit_tb;
  reg clk;
  wire [31:0]data_out;
  wire [7:0]storesig;
  reg [31:0]reg0;
  reg [31:0]reg1;
  reg [31:0]reg2;
  reg [31:0]reg3;
  reg [39:0]instbus1;
  reg [39:0]instbus2;
  reg [39:0]addbus;
  reg [39:0]multbus;
  reg [39:0]loadbus;

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
  
  storeunit S1(
  .clk(clk),
  .data_out(data_out),
  .reg0(reg0),
  .reg1(reg1),
  .reg2(reg2),
  .reg3(reg3),
  .storesig(storesig),
  .instbus1(instbus1),
  .instbus2(instbus2),
  .addbus(addbus),
  .multbus(multbus),
  .loadbus(loadbus)
  );
  
  initial begin
    clk=0;
    reg1=32'h321234bc;
    #10 instbus1={`R1,`STORE,16'h0,`ST0};
        instbus2={`LD0,`STORE,16'h0,`ST1};
  end
  
  initial begin
    #30 loadbus={`LD0,32'h45d6bcef};
    #10 loadbus=40'hz;
  end
  
  always
    #5 clk=~clk;
    
endmodule
  
  
