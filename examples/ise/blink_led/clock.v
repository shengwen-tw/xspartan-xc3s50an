`timescale 1ns / 1ps

module top;
	reg clk;

	blink_led led(clk);
	
	always #500 begin
		clk = ~clk;
	end
	
	initial begin
		clk = 0;
	end
endmodule
