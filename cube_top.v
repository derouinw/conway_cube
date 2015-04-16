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
        BtnL, BtnU, BtnR, BtnD, BtnC,	             // the Left, Up, Right, Down, and Center buttons
        Sw0, Sw1, Sw2, Sw3, Sw4, Sw5, Sw6, Sw7,     // 8 Switches
        Ld0, Ld1, Ld2, Ld3, Ld4, Ld5, Ld6, Ld7,     // 8 LEDs
		  An0, An1, An2, An3,                         // 4 seven-LEDs
		  Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp
		  );
                                    
	input    ClkPort;
	input    BtnL, BtnU, BtnD, BtnR, BtnC;
	input    Sw0, Sw1, Sw2, Sw3, Sw4, Sw5, Sw6, Sw7;
	output   Ld0, Ld1, Ld2, Ld3, Ld4,Ld5, Ld6, Ld7;
	output   An0, An1, An2, An3;
	output   Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp;
	  
	// ROM drivers: Control signals on Memory chips (to disable them) 	
	output 	MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS;  
	
	// Disable the three memories so that they do not interfere with the rest of the design.
	assign {MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS} = 5'b11111;
	
	reg[511:0] Cells;
	wire board_clk;
	wire Clk;
	
	// Wire outputs to cube
	wire[20:0] Pins;
	
	//------------ 
	// ClkPort travels throughout our design,
	// it is necessary to provide global routing to these signals. 
	// The BUFGPs buffer the input ports and connect them to the global 
	// routing resources in the FPGA.
	
	BUF BUF2 (board_clk, ClkPort);
	assign Clk = board_clk;
	
	assign Reset = BtnC;
	
	conway_sim conway(.Clk(Clk), .Cells(Cells), .Reset(Reset), .BtnL(BtnL), .BtnR(BtnR), .Sw0(Sw0));
	
	cube_output cube(.Clk(Clk), .Cells(Cells), .Pins(Pins));

	// assign {P1, P2, ...} = Pins;
endmodule
