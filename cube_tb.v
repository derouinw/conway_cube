`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:00:54 04/15/2015 
// Design Name: 
// Module Name:    cube_tb 
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
module cube_tb;

	reg Clk_tb, Reset_tb, BtnL_tb, BtnR_tb, Sw0_tb, Sw1_tb, slow_clk;
	wire q_setup_tb, q_simul_tb, q_pause_tb;
	wire [511:0] cells_tb;
	wire [511:0] cells_out;
	assign cells_out = cells_tb;
	wire[14:0] pins_tb;
	integer slow_count;

	conway_sim UUT (.Clk(slow_clk), .Cells(cells_tb), .Reset(Reset_tb), .BtnL(BtnL_tb), .BtnR(BtnR_tb), .Sw0(Sw0_tb),
							.Sw1(Sw1_tb), .q_setup(q_setup_tb), .q_simul(q_simul_tb), .q_pause(q_pause_tb));
	cube_output out (.Clk(Clk_tb), .Cells(cells_out), .Pins(pins_tb));

	initial
	begin
		Clk_tb = 0;
		Reset_tb = 1;
		BtnL_tb = 0;
		BtnR_tb = 0;
		Sw0_tb = 1;
		Sw1_tb = 1;
		slow_count = 0;
		slow_clk = 0;
	end
	
	always
	begin
		#10;
		Clk_tb = ~Clk_tb;
		if (slow_count == 64)
		begin
			slow_count = 0;
			slow_clk = ~slow_clk;
		end
		else
			slow_count = slow_count + 1;
	end

	initial
	begin
		#300;
		Reset_tb = 0;
		#50;
		BtnR_tb = 1;
		#1000;
		BtnR_tb = 0;
		#5000;
		
	end	

endmodule
