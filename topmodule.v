module topmodule(pcout,pcinc,stride_enable,mask_enable,rw,startMAU,doneMAU,mask_bit,ready,ackMAU,ackMCN,ackMEM,reqMEM,reqMCN,halt,rwMCN,rwMEM,insout,vx_index,mask_index,vx_select,rx_select,ry_select,bankSelect,rxout,ryout,vxout,doutMAU,doutMCN,doutMEM,addrMCN,addrMEM,clk,reset);

input clk,reset;
output [3:0]pcout;
output pcinc,stride_enable,mask_enable,rw,startMAU,doneMAU;
output mask_bit,ready,ackMAU,ackMCN,ackMEM,reqMEM,reqMCN,halt,rwMCN,rwMEM;
output [11:0]insout;
output [5:0]vx_index,mask_index;
output [2:0]vx_select,rx_select,ry_select,bankSelect;
output [31:0]rxout,ryout,vxout,doutMAU,doutMCN,doutMEM;
output [8:0]addrMCN;
output [5:0]addrMEM;

pc PC(pcout,pcinc,clk,reset);
ins_mem IMEM(insout,pcout);
ins_decoder IDEC(vx_select,rx_select,ry_select,stride_enable,mask_enable,rw,pcinc,startMAU,insout,doneMAU,clk,reset);
mask_reg VMR(mask_bit,mask_index);
scalar_regs REGS(rxout,ryout,rx_select,ry_select);
vector_regs VREGS(vxout,doutMAU,vx_select,vx_index,ackMAU,clk,reset);
mau MAU(doutMAU,vx_index,mask_index,addrMCN,reqMCN,rwMCN,ackMAU,doneMAU,vxout,rxout,ryout,doutMCN,stride_enable,mask_enable,mask_bit,rw,startMAU,ackMCN,halt,clk,reset);
mcn MCN(doutMCN,addrMEM,bankSelect,reqMEM,ackMCN,halt,rwMEM,doutMAU,doutMEM,addrMCN,rwMCN,reqMCN,ready,ackMEM,clk,reset);
data_mem DMEM(doutMEM,ready,ackMEM,doutMCN,addrMEM,bankSelect,rwMEM,reqMEM,clk,reset);

endmodule
