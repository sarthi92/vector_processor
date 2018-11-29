module ins_mem(insout,pcin);
output [11:0]insout;
input [3:0]pcin;

reg [11:0]ins_store[0:15];

assign insout=ins_store[pcin];

localparam vli=3'b000,vsi=3'b001,vls=3'b100,vss=3'b101,vlm=3'b010,vsm=3'b011,stp=3'b111;

initial
begin
ins_store[0]<={vsi,3'd1,3'd0,3'd0};//vsi v1,r0
ins_store[1]<={vli,3'd2,3'd0,3'd0};//vli v2,r0
ins_store[2]<={stp,3'd0,3'd0,3'd0};//stop
end

endmodule
