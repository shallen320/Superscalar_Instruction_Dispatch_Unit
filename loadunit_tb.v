module loadunit_tb;
  reg clk;
  reg [31:0]data_in;
  reg [39:0]instbus1;
  reg [39:0]instbus2;
  wire [39:0]loadout;
  
  loadunit L1(
  .clk(clk),
  .data_in(data_in),
  .instbus1(instbus1),
  .instbus2(instbus2),
  .loadout(loadout)
  );
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

initial begin
  clk=0;
  data_in=32'h47bdce12;
  
  #10 instbus1={`LD0,`LOAD,16'h0,`R0}; instbus2={`LD1,`LOAD,16'h0,`R2};
  #30 data_in=32'h345612bc;
end

always
  #5 clk=~clk;
  
endmodule