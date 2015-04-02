module multi (
  input clk,
  input [31:0]reg0,
  input [31:0]reg1,
  input [31:0]reg2,
  input [31:0]reg3,
  input [39:0]loadbus,
  input [39:0]multbus,
  input [39:0]addbus,
  input [39:0]instbus1,
  input [39:0]instbus2,
  output [39:0]multout
    
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
  
  reg [31:0]M0_a;
  reg [31:0]M0_b;
  reg [7:0]M0_a_tag;
  reg [7:0]M0_b_tag;
  reg [31:0]M1_a;
  reg [31:0]M1_b;
  reg [7:0]M1_a_tag;
  reg [7:0]M1_b_tag;
  reg [2:0]M0_count;
  reg [2:0]M1_count;
  reg M0_a_rdy;
  reg M0_b_rdy;
  reg M1_a_rdy;
  reg M1_b_rdy;
  
  initial begin
    M0_count<=5;
    M1_count<=5;
    M0_a_rdy<=0;
    M0_b_rdy<=0;
    M1_a_rdy<=0;
    M1_b_rdy<=0;
  end
  
  always @ (posedge clk) begin
    if (M0_a_tag==addbus[39:32])begin
      M0_a<=addbus[31:0];
      M0_a_tag<=0;
      M0_a_rdy<=1;
    end
    else if (M0_a_tag==multbus[39:32])begin
      M0_a<=multbus[31:0];
      M0_a_tag<=0;
      M0_a_rdy<=1;
    end
    else if (M0_a_tag==loadbus[39:32])begin
      M0_a<=loadbus[31:0];
      M0_a_tag<=0;
      M0_a_rdy<=1;
    end
      
    if (M0_b_tag==addbus[39:32])begin
      M0_b<=addbus[31:0];
      M0_b_tag<=0;
      M0_b_rdy<=1;
    end
    else if (M0_b_tag==multbus[39:32])begin
      M0_b<=multbus[31:0];
      M0_b_tag<=0;
      M0_b_rdy<=1;
    end
    else if (M0_b_tag==loadbus[39:32])begin
      M0_b<=loadbus[31:0];
      M0_b_tag<=0;
      M0_b_rdy<=1;
    end
      
    if (M1_a_tag==addbus[39:32])begin
      M1_a<=addbus[31:0];
      M1_a_tag<=0;
      M1_a_rdy<=1;
    end
    else if (M1_a_tag==multbus[39:32])begin
      M1_a<=multbus[31:0];
      M1_a_tag<=0;
      M1_a_rdy<=1;
    end
    else if (M1_a_tag==loadbus[39:32])begin
      M1_a<=loadbus[31:0];
      M1_a_tag<=0;
      M1_a_rdy<=1;
    end
      
    if (M1_b_tag==addbus[39:32])begin
      M1_b<=addbus[31:0];
      M1_b_tag<=0;
      M1_b_rdy<=1;
    end
    else if (M1_b_tag==multbus[39:32])begin
      M1_b<=multbus[31:0];
      M1_b_tag<=0;
      M1_b_rdy<=1;
    end
    else if (M1_b_tag==loadbus[39:32])begin
      M1_b<=loadbus[31:0];
      M1_b_tag<=0;
      M1_b_rdy<=1;
    end
  end
  
  always @ (instbus1)begin
    if(instbus1[31:24]==`MULTI)
      case (instbus1[39:32])      //reservation station
        `M0: begin
          case (instbus1[23:16])        //first operand
            `R0:begin
              M0_a<=reg0; 
              M0_a_rdy<=1;
            end
            `R1:begin
              M0_a<=reg1;
              M0_a_rdy<=1;
            end
            `R2:begin
              M0_a<=reg2;
              M0_a_rdy<=1;
            end
            `R3:begin
              M0_a<=reg3;
              M0_a_rdy<=1;
            end
            `A0:M0_a_tag<=`A0;
            `A1:M0_a_tag<=`A1;
            `A2:M0_a_tag<=`A2;
            `M0:M0_a_tag<=`M0;
            `M1:M0_a_tag<=`M1;
            `LD0:M0_a_tag<=`LD0;
            `LD1:M0_a_tag<=`LD1;
          endcase
          case (instbus1[15:8])        //second operand
            `R0:begin
              M0_b<=reg0; 
              M0_b_rdy<=1;
            end
            `R1:begin
              M0_b<=reg1;
              M0_b_rdy<=1;
            end
            `R2:begin
              M0_b<=reg2;
              M0_b_rdy<=1;
            end
            `R3:begin
              M0_b<=reg3;
              M0_b_rdy<=1;
            end
            `A0:M0_b_tag<=`A0;
            `A1:M0_b_tag<=`A1;
            `A2:M0_b_tag<=`A2;
            `M0:M0_b_tag<=`M0;
            `M1:M0_b_tag<=`M1;
            `LD0:M0_b_tag<=`LD0;
            `LD1:M0_b_tag<=`LD1;
          endcase
        end
        `M1: begin
          case (instbus1[23:16])        //first operand
            `R0:begin
              M1_a<=reg0; 
              M1_a_rdy<=1;
            end
            `R1:begin
              M1_a<=reg1;
              M1_a_rdy<=1;
            end
            `R2:begin
              M1_a<=reg2;
              M1_a_rdy<=1;
            end
            `R3:begin
              M1_a<=reg3;
              M1_a_rdy<=1;
            end
            `A0:M1_a_tag<=`A0;
            `A1:M1_a_tag<=`A1;
            `A2:M1_a_tag<=`A2;
            `M0:M1_a_tag<=`M0;
            `M1:M1_a_tag<=`M1;
            `LD0:M1_a_tag<=`LD0;
            `LD1:M1_a_tag<=`LD1;
          endcase
          case (instbus1[15:8])        //second operand
            `R0:begin
              M1_b<=reg0; 
              M1_b_rdy<=1;
            end
            `R1:begin
              M1_b<=reg1;
              M1_b_rdy<=1;
            end
            `R2:begin
              M1_b<=reg2;
              M1_b_rdy<=1;
            end
            `R3:begin
              M1_b<=reg3;
              M1_b_rdy<=1;
            end
            `A0:M1_b_tag<=`A0;
            `A1:M1_b_tag<=`A1;
            `A2:M1_b_tag<=`A2;
            `M0:M1_b_tag<=`M0;
            `M1:M1_b_tag<=`M1;
            `LD0:M1_b_tag<=`LD0;
            `LD1:M1_b_tag<=`LD1;
          endcase
        end
      endcase
    end

  always @(instbus2) begin
    if(instbus2[31:24]==`MULTI)   //second instruction
      case (instbus2[39:32])      //reservation station
        `M0: begin
          case (instbus2[23:16])        //first operand
            `R0:begin
              M0_a<=reg0; 
              M0_a_rdy<=1;
            end
            `R1:begin
              M0_a<=reg1;
              M0_a_rdy<=1;
            end
            `R2:begin
              M0_a<=reg2;
              M0_a_rdy<=1;
            end
            `R3:begin
              M0_a<=reg3;
              M0_a_rdy<=1;
            end
            `A1:M0_a_tag<=`A1;
            `A2:M0_a_tag<=`A2;
            `M0:M0_a_tag<=`M0;
            `M1:M0_a_tag<=`M1;
            `LD0:M0_a_tag<=`LD0;
            `LD1:M0_a_tag<=`LD1;
          endcase
          case (instbus2[15:8])        //second operand
            `R0:begin
              M0_b<=reg0; 
              M0_b_rdy<=1;
            end
            `R1:begin
              M0_b<=reg1;
              M0_b_rdy<=1;
            end
            `R2:begin
              M0_b<=reg2;
              M0_b_rdy<=1;
            end
            `R3:begin
              M0_b<=reg3;
              M0_b_rdy<=1;
            end
            `A0:M0_b_tag<=`A0;
            `A1:M0_b_tag<=`A1;
            `A2:M0_b_tag<=`A2;
            `M0:M0_b_tag<=`M0;
            `M1:M0_b_tag<=`M1;
            `LD0:M0_b_tag<=`LD0;
            `LD1:M0_b_tag<=`LD1;
          endcase
        end
        `M1: begin
          case (instbus2[23:16])        //first operand
            `R0:begin
              M1_a<=reg0; 
              M1_a_rdy<=1;
            end
            `R1:begin
              M1_a<=reg1;
              M1_a_rdy<=1;
            end
            `R2:begin
              M1_a<=reg2;
              M1_a_rdy<=1;
            end
            `R3:begin
              M1_a<=reg3;
              M1_a_rdy<=1;
            end
            `A0:M1_a_tag<=`A0;
            `A1:M1_a_tag<=`A1;
            `A2:M1_a_tag<=`A2;
            `M0:M1_a_tag<=`M0;
            `M1:M1_a_tag<=`M1;
            `LD0:M1_a_tag<=`LD0;
            `LD1:M1_a_tag<=`LD1;
          endcase
          case (instbus2[15:8])        //second operand
            `R0:begin
              M1_b<=reg0; 
              M1_b_rdy<=1;
            end
            `R1:begin
              M1_b<=reg1;
              M1_b_rdy<=1;
            end
            `R2:begin
              M1_b<=reg2;
              M1_b_rdy<=1;
            end
            `R3:begin
              M1_b<=reg3;
              M1_b_rdy<=1;
            end
            `A0:M1_b_tag<=`A0;
            `A1:M1_b_tag<=`A1;
            `A2:M1_b_tag<=`A2;
            `M0:M1_b_tag<=`M0;
            `M1:M1_b_tag<=`M1;
            `LD0:M1_b_tag<=`LD0;
            `LD1:M1_b_tag<=`LD1;
          endcase
        end
      endcase
    end
  
  always @ (negedge clk)begin
    if (M0_count!=5)
      M0_count<=M0_count+1;
    if (M1_count!=5)
      M1_count<=M1_count+1;
      
    if(M0_a_rdy==1 && M0_b_rdy==1)begin
      M0_count<=0;
      M0_a_rdy<=0;
      M0_b_rdy<=0;
    end
    else if(M1_a_rdy==1 && M1_b_rdy==1)begin
      M1_count<=0;
      M1_a_rdy<=0;
      M1_b_rdy<=0;
    end
  end
  
  assign  multout = (M0_count==4)?{`M0,M0_a*M0_b}:((M1_count==4)?{`M1,M1_a*M1_b}:40'hz);    
endmodule