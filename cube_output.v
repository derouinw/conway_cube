`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:39 04/08/2015 
// Design Name: 
// Module Name:    cube_output 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module cube_output(Cells, Clk, Pins);
	input Clk;
	input[511:0] Cells;

	output[20:0] Pins;
	
	reg[20:0] outputs;
	
	assign Pins = outputs;
	
	always @(posedge Clk)
	begin
		outputs[0] <= ~outputs[0];
	end
	
	initial
	begin
		outputs = 0;
	end

endmodule
