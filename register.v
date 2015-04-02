module register(
  input clk,
  input [39:0]loadbus,
  input [39:0]multbus,
  input [39:0]addbus,
  input [39:0]instbus1,
  input [39:0]instbus2,
  output reg [31:0]reg0,
  output reg [31:0]reg1,
  output reg [31:0]reg2,
  output reg [31:0]reg3
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
  
  reg [7:0]R0_t;
  reg [7:0]R1_t;
  reg [7:0]R2_t;
  reg [7:0]R3_t;
  
  always @ (instbus1) begin
    case (instbus1[7:0])
      `R0:R0_t<=instbus1[39:32];
      `R1:R1_t<=instbus1[39:32];
      `R2:R2_t<=instbus1[39:32];
      `R3:R3_t<=instbus1[39:32];
    endcase
  end
  
  always @ (instbus2) begin
    case (instbus2[7:0])
      `R0:R0_t<=instbus2[39:32];
      `R1:R1_t<=instbus2[39:32];
      `R2:R2_t<=instbus2[39:32];
      `R3:R3_t<=instbus2[39:32];
    endcase
  end
  
  always @ (posedge clk) begin
    if (R0_t==addbus[39:32])begin
      reg0<=addbus[31:0];
      R0_t<=0;
    end
    else if (R0_t==multbus[39:32])begin
      reg0<=multbus[31:0];
      R0_t<=0;
    end
    else if (R0_t==loadbus[39:32])begin
      reg0<=loadbus[31:0];
      R0_t<=0;
    end
      
    if (R1_t==addbus[39:32])begin
      reg1<=addbus[31:0];
      R1_t<=0;
    end
    else if (R1_t==multbus[39:32])begin
      reg1<=multbus[31:0];
      R1_t<=0;
    end
    else if (R1_t==loadbus[39:32])begin
      reg1<=loadbus[31:0];
      R1_t<=0;
    end
  
    if (R2_t==addbus[39:32])begin
      reg2<=addbus[31:0];
      R2_t<=0;
    end
    else if (R2_t==multbus[39:32])begin
      reg2<=multbus[31:0];
      R2_t<=0;
    end
    else if (R2_t==loadbus[39:32])begin
      reg2<=loadbus[31:0];
      R2_t<=0;
    end
      
    if (R3_t==addbus[39:32])begin
      reg3<=addbus[31:0];
      R3_t<=0;
    end
    else if (R3_t==multbus[39:32])begin
      reg3<=multbus[31:0];
      R3_t<=0;
    end
    else if (R3_t==loadbus[39:32])begin
      reg3<=loadbus[31:0];
      R3_t<=0;
    end
  end
      
endmodule
