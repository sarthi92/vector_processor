module scalar_regs(rxout,ryout,rx_select,ry_select);
output [31:0]rxout,ryout;
input [2:0]rx_select,ry_select;

reg [31:0]regs[0:7];

assign rxout=regs[rx_select];
assign ryout=regs[ry_select];

initial
begin
regs[0]<=32'd0;
regs[1]<=32'd1;
regs[2]<=32'd2;
regs[3]<=32'd3;
regs[4]<=32'd4;
regs[5]<=32'd5;
regs[6]<=32'd6;
regs[7]<=32'd7;
end

endmodule