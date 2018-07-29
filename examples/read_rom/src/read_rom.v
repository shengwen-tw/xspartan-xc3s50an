module read_rom(input wire sys_clk,
		 output reg led,
		 output wire uart_tx_clk,
		 output wire uart_rx_clk,
	         output wire uart_tx,
		 input wire uart_rx
);

	parameter DELAY_1S = 30000000;

	reg[32:0] delay_cnt = 0;

	reg uart_tx_en = 0; //set 1 to trigger uart to send a byte of data
	reg [7:0] uart_send_data;
	wire [7:0] uart_received_data;

	wire uart_rx_ready;
	reg uart_rx_ready_clear = 0;

	wire uart_tx_busy;

	reg [7:0] mem[0:5];
	reg [7:0] str_pos = 0;

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
		$readmemh("mem_init.mif", mem, 0, 5);
	end

	//print data received from uart rx
	always @(posedge sys_clk) begin
		if (delay_cnt == (DELAY_1S / 6)) begin
			delay_cnt <= 0;

			//send 1 byte through uart
			uart_send_data <= mem[str_pos];
			uart_tx_en <= 1;

			//print H,E,L,L,O,\n
			if (str_pos == 5) begin
				str_pos <= 0;
				led = ~led;
			end
			else
				str_pos <= str_pos + 1;
		end
		else
			delay_cnt <= delay_cnt + 1;

		if (uart_tx_busy == 1)
			uart_tx_en <= 0;
	end

endmodule
