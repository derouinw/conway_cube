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
		  JA0, JA1, JA2, JA3, JA4, JA5, JA6, JA7,  // Pmod outputs
		  JB0, JB1, JB2, JB3, JB4, JB5, JB6, JB7
		  );
                                    
	input    ClkPort;
	input    BtnL, BtnR, BtnC;
	input    Sw0, Sw1;
	input 	JA0, JA1, JA2, JA3, JA4, JA5, JA6, JA7;
	input 	JB0, JB1, JB2, JB3, JB4, JB5, JB6, JB7;
	
	// ROM drivers: Control signals on Memory chips (to disable them) 	
	output 	MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS;  
	
	// Disable the three memories so that they do not interfere with the rest of the design.
	assign {MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS} = 5'b11111;
	
	wire[511:0] Cells;
	wire[511:0] cells_out;
	assign cells_out = Cells;
	
	wire board_clk;
	wire Clk;
	
	// Wire outputs to cube
	wire[14:0] Pins;
	assign { JB0, JB1, JB2, JB3, JB4, JB5, JB6 } = Pins[14:8]; // data select and enable
	assign { JA0, JA1, JA2, JA3, JA4, JA5, JA6, JA7 } = Pins[7:0]; // data
	
	//------------ 
	// ClkPort travels throughout our design,
	// it is necessary to provide global routing to these signals. 
	// The BUFGPs buffer the input ports and connect them to the global 
	// routing resources in the FPGA.
	
	BUF BUF2 (board_clk, ClkPort);
	assign Clk = board_clk;
	
	assign Reset = BtnC;
	
	conway_sim conway(.Clk(Clk), .Cells(Cells), .Reset(Reset), .BtnL(BtnL), .BtnR(BtnR), .Sw0(Sw0), .Sw1(Sw1));
	
	cube_output cube(.Clk(Clk), .Cells(cells_out), .Pins(Pins));
	
endmodule
