module uart(input wire sys_clk,
	    output wire uart_tx_clk,
	    output wire uart_rx_clk,
	    input wire tx_en,
	    input wire [7:0] tx_data,
	    output wire uart_tx);

	uart_clock_generator uart_clk(
		.sys_clk(sys_clk),
		.uart_tx_clk(uart_tx_clk),
		.uart_rx_clk(uart_rx_clk)
	);

	uart_transmitter uart_tx_handler(
		.tx_en(tx_en),
		.tx_clk(uart_tx_clk),
		.sys_clk(sys_clk),
		.tx_data(tx_data),
		.uart_tx(uart_tx)
	);

endmodule
