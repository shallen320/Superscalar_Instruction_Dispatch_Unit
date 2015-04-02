module loadunit(
  input clk,
  input [31:0]data_in,
  input [39:0]instbus1,
  input [39:0]instbus2,
  output [39:0]loadout
  );
  
  reg [1:0] LD0_count;
  reg [1:0] LD1_count;
  reg LD0_rdy;
  reg LD1_rdy;
  
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
    LD0_count<=2;
    LD1_count<=2;
  end
  
  always @ (instbus1)
    if(instbus1[31:24]==`LOAD)
      case (instbus1[39:32])
        `LD0:LD0_rdy<=1;
        `LD1:LD1_rdy<=1;
      endcase
      
  always @ (instbus2)
    if(instbus2[31:24]==`LOAD)
      case (instbus2[39:32])
        `LD0:LD0_rdy<=1;
        `LD1:LD1_rdy<=1;
      endcase
  
  always @ (negedge clk)begin
    if (LD0_count!=2)
      LD0_count<=LD0_count+1;
    if (LD1_count!=2)
      LD1_count<=LD1_count+1;
      
    if(LD0_rdy==1)begin
      LD0_count<=0;
      LD0_rdy<=0;
    end
    else if(LD1_rdy==1)begin
      LD1_count<=0;
      LD1_rdy<=0;
    end
  end  
  
  assign loadout = (LD0_count==1)?{`LD0,data_in}:((LD1_count==1)?{`LD1,data_in}:40'hz);
endmodule
