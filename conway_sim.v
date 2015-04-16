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
module conway_sim(Clk, Cells, Reset, BtnL, BtnR, Sw0, q_setup, q_simul, q_pause);
	 
	 input Clk, Reset, BtnL, BtnR, Sw0;
	 output Cells, q_setup, q_simul, q_pause;
	 
	 reg [511:0] sim_cells;
	 wire Q_setup, Q_simul, Q_pause;
	 reg [2:0] State;
	 
	 assign Cells = sim_cells;
	 assign { Q_setup, Q_simul, Q_pause } = State;
	 assign q_setup = Q_setup;
	 assign q_simul = Q_simul;
	 assign q_pause = Q_pause;
	 assign End = BtnL;
	 assign Start = BtnR;
	 assign Running = Sw0;
	 
	 // States
	 localparam
			Q_SETUP = 3'b100,
			Q_SIMUL = 3'b010,
			Q_PAUSE = 3'b001;
			
	 // Main loop
	 always @(posedge Clk, posedge Reset)
	 begin
		if (Reset)
		begin
			State <= Q_SETUP;
			sim_cells <= 0;
		end
		else
		begin
			case (State)
				Q_SETUP:
					// state transitions
					if (Start)
						State <= Q_SIMUL;
				Q_SIMUL:
					// state transitions
					if (End)
						State <= Q_SETUP;
					else if (~Running)
						State <= Q_PAUSE;
				Q_PAUSE:
					// state transitions
					if (End)
						State <= Q_SETUP;
					else if (Running)
						State <= Q_SIMUL;
			endcase
		end
	 end


endmodule
