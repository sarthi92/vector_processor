module data_mem(dout,ready,done,din,addr,bank_select,rw,start,clk,reset);
output [31:0]dout;
output ready,done;
input [31:0]din;
input [5:0]addr;
input [2:0]bank_select;
input rw,start,clk,reset;
wire [31:0]bank_dout[0:7];
wire bank_ready[0:7];
wire bank_start[0:7];
wire bank_done[0:7];
wire [2:0]bank_select_reg;

assign ready=bank_ready[bank_select];
assign dout=bank_dout[bank_select_reg];

assign bank_start[0]=(bank_select==3'd0)?start:1'd0;
assign bank_start[1]=(bank_select==3'd1)?start:1'd0;
assign bank_start[2]=(bank_select==3'd2)?start:1'd0;
assign bank_start[3]=(bank_select==3'd3)?start:1'd0;
assign bank_start[4]=(bank_select==3'd4)?start:1'd0;
assign bank_start[5]=(bank_select==3'd5)?start:1'd0;
assign bank_start[6]=(bank_select==3'd6)?start:1'd0;
assign bank_start[7]=(bank_select==3'd7)?start:1'd0;

assign bank_select_reg=bank_done[0]?3'd0:bank_done[1]?3'd1:bank_done[2]?3'd2:bank_done[3]?3'd3:bank_done[4]?3'd4:bank_done[5]?3'd5:bank_done[6]?3'd6:3'd7;
assign done=bank_done[0]|bank_done[1]|bank_done[2]|bank_done[3]|bank_done[4]|bank_done[5]|bank_done[6]|bank_done[7];

mem_bank M0(bank_dout[0],bank_ready[0],bank_done[0],din,addr,rw,bank_start[0],clk,reset);
mem_bank M1(bank_dout[1],bank_ready[1],bank_done[1],din,addr,rw,bank_start[1],clk,reset);
mem_bank M2(bank_dout[2],bank_ready[2],bank_done[2],din,addr,rw,bank_start[2],clk,reset);
mem_bank M3(bank_dout[3],bank_ready[3],bank_done[3],din,addr,rw,bank_start[3],clk,reset);
mem_bank M4(bank_dout[4],bank_ready[4],bank_done[4],din,addr,rw,bank_start[4],clk,reset);
mem_bank M5(bank_dout[5],bank_ready[5],bank_done[5],din,addr,rw,bank_start[5],clk,reset);
mem_bank M6(bank_dout[6],bank_ready[6],bank_done[6],din,addr,rw,bank_start[6],clk,reset);
mem_bank M7(bank_dout[7],bank_ready[7],bank_done[7],din,addr,rw,bank_start[7],clk,reset);

endmodule