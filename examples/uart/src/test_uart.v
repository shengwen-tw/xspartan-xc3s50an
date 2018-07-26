module test_uart(input wire sys_clk,
		 output reg led,
		 output wire uart_tx_clk,
		 output wire uart_rx_clk,
	         output wire uart_tx
);

	parameter DELYA_1S = 30000000;

	reg[23:0] led_cnt = DELYA_1S / 2;

	reg uart_tx_en = 0; //set 1 to trigger uart to send a byte of data
	reg [7:0] uart_send_data;

	wire uart_tx_busy;

	uart uart1(
		.sys_clk(sys_clk),
		.tx_clk(uart_tx_clk),
		.rx_clk(uart_rx_clk),
		.tx_en(uart_tx_en),
		.tx_data(uart_send_data),
		.tx(uart_tx),
		.tx_busy(uart_tx_busy)
	);

	initial begin
		led = 1;
	end

	always @(posedge sys_clk) begin
		//blink led and send 1 byte data through uart every second
		if(led_cnt == 0)
		begin
			led_cnt = DELYA_1S / 2;
			led = ~led;

			//send data if uart tx isn't busy
			if (uart_tx_busy == 0) begin
				uart_send_data = 65;
				uart_tx_en = 1;
			end
		end
		else
			led_cnt = led_cnt - 1;

		//data is sent, reset the send bit
		if (uart_tx_busy == 1) begin
			uart_tx_en = 0;
		end
	end

endmodule
