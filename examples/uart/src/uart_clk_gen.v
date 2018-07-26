module uart_clock_generator(input wire sys_clk,
			    output reg tx_clk,      //tx clk debug pin
			    output reg rx_clk,      //rx clk debug pin
			    output wire tx_clk_en,
			    output wire rx_clk_en);

	parameter SYS_CLK = 30000000;
	parameter BAUDRATE = 115200;

	parameter TX_ACC_MAX = SYS_CLK / BAUDRATE;
	parameter RX_ACC_MAX = SYS_CLK / (BAUDRATE * 16);

	reg[24:0] tx_acc = TX_ACC_MAX;
	reg[24:0] rx_acc = RX_ACC_MAX;

	initial begin
		tx_clk = 0;
		rx_clk = 0;
	end

	assign tx_clk_en = (tx_acc == 0);
	assign rx_clk_en = (rx_acc == 0);

	always @(posedge sys_clk) begin
		if(tx_acc == 0)
		begin
			tx_acc = TX_ACC_MAX;
			tx_clk = ~tx_clk;
		end
		else
			tx_acc = tx_acc - 1;
	end

	always @(posedge sys_clk) begin
		if(rx_acc == 0)
		begin
			rx_acc = RX_ACC_MAX;
			rx_clk = ~rx_clk;
		end
		else
			rx_acc = rx_acc - 1;
	end

endmodule
