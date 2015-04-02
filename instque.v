module instque(
  input clk,
  input stall1,
  input stall2,
  output reg [31:0]inst1,
  output reg [31:0]inst2
  );
  
  reg [31:0]queue[255:0];
  reg [7:0] index=0;
  
  initial begin
    $readmemh("instruction",queue);
  end
  
  always @ (posedge clk)
    if(stall1==0)begin
      inst1=queue[index];
      if(stall2==0)begin
        inst2=queue[index+1];
        index=index+2;
      end
      else
        index=index+1;
    end
    
endmodule
  
