module gw_packer(
    input clk,
    input rst,

    input debug_rst,

    input jtag_tms,
    input jtag_tdi,
    output jtag_tdo,
    input jtag_tck,

    output tx_p
);

wire debug_rst_out;
wire sys_rst;

assign sys_rst = rst || debug_rst_out;



wire [9:0] ext_adr;
wire [7:0] ext_do;
reg [7:0] ext_di;
wire ext_oe;

wire [1:0] uart_tx_adr;
wire [7:0] uart_tx_din;
wire [0:0] uart_tx_dout;
wire uart_tx_wr_en;

wire [2:0] timer_adr;
wire [7:0] timer_din;
wire [7:0] timer_dout;
wire timer_wr_en;

assign uart_tx_adr = ext_adr[1:0];
assign uart_tx_din = ext_do;
assign uart_tx_wr_en = ext_oe && (ext_adr >= 10'h010 && ext_adr <= 10'h013);

assign timer_adr = ext_adr[2:0];
assign timer_din = ext_do;
assign timer_wr_en = ext_oe && (ext_adr >= 10'h000 && ext_adr <= 10'h007);

always@(*)begin
    ext_di <= 8'hXX;
    if(ext_adr >= 10'h000 && ext_adr <= 10'h007)begin
        ext_di <= timer_dout;
    end
    if(ext_adr >= 10'h010 && ext_adr <= 10'h013)begin
        ext_di <= uart_tx_dout;
    end
end

LAKKA_pack cpu(
    .clk(clk),
    .reset(sys_rst),
    .debugReset(debug_rst),
    .ndmreset(debug_rst_out),

    .jtag_tms(jtag_tms),
    .jtag_tdi(jtag_tdi),
    .jtag_tdo(jtag_tdo),
    .jtag_tck(jtag_tck),

    .ext_adr(ext_adr),
    .ext_do(ext_do),
    .ext_di(ext_di),
    .ext_oe(ext_oe)
);

uart_tx_simp_bus uart_tx(
    .clk(clk),
    .rst(sys_rst),
    .adr(uart_tx_adr),
    .din(uart_tx_din),
    .wr_en(uart_tx_wr_en),
    .tx_busy(uart_tx_dout),
    .tx_p(tx_p)
);

timer_simp_bus timer(
    .clk(clk),
    .adr(timer_adr),
    .din(timer_din),
    .dout(timer_dout),
    .wr_en(timer_wr_en)
);

endmodule
