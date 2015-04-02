module adder(
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
  output [39:0]addout
  
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
  
  reg [31:0]A0_a;
  reg [31:0]A0_b;
  reg [7:0]A0_a_tag;
  reg [7:0]A0_b_tag;
  reg [31:0]A1_a;
  reg [31:0]A1_b;
  reg [7:0]A1_a_tag;
  reg [7:0]A1_b_tag;
  reg [31:0]A2_a;
  reg [31:0]A2_b;
  reg [7:0]A2_a_tag;
  reg [7:0]A2_b_tag;
  reg [1:0]A0_count;
  reg [1:0]A1_count;
  reg [1:0]A2_count;
  reg A0_a_rdy;
  reg A0_b_rdy;
  reg A1_a_rdy;
  reg A1_b_rdy;
  reg A2_a_rdy;
  reg A2_b_rdy;
  
  initial begin
    A0_count<=3;
    A1_count<=3;
    A2_count<=3;
    A0_a_rdy<=0;
    A0_b_rdy<=0;
    A1_a_rdy<=0;
    A1_b_rdy<=0;
    A2_a_rdy<=0;
    A2_b_rdy<=0;
  end

  always @ (posedge clk) begin
    if (A0_a_tag==addbus[39:32])begin
      A0_a<=addbus[31:0];
      A0_a_tag<=0;
      A0_a_rdy<=1;
    end
    else if (A0_a_tag==multbus[39:32])begin
      A0_a<=multbus[31:0];
      A0_a_tag<=0;
      A0_a_rdy<=1;
    end
    else if (A0_a_tag==loadbus[39:32])begin
      A0_a<=loadbus[31:0];
      A0_a_tag<=0;
      A0_a_rdy<=1;
    end
      
    if (A0_b_tag==addbus[39:32])begin
      A0_b<=addbus[31:0];
      A0_b_tag<=0;
      A0_b_rdy<=1;
    end
    else if (A0_b_tag==multbus[39:32])begin
      A0_b<=multbus[31:0];
      A0_b_tag<=0;
      A0_b_rdy<=1;
    end
    else if (A0_b_tag==loadbus[39:32])begin
      A0_b<=loadbus[31:0];
      A0_b_tag<=0;
      A0_b_rdy<=1;
    end
      
    if (A1_a_tag==addbus[39:32])begin
      A1_a<=addbus[31:0];
      A1_a_tag<=0;
      A1_a_rdy<=1;
    end
    else if (A1_a_tag==multbus[39:32])begin
      A1_a<=multbus[31:0];
      A1_a_tag<=0;
      A1_a_rdy<=1;
    end
    else if (A1_a_tag==loadbus[39:32])begin
      A1_a<=loadbus[31:0];
      A1_a_tag<=0;
      A1_a_rdy<=1;
    end
      
    if (A1_b_tag==addbus[39:32])begin
      A1_b<=addbus[31:0];
      A1_b_tag<=0;
      A1_b_rdy<=1;
    end
    else if (A1_b_tag==multbus[39:32])begin
      A1_b<=multbus[31:0];
      A1_b_tag<=0;
      A1_b_rdy<=1;
    end
    else if (A1_b_tag==loadbus[39:32])begin
      A1_b<=loadbus[31:0];
      A1_b_tag<=0;
      A1_b_rdy<=1;
    end
      
    if (A2_a_tag==addbus[39:32])begin
      A2_a<=addbus[31:0];
      A2_a_tag<=0;
      A2_a_rdy<=1;
    end
    else if (A2_a_tag==multbus[39:32])begin
      A2_a<=multbus[31:0];
      A2_a_tag<=0;
      A2_a_rdy<=1;
    end
    else if (A2_a_tag==loadbus[39:32])begin
      A2_a<=loadbus[31:0];
      A2_a_tag<=0;
      A2_a_rdy<=1;
    end
      
    if (A2_b_tag==addbus[39:32])begin
      A2_b<=addbus[31:0];
      A2_b_tag<=0;
      A2_b_rdy<=1;
    end
    else if (A2_b_tag==multbus[39:32])begin
      A2_b<=multbus[31:0];
      A2_b_tag<=0;
      A2_b_rdy<=1;
    end
    else if (A2_b_tag==loadbus[39:32])begin
      A2_b<=loadbus[31:0];   
      A2_b_tag<=0;  
      A2_b_rdy<=1;
    end
  end
  
  always @ (instbus1, instbus2)begin
    if(instbus1[31:24]==`ADD)
      case (instbus1[39:32])      //reservation station
        `A0: begin
          case (instbus1[23:16])        //first operand
            `R0:begin
              A0_a<=reg0; 
              A0_a_rdy<=1;
            end
            `R1:begin
              A0_a<=reg1;
              A0_a_rdy<=1;
            end
            `R2:begin
              A0_a<=reg2;
              A0_a_rdy<=1;
            end
            `R3:begin
              A0_a<=reg3;
              A0_a_rdy<=1;
            end
            `A0:A0_a_tag<=`A0;
            `A1:A0_a_tag<=`A1;
            `A2:A0_a_tag<=`A2;
            `M0:A0_a_tag<=`M0;
            `M1:A0_a_tag<=`M1;
            `LD0:A0_a_tag<=`LD0;
            `LD1:A0_a_tag<=`LD1;
          endcase
          case (instbus1[15:8])        //second operand
            `R0:begin
              A0_b<=reg0; 
              A0_b_rdy<=1;
            end
            `R1:begin
              A0_b<=reg1;
              A0_b_rdy<=1;
            end
            `R2:begin
              A0_b<=reg2;
              A0_b_rdy<=1;
            end
            `R3:begin
              A0_b<=reg3;
              A0_b_rdy<=1;
            end
            `A0:A0_b_tag<=`A0;
            `A1:A0_b_tag<=`A1;
            `A2:A0_b_tag<=`A2;
            `M0:A0_b_tag<=`M0;
            `M1:A0_b_tag<=`M1;
            `LD0:A0_b_tag<=`LD0;
            `LD1:A0_b_tag<=`LD1;
          endcase
        end
        `A1: begin
          case (instbus1[23:16])        //first operand
            `R0:begin
              A1_a<=reg0; 
              A1_a_rdy<=1;
            end
            `R1:begin
              A1_a<=reg1;
              A1_a_rdy<=1;
            end
            `R2:begin
              A1_a<=reg2;
              A1_a_rdy<=1;
            end
            `R3:begin
              A1_a<=reg3;
              A1_a_rdy<=1;
            end
            `A0:A1_a_tag<=`A0;
            `A1:A1_a_tag<=`A1;
            `A2:A1_a_tag<=`A2;
            `M0:A1_a_tag<=`M0;
            `M1:A1_a_tag<=`M1;
            `LD0:A1_a_tag<=`LD0;
            `LD1:A1_a_tag<=`LD1;
          endcase
          case (instbus1[15:8])        //second operand
            `R0:begin
              A1_b<=reg0; 
              A1_b_rdy<=1;
            end
            `R1:begin
              A1_b<=reg1;
              A1_b_rdy<=1;
            end
            `R2:begin
              A1_b<=reg2;
              A1_b_rdy<=1;
            end
            `R3:begin
              A1_b<=reg3;
              A1_b_rdy<=1;
            end
            `A0:A1_b_tag<=`A0;
            `A1:A1_b_tag<=`A1;
            `A2:A1_b_tag<=`A2;
            `M0:A1_b_tag<=`M0;
            `M1:A1_b_tag<=`M1;
            `LD0:A1_b_tag<=`LD0;
            `LD1:A1_b_tag<=`LD1;
          endcase
        end
        `A2: begin
          case (instbus1[23:16])        //first operand
            `R0:begin
              A2_a<=reg0; 
              A2_a_rdy<=1;
            end
            `R1:begin
              A2_a<=reg1;
              A2_a_rdy<=1;
            end
            `R2:begin
              A2_a<=reg2;
              A2_a_rdy<=1;
            end
            `R3:begin
              A2_a<=reg3;
              A2_a_rdy<=1;
            end
            `A0:A2_a_tag<=`A0;
            `A1:A2_a_tag<=`A1;
            `A2:A2_a_tag<=`A2;
            `M0:A2_a_tag<=`M0;
            `M1:A2_a_tag<=`M1;
            `LD0:A2_a_tag<=`LD0;
            `LD1:A2_a_tag<=`LD1;
          endcase
          case (instbus1[15:8])        //second operand
            `R0:begin
              A2_b<=reg0; 
              A2_b_rdy<=1;
            end
            `R1:begin
              A2_b<=reg1;
              A2_b_rdy<=1;
            end
            `R2:begin
              A2_b<=reg2;
              A2_b_rdy<=1;
            end
            `R3:begin
              A2_b<=reg3;
              A2_b_rdy<=1;
            end
            `A0:A2_b_tag<=`A0;
            `A1:A2_b_tag<=`A1;
            `A2:A2_b_tag<=`A2;
            `M0:A2_b_tag<=`M0;
            `M1:A2_b_tag<=`M1;
            `LD0:A2_b_tag<=`LD0;
            `LD1:A2_b_tag<=`LD1;
          endcase
        end
      endcase
      if(instbus2[31:24]==`ADD)   //second instruction
      case (instbus2[39:32])      //reservation station
        `A0: begin
          case (instbus2[23:16])        //first operand
            `R0:begin
              A0_a<=reg0; 
              A0_a_rdy<=1;
            end
            `R1:begin
              A0_a<=reg1;
              A0_a_rdy<=1;
            end
            `R2:begin
              A0_a<=reg2;
              A0_a_rdy<=1;
            end
            `R3:begin
              A0_a<=reg3;
              A0_a_rdy<=1;
            end
            `A1:A0_a_tag<=`A1;
            `A2:A0_a_tag<=`A2;
            `M0:A0_a_tag<=`M0;
            `M1:A0_a_tag<=`M1;
            `LD0:A0_a_tag<=`LD0;
            `LD1:A0_a_tag<=`LD1;
          endcase
          case (instbus2[15:8])        //second operand
            `R0:begin
              A0_b<=reg0; 
              A0_b_rdy<=1;
            end
            `R1:begin
              A0_b<=reg1;
              A0_b_rdy<=1;
            end
            `R2:begin
              A0_b<=reg2;
              A0_b_rdy<=1;
            end
            `R3:begin
              A0_b<=reg3;
              A0_b_rdy<=1;
            end
            `A0:A0_b_tag<=`A0;
            `A1:A0_b_tag<=`A1;
            `A2:A0_b_tag<=`A2;
            `M0:A0_b_tag<=`M0;
            `M1:A0_b_tag<=`M1;
            `LD0:A0_b_tag<=`LD0;
            `LD1:A0_b_tag<=`LD1;
          endcase
        end
        `A1: begin
          case (instbus2[23:16])        //first operand
            `R0:begin
              A1_a<=reg0; 
              A1_a_rdy<=1;
            end
            `R1:begin
              A1_a<=reg1;
              A1_a_rdy<=1;
            end
            `R2:begin
              A1_a<=reg2;
              A1_a_rdy<=1;
            end
            `R3:begin
              A1_a<=reg3;
              A1_a_rdy<=1;
            end
            `A0:A1_a_tag<=`A0;
            `A1:A1_a_tag<=`A1;
            `A2:A1_a_tag<=`A2;
            `M0:A1_a_tag<=`M0;
            `M1:A1_a_tag<=`M1;
            `LD0:A1_a_tag<=`LD0;
            `LD1:A1_a_tag<=`LD1;
          endcase
          case (instbus2[15:8])        //second operand
            `R0:begin
              A1_b<=reg0; 
              A1_b_rdy<=1;
            end
            `R1:begin
              A1_b<=reg1;
              A1_b_rdy<=1;
            end
            `R2:begin
              A1_b<=reg2;
              A1_b_rdy<=1;
            end
            `R3:begin
              A1_b<=reg3;
              A1_b_rdy<=1;
            end
            `A0:A1_b_tag<=`A0;
            `A1:A1_b_tag<=`A1;
            `A2:A1_b_tag<=`A2;
            `M0:A1_b_tag<=`M0;
            `M1:A1_b_tag<=`M1;
            `LD0:A1_b_tag<=`LD0;
            `LD1:A1_b_tag<=`LD1;
          endcase
        end
        `A2: begin
          case (instbus2[23:16])        //first operand
            `R0:begin
              A2_a<=reg0; 
              A2_a_rdy<=1;
            end
            `R1:begin
              A2_a<=reg1;
              A2_a_rdy<=1;
            end
            `R2:begin
              A2_a<=reg2;
              A2_a_rdy<=1;
            end
            `R3:begin
              A2_a<=reg3;
              A2_a_rdy<=1;
            end
            `A0:A2_a_tag<=`A0;
            `A1:A2_a_tag<=`A1;
            `A2:A2_a_tag<=`A2;
            `M0:A2_a_tag<=`M0;
            `M1:A2_a_tag<=`M1;
            `LD0:A2_a_tag<=`LD0;
            `LD1:A2_a_tag<=`LD1;
          endcase
          case (instbus2[15:8])        //second operand
            `R0:begin
              A2_b<=reg0; 
              A2_b_rdy<=1;
            end
            `R1:begin
              A2_b<=reg1;
              A2_b_rdy<=1;
            end
            `R2:begin
              A2_b<=reg2;
              A2_b_rdy<=1;
            end
            `R3:begin
              A2_b<=reg3;
              A2_b_rdy<=1;
            end
            `A0:A2_b_tag<=`A0;
            `A1:A2_b_tag<=`A1;
            `A2:A2_b_tag<=`A2;
            `M0:A2_b_tag<=`M0;
            `M1:A2_b_tag<=`M1;
            `LD0:A2_b_tag<=`LD0;
            `LD1:A2_b_tag<=`LD1;
          endcase
        end
      endcase
    end  
  
  always @ (negedge clk)begin
    if (A0_count!=3)
      A0_count<=A0_count+1;
    if (A1_count!=3)
      A1_count<=A1_count+1;
    if (A2_count!=3)
      A2_count<=A2_count+1;
      
    if(A0_a_rdy==1 && A0_b_rdy==1)begin
      A0_count<=0;
      A0_a_rdy<=0;
      A0_b_rdy<=0;
    end
    else if(A1_a_rdy==1 && A1_b_rdy==1)begin
      A1_count<=0;
      A1_a_rdy<=0;
      A1_b_rdy<=0;
    end
    else if(A2_a_rdy==1 && A2_b_rdy==1)begin
      A2_count<=0;
      A2_a_rdy<=0;
      A2_b_rdy<=0;
    end
  end
  
  
  assign  addout = (A0_count==2)?{`A0,A0_a+A0_b}:((A1_count==2)?{`A1,A1_a+A1_b}:((A2_count==2)?{`A2,A2_a+A2_b}:40'hz));
  
endmodule