module mem_bank(dout,ready,done,din,addr,rw,start,clk,reset);
output reg [31:0]dout;
output reg ready,done;
input [31:0]din;
input [5:0]addr;
input rw,start,clk,reset;

reg [31:0]mem[0:63];
reg [31:0]din_reg;
reg [5:0]addr_reg;

localparam idle=2'd0,phase1=2'd1,phase2=2'd2,phase3=2'd3;
reg [1:0]ps;

always @(posedge clk)
begin
if(reset)
begin
dout<=32'd0;
ready<=1'd1;
done<=1'd0;
ps<=idle;
end
else
begin
case(ps)

idle:
begin
ready<=1'd1;
done<=1'd0;
if(start)
begin
if(rw)
din_reg<=din;
addr_reg<=addr;
ps<=phase1;
end
end

phase1:
begin
ready<=1'd0;
ps<=phase2;
end

phase2:
ps<=phase3;

phase3:
begin
if(rw)
mem[addr_reg]<=din_reg;
else
dout<=mem[addr_reg];
done<=1'd1;
ps<=idle;
end

endcase
$display("%d %d %d %d %d %d %d %d",mem[0],mem[1],mem[2],mem[3],mem[4],mem[5],mem[6],mem[7]);
end
end

initial
begin
mem[0]<=32'd0;
mem[1]<=32'd0;
mem[2]<=32'd0;
mem[3]<=32'd0;
mem[4]<=32'd0;
mem[5]<=32'd0;
mem[6]<=32'd0;
mem[7]<=32'd0;
end

endmodule