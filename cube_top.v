`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:51:27 04/08/2015 
// Design Name: 
// Module Name:    cube_top 
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
module cube_top(ClkPort,                                    // System Clock
        MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS,
        BtnL, BtnC, BtnR,	             // the Left and Right buttons
        Sw0, Sw1,     // 2 Switches
		  );
                                    
	input    ClkPort;
	input    BtnL, BtnR, BtnC;
	input    Sw0, Sw1;
	  
	// ROM drivers: Control signals on Memory chips (to disable them) 	
	output 	MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS;  
	
	// Disable the three memories so that they do not interfere with the rest of the design.
	assign {MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS} = 5'b11111;
	
	wire[511:0] Cells;
	wire board_clk;
	wire Clk;
	
	// Wire outputs to cube
	wire[14:0] Pins;
	
	//------------ 
	// ClkPort travels throughout our design,
	// it is necessary to provide global routing to these signals. 
	// The BUFGPs buffer the input ports and connect them to the global 
	// routing resources in the FPGA.
	
	BUF BUF2 (board_clk, ClkPort);
	assign Clk = board_clk;
	
	assign Reset = BtnC;
	
	conway_sim conway(.Clk(Clk), .Cells(Cells), .Reset(Reset), .BtnL(BtnL), .BtnR(BtnR), .Sw0(Sw0), .Sw1(Sw1));
	
	cube_output cube(.Clk(Clk), .Cells(Cells), .Pins(Pins));

	// assign {P1, P2, ...} = Pins;
endmodule
