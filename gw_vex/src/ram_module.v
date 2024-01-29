module RAM_4kx32 ( Q, ADR, D, WEM, WE, OE, ME,  CLK);

output [31:0] Q;
wire [31:0] Q;

input [11:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

reg [31:0] out_reg;

reg [31:0] core_mem [4095:0];

assign Q = OE?(ME?out_reg : 32'hXXXXXXXX):32'hZZZZZZZZ;

wire wre = ME && WE;

integer i;

always @(posedge CLK)
begin
    if(wre) begin
        for(i = 0; i < 4; i = i + 1) begin
            if(WEM[i])
                core_mem[ADR][i*8 +: 8] <= D[i*8 +: 8];
        end
    end
    out_reg <= core_mem[ADR];
end

initial begin : init_mem
    $readmemh("Hello_world.hex", core_mem);
end


endmodule