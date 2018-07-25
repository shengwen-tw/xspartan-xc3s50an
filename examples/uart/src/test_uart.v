module test_uart(input wire sys_clk,
		 output reg led,
		 output wire uart_tx_clk,
		 output wire uart_rx_clk,
	         output wire uart_tx
);

	reg[23:0] led_cnt = 15000000;

	reg tx_en = 0;
	reg [7:0] uart_send_data;

	uart uart1(
		.sys_clk(sys_clk),
		.uart_tx_clk(uart_tx_clk),
		.uart_rx_clk(uart_rx_clk),
		.tx_en(tx_en),
		.tx_data(uart_send_data),
		.uart_tx(uart_tx)
	);

	initial begin
		led = 1;
	end

	//Blink led and send 1 byte data through uart every second
	always @(posedge sys_clk) begin
		if(led_cnt == 0)
		begin
			led_cnt = 15000000;
			led = ~led;
		end
		else
			led_cnt = led_cnt - 1;
	end

endmodule
