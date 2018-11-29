`timescale 1ns / 1ps
module tb_topmodule();

reg clk,reset;
wire [3:0]pcout;
wire pcinc,stride_enable,mask_enable,rw,startMAU,doneMAU;
wire mask_bit,ready,ackMAU,ackMCN,ackMEM,reqMEM,reqMCN,halt,rwMCN,rwMEM;
wire [11:0]insout;
wire [5:0]vx_index,mask_index;
wire [2:0]vx_select,rx_select,ry_select,bankSelect;
wire [31:0]rxout,ryout,vxout,doutMAU,doutMCN,doutMEM;
wire [8:0]addrMCN;
wire [5:0]addrMEM;

topmodule UUT(pcout,pcinc,stride_enable,mask_enable,rw,startMAU,doneMAU,mask_bit,ready,ackMAU,ackMCN,ackMEM,reqMEM,reqMCN,halt,rwMCN,rwMEM,insout,vx_index,mask_index,vx_select,rx_select,ry_select,bankSelect,rxout,ryout,vxout,doutMAU,doutMCN,doutMEM,addrMCN,addrMEM,clk,reset);

initial
begin
clk=1'd0;
reset=1'd1;
#21
reset=1'd0; 
end

always #10 clk=~clk;

endmodule
