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

	reg Clk_tb, Reset_tb, BtnL_tb, BtnR_tb, Sw0_tb, Sw1_tb;
	wire q_setup_tb, q_simul_tb, q_pause_tb;
	wire [511:0] cells_tb;

	conway_sim UUT (.Clk(Clk_tb), .Cells(cells_tb), .Reset(Reset_tb), .BtnL(BtnL_tb), .BtnR(BtnR_tb), .Sw0(Sw0_tb),
							.Sw1(Sw1_tb), .q_setup(q_setup_tb), .q_simul(q_simul_tb), .q_pause(q_pause_tb));

	initial
	begin
		Clk_tb = 0;
		Reset_tb = 1;
		BtnL_tb = 0;
		BtnR_tb = 0;
		Sw0_tb = 1;
		Sw1_tb = 0;
	end
	
	always
	begin
		#10;
		Clk_tb = ~Clk_tb;
	end

	initial
	begin
		#30;
		Reset_tb = 0;
		#50;
		BtnR_tb = 1;
		#20;
		BtnR_tb = 0;
		#500;
		BtnL_tb = 1;
		Sw1_tb = 0;
		#20;
		BtnR_tb = 1;
		#50;
		BtnR_tb = 0;
		#1000;
		
	end	

endmodule
