`timescale 1ns / 1ps

module blink_led(clk_in, led);
	input clk_in;
	output led;

	reg[23:0] cnt;
	reg led;
	
	always @(posedge clk_in) begin
		if(cnt == 0)
		begin
			cnt = 15000000;
			led = ~led;
		end
		else
			cnt = cnt - 1;
	end
	
	initial begin
		cnt = 15000000;
		led = 1;
	end
endmodule
