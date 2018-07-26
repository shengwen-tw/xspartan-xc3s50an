module uart_receiver(input wire sys_clk,
		     input wire rx_clk_en,
		     output reg [7:0] rx_data,
		     output reg rx,
		     output wire rx_ready,
		     input wire rx_ready_clear);

	parameter UART_RX_START = 2'b01;
	parameter UART_RX_DATA  = 2'b10;
	parameter UART_RX_STOP  = 2'b11;

	parameter SAMPLE_TIMES = 15; //we are using a 16x clock to do the sampling

	reg [2:0] state = UART_RX_START;
	reg [3:0] sample = 0;
	reg [3:0] bit_pos = 0;

	reg error = 0;

	always @(posedge sys_clk) begin
		if (rx_clk_en) begin
			case(state) 
			UART_RX_START: begin
			end
			UART_RX_DATA: begin
			end
			UART_RX_STOP: begin
			end
			default: begin
			end
			endcase

			if(error) begin
			end
		end
	end

endmodule
