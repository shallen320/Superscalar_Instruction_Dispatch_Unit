module dispatch_tb();
  reg clk;
  reg [31:0]inst1;
  reg [31:0]inst2;
  reg [39:0]addbus;
  reg [39:0]multbus;
  reg [39:0]loadbus;
  reg [7:0]storesig;
  
  wire [39:0]instbus1;
  wire [39:0]instbus2;
  wire stall1;
  wire stall2;
  
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
  
  dispatch D1 (
    .clk(clk),
    .inst1(inst1),
    .inst2(inst2),
    .addbus(addbus),
    .multbus(multbus),
    .loadbus(loadbus),
    .storesig(storesig),
    .instbus1(instbus1),
    .instbus2(instbus2),
    .stall1(stall1),
    .stall2(stall2)
    
    );
  initial begin
    #5 D1.A0_flag=1;
  end
  
  
  initial begin
  clk=0;
  //Load R1;
  #5inst1={`LOAD,`R1,16'h0};
    inst2={`MULTI,`R1,`R1,`R2};
  #10 inst1={`ADD,`R3,`R1,`R2};  inst2={`ADD,`R1,`R1,`R3};   //ADD R3 R1 R2
  #10 inst1=0;  inst2=0;
  #10 inst1={`ADD,`R2,`R3,`R0}; inst2={`STORE,`R1,16'h0};
  #10 inst1=0; inst2=0;
  
  end
  
  initial begin
    #30 addbus={`A0,32'h23451234};   //addbus has data
    #10 addbus=0;
  end
  
  always
    #5 clk=~clk;

    
endmodule
