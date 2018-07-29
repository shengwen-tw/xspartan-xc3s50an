module uart_receiver(input wire sys_clk,
		     input wire rx_clk_en,
		     output reg [7:0] rx_data,
		     input wire rx,
		     output reg rx_ready,
		     input wire rx_ready_clear);

	parameter UART_RX_START = 2'b01;
	parameter UART_RX_DATA  = 2'b10;
	parameter UART_RX_STOP  = 2'b11;

	parameter SAMPLE_TIMES = 15; //we are using a 16x clock to do the sampling

	reg [7:0] rx_buffer = 0;
	reg [2:0] state = UART_RX_START;
	reg [3:0] sample = 0;
	reg [3:0] bit_pos = 0;

	initial begin
		rx_ready <= 0;
	end

	always @(posedge sys_clk) begin
		if (rx_ready_clear == 1 && rx_ready == 1)
			rx_ready <= 0;

		if (rx_clk_en) begin
			case(state)
			UART_RX_START: begin
				//we are waiting for a low signal that continuing for 16 cycles
				if (rx == 0)
					sample <= sample + 1;
				else
					sample <= 0;

				if (sample == SAMPLE_TIMES) begin
					state <= UART_RX_DATA;
					sample <= 0;
					bit_pos <= 0;
					rx_buffer <= 0;
					rx_ready <= 0;
				end
			end
			UART_RX_DATA: begin
				sample <= sample + 1;

				//receive the bit at the 8th sampling
				if (sample == 8) begin
					rx_buffer[bit_pos] <= rx;
					bit_pos <= bit_pos + 1;
				end

				//8 bits to get
				if (bit_pos == 8 && sample == SAMPLE_TIMES) begin
					state <= UART_RX_STOP;
					sample <= 0;
				end
			end
			UART_RX_STOP: begin
				sample <= sample + 1;

				if (sample == 8) begin
					if (rx == 1) begin
						rx_data <= rx_buffer;
						rx_ready <= 1;
					end //if 8th bit is not a high signal, abandon the packet

					state <= UART_RX_START;
					sample <= 0;
				end
			end
			default: begin
				state <= UART_RX_START;
			end
			endcase
		end
	end

endmodule
