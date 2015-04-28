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
	// The values of the output pins
	// are dependent on the data in the
	// cells and the current layer and
	// row, which act as the state.
	input Clk;
	input[511:0] Cells;

	output[14:0] Pins;
	
	localparam
		WIDTH = 8,
		HEIGHT = 8,
		DEPTH = 8;
		
	wire[511:0] sim_cells;
	assign sim_cells = Cells;
	
	// The outputs to the cube consist of:
	// 0-2: Layer
	// 3-5: Row
	// 6-13: Data
	// 14: Enable (active-low)
	wire[14:0] outputs;
	assign Pins = outputs;
	
	reg[2:0] layer = 0;
	assign outputs[0] = layer[0];
	assign outputs[1] = layer[1];
	assign outputs[2] = layer[2];
	
	reg[2:0] row = 0;
	assign outputs[5:3] = row;
	
	reg[7:0] data = 0;
	assign outputs[13:6] = data;
	
	reg enable = 0;
	assign outputs[14] = enable;
	
	// In total, to scan through the entire
	// cube takes (8 layers * 8 rows =) 64 clocks.
	// Therefore, we want the simulation to run
	// in multiples of 64 clocks.
	always @(posedge Clk)
	begin
		// What we need to do is scan through
		// the cube, 8-bit row at a time.
		enable <= 0;
		
		// set the data
		// data <= sim_cells[layer*WIDTH + row*WIDTH*HEIGHT+:7];
		data <= sim_cells[layer*WIDTH + row*WIDTH*HEIGHT+:DEPTH];
		
		// end of layer?
		if (row == WIDTH-1)
		begin
			row <= 0;
			
			// top of cube?
			if (layer == HEIGHT-1)
				layer <= 0;
			else
				layer <= layer + 1;
		end
		else
			row <= row + 1;
	end

endmodule
