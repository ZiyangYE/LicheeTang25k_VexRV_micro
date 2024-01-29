module LAKKA_pack(
  input clk,
  input reset,
  input debugReset,
  output ndmreset,

  input jtag_tms,
  input jtag_tdi,
  output jtag_tdo,
  input jtag_tck,
  
  output [9:0] ext_adr,
  output [7:0] ext_do,
  input [7:0] ext_di,
  output ext_oe
);

reg [9:0] r_ext_adr;

wire [11:0] mem_adr;
wire [31:0] mem_di;
reg [3:0] mem_wem;
wire mem_we;
wire [31:0] mem_do;


wire [31:0] iBus_resp;
reg iBus_resp_valid;
wire iBus_cmd_ready;

wire iBus_cmd_valid;
wire [31:0] iBus_cmd_payload_pc;



wire [31:0] dBus_resp;
reg dBus_resp_valid;

wire dBus_cmd_valid;
wire dBus_cmd_payload_wr;
wire [31:0] dBus_cmd_payload_address;
wire [31:0] dBus_cmd_payload_data;
wire [1:0] dBus_cmd_payload_size;

wire dBus_acc_ext = dBus_cmd_payload_address[31] && dBus_cmd_valid;
wire dBus_acc_ram = (!dBus_cmd_payload_address[31]) && dBus_cmd_valid;
wire iBus_acc_ram = iBus_cmd_valid && !dBus_acc_ram;

reg last_dBus_acc_ext;

assign iBus_cmd_ready = !dBus_acc_ram;

assign mem_di = dBus_cmd_payload_data;
assign mem_we = dBus_cmd_payload_wr && dBus_acc_ram;
assign mem_adr = dBus_acc_ram?dBus_cmd_payload_address[13:2]:iBus_cmd_payload_pc[13:2];

always @(*) begin
    case(dBus_cmd_payload_size)
        2'b00 : begin
        mem_wem <= 4'b0001 <<< dBus_cmd_payload_address[1 : 0];
        end
        2'b01 : begin
        mem_wem <= 4'b0011 <<< dBus_cmd_payload_address[1 : 0];
        end
        default : begin
        mem_wem <= 4'b1111 <<< dBus_cmd_payload_address[1 : 0];
        end
    endcase
end

assign ext_do = dBus_cmd_payload_data[7:0];
assign ext_oe = dBus_acc_ext && dBus_cmd_payload_wr;
assign ext_adr = dBus_acc_ext?dBus_cmd_payload_address[9:0]:r_ext_adr;

assign dBus_resp = last_dBus_acc_ext?{ext_di, ext_di, ext_di, ext_di}:mem_do;
assign iBus_resp = mem_do;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        iBus_resp_valid <= 0;

        dBus_resp_valid <= 0;

        last_dBus_acc_ext <= 0;
    end else begin
        r_ext_adr <= ext_adr;

        dBus_resp_valid <= (dBus_acc_ext || dBus_acc_ram)&&!dBus_cmd_payload_wr;
        iBus_resp_valid <= iBus_acc_ram;

        last_dBus_acc_ext <= dBus_acc_ext;

        if(dBus_acc_ext)begin
            r_ext_adr <= dBus_cmd_payload_address[9:0];
        end
    end
end

VexRiscv cpu (
    .clk(clk),
    .reset(reset),
    .debugReset(debugReset),
    .ndmreset(ndmreset),
    .jtag_tms(jtag_tms),
    .jtag_tdi(jtag_tdi),
    .jtag_tdo(jtag_tdo),
    .jtag_tck(jtag_tck),

    .iBus_cmd_valid(iBus_cmd_valid),
    .iBus_cmd_ready(iBus_cmd_ready),
    .iBus_cmd_payload_pc(iBus_cmd_payload_pc),
    .iBus_rsp_valid(iBus_resp_valid),
    .iBus_rsp_payload_error(1'b0),
    .iBus_rsp_payload_inst(iBus_resp),

    .dBus_cmd_valid(dBus_cmd_valid),
    .dBus_cmd_ready(1'b1),
    .dBus_cmd_payload_wr(dBus_cmd_payload_wr),
    .dBus_cmd_payload_address(dBus_cmd_payload_address),
    .dBus_cmd_payload_data(dBus_cmd_payload_data),
    .dBus_cmd_payload_size(dBus_cmd_payload_size),
    .dBus_rsp_ready(dBus_resp_valid),
    .dBus_rsp_error(1'b0),
    .dBus_rsp_data(dBus_resp),

    .timerInterrupt(1'b0),
    .externalInterrupt(1'b0),
    .softwareInterrupt(1'b0),

    .stoptime()
);

RAM_4kx32 mem(
    .Q(mem_do),
    .ADR(mem_adr),
    .D(mem_di),
    .WEM(mem_wem),
    .WE(mem_we),
    .OE(1'b1),
    .ME(~reset),
    .CLK(clk)
);

endmodule
