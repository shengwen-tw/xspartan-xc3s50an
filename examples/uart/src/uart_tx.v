module uart_transmitter(input wire sys_clk,
			input wire tx_clk_en,
			input wire tx_en,
			input wire [7:0] tx_data,
			output reg uart_tx,
			output wire uart_tx_busy);

	parameter UART_TX_IDLE  = 2'b00;
	parameter UART_TX_START = 2'b01;
	parameter UART_TX_DATA  = 2'b10;
	parameter UART_TX_STOP  = 2'b11;

	reg [2:0] state = UART_TX_IDLE;
	reg [3:0] bit_pos = 0;

	initial begin
		uart_tx <= 1;
	end

	assign uart_tx_busy = (state != UART_TX_IDLE);

	always @(posedge sys_clk) begin
		case (state)
		UART_TX_IDLE: begin
			if(tx_en) begin
				bit_pos <= 3'd0;
				state <= UART_TX_START;
			end
		end
		UART_TX_START: begin
			if (tx_clk_en) begin
				uart_tx <= 0;
				state <= UART_TX_DATA;
			end
		end
		UART_TX_DATA: begin
			if (tx_clk_en) begin
				uart_tx <= tx_data[bit_pos];

				if (bit_pos == 3'd7)
					state <= UART_TX_STOP;
				else
					bit_pos <= bit_pos + 3'd1;
			end
		end
		UART_TX_STOP: begin
			if (tx_clk_en) begin
				uart_tx <= 1;
				state <= UART_TX_IDLE;
			end
		end
		default: begin
			state <= UART_TX_IDLE;
			uart_tx <= 1;
		end
		endcase
	end

endmodule
