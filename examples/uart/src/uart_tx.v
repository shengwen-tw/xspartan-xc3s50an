module uart_transmitter(input wire sys_clk,
			input wire tx_clk,
			input wire tx_en,
			input wire [7:0] tx_data,
			output reg uart_tx);

	parameter UART_TX_IDLE  = 2'b00;
	parameter UART_TX_START = 2'b01;
	parameter UART_TX_DATA  = 2'b10;
	parameter UART_TX_STOP  = 2'b11;

	reg [2:0] state = UART_TX_IDLE;
	reg [3:0] bit_pos = 0;

	initial begin
		uart_tx = 1;
	end

	always @(posedge sys_clk) begin
		case (state)
		UART_TX_IDLE: begin
			if(tx_en) begin
				state = UART_TX_START;
				bit_pos = 3'd0;
			end
		end
		UART_TX_IDLE: begin
			if (tx_clk) begin
			end
		end
		UART_TX_DATA: begin
			if (tx_clk) begin
			end
		end
		UART_TX_STOP: begin
			if (tx_clk) begin
			end
		end
		default: begin
			state = UART_TX_IDLE;
			//uart_tx = 1;
		end
		endcase
	end

endmodule
