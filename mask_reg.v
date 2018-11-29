module mask_reg(mask_bit,index_select);
output mask_bit;
input [5:0]index_select;

reg masks[0:63];

assign mask_bit=masks[index_select];

integer x;

initial
begin
for(x=0;x<=32'd63;x=x+32'd1)
masks[x]=1'd1;
masks[1]=1'd0;
masks[3]=1'd0;
masks[5]=1'd0;
masks[7]=1'd0;
end

endmodule