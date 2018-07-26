module uart(input wire sys_clk,
	    output wire tx_clk,
	    output wire rx_clk,
	    input wire tx_en,
	    input wire [7:0] tx_data,
	    output wire tx,
	    output wire tx_busy);

	wire tx_clk_en;
	wire rx_clk_en;

	uart_clock_generator uart_clk(
		.sys_clk(sys_clk),
		.tx_clk(tx_clk),
		.rx_clk(rx_clk),
		.tx_clk_en(tx_clk_en),
		.rx_clk_en(rx_clk_en)
	);

	uart_transmitter uart_tx_handler(
		.sys_clk(sys_clk),
		.tx_en(tx_en),
		.tx_clk_en(tx_clk_en),
		.tx_data(tx_data),
		.tx(tx),
		.tx_busy(tx_busy)
	);

endmodule
