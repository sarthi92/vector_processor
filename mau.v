module mau(dout,vx_index,mask_index,memaddr,startMCN,rw_out,mak_out,done,vx,rx,ry,din,stride_enable,mask_enable,mask_bit,rw,start,mak,halt,clk,reset);
output reg [31:0]dout;
output [5:0]vx_index,mask_index;
output reg mak_out;
output reg [8:0]memaddr;
output reg startMCN,done;
output rw_out;
input [31:0]vx,rx,ry,din;
input mask_enable,stride_enable,mask_bit,rw,start,mak,halt,clk,reset;

wire [31:0]stride;
reg mask;
reg [6:0]index_select;
reg [6:0]mak_count;
reg [6:0]num_masks;

assign rw_out=rw;
assign stride=stride_enable?ry:32'd1;
assign vx_index=rw?index_select:index_select-7'd5;
assign mask_index=index_select;

localparam idle=1'd0, busy=1'd1;
reg ps;

always @(posedge clk)
begin

if(reset)
begin
index_select<=7'd0;
memaddr<=9'd0;
mask<=1'd0;
dout<=32'd0;
mak_out<=1'd0;
mak_count<=7'd0;
num_masks<=7'd64;
done<=1'd0;
startMCN<=1'd0;
ps<=idle;
end
else
begin
case(ps)

    idle:
    begin
    index_select=7'd0;
	memaddr=rx;
	#1
	mask=mask_enable?mask_bit:1'd1;
	dout=rw?vx:din;
	mak_out=1'd0;
	mak_count=7'd0;
	num_masks=mask?7'd63:7'd64;
    done=1'd0;
    startMCN=mask&start;
	ps=start?busy:idle;
    end
    
    busy:
    begin
    index_select=(!halt)?index_select+7'd1:index_select;
    memaddr=((index_select<=7'd64)&(!halt))?rx+index_select*stride:memaddr;
    #1
    mask=mask_enable?mask_bit:1'd1;
    dout=rw?vx:din;
    mak_out=rw?1'd0:mak;
    if((index_select<=7'd64)&(!mask))
    num_masks=num_masks-7'd1;
    if(mak_count==num_masks) mak_count=7'd0;
    else if(mak) mak_count=mak_count+7'd1;
    done=(mak_count==num_masks);
    startMCN=mask&(index_select<=7'd64);
    ps=(mak_count==num_masks)?idle:busy;
    end

endcase
end
end

endmodule