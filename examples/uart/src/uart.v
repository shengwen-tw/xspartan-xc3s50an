`timescale 1ns / 1ps

//uart_clk_gen
module uart(input sys_clk, output reg uart_tx_clk, output reg uart_rx_clk);
	parameter SYS_CLK = 30000000;
	parameter BAUDRATE = 9600;

	parameter TX_ACC_MAX = SYS_CLK / BAUDRATE;
	parameter RX_ACC_MAX = SYS_CLK / (BAUDRATE * 16);

	reg[24:0] tx_acc = TX_ACC_MAX;
	reg[24:0] rx_acc = RX_ACC_MAX;

	initial begin
		uart_tx_clk = 0;
		uart_rx_clk = 0;
	end

	always @(posedge sys_clk) begin
		if(tx_acc == 0)
		begin
			tx_acc = TX_ACC_MAX;
			uart_tx_clk = ~uart_tx_clk;
		end
		else
			tx_acc = tx_acc - 1;
	end

	always @(posedge sys_clk) begin
		if(rx_acc == 0)
		begin
			rx_acc = RX_ACC_MAX;
			uart_rx_clk = ~uart_rx_clk;
		end
		else
			rx_acc = rx_acc - 1;
	end
endmodule
