module uart_tx_simp_bus(
    input wire clk,
    input wire rst,
    input wire [1:0] adr,
    input wire [7:0] din,
    input wire wr_en,
    output wire tx_busy,

    output reg tx_p    
);


localparam STATE_IDLE	= 2'b00;
localparam STATE_START	= 2'b01;
localparam STATE_DATA	= 2'b10;
localparam STATE_STOP	= 2'b11;

reg[7:0] localdin;
reg localwr_en;
reg [15:0] TX_CLK_MAX;

always@(posedge clk or posedge rst)begin
    if(rst)begin
        TX_CLK_MAX <= 16'hffff;
        localwr_en <= 1'b0;
    end else begin
        localwr_en <= 1'b0;
        if(wr_en)begin
            if(adr==2'b00)begin
                TX_CLK_MAX[7:0] <= din;
            end
            if(adr==2'b01)begin
                TX_CLK_MAX[15:8] <= din;
            end
            if(adr==2'b10)begin
                localdin<=din;
                localwr_en<=1'b1;
            end
        end
    end
end

reg [7:0] data= 8'h00;
reg [2:0] bitpos= 3'h0;
reg [1:0] state= STATE_IDLE;

wire tx_clk;

reg [15:0] tx_clkcnt;

assign tx_clk = (tx_clkcnt == 0);

initial tx_clkcnt=0;

always @(posedge clk) begin
    if (tx_clkcnt >= TX_CLK_MAX)
        tx_clkcnt <= 0;
    else
        tx_clkcnt <= tx_clkcnt + 16'd1;
end
    

always @(posedge clk or posedge rst) begin
    if(rst)begin
        state <= STATE_IDLE;
        tx_p <= 1'b1;
    end else begin
    case (state)
        STATE_IDLE: begin
            if (localwr_en) begin
                state <= STATE_START;
                data <= localdin;
                bitpos <= 3'h0;
            end
        end
        STATE_START: begin
            if (tx_clk) begin
                tx_p <= 1'b0;
                state <= STATE_DATA;
            end
        end
        STATE_DATA: begin
            if (tx_clk) begin
                if (bitpos == 3'h7)
                    state <= STATE_STOP;
                else
                    bitpos <= bitpos + 3'h1;
                tx_p <= data[bitpos];
            end
        end
        STATE_STOP: begin
            if (tx_clk) begin
                tx_p <= 1'b1;
                state <= STATE_IDLE;
            end
        end
        default: begin
            tx_p <= 1'b1;
            state <= STATE_IDLE;
        end
        endcase
    end
end

assign tx_busy = (state != STATE_IDLE);

endmodule
