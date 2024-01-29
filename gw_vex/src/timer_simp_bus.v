module timer_simp_bus(
    input clk,
    input [2:0] adr,
    input [7:0] din,
    output [7:0] dout,
    input wr_en
);

reg [15:0] pre_clkcnt;
reg [15:0] pre_max;

reg [31:0] clkcnt;
reg [31:0] clk_snapshot;

reg [7:0] r_dout;

always@(posedge clk)begin
    pre_clkcnt <= pre_clkcnt + 16'd1;
    if(pre_clkcnt >= pre_max)begin
        pre_clkcnt <= 0;
    end
    if(pre_clkcnt==0)begin
        clkcnt <= clkcnt + 1;
    end

    if(wr_en && adr[2])begin
        case(adr[1:0])
            2'b00:begin
                pre_clkcnt <= 16'd0;
                clkcnt <= 32'd0;
            end
            2'b01:begin
                clk_snapshot <= clkcnt;
            end
            2'b10:begin
                pre_max[7:0] <= din;
            end
            2'b11:begin
                pre_max[15:8] <= din;
            end
        endcase
    end
end

always@(*)begin
    case(adr[1:0])
        2'b00:begin
            r_dout <= clk_snapshot[7:0];
        end
        2'b01:begin
            r_dout <= clk_snapshot[15:8];
        end
        2'b10:begin
            r_dout <= clk_snapshot[23:16];
        end
        2'b11:begin
            r_dout <= clk_snapshot[31:24];
        end
    endcase
end

assign dout = r_dout;

endmodule
