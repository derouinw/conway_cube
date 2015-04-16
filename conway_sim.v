`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:55:06 04/08/2015 
// Design Name: 
// Module Name:    conway_sim 
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
module conway_sim(Clk, Cells);
	 
	 input Clk;
	 output Cells;
	 
	 reg [511:0] sim_cells;
	 
	 assign Cells = sim_cells;


endmodule
