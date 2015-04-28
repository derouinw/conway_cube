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
module conway_sim(Clk, Cells, Reset, BtnL, BtnR, Sw0, Sw1, q_setup, q_simul, q_pause);
	 
	 input Clk, Reset, BtnL, BtnR, Sw0, Sw1;
	 output q_setup, q_simul, q_pause;
	 output [511:0] Cells;
	 
	 reg [511:0] sim_cells;
	 wire Q_setup, Q_simul, Q_pause;
	 reg [2:0] State;
	 reg mode;
	 
	 assign Cells = sim_cells;
	 assign { Q_setup, Q_simul, Q_pause } = State;
	 assign q_setup = Q_setup;
	 assign q_simul = Q_simul;
	 assign q_pause = Q_pause;
	 assign End = BtnL;
	 assign Start = BtnR;
	 assign Running = Sw0;
	 
	 // Size of cube
	 localparam
			WIDTH = 4'b1000,
			HEIGHT = 4'b1000,
			DEPTH = 4'b1000;
	 
	 // States
	 localparam
			Q_SETUP = 3'b100,
			Q_SIMUL = 3'b010,
			Q_PAUSE = 3'b001;
			
	 // Simulation modes
	 localparam
			M_LAYERS = 0,
			M_CONWAY = 1;
			
	 // Simulation parameters
	 localparam
			S_UNDER = 1, // underpopulation -> die
			S_BORN = 5,  // right population -> born
			S_OVER = 8;  // overpopulation -> die
			
	 // Integers
	 integer i, j, k;
	 integer layer;
	 integer neighbors;
			
	 // Main loop
	 always @(posedge Clk, posedge Reset)
	 begin
		if (Reset)
		begin
			State <= Q_SETUP;
			layer <= 0;
			for (i = 0; i < 512; i = i+1)
				sim_cells[i] <= $random;
		end
		else
		begin
			case (State)
				Q_SETUP:
				begin
					// state transitions
					if (Start)
						State <= Q_SIMUL;
					// RTL
					if (Sw1)
						mode <= M_CONWAY;
					else
						mode <= M_LAYERS;
				end
				Q_SIMUL:
				begin
					// state transitions
					if (End)
						State <= Q_SETUP;
					else if (~Running)
						State <= Q_PAUSE;
					// RTL
					case (mode)
						// Light an entire layer up
						// layer by layer.
						M_LAYERS:
						begin
							for (i = 0; i < WIDTH; i = i+1) // x
								for (j = 0; j < HEIGHT; j = j+1) // y
									for (k = 0; k < WIDTH; k = k+1) // z
										if (j == layer)
											sim_cells[i + j*WIDTH + k*WIDTH*HEIGHT] <= 1;
										else
											sim_cells[i + j*WIDTH + k*WIDTH*HEIGHT] <= 0;
							layer <= layer + 1;
							if (layer == HEIGHT)
								layer <= 0;
						end
						// Simulate conways game of life
						M_CONWAY:
						begin
							for (i = 0; i < WIDTH; i = i+1) // x
								for (j = 0; j < HEIGHT; j = j+1) // y
									for (k = 0; k < WIDTH; k = k+1) // z
									begin
										neighbors = num_neighbors(i, j, k);
										if (sim_cells[i + j*WIDTH + k*WIDTH*HEIGHT])
											if (neighbors <= S_UNDER)
												sim_cells[i + j*WIDTH + k*WIDTH*HEIGHT] <= 0;
											else if (neighbors > S_OVER)
												sim_cells[i + j*WIDTH + k*WIDTH*HEIGHT] <= 0;
										else
											if (neighbors == S_BORN)
												sim_cells[i + j*WIDTH + k*WIDTH*HEIGHT] <= 1;
									end
						end
					endcase
				end
				Q_PAUSE:
					// state transitions
					if (End)
						State <= Q_SETUP;
					else if (Running)
						State <= Q_SIMUL;
			endcase
		end
	 end

	function integer num_neighbors;
		input x, y, z;
		integer t, u, v, min_x, max_x, min_y, max_y, min_z, max_z;
		
		begin
			// Range of neighbors around cell
			min_x = (x > 0) ? x-1 : 0;
			max_x = (x < WIDTH-1) ? x+1 : WIDTH;
			min_y = (y > 0) ? y-1 : 0;
			max_y = (y < HEIGHT-1) ? y+1 : HEIGHT;
			min_z = (z > 0) ? z-1 : 0;
			max_z = (z < DEPTH-1) ? z+1 : DEPTH;
			
			num_neighbors = 0;
			
			for (t = min_x; t <= max_x; t = t+1)
				for (u = min_y; u <= max_y; u = u+1)
					for (v = min_z; v <= max_z; v = v+1)
						// Don't want to include current cell
						if ( ~(t==x && u==y && v==z) && sim_cells[t + u*WIDTH + v*WIDTH*HEIGHT])
							num_neighbors = num_neighbors + 1;
		end
	endfunction

endmodule
