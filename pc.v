module pc(pcout,inc,clk,reset);
output reg [3:0]pcout;
input inc,reset,clk;

always @(posedge clk)
begin
if(reset)
pcout<=4'd0;
else
pcout<=inc?pcout+4'd1:pcout;
end

endmodule
