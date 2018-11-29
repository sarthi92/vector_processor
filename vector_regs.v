module vector_regs(vxout,datain,vx_select,index_select,mak,clk,reset);
output [31:0]vxout;
input [31:0]datain;
input [2:0]vx_select;
input [5:0]index_select;
input mak,clk,reset;

reg [31:0]vx[0:7][0:63];

assign vxout=vx[vx_select][index_select];

always @(negedge clk)
begin
if(!reset && mak)vx[vx_select][index_select]<=datain;
//$display("%d %d %d %d %d %d %d %d",vx[2][0],vx[2][1],vx[2][2],vx[2][3],vx[2][4],vx[2][5],vx[2][6],vx[2][7]);
end

integer x;

initial
begin
for(x=0;x<=32'd63;x=x+32'd1)
vx[1][x]<=x;
for(x=0;x<=32'd63;x=x+32'd1)
vx[2][x]<=32'd0;
end

endmodule