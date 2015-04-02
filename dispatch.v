module dispatch(
  input clk,
  input [31:0]inst1,
  input [31:0]inst2,
  input [39:0]addbus,
  input [39:0]multbus,
  input [39:0]loadbus,
  input [7:0]storesig,
  
  output reg [39:0]instbus1,    //first instruction
  output reg [39:0]instbus2,     //second instruction
  output reg stall1=0,
  output reg stall2=0
  
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
  
  
  reg A0_flag,A1_flag,A2_flag;
  reg M0_flag,M1_flag,LD0_flag,LD1_flag;
  reg ST0_flag,ST1_flag;   //0: available 1: ocupied
  
  reg A0_temp,A1_temp,A2_temp;
  reg M0_temp,M1_temp,LD0_temp,LD1_temp;
  reg ST0_temp,ST1_temp;
  
  reg [7:0]R0_t;
  reg [7:0]R1_t;
  reg [7:0]R2_t;
  reg [7:0]R3_t;
  
  initial begin
    A0_flag<=0;
    A1_flag<=0;
    A2_flag<=0;
    M0_flag<=0;
    M1_flag<=0;
    LD0_flag<=0;
    LD1_flag<=0;
    ST0_flag<=0;
    ST1_flag<=0;
    A0_temp<=0;
    A1_temp<=0;
    A2_temp<=0;
    M0_temp<=0;
    M1_temp<=0;
    LD0_temp<=0;
    LD1_temp<=0;
    ST0_temp<=0;
    ST1_temp<=0;
    R0_t<=0;
    R1_t<=0;
    R2_t<=0;
    R3_t<=0;
  end
  
  always @ (posedge clk)begin
    if(A0_temp==1) begin
      A0_flag=1;
      A0_temp=0;
    end
    if(A1_temp==1) begin
      A1_flag=1;
      A1_temp=0;
    end
    if(A2_temp==1) begin
      A2_flag=1;
      A2_temp=0;
    end
    if(M0_temp==1) begin
      M0_flag=1;
      M0_temp=0;
    end
    if(M1_temp==1) begin
      M1_flag=1;
      M1_temp=0;
    end
    if(LD0_temp==1) begin
      LD0_flag=1;
      LD0_temp=0;
    end
    if(LD1_temp==1) begin
      LD1_flag=1;
      LD1_temp=0;
    end
    if(ST0_temp==1) begin
      ST0_flag=1;
      ST0_temp=0;
    end
    if(ST1_temp==1) begin
      ST1_flag=1;
      ST1_temp=0;
    end
    
    case (addbus[39:32])
      `A0: begin A0_flag=0; clear_tag(`A0);end
      `A1: begin A1_flag=0; clear_tag(`A1);end
      `A2: begin A2_flag=0; clear_tag(`A2);end
    endcase
    
    case (loadbus[39:32])
      `LD0: begin LD0_flag=0; clear_tag(`LD0);end
      `LD1: begin LD1_flag=0; clear_tag(`LD1);end
    endcase
    
    case (multbus[39:32])
      `M0: begin M0_flag=0; clear_tag(`M0); end
      `M1: begin M1_flag=0; clear_tag(`M1); end
    endcase
    
    case (storesig)
      `ST0: begin ST0_flag=0; clear_tag(`ST0); end
      `ST1: begin ST1_flag=0; clear_tag(`ST1); end
    endcase  
  end
    
  always @ (negedge clk)begin

    case (inst1[31:24])     //instruction1 decoding
      `LOAD: begin
        if (LD0_flag==0) begin
          instbus1[39:32]=`LD0;
          instbus1[7:0]=inst1[23:16];
          instbus1[31:24]=inst1[31:24];
          stall1=0;
          update_tag(inst1[23:16],`LD0);
          LD0_temp=1;
          inst2_decode;
        end
        else if(LD1_flag==0) begin
          instbus1[39:32]=`LD1;
          instbus1[7:0]=inst1[23:16];
          instbus1[31:24]=inst1[31:24];
          stall1=0;
          update_tag(inst1[23:16],`LD1);
          LD1_temp=1;
          inst2_decode;
        end
        else begin
          stall1<=1;
          stall2<=1;
        end
      end  
      `STORE:begin
        if (ST0_flag==0)begin
          instbus1[7:0]=`ST0;
          instbus1[39:32]=RegReslv(inst1[23:16]);
          instbus1[31:24]=inst1[31:24];
          stall1=0;
          ST0_temp=1;
          inst2_decode;
        end
        else if(ST1_flag==0)begin
          instbus1[7:0]=`ST1;
          instbus1[39:32]=RegReslv(inst1[23:16]);
          instbus1[31:24]=inst1[31:24];
          stall1=0;
          ST1_temp=1;
          inst2_decode;
        end
        else begin
          stall1<=1;
          stall2<=1;
        end  
      end
      `ADD:begin
        if (A0_flag==0)begin
          instbus1[39:32]=`A0;
          instbus1[23:16]=RegReslv(inst1[15:8]);         //operand 1
          instbus1[15:8]=RegReslv(inst1[7:0]);         //operand 2
          instbus1[7:0]=inst1[23:16];
          instbus1[31:24]=inst1[31:24];      //op code
          stall1=0;
          update_tag(inst1[23:16],`A0);
          A0_temp=1;
          inst2_decode;
        end
        else if(A1_flag==0)begin
          instbus1[39:32]=`A1;
          instbus1[23:16]=RegReslv(inst1[15:8]);
          instbus1[15:8]=RegReslv(inst1[7:0]);
          instbus1[7:0]=inst1[23:16];
          instbus1[31:24]=inst1[31:24];
          stall1=0;
          update_tag(inst1[23:16],`A1);
          A1_temp=1;
          inst2_decode; 
        end
        else if(A2_flag==0)begin
          instbus1[39:32]=`A2;
          instbus1[23:16]=RegReslv(inst1[15:8]);
          instbus1[15:8]=RegReslv(inst1[7:0]);
          instbus1[7:0]=inst1[23:16];
          instbus1[31:24]=inst1[31:24];
          stall1=0;
          update_tag(inst1[23:16],`A2); 
          A2_temp=1;
          inst2_decode;
        end
        else begin
          stall1<=1;
          stall2<=1;
        end
      end       
      `MULTI:begin
        if (M0_flag==0)begin
          instbus1[39:32]=`M0;
          instbus1[23:16]=RegReslv(inst1[15:8]);
          instbus1[15:8]=RegReslv(inst1[7:0]);
          instbus1[7:0]=inst1[23:16];
          instbus1[31:24]=inst1[31:24];
          stall1=0;
          update_tag(inst1[23:16],`M0);
          M0_temp=1;
          inst2_decode;
        end
        else if(M1_flag==0)begin
          instbus1[39:32]=`M1;
          instbus1[23:16]=RegReslv(inst1[15:8]);
          instbus1[15:8]=RegReslv(inst1[7:0]);
          update_tag(inst1[15:8],`M1);
          update_tag(inst1[7:0],`M1);
          instbus1[7:0]=inst1[23:16];
          instbus1[31:24]=inst1[31:24];
          stall1=0;
          update_tag(inst1[23:16],`M1);
          M1_temp=1; 
          inst2_decode;
        end
        else begin
          stall1<=1;
          stall2<=1;
        end
      end
    endcase
  end
    
  function [7:0]RegReslv;
    input [7:0]Regi;
    case (Regi)
      `R0: 
        if(R0_t!=0)
          RegReslv=R0_t;
        else
          RegReslv=`R0;
      `R1: 
        if(R1_t!=0)
          RegReslv=R1_t;
        else
          RegReslv=`R1;
      `R2: 
        if(R2_t!=0)
          RegReslv=R2_t;
        else
          RegReslv=`R2;
      `R3: 
        if(R3_t!=0)
          RegReslv=R3_t;
        else
          RegReslv=`R3;
    endcase
  endfunction
  
  task update_tag;
    input [7:0]des_reg;
    input [7:0]new_tag;
    case (des_reg)
      `R0: R0_t=new_tag;
      `R1: R1_t=new_tag;
      `R2: R2_t=new_tag;
      `R3: R3_t=new_tag;
    endcase
  endtask

  task clear_tag;
    input [7:0]res_sta;
    begin
      R0_t=(R0_t==res_sta)?0:R0_t;
      R1_t=(R1_t==res_sta)?0:R1_t;
      R2_t=(R2_t==res_sta)?0:R2_t;
      R3_t=(R3_t==res_sta)?0:R3_t;
    end
  endtask
  
  task inst2_decode;
    case (inst2[31:24])     //instruction2 decoding
        `LOAD: begin
          if (inst1[31:24]!=`LOAD)begin
            if (LD0_flag==0) begin
              instbus2[39:32]=`LD0;    //Resv Station
              instbus2[31:24]=inst2[31:24];  //OP code
              instbus2[7:0]=inst2[23:16];    // destine reg
              stall2=0;
              update_tag(inst2[23:16],`LD0);
              LD0_temp=1;
            end
            else if(LD1_flag==0) begin
              instbus2[39:32]=`LD1;
              instbus2[31:24]=inst2[31:24];
              instbus2[7:0]=inst2[23:16];
              stall2=0;
              update_tag(inst2[23:16],`LD1);
              LD1_temp=1;
            end
            else
              stall2<=1;
          end
          else begin
            if (LD0_flag==0 && LD1_flag==0)begin
              instbus2[39:32]=`LD1;
              instbus2[31:24]=inst2[31:24];
              instbus2[7:0]=inst2[23:16];
              stall2=0;
              update_tag(inst2[23:16],`LD1);
              LD1_temp=1;
            end
            else
              stall2=1;         
          end
        end  
        `STORE:begin
          if(inst1[31:24]!=`STORE) begin
            if (ST0_flag==0)begin
              instbus2[7:0]=`ST0;
              instbus2[39:32]=RegReslv(inst2[23:16]);
              instbus2[31:24]=inst2[31:24];
              stall2=0;
              ST0_temp=1;
            end
            else if(ST1_flag==0)begin
              instbus2[7:0]=`ST1;
              instbus2[39:32]=RegReslv(inst2[23:16]);
              instbus2[31:24]=inst2[31:24];
              stall2=0;
              ST1_temp=1;
            end
            else
              stall2=1; 
          end
          else begin
            if(ST0_flag==0 && ST1_flag==0)begin
              instbus2[7:0]=`ST1;
              instbus2[39:32]=RegReslv(inst2[23:16]);
              instbus2[31:24]=inst2[31:24];
              stall2=0;
              ST1_temp=1;
            end
            else
              stall2=1;
          end
        end
        `ADD: begin
          if (inst1[31:24]!=`ADD) begin
            if (A0_flag==0)begin
              instbus2[39:32]=`A0;   //Resev Station
              instbus2[23:16]=RegReslv(inst2[15:8]);   //operand 1
              instbus2[15:8]=RegReslv(inst2[7:0]);   //operand 2
              instbus2[7:0]=inst2[23:16];    //destin register
              instbus2[31:24]=inst2[31:24];    // OP code
              stall2=0;
              update_tag(inst2[23:16],`A0);
              A0_temp=1;
            end
            else if(A1_flag==0)begin
              instbus2[39:32]=`A1;
              instbus2[23:16]=RegReslv(inst2[15:8]);
              instbus2[15:8]=RegReslv(inst2[7:0]);
              instbus2[7:0]=inst2[23:16];
              instbus2[31:24]=inst2[31:24];
              stall2=0;
              update_tag(inst2[23:16],`A1);
              A1_temp=1; 
            end
            else if(A2_flag==0)begin
              instbus2[39:32]=`A2;
              instbus2[23:16]=RegReslv(inst2[15:8]);
              instbus2[15:8]=RegReslv(inst2[7:0]);
              instbus2[7:0]=inst2[23:16];
              instbus2[31:24]=inst2[31:24];
              stall2=0;
              update_tag(inst2[23:16],`A2); 
              A2_temp=1;
            end
            else
              stall2=1;
          end
          else begin
            if(A0_flag==0)
              if(A1_flag==0)begin
                instbus2[39:32]=`A1;
                instbus2[23:16]=RegReslv(inst2[15:8]);
                instbus2[15:8]=RegReslv(inst2[7:0]);
                instbus2[7:0]=inst2[23:16];
                instbus2[31:24]=inst2[31:24];
                stall2=0;
                update_tag(inst2[23:16],`A1);
                A1_temp=1;
              end
              else if(A2_flag==0)begin
                instbus2[39:32]=`A2;
                instbus2[23:16]=RegReslv(inst2[15:8]);
                instbus2[15:8]=RegReslv(inst2[7:0]);
                instbus2[7:0]=inst2[23:16];
                instbus2[31:24]=inst2[31:24];
                stall2=0;
                update_tag(inst2[23:16],`A2);
                A2_temp=1;
              end
              else
                stall2=1;
            else if(A1_flag==0)
              if(A2_flag==0)begin
                instbus2[39:32]=`A2;
                instbus2[23:16]=RegReslv(inst2[15:8]);
                instbus2[15:8]=RegReslv(inst2[7:0]);
                instbus2[7:0]=inst2[23:16];
                instbus2[31:24]=inst2[31:24];
                stall2=0;
                update_tag(inst2[23:16],`A2);
                A2_temp=1;
              end
              else
                stall2=1;
            else
              stall2=1;
          end
        end       
        `MULTI:begin
          if (inst1[31:24]!=`MULTI)
            if (M0_flag==0)begin
              instbus2[39:32]=`M0;
              instbus2[23:16]=RegReslv(inst2[15:8]);
              instbus2[15:8]=RegReslv(inst2[7:0]);
              instbus2[7:0]=inst2[23:16];
              instbus2[31:24]=inst2[31:24];
              stall2=0;
              update_tag(inst2[23:16],`M0);
              M0_temp=1;
            end
            else if(M1_flag==0)begin
              instbus2[39:32]=`M1;
              instbus2[23:16]=RegReslv(inst2[15:8]);
              instbus2[15:8]=RegReslv(inst2[7:0]);
              instbus2[7:0]=inst2[23:16];
              instbus2[31:24]=inst2[31:24];
              stall2=0; 
              update_tag(inst2[23:16],`M1);
              M1_temp=1;
            end
            else
              stall2=1;
          else
            if (M0_flag==0 && M1_flag==0) begin
              instbus2[39:32]=`M1;
              instbus2[23:16]=RegReslv(inst2[15:8]);
              instbus2[15:8]=RegReslv(inst2[7:0]);
              instbus2[7:0]=inst2[23:16];
              instbus2[31:24]=inst2[31:24];
              stall2=0;
              update_tag(inst2[23:16],`M1); 
              M1_temp=1;
            end
            else
              stall2=1;
        end
      endcase
  endtask

endmodule
