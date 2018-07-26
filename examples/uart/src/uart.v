module uart(input wire sys_clk,
	    output wire tx_clk,
	    output wire rx_clk,
	    input wire tx_en,
	    input wire [7:0] tx_data,
	    output wire tx,
	    output wire tx_busy,
	    output wire [7:0] rx_data,
	    input wire rx,
	    output wire rx_ready,
	    input wire rx_ready_clear);

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

	uart_receiver uart_rx_handler(.sys_clk(sys_clk),
		      .rx_clk_en(rx_en),
		      .rx_data(rx_clk_en),
		      .rx(rx_data),
		      .rx_ready(rx_ready),
		      .rx_ready_clear(rx_ready_clear)
	);

endmodule
