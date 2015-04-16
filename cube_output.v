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
	input Cells;

	output Pins;
	
	reg[20:0] outputs;
	
	assign Pins = outputs;

endmodule
