module mcn(dout,addrOut,bankSelect,req,ack,halt,rwMEM,dinMAU,dinMEM,addrIn,rw,enable,ready,done,clk,reset);
output reg [31:0]dout;
output reg [5:0]addrOut;
output reg [2:0]bankSelect;
output reg req,ack,halt;
output rwMEM;
input [31:0]dinMAU,dinMEM;
input [8:0]addrIn;
input rw,enable,ready,done,clk,reset;

assign rwMEM=rw;

always @(negedge clk)
begin
if(reset) 
begin 
dout<=32'd0;
addrOut<=6'd0;
bankSelect<=3'd0;
req<=1'd0; 
halt<=1'd0;
ack<=1'd0; 
end
else
begin
ack=done;
dout=rw?dinMAU:dinMEM;
addrOut=addrIn[8:3];
bankSelect=addrIn[2:0];
req=ready&enable;
halt=~ready&enable;
end
end
endmodule