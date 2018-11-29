module ins_decoder(vx_select,rx_select,ry_select,stride_enable,mask_enable,rw,pcinc,start,ins,done,clk,reset);
output reg [2:0]vx_select;
output reg [2:0]rx_select;
output reg [2:0]ry_select;
output reg stride_enable,mask_enable,rw,pcinc,start;
input [11:0]ins;
input done,clk,reset;

reg ps;

localparam idle=1'd0,busy=1'd1;
localparam vli=3'b000,vsi=3'b001,vls=3'b100,vss=3'b101,vlm=3'b010,vsm=3'b011;

always @(negedge clk)
begin
if(reset)   
    begin
    vx_select<=3'd0;
    rx_select<=3'd0;
    ry_select<=3'd0;
    stride_enable<=1'd0;
    mask_enable<=1'd0;
    rw<=1'd0;
    pcinc<=1'd0;
    start<=1'd0;
    ps<=idle;
    end
else
    begin
    case(ps)
    idle:
        begin
        vx_select<=ins[8:6];
        rx_select<=ins[5:3];
        ry_select<=ins[2:0];
		pcinc<=1'd0;
        case(ins[11:9])
        vli:
            begin
            stride_enable<=1'd0;
            mask_enable<=1'd0;
            rw<=1'd0;
            start<=1'd1;
            ps<=busy;
            end
        vsi:
            begin
            stride_enable<=1'd0;
            mask_enable<=1'd0;
            rw<=1'd1;
            start<=1'd1;
            ps<=busy;
            end
        vls:
            begin
            stride_enable<=1'd1;
            mask_enable<=1'd0;
            rw<=1'd0;
            start<=1'd1;
            ps<=busy;
            end
        vss:
            begin
            stride_enable<=1'd1;
            mask_enable<=1'd0;
            rw<=1'd1;
            start<=1'd1;
            ps<=busy;
            end
        vlm:
            begin
            stride_enable<=1'd0;
            mask_enable<=1'd1;
            rw<=1'd0;
            start<=1'd1;
            ps<=busy;
            end
        vsm:
            begin
            stride_enable<=1'd0;
            mask_enable<=1'd1;
            rw<=1'd1;
            start<=1'd1;
            ps<=busy;
            end
        default:
            begin
            stride_enable<=1'd0;
            mask_enable<=1'd0;
            rw<=1'd0;
            start<=1'd0;
            end
        endcase
        end
    busy:
        begin
        start<=1'd0;
        if(done)
        begin
        pcinc<=1'd1;
        ps<=idle;
        end
        end
    endcase
    end
end

endmodule
