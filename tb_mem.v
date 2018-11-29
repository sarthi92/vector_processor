`timescale 1ns / 1ps
module tb_mem();
wire [31:0]dout;
wire ready,done;
reg [31:0]din;
reg [5:0]addr;
reg [2:0]bank_select;
reg rw,start,clk,reset;
data_mem UUT(dout,ready,done,din,addr,bank_select,rw,start,clk,reset);

initial
begin
clk=1'd0;
reset=1'd1;
start=1'd0;
#11
reset=1'd0;
#10
start=1'd1;
addr=6'd0;
bank_select=3'd0;
din=32'd45;
rw=1'd1;
#20
start=1'd1;
addr=6'd0;
bank_select=3'd1;
din=32'd50;
rw=1'd1;
#20
start=1'd0;
#60
start=1'd1;
addr=6'd0;
bank_select=3'd0;
rw=1'd0;
#20
start=1'd1;
addr=6'd0;
bank_select=3'd1;
rw=1'd0;
#20
start=1'd0;
end

always #10 clk=~clk;

endmodule
