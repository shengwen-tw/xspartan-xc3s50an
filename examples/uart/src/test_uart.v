module test_uart(input wire sys_clk,
		 output reg led,
		 output wire uart_tx_clk,
		 output wire uart_rx_clk,
	         output wire uart_tx,
		 input wire uart_rx
);

	parameter DELAY_1S = 30000000;

	reg[23:0] delay_cnt = 0;

	reg uart_tx_en = 0; //set 1 to trigger uart to send a byte of data
	reg [7:0] uart_send_data;
	wire [7:0] uart_received_data;

	wire uart_rx_ready;
	reg uart_rx_ready_clear = 0;

	wire uart_tx_busy;

	uart uart1(
		.sys_clk(sys_clk),
		.tx_clk(uart_tx_clk),
		.rx_clk(uart_rx_clk),
		.tx_en(uart_tx_en),
		.tx_data(uart_send_data),
		.tx(uart_tx),
		.tx_busy(uart_tx_busy),
		.rx_data(uart_received_data),
		.rx(uart_rx),
		.rx_ready(uart_rx_ready),
		.rx_ready_clear(uart_rx_ready_clear)
	);

	initial begin
		led <= 0;
	end

	//print data received from uart rx
	always @(posedge sys_clk) begin
		if (uart_rx_ready) begin
			uart_send_data <= uart_received_data;
			uart_tx_en <= 1;
			
			uart_rx_ready_clear <= 1;
		end

		if (uart_tx_busy == 1)
			uart_tx_en <= 0;

		if (uart_rx_ready == 0)
			uart_rx_ready_clear <= 0;
	end

	//blink led when receive the data from uart rx
	always @(posedge sys_clk) begin
		if (uart_rx_ready) begin
			led <= 0;
			delay_cnt <= 0;
		end

		if (delay_cnt == (DELAY_1S / 100)) begin
			delay_cnt <= 0;
			led <= 1;
		end
		else
			delay_cnt <= delay_cnt + 1; 
	end

endmodule
