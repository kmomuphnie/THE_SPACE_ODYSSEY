
module fill(CLOCK_50, resetn, 

			x_input, y_input, color_input, iSD, iSE, 

			x_input_M, y_input_M, color_input_M, iSD_M, iSE_M,
			x_input_M1, y_input_M1, color_input_M1, iSD_M1, iSE_M1,
			x_input_M2, y_input_M2, color_input_M2, iSD_M2, iSE_M2,
			x_input_M3, y_input_M3, color_input_M3, iSD_M3, iSE_M3,
			x_input_M4, y_input_M4, color_input_M4, iSD_M4, iSE_M4,

			x_input_P1, y_input_P1, color_input_P1, iSD_P1, iSE_P1,
			x_input_P2, y_input_P2, color_input_P2, iSD_P2, iSE_P2,
			x_input_P3, y_input_P3, color_input_P3, iSD_P3, iSE_P3,
			x_input_P4, y_input_P4, color_input_P4, iSD_P4, iSE_P4,
			x_input_P5, y_input_P5, color_input_P5, iSD_P5, iSE_P5,
			x_input_P6, y_input_P6, color_input_P6, iSD_P6, iSE_P6,

			x_input_E, y_input_E, color_input_E, iSD_E, iSE_E,
			

			oDD, oDE, 

			oDD_M, oDE_M,
			oDD_M1, oDE_M1,
			oDD_M2, oDE_M2,
			oDD_M3, oDE_M3,
			oDD_M4, oDE_M4,

			oDD_P1, oDE_P1,
			oDD_P2, oDE_P2,
			oDD_P3, oDE_P3,
			oDD_P4, oDE_P4,
			oDD_P5, oDE_P5,
			oDD_P6, oDE_P6,

			oDD_E, oDE_E,
			

			VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B);

	input CLOCK_50;				//	50 MHz
	input resetn;
	
	
	input [8:0] x_input;
	input [7:0] y_input;
	input [2:0] color_input;
	input iSD;
	input iSE;

	input [8:0] x_input_M;
	input [7:0] y_input_M;
	input [2:0] color_input_M;
	input iSD_M;
	input iSE_M;

	input [8:0] x_input_M1;
	input [7:0] y_input_M1;
	input [2:0] color_input_M1;
	input iSD_M1;
	input iSE_M1;

	input [8:0] x_input_M2;
	input [7:0] y_input_M2;
	input [2:0] color_input_M2;
	input iSD_M2;
	input iSE_M2;

	input [8:0] x_input_M3;
	input [7:0] y_input_M3;
	input [2:0] color_input_M3;
	input iSD_M3;
	input iSE_M3;

	input [8:0] x_input_M4;
	input [7:0] y_input_M4;
	input [2:0] color_input_M4;
	input iSD_M4;
	input iSE_M4;


	input [8:0] x_input_P1;
	input [7:0] y_input_P1;
	input [2:0] color_input_P1;
	input iSD_P1;
	input iSE_P1;

	input [8:0] x_input_P2;
	input [7:0] y_input_P2;
	input [2:0] color_input_P2;
	input iSD_P2;
	input iSE_P2;

	input [8:0] x_input_P3;
	input [7:0] y_input_P3;
	input [2:0] color_input_P3;
	input iSD_P3;
	input iSE_P3;

	input [8:0] x_input_P4;
	input [7:0] y_input_P4;
	input [2:0] color_input_P4;
	input iSD_P4;
	input iSE_P4;

	input [8:0] x_input_P5;
	input [7:0] y_input_P5;
	input [2:0] color_input_P5;
	input iSD_P5;
	input iSE_P5;

	input [8:0] x_input_P6;
	input [7:0] y_input_P6;
	input [2:0] color_input_P6;
	input iSD_P6;
	input iSE_P6;

	input [8:0] x_input_E;
	input [7:0] y_input_E;
	input [2:0] color_input_E;
	input iSD_E;
	input iSE_E;



	output reg oDD;
	output reg oDE;

	output reg oDD_M;
	output reg oDE_M;

	output reg oDD_M1;
	output reg oDE_M1;

	output reg oDD_M2;
	output reg oDE_M2;
	
	output reg oDD_M3;
	output reg oDE_M3;

	output reg oDD_M4;
	output reg oDE_M4;
	

	output reg oDD_P1;
	output reg oDE_P1;

	output reg oDD_P2;
	output reg oDE_P2;

	output reg oDD_P3;
	output reg oDE_P3;

	output reg oDD_P4;
	output reg oDE_P4;

	output reg oDD_P5;
	output reg oDE_P5;

	output reg oDD_P6;
	output reg oDE_P6;

	output reg oDD_E;
	output reg oDE_E;


	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [8:0] x;
	wire [7:0] y;
	wire writeEn;
	wire [5:0] color;
	


	wire ld_x, ld_y, count_enable, black_enable;
	wire DD, DE;
	always @(*)begin
		oDD = DD;
	    oDE = DE;
	end
	

	wire ld_x_M, ld_y_M, count_enable_M, black_enable_M;
	wire DD_M, DE_M;
	always @(*)begin
		oDD_M = DD_M;
	    oDE_M = DE_M;
	end

	wire ld_x_M1, ld_y_M1, count_enable_M1, black_enable_M1;
	wire DD_M1, DE_M1;
	always @(*)begin
		oDD_M1 = DD_M1;
	    oDE_M1 = DE_M1;
	end


	wire ld_x_M2, ld_y_M2, count_enable_M2, black_enable_M2;
	wire DD_M2, DE_M2;
	always @(*)begin
		oDD_M2 = DD_M2;
	    oDE_M2 = DE_M2;
	end
	
	
	wire ld_x_M3, ld_y_M3, count_enable_M3, black_enable_M3;
	wire DD_M3, DE_M3;
	always @(*)begin
		oDD_M3 = DD_M3;
	    oDE_M3 = DE_M3;
	end

	wire ld_x_M4, ld_y_M4, count_enable_M4, black_enable_M4;
	wire DD_M4, DE_M4;
	always @(*)begin
		oDD_M4 = DD_M4;
	   oDE_M4 = DE_M4;
	end
	

	wire ld_x_P1, ld_y_P1, count_enable_P1, black_enable_P1;
	wire DD_P1, DE_P1;
	always @(*)begin
		oDD_P1 = DD_P1;
	   oDE_P1 = DE_P1;
	end
	

	wire ld_x_P2, ld_y_P2, count_enable_P2, black_enable_P2;
	wire DD_P2, DE_P2;
	always @(*)begin
		oDD_P2 = DD_P2;
	   oDE_P2 = DE_P2;
	end

	wire ld_x_P3, ld_y_P3, count_enable_P3, black_enable_P3;
	wire DD_P3, DE_P3;
	always @(*)begin
		oDD_P3 = DD_P3;
	   oDE_P3 = DE_P3;
	end
	

	wire ld_x_P4, ld_y_P4, count_enable_P4, black_enable_P4;
	wire DD_P4, DE_P4;
	always @(*)begin
		oDD_P4 = DD_P4;
	   oDE_P4 = DE_P4;
	end
	
	
	wire ld_x_P5, ld_y_P5, count_enable_P5, black_enable_P5;
	wire DD_P5, DE_P5;
	always @(*)begin
		oDD_P5 = DD_P5;
	   oDE_P5 = DE_P5;
	end


	wire ld_x_P6, ld_y_P6, count_enable_P6, black_enable_P6;
	wire DD_P6, DE_P6;
	always @(*)begin
		oDD_P6 = DD_P6;
	   oDE_P6 = DE_P6;
	end
	
	wire ld_x_E, ld_y_E, count_enable_E, black_enable_E;
	wire DD_E, DE_E;
	always @(*)begin
		oDD_E = DD_E;
	   oDE_E = DE_E;
	end
	
	
	





	control c1(CLOCK_50, resetn,

			   iSD, iSE, 

			   iSD_M, iSE_M,
			   iSD_M1, iSE_M1,
			   iSD_M2, iSE_M2,
				iSD_M3, iSE_M3,
			   iSD_M4, iSE_M4,
				
				iSD_P1, iSE_P1,
			   iSD_P2, iSE_P2,
				iSD_P3, iSE_P3,
			   iSD_P4, iSE_P4,
				iSD_P5, iSE_P5,
			   iSD_P6, iSE_P6,
				
				iSD_E, iSE_E,
			   

			   DD, DE, ld_x, ld_y, count_enable, black_enable,

			   DD_M, DE_M,ld_x_M, ld_y_M, count_enable_M, black_enable_M,
			   DD_M1, DE_M1,ld_x_M1, ld_y_M1, count_enable_M1, black_enable_M1,
			   DD_M2, DE_M2,ld_x_M2, ld_y_M2, count_enable_M2, black_enable_M2,
				DD_M3, DE_M3,ld_x_M3, ld_y_M3, count_enable_M3, black_enable_M3,
			   DD_M4, DE_M4,ld_x_M4, ld_y_M4, count_enable_M4, black_enable_M4,
				
				DD_P1, DE_P1,ld_x_P1, ld_y_P1, count_enable_P1, black_enable_P1,
			   DD_P2, DE_P2,ld_x_P2, ld_y_P2, count_enable_P2, black_enable_P2,
				DD_P3, DE_P3,ld_x_P3, ld_y_P3, count_enable_P3, black_enable_P3,
				DD_P4, DE_P4,ld_x_P4, ld_y_P4, count_enable_P4, black_enable_P4,
				DD_P5, DE_P5,ld_x_P5, ld_y_P5, count_enable_P5, black_enable_P5,
				DD_P6, DE_P6,ld_x_P6, ld_y_P6, count_enable_P6, black_enable_P6,
				
				DD_E, DE_E,ld_x_E, ld_y_E, count_enable_E, black_enable_E,
			   

			   writeEn);
	
	
	datapath d1(CLOCK_50, resetn, 

				x_input, y_input, color_input, ld_x, ld_y, count_enable, black_enable, 

				x_input_M, y_input_M, color_input_M, ld_x_M, ld_y_M, count_enable_M, black_enable_M, 
				x_input_M1, y_input_M1, color_input_M1, ld_x_M1, ld_y_M1, count_enable_M1, black_enable_M1, 
				x_input_M2, y_input_M2, color_input_M2, ld_x_M2, ld_y_M2, count_enable_M2, black_enable_M2, 
				x_input_M3, y_input_M3, color_input_M3, ld_x_M3, ld_y_M3, count_enable_M3, black_enable_M3, 
				x_input_M4, y_input_M4, color_input_M4, ld_x_M4, ld_y_M4, count_enable_M4, black_enable_M4,
				
				x_input_P1, y_input_P1, color_input_P1, ld_x_P1, ld_y_P1, count_enable_P1, black_enable_P1,
				x_input_P2, y_input_P2, color_input_P2, ld_x_P2, ld_y_P2, count_enable_P2, black_enable_P2,
				x_input_P3, y_input_P3, color_input_P3, ld_x_P3, ld_y_P3, count_enable_P3, black_enable_P3,
				x_input_P4, y_input_P4, color_input_P4, ld_x_P4, ld_y_P4, count_enable_P4, black_enable_P4,
				x_input_P5, y_input_P5, color_input_P5, ld_x_P5, ld_y_P5, count_enable_P5, black_enable_P5,
				x_input_P6, y_input_P6, color_input_P6, ld_x_P6, ld_y_P6, count_enable_P6, black_enable_P6,
				
				x_input_E, y_input_E, color_input_E, ld_x_E, ld_y_E, count_enable_E, black_enable_E,

				
				color, x, y);
				
	
//	ram_spaceship10x16 R1([7:0]address, clk, 6'b111_111, 0, [5:0]q);
	
	
			
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(color),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "320x240";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 2;
		defparam VGA.BACKGROUND_IMAGE = "black320x240.mif";		
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.	
endmodule

module control(input clk, resetn, 
			   
			   input iSD, iSE,
				
			   input iSD_M, iSE_M,
			   input iSD_M1, iSE_M1,
			   input iSD_M2, iSE_M2,
				input iSD_M3, iSE_M3,
			   input iSD_M4, iSE_M4,
				
				input iSD_P1, iSE_P1,
			   input iSD_P2, iSE_P2,
				input iSD_P3, iSE_P3,
			   input iSD_P4, iSE_P4,
				input iSD_P5, iSE_P5,
			   input iSD_P6, iSE_P6,
				
				input iSD_E, iSE_E,


			   output reg oDD,    oDE,   ld_x,    ld_y,    count_enable,    black_enable, 
			   output reg oDD_M,  oDE_M, ld_x_M,  ld_y_M,  count_enable_M,  black_enable_M,
			   output reg oDD_M1, oDE_M1,ld_x_M1, ld_y_M1, count_enable_M1, black_enable_M1,
			   output reg oDD_M2, oDE_M2,ld_x_M2, ld_y_M2, count_enable_M2, black_enable_M2,
				output reg oDD_M3, oDE_M3,ld_x_M3, ld_y_M3, count_enable_M3, black_enable_M3,
			   output reg oDD_M4, oDE_M4,ld_x_M4, ld_y_M4, count_enable_M4, black_enable_M4,
				
				output reg oDD_P1, oDE_P1,ld_x_P1, ld_y_P1, count_enable_P1, black_enable_P1,
			   output reg oDD_P2, oDE_P2,ld_x_P2, ld_y_P2, count_enable_P2, black_enable_P2,
				output reg oDD_P3, oDE_P3,ld_x_P3, ld_y_P3, count_enable_P3, black_enable_P3,
				output reg oDD_P4, oDE_P4,ld_x_P4, ld_y_P4, count_enable_P4, black_enable_P4,
				output reg oDD_P5, oDE_P5,ld_x_P5, ld_y_P5, count_enable_P5, black_enable_P5,
				output reg oDD_P6, oDE_P6,ld_x_P6, ld_y_P6, count_enable_P6, black_enable_P6,
				
				output reg oDD_E,  oDE_E, ld_x_E,  ld_y_E,  count_enable_E,  black_enable_E,		
		

			   output reg plot);
	
	 reg [7:0] current_state, next_state; 

	 reg [7:0] count;
	 reg [7:0] black_count;

	 reg [7:0] count_M;
	 reg [7:0] black_count_M;

	 reg [7:0] count_M1;
	 reg [7:0] black_count_M1;

	 reg [7:0] count_M2;
	 reg [7:0] black_count_M2;
	 
	 reg [7:0] count_M3;
	 reg [7:0] black_count_M3;
	 
	 reg [7:0] count_M4;
	 reg [7:0] black_count_M4;
	 
	 
	 reg [7:0] count_P1;
	 reg [7:0] black_count_P1;
	 
	 reg [7:0] count_P2;
	 reg [7:0] black_count_P2;
	 
	 reg [7:0] count_P3;
	 reg [7:0] black_count_P3;
	 
	 reg [7:0] count_P4;
	 reg [7:0] black_count_P4;
	 
	 reg [7:0] count_P5;
	 reg [7:0] black_count_P5;
	 
	 reg [7:0] count_P6;
	 reg [7:0] black_count_P6;
	 
	 
	 reg [7:0] count_E;
	 reg [7:0] black_count_E;
	    
    localparam  S_IDLE            		= 8'd0,

                S_PLOT        			= 8'd1,
				S_ERASE					= 8'd2,
				S_FinishDraw			= 8'd3,
				S_FinishErase			= 8'd4, 

				S_PLOT_M        		= 8'd5,
				S_ERASE_M				= 8'd6,
				S_FinishDraw_M			= 8'd7,
				S_FinishErase_M		= 8'd8,

				S_PLOT_M1        		= 8'd9,
				S_ERASE_M1				= 8'd10,
				S_FinishDraw_M1		= 8'd11,
				S_FinishErase_M1		= 8'd12,

				S_PLOT_M2        		= 8'd13,
				S_ERASE_M2				= 8'd14,
				S_FinishDraw_M2		= 8'd15,
				S_FinishErase_M2		= 8'd16,
				
				S_PLOT_M3        		= 8'd17,
				S_ERASE_M3				= 8'd18,
				S_FinishDraw_M3		= 8'd19,
				S_FinishErase_M3		= 8'd20,
				
				S_PLOT_M4        		= 8'd21,
				S_ERASE_M4				= 8'd22,
				S_FinishDraw_M4		= 8'd23,
				S_FinishErase_M4		= 8'd24,
				
				S_PLOT_P1        		= 8'd25,
				S_ERASE_P1				= 8'd26,
				S_FinishDraw_P1		= 8'd27,
				S_FinishErase_P1		= 8'd28,
				
				S_PLOT_P2        		= 8'd29,
				S_ERASE_P2				= 8'd30,
				S_FinishDraw_P2		= 8'd31,
				S_FinishErase_P2		= 8'd32,
				
				S_PLOT_P3        		= 8'd33,
				S_ERASE_P3				= 8'd34,
				S_FinishDraw_P3		= 8'd35,
				S_FinishErase_P3		= 8'd36,
				
				S_PLOT_P4        		= 8'd37,
				S_ERASE_P4				= 8'd38,
				S_FinishDraw_P4		= 8'd39,
				S_FinishErase_P4		= 8'd40,
				
				S_PLOT_P5        		= 8'd41,
				S_ERASE_P5				= 8'd42,
				S_FinishDraw_P5		= 8'd43,
				S_FinishErase_P5		= 8'd44,
			
				S_PLOT_P6        		= 8'd45,
				S_ERASE_P6				= 8'd46,
				S_FinishDraw_P6		= 8'd47,
				S_FinishErase_P6		= 8'd48,
				
				S_PLOT_E        		= 8'd49,
				S_ERASE_E				= 8'd50,
				S_FinishDraw_E			= 8'd51,
				S_FinishErase_E		= 8'd52;
				


					 
					 
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
        case (current_state)
				
        S_IDLE:begin
					if((iSD == 0)    && (iSE == 0)   && 
					   (iSD_M == 0)  && (iSE_M == 0) && 
						(iSD_M1 == 0) && (iSE_M1 == 0)&& 
						(iSD_M2 == 0) && (iSE_M2 == 0)&& 
						(iSD_M3 == 0) && (iSE_M3 == 0)&& 
						(iSD_M4 == 0) && (iSE_M4 == 0)&& 
						
						(iSD_P1 == 0) && (iSE_P1 == 0)&& 
						(iSD_P2 == 0) && (iSE_P2 == 0)&& 
						(iSD_P3 == 0) && (iSE_P3 == 0)&& 
						(iSD_P4 == 0) && (iSE_P4 == 0)&& 
						(iSD_P5 == 0) && (iSE_P5 == 0)&& 
						(iSD_P6 == 0) && (iSE_P6 == 0)&& 
						
						(iSD_E == 0)  && (iSE_E == 0)
						)
						 next_state = S_IDLE;						
					else begin
						if(iSE == 1) next_state = S_ERASE;
						if(iSD == 1) next_state = S_PLOT;

						if(iSE_M == 1) next_state = S_ERASE_M;
						if(iSD_M == 1) next_state = S_PLOT_M;

						if(iSE_M1 == 1) next_state = S_ERASE_M1;
						if(iSD_M1 == 1) next_state = S_PLOT_M1;

						if(iSE_M2 == 1) next_state = S_ERASE_M2;
						if(iSD_M2 == 1) next_state = S_PLOT_M2;
						
						if(iSE_M3 == 1) next_state = S_ERASE_M3;
						if(iSD_M3 == 1) next_state = S_PLOT_M3;
						
						if(iSE_M4 == 1) next_state = S_ERASE_M4;
						if(iSD_M4 == 1) next_state = S_PLOT_M4;
						
						
						if(iSE_P1 == 1) next_state = S_ERASE_P1;
						if(iSD_P1 == 1) next_state = S_PLOT_P1;
						
						if(iSE_P2 == 1) next_state = S_ERASE_P2;
						if(iSD_P2 == 1) next_state = S_PLOT_P2;
						
						if(iSE_P3 == 1) next_state = S_ERASE_P3;
						if(iSD_P3 == 1) next_state = S_PLOT_P3;
						
						if(iSE_P4 == 1) next_state = S_ERASE_P4;
						if(iSD_P4 == 1) next_state = S_PLOT_P4;
						
						if(iSE_P5 == 1) next_state = S_ERASE_P5;
						if(iSD_P5 == 1) next_state = S_PLOT_P5;
						
						if(iSE_P6 == 1) next_state = S_ERASE_P6;
						if(iSD_P6 == 1) next_state = S_PLOT_P6;

						
						if(iSE_E == 1) next_state = S_ERASE_E;
						if(iSD_E == 1) next_state = S_PLOT_E;
			
						
					end
			end
					 
        	S_PLOT:        next_state = (count == 8'd255)? S_FinishDraw : S_PLOT; // Loop in current state until value is input									 
					 
			S_FinishDraw:  next_state =  iSD ? S_FinishDraw : S_IDLE;
					 
			S_ERASE:       next_state = (black_count == 8'd255)? S_FinishErase : S_ERASE;
					 
			S_FinishErase: next_state = iSE ? S_FinishErase : S_IDLE;



			S_PLOT_M:        next_state = (count_M == 8'd255)? S_FinishDraw_M : S_PLOT_M; // Loop in current state until value is input									 
					 
			S_FinishDraw_M:  next_state =  iSD_M ? S_FinishDraw_M : S_IDLE;
					 
			S_ERASE_M:       next_state = (black_count_M == 8'd255)? S_FinishErase_M : S_ERASE_M;
					 
			S_FinishErase_M: next_state = iSE_M ? S_FinishErase_M : S_IDLE;



			S_PLOT_M1:        next_state = (count_M1 == 8'd255)? S_FinishDraw_M1 : S_PLOT_M1; // Loop in current state until value is input									 
					 
			S_FinishDraw_M1:  next_state =  iSD_M1 ? S_FinishDraw_M1 : S_IDLE;
					 
			S_ERASE_M1:       next_state = (black_count_M1 == 8'd255)? S_FinishErase_M1 : S_ERASE_M1;
					 
			S_FinishErase_M1: next_state = iSE_M1 ? S_FinishErase_M1 : S_IDLE;



			S_PLOT_M2:        next_state = (count_M2 == 8'd255)? S_FinishDraw_M2 : S_PLOT_M2; // Loop in current state until value is input									 
					 
			S_FinishDraw_M2:  next_state =  iSD_M2 ? S_FinishDraw_M2 : S_IDLE;
					 
			S_ERASE_M2:       next_state = (black_count_M2 == 8'd255)? S_FinishErase_M2 : S_ERASE_M2;
					 
			S_FinishErase_M2: next_state = iSE_M2 ? S_FinishErase_M2 : S_IDLE;
			
			
			S_PLOT_M3:        next_state = (count_M3 == 8'd255)? S_FinishDraw_M3 : S_PLOT_M3; // Loop in current state until value is input									 
					 
			S_FinishDraw_M3:  next_state =  iSD_M3 ? S_FinishDraw_M3 : S_IDLE;
					 
			S_ERASE_M3:       next_state = (black_count_M3 == 8'd255)? S_FinishErase_M3 : S_ERASE_M3;
					 
			S_FinishErase_M3: next_state = iSE_M3 ? S_FinishErase_M3 : S_IDLE;
			
			

			S_PLOT_M4:        next_state = (count_M4 == 8'd255)? S_FinishDraw_M4 : S_PLOT_M4; // Loop in current state until value is input									 
					 
			S_FinishDraw_M4:  next_state =  iSD_M4 ? S_FinishDraw_M4 : S_IDLE;
					 
			S_ERASE_M4:       next_state = (black_count_M4 == 8'd255)? S_FinishErase_M4 : S_ERASE_M4;
					 
			S_FinishErase_M4: next_state = iSE_M4 ? S_FinishErase_M4 : S_IDLE;
			

			S_PLOT_P1:        next_state = (count_P1 == 8'd255)? S_FinishDraw_P1 : S_PLOT_P1; // Loop in current state until value is input									 
					 
			S_FinishDraw_P1:  next_state =  iSD_P1 ? S_FinishDraw_P1 : S_IDLE;
					 
			S_ERASE_P1:       next_state = (black_count_P1 == 8'd255)? S_FinishErase_P1 : S_ERASE_P1;
					 
			S_FinishErase_P1: next_state = iSE_P1 ? S_FinishErase_P1 : S_IDLE;



			S_PLOT_P2:        next_state = (count_P2 == 8'd255)? S_FinishDraw_P2 : S_PLOT_P2; // Loop in current state until value is input									 
					 
			S_FinishDraw_P2:  next_state =  iSD_P2 ? S_FinishDraw_P2 : S_IDLE;
					 
			S_ERASE_P2:       next_state = (black_count_P2 == 8'd255)? S_FinishErase_P2 : S_ERASE_P2;
					 
			S_FinishErase_P2: next_state = iSE_P2 ? S_FinishErase_P2 : S_IDLE;
	

			S_PLOT_P3:        next_state = (count_P3 == 8'd255)? S_FinishDraw_P3 : S_PLOT_P3; // Loop in current state until value is input									 
					 
			S_FinishDraw_P3:  next_state =  iSD_P3 ? S_FinishDraw_P3 : S_IDLE;
					 
			S_ERASE_P3:       next_state = (black_count_P3 == 8'd255)? S_FinishErase_P3 : S_ERASE_P3;
					 
			S_FinishErase_P3: next_state = iSE_P3 ? S_FinishErase_P3 : S_IDLE;
			
			
			
			S_PLOT_P4:        next_state = (count_P4 == 8'd255)? S_FinishDraw_P4 : S_PLOT_P4; // Loop in current state until value is input									 
					 
			S_FinishDraw_P4:  next_state =  iSD_P4 ? S_FinishDraw_P4 : S_IDLE;
					 
			S_ERASE_P4:       next_state = (black_count_P4 == 8'd255)? S_FinishErase_P4 : S_ERASE_P4;
					 
			S_FinishErase_P4: next_state = iSE_P4 ? S_FinishErase_P4 : S_IDLE;
			
			

			S_PLOT_P5:        next_state = (count_P5 == 8'd255)? S_FinishDraw_P5 : S_PLOT_P5; // Loop in current state until value is input									 
					 
			S_FinishDraw_P5:  next_state =  iSD_P5 ? S_FinishDraw_P5 : S_IDLE;
					 
			S_ERASE_P5:       next_state = (black_count_P5 == 8'd255)? S_FinishErase_P5 : S_ERASE_P5;
					 
			S_FinishErase_P5: next_state = iSE_P5 ? S_FinishErase_P5 : S_IDLE;
		
	
			S_PLOT_P6:        next_state = (count_P6 == 8'd255)? S_FinishDraw_P6 : S_PLOT_P6; // Loop in current state until value is input									 
					 
			S_FinishDraw_P6:  next_state =  iSD_P6 ? S_FinishDraw_P6 : S_IDLE;
					 
			S_ERASE_P6:       next_state = (black_count_P6 == 8'd255)? S_FinishErase_P6 : S_ERASE_P6;
					 
			S_FinishErase_P6: next_state = iSE_P6 ? S_FinishErase_P6 : S_IDLE;
		
	
			S_PLOT_E:        next_state = (count_E == 8'd255)? S_FinishDraw_E : S_PLOT_E; // Loop in current state until value is input									 
					 
			S_FinishDraw_E:  next_state =  iSD_E ? S_FinishDraw_E : S_IDLE;
					 
			S_ERASE_E:       next_state = (black_count_E == 8'd255)? S_FinishErase_E : S_ERASE_E;
					 
			S_FinishErase_E: next_state = iSE_E ? S_FinishErase_E : S_IDLE;


					 
			default:       next_state = S_IDLE;
		endcase
    end // state_table

	     // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        ld_x = 1'b0;
        ld_y = 1'b0;
		 plot = 1'b0;
        count_enable = 1'b0;
		  black_enable = 1'b0;
		  oDD = 1'b0;
		  oDE = 1'b0;

		ld_x_M = 1'b0;
        ld_y_M = 1'b0;
        count_enable_M = 1'b0;
		black_enable_M = 1'b0;
		oDD_M = 1'b0;
		oDE_M = 1'b0;


		ld_x_M1 = 1'b0;
        ld_y_M1 = 1'b0;
        count_enable_M1 = 1'b0;
		black_enable_M1 = 1'b0;
		oDD_M1 = 1'b0;
		oDE_M1 = 1'b0;


		ld_x_M2 = 1'b0;
      ld_y_M2 = 1'b0;
      count_enable_M2 = 1'b0;
		black_enable_M2 = 1'b0;
		oDD_M2 = 1'b0;
		oDE_M2 = 1'b0;
		
		
		ld_x_M3 = 1'b0;
      ld_y_M3 = 1'b0;
      count_enable_M3 = 1'b0;
		black_enable_M3 = 1'b0;
		oDD_M3 = 1'b0;
		oDE_M3 = 1'b0;		
		  
		
		ld_x_M4 = 1'b0;
      ld_y_M4 = 1'b0;
      count_enable_M4 = 1'b0;
		black_enable_M4 = 1'b0;
		oDD_M4 = 1'b0;
		oDE_M4 = 1'b0;		
		
		
		
		ld_x_P1 = 1'b0;
      ld_y_P1 = 1'b0;
      count_enable_P1 = 1'b0;
		black_enable_P1 = 1'b0;
		oDD_P1 = 1'b0;
		oDE_P1 = 1'b0;
		
		
		ld_x_P2 = 1'b0;
      ld_y_P2 = 1'b0;
      count_enable_P2 = 1'b0;
		black_enable_P2 = 1'b0;
		oDD_P2 = 1'b0;
		oDE_P2 = 1'b0;
		
		ld_x_P3 = 1'b0;
      ld_y_P3 = 1'b0;
      count_enable_P3 = 1'b0;
		black_enable_P3 = 1'b0;
		oDD_P3 = 1'b0;
		oDE_P3 = 1'b0;
		
		ld_x_P4 = 1'b0;
      ld_y_P4 = 1'b0;
      count_enable_P4 = 1'b0;
		black_enable_P4 = 1'b0;
		oDD_P4 = 1'b0;
		oDE_P4 = 1'b0;
		
		ld_x_P5 = 1'b0;
      ld_y_P5 = 1'b0;
      count_enable_P5 = 1'b0;
		black_enable_P5 = 1'b0;
		oDD_P5 = 1'b0;
		oDE_P5 = 1'b0;
		
		ld_x_P6 = 1'b0;
      ld_y_P6 = 1'b0;
      count_enable_P6 = 1'b0;
		black_enable_P6 = 1'b0;
		oDD_P6 = 1'b0;
		oDE_P6 = 1'b0;
		
		
		ld_x_E = 1'b0;
      ld_y_E = 1'b0;
      count_enable_E = 1'b0;
		black_enable_E = 1'b0;
		oDD_E = 1'b0;
		oDE_E = 1'b0;
		
		  
		  
        case (current_state)
            S_IDLE: begin
            ld_x = 1'b1;
				ld_y = 1'b1;
				oDD = 1'b0;
				oDE = 1'b0;


				ld_x_M = 1'b1;
				ld_y_M = 1'b1;
				oDD_M = 1'b0;
				oDE_M = 1'b0;

				ld_x_M1 = 1'b1;
				ld_y_M1 = 1'b1;
				oDD_M1 = 1'b0;
				oDE_M1 = 1'b0;

				ld_x_M2 = 1'b1;
				ld_y_M2 = 1'b1;
				oDD_M2 = 1'b0;
				oDE_M2 = 1'b0;
				
				ld_x_M3 = 1'b1;
				ld_y_M3 = 1'b1;
				oDD_M3 = 1'b0;
				oDE_M3 = 1'b0;

				ld_x_M4 = 1'b1;
				ld_y_M4 = 1'b1;
				oDD_M4 = 1'b0;
				oDE_M4 = 1'b0;
				
				
				
				
				ld_x_P1 = 1'b1;
				ld_y_P1 = 1'b1;
				oDD_P1 = 1'b0;
				oDE_P1 = 1'b0;
				
				ld_x_P2 = 1'b1;
				ld_y_P2 = 1'b1;
				oDD_P2 = 1'b0;
				oDE_P2 = 1'b0;
				
				ld_x_P3 = 1'b1;
				ld_y_P3 = 1'b1;
				oDD_P3 = 1'b0;
				oDE_P3 = 1'b0;
				
				ld_x_P4 = 1'b1;
				ld_y_P4 = 1'b1;
				oDD_P4 = 1'b0;
				oDE_P4 = 1'b0;
				
				ld_x_P5 = 1'b1;
				ld_y_P5 = 1'b1;
				oDD_P5 = 1'b0;
				oDE_P5 = 1'b0;
				
				ld_x_P6 = 1'b1;
				ld_y_P6 = 1'b1;
				oDD_P6 = 1'b0;
				oDE_P6 = 1'b0;
				
				
				
				
				ld_x_E = 1'b1;
				ld_y_E = 1'b1;
				oDD_E = 1'b0;
				oDE_E = 1'b0;

				

            end

            S_PLOT: begin
               count_enable = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw: oDD = 1'b1;
				S_ERASE: begin
               black_enable = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase: oDE = 1'b1;




            S_PLOT_M: begin
               count_enable_M = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_M: oDD_M = 1'b1;
				S_ERASE_M: begin
               black_enable_M = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_M: oDE_M = 1'b1;



            S_PLOT_M1: begin
               count_enable_M1 = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_M1: oDD_M1 = 1'b1;
				S_ERASE_M1: begin
               black_enable_M1 = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_M1: oDE_M1 = 1'b1;



            S_PLOT_M2: begin
               count_enable_M2 = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_M2: oDD_M2 = 1'b1;
				S_ERASE_M2: begin
               black_enable_M2 = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_M2: oDE_M2 = 1'b1;
				
				
            S_PLOT_M3: begin
               count_enable_M3 = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_M3: oDD_M3 = 1'b1;
				S_ERASE_M3: begin
               black_enable_M3 = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_M3: oDE_M3 = 1'b1;
				


            S_PLOT_M4: begin
               count_enable_M4 = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_M4: oDD_M4 = 1'b1;
				S_ERASE_M4: begin
               black_enable_M4 = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_M4: oDE_M4 = 1'b1;


            S_PLOT_P1: begin
               count_enable_P1 = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_P1: oDD_P1 = 1'b1;
				S_ERASE_P1: begin
               black_enable_P1 = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_P1: oDE_P1 = 1'b1;
	
	
            S_PLOT_P2: begin
               count_enable_P2 = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_P2: oDD_P2 = 1'b1;
				S_ERASE_P2: begin
               black_enable_P2 = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_P2: oDE_P2 = 1'b1;
				
				
				
            S_PLOT_P3: begin
               count_enable_P3 = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_P3: oDD_P3 = 1'b1;
				S_ERASE_P3: begin
               black_enable_P3 = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_P3: oDE_P3 = 1'b1;
		
		
		
            S_PLOT_P4: begin
               count_enable_P4 = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_P4: oDD_P4 = 1'b1;
				S_ERASE_P4: begin
               black_enable_P4 = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_P4: oDE_P4 = 1'b1;
				
				
				
			S_PLOT_P5: begin
               count_enable_P5 = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_P5: oDD_P5 = 1'b1;
				S_ERASE_P5: begin
               black_enable_P5 = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_P5: oDE_P5 = 1'b1;
				
            S_PLOT_P6: begin
               count_enable_P6 = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_P6: oDD_P6 = 1'b1;
				S_ERASE_P6: begin
               black_enable_P6 = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_P6: oDE_P6 = 1'b1;
				
				
            S_PLOT_E: begin
               count_enable_E = 1'b1;
					plot = 1'b1;
            end
            S_FinishDraw_E: oDD_E = 1'b1;
				S_ERASE_E: begin
               black_enable_E = 1'b1;
					plot = 1'b1;
            end	 
            S_FinishErase_E: oDE_E = 1'b1;
						 
        endcase
    end // enable_signals

    always@(posedge clk)
    begin: state_FFs
	 
        if(!resetn)
				begin
					current_state <= S_IDLE;
					
					count <= 8'b0;
					black_count <= 8'b0;

   

					count_M <= 8'b0;
					black_count_M <= 8'b0;

					count_M1 <= 8'b0;
					black_count_M1 <= 8'b0;

					count_M2 <= 8'b0;
					black_count_M2 <= 8'b0;
					
					count_M3 <= 8'b0;
					black_count_M4 <= 8'b0;
					
					count_M4 <= 8'b0;
					black_count_M4 <= 8'b0;
					
					
					count_P1 <= 8'b0;
					black_count_P1 <= 8'b0;
					
					count_P2 <= 8'b0;
					black_count_P2 <= 8'b0;
					
					count_P3 <= 8'b0;
					black_count_P3 <= 8'b0;
					
					count_P4 <= 8'b0;
					black_count_P4 <= 8'b0;
					
					count_P5 <= 8'b0;
					black_count_P5 <= 8'b0;
					
					count_P6 <= 8'b0;
					black_count_P6 <= 8'b0;
					
					
					
					count_E <= 8'b0;
					black_count_E <= 8'b0;
					

				end
				


        else if((current_state == S_PLOT) && (count != 8'd255))
				begin
				current_state <= next_state;
				count <= count + 1'b1;
				end
				
	    else if((current_state == S_ERASE) && (black_count != 8'd255))
				begin
				current_state <= next_state;
				black_count <= black_count + 1'b1;
				end





		else if((current_state == S_PLOT_M) && (count_M != 8'd255))
				begin
				current_state <= next_state;
				count_M <= count_M + 1'b1;
				end
				
	   else if((current_state == S_ERASE_M) && (black_count_M != 8'd255))
				begin
				current_state <= next_state;
				black_count_M <= black_count_M + 1'b1;
				end
	
	
	
		else if((current_state == S_PLOT_M1) && (count_M1 != 8'd255))
				begin
				current_state <= next_state;
				count_M1 <= count_M1 + 1'b1;
				end
				
	   else if((current_state == S_ERASE_M1) && (black_count_M1 != 8'd255))
				begin
				current_state <= next_state;
				black_count_M1 <= black_count_M1 + 1'b1;
				end

				
				
				

		else if((current_state == S_PLOT_M2) && (count_M2 != 8'd255))
				begin
				current_state <= next_state;
				count_M2 <= count_M2 + 1'b1;
				end
			
	   else if((current_state == S_ERASE_M2) && (black_count_M2 != 8'd255))
				begin
				current_state <= next_state;
				black_count_M2 <= black_count_M2 + 1'b1;
				end

		else if((current_state == S_PLOT_M3) && (count_M3 != 8'd255))
				begin
				current_state <= next_state;
				count_M3 <= count_M3 + 1'b1;
				end
			
	   else if((current_state == S_ERASE_M3) && (black_count_M3 != 8'd255))
				begin
				current_state <= next_state;
				black_count_M3 <= black_count_M3 + 1'b1;
				end
				
	
	
		else if((current_state == S_PLOT_M4) && (count_M4 != 8'd255))
				begin
				current_state <= next_state;
				count_M4 <= count_M4 + 1'b1;
				end
			
	   else if((current_state == S_ERASE_M4) && (black_count_M4 != 8'd255))
				begin
				current_state <= next_state;
				black_count_M4 <= black_count_M4 + 1'b1;
				end
				
				
				
		else if((current_state == S_PLOT_P1) && (count_P1 != 8'd255))
				begin
				current_state <= next_state;
				count_P1 <= count_P1 + 1'b1;
				end
			
	   else if((current_state == S_ERASE_P1) && (black_count_P1 != 8'd255))
				begin
				current_state <= next_state;
				black_count_P1 <= black_count_P1 + 1'b1;
				end
				

		else if((current_state == S_PLOT_P2) && (count_P2 != 8'd255))
				begin
				current_state <= next_state;
				count_P2 <= count_P2 + 1'b1;
				end
			
	   else if((current_state == S_ERASE_P2) && (black_count_P2 != 8'd255))
				begin
				current_state <= next_state;
				black_count_P2 <= black_count_P2 + 1'b1;
				end
				
				
				
		
		else if((current_state == S_PLOT_P3) && (count_P3 != 8'd255))
				begin
				current_state <= next_state;
				count_P3 <= count_P3 + 1'b1;
				end
			
	   else if((current_state == S_ERASE_P3) && (black_count_P3 != 8'd255))
				begin
				current_state <= next_state;
				black_count_P3 <= black_count_P3 + 1'b1;
				end
				
				
				
	
		else if((current_state == S_PLOT_P4) && (count_P4 != 8'd255))
				begin
				current_state <= next_state;
				count_P4 <= count_P4 + 1'b1;
				end
			
	   else if((current_state == S_ERASE_P4) && (black_count_P4 != 8'd255))
				begin
				current_state <= next_state;
				black_count_P4 <= black_count_P4 + 1'b1;
				end
				
				
		else if((current_state == S_PLOT_P5) && (count_P5 != 8'd255))
				begin
				current_state <= next_state;
				count_P5 <= count_P5 + 1'b1;
				end
			
	   else if((current_state == S_ERASE_P5) && (black_count_P5 != 8'd255))
				begin
				current_state <= next_state;
				black_count_P5 <= black_count_P5 + 1'b1;
				end
				
				
		else if((current_state == S_PLOT_P6) && (count_P6 != 8'd255))
				begin
				current_state <= next_state;
				count_P6 <= count_P6 + 1'b1;
				end
			
	   else if((current_state == S_ERASE_P6) && (black_count_P6 != 8'd255))
				begin
				current_state <= next_state;
				black_count_P6 <= black_count_P6 + 1'b1;
				end
				
				
		
		else if((current_state == S_PLOT_E) && (count_E != 8'd255))
				begin
				current_state <= next_state;
				count_E <= count_E + 1'b1;
				end
			
	   else if((current_state == S_ERASE_E) && (black_count_E != 8'd255))
				begin
				current_state <= next_state;
				black_count_E <= black_count_E + 1'b1;
				end
	
	




		  else if(current_state == S_IDLE)
				begin
					current_state <= next_state;
					count <= 8'b0;
					black_count <= 8'b0;



					count_M <= 8'b0;
					black_count_M <= 8'b0;	

					count_M1 <= 8'b0;
					black_count_M1 <= 8'b0;	

					count_M2 <= 8'b0;
					black_count_M2 <= 8'b0;
					
					count_M3 <= 8'b0;
					black_count_M3 <= 8'b0;
					
					count_M4 <= 8'b0;
					black_count_M4 <= 8'b0;
					
					
					count_P1 <= 8'b0;
					black_count_P1 <= 8'b0;
					
					count_P2 <= 8'b0;
					black_count_P2 <= 8'b0;
					
					count_P3 <= 8'b0;
					black_count_P3 <= 8'b0;
					
					count_P4 <= 8'b0;
					black_count_P4 <= 8'b0;
					
					count_P5 <= 8'b0;
					black_count_P5 <= 8'b0;
					
					count_P6 <= 8'b0;
					black_count_P6 <= 8'b0;
					
					count_E <= 8'b0;
					black_count_E <= 8'b0;

					
				end
		  else
			
			  current_state <= next_state;
			
    end // state_FFS

endmodule




module datapath(input clk, resetn,

	 input [8:0] X,
    input [7:0] Y,
	 input [2:0] color_input,
    input ld_x, ld_y, count_enable, black_enable,

    input [8:0] X_M,
    input [7:0] Y_M,
	 input [2:0] color_input_M,
    input ld_x_M, ld_y_M, count_enable_M, black_enable_M,

    input [8:0] X_M1,
    input [7:0] Y_M1,
	 input [2:0] color_input_M1,
    input ld_x_M1, ld_y_M1, count_enable_M1, black_enable_M1,

    input [8:0] X_M2,
    input [7:0] Y_M2,
	 input [2:0] color_input_M2,
    input ld_x_M2, ld_y_M2, count_enable_M2, black_enable_M2,
	 
	 
	 input [8:0] X_M3,
    input [7:0] Y_M3,
	 input [2:0] color_input_M3,
    input ld_x_M3, ld_y_M3, count_enable_M3, black_enable_M3,
	 
	 input [8:0] X_M4,
    input [7:0] Y_M4,
	 input [2:0] color_input_M4,
    input ld_x_M4, ld_y_M4, count_enable_M4, black_enable_M4,
	 
	 
	 input [8:0] X_P1,
    input [7:0] Y_P1,
	 input [2:0] color_input_P1,
    input ld_x_P1, ld_y_P1, count_enable_P1, black_enable_P1,
	 
	 input [8:0] X_P2,
    input [7:0] Y_P2,
	 input [2:0] color_input_P2,
    input ld_x_P2, ld_y_P2, count_enable_P2, black_enable_P2,
	 
	 input [8:0] X_P3,
    input [7:0] Y_P3,
	 input [2:0] color_input_P3,
    input ld_x_P3, ld_y_P3, count_enable_P3, black_enable_P3,
	 
	 input [8:0] X_P4,
    input [7:0] Y_P4,
	 input [2:0] color_input_P4,
    input ld_x_P4, ld_y_P4, count_enable_P4, black_enable_P4,
	 
	 
	 input [8:0] X_P5,
    input [7:0] Y_P5,
	 input [2:0] color_input_P5,
    input ld_x_P5, ld_y_P5, count_enable_P5, black_enable_P5,
	 
	 input [8:0] X_P6,
    input [7:0] Y_P6,
	 input [2:0] color_input_P6,
    input ld_x_P6, ld_y_P6, count_enable_P6, black_enable_P6,
	 
	 
	 input [8:0] X_E,
    input [7:0] Y_E,
	 input [2:0] color_input_E,
    input ld_x_E, ld_y_E, count_enable_E, black_enable_E,
	 
	

	 output reg [5:0] color,
    output reg [8:0] x_final,
	 output reg [7:0] y_final
    );
    
    // input registers
    reg [8:0] x_start;
	reg [7:0] y_start;
	reg [7:0] count;
	reg [7:0] black_count;
	reg first, black_first;
	wire [5:0]ram_color;
	 
	ram_spaceship16x16 S1(count[7:0], clk, 6'b111_111, 0, ram_color);

	reg [8:0] x_start_M;
	reg [7:0] y_start_M;
	reg [7:0] count_M;
	reg [7:0] black_count_M;
	reg first_M, black_first_M;
	wire [5:0]ram_color_M;
	
	ram_meteor16x16 M(count_M[7:0], clk, 6'b111_111, 0, ram_color_M);
	

	reg [8:0] x_start_M1;
	reg [7:0] y_start_M1;
	reg [7:0] count_M1;
	reg [7:0] black_count_M1;
	reg first_M1, black_first_M1;
	wire [5:0]ram_color_M1;
	
	ram_meteor16x16 M1(count_M1[7:0], clk, 6'b111_111, 0, ram_color_M1);

	reg [8:0] x_start_M2;
	reg [7:0] y_start_M2;
	reg [7:0] count_M2;
	reg [7:0] black_count_M2;
	reg first_M2, black_first_M2;
	wire [5:0]ram_color_M2;
	
	ram_meteor16x16 M2(count_M2[7:0], clk, 6'b111_111, 0, ram_color_M2);
	
	reg [8:0] x_start_M3;
	reg [7:0] y_start_M3;
	reg [7:0] count_M3;
	reg [7:0] black_count_M3;
	reg first_M3, black_first_M3;
	wire [5:0]ram_color_M3;
	
	ram_meteor16x16 M3(count_M3[7:0], clk, 6'b111_111, 0, ram_color_M3);
	
	reg [8:0] x_start_M4;
	reg [7:0] y_start_M4;
	reg [7:0] count_M4;
	reg [7:0] black_count_M4;
	reg first_M4, black_first_M4;
	wire [5:0]ram_color_M4;
	
	ram_meteor16x16 M4(count_M4[7:0], clk, 6'b111_111, 0, ram_color_M4);
	
	
	reg [8:0] x_start_P1;
	reg [7:0] y_start_P1;
	reg [7:0] count_P1;
	reg [7:0] black_count_P1;
	reg first_P1, black_first_P1;
	wire [5:0]ram_color_P1;
	
	ram_pirateship16x16 P1(count_P1[7:0], clk, 6'b111_111, 0, ram_color_P1);
	
	reg [8:0] x_start_P2;
	reg [7:0] y_start_P2;
	reg [7:0] count_P2;
	reg [7:0] black_count_P2;
	reg first_P2, black_first_P2;
	wire [5:0]ram_color_P2;
	
	ram_pirateship16x16 P2(count_P2[7:0], clk, 6'b111_111, 0, ram_color_P2);
	
	

	reg [8:0] x_start_P3;
	reg [7:0] y_start_P3;
	reg [7:0] count_P3;
	reg [7:0] black_count_P3;
	reg first_P3, black_first_P3;
	wire [5:0]ram_color_P3;
	
	ram_pirateship16x16 P3(count_P3[7:0], clk, 6'b111_111, 0, ram_color_P3);
	
	
	reg [8:0] x_start_P4;
	reg [7:0] y_start_P4;
	reg [7:0] count_P4;
	reg [7:0] black_count_P4;
	reg first_P4, black_first_P4;
	wire [5:0]ram_color_P4;
	
	ram_pirateship16x16 P4(count_P4[7:0], clk, 6'b111_111, 0, ram_color_P4);
	
	
	reg [8:0] x_start_P5;
	reg [7:0] y_start_P5;
	reg [7:0] count_P5;
	reg [7:0] black_count_P5;
	reg first_P5, black_first_P5;
	wire [5:0]ram_color_P5;
	
	ram_pirateship16x16 P5(count_P5[7:0], clk, 6'b111_111, 0, ram_color_P5);
	
	reg [8:0] x_start_P6;
	reg [7:0] y_start_P6;
	reg [7:0] count_P6;
	reg [7:0] black_count_P6;
	reg first_P6, black_first_P6;
	wire [5:0]ram_color_P6;
	
	ram_pirateship16x16 P6(count_P6[7:0], clk, 6'b111_111, 0, ram_color_P6);
	
	
	
	reg [8:0] x_start_E;
	reg [7:0] y_start_E;
	reg [7:0] count_E;
	reg [7:0] black_count_E;
	reg first_E, black_first_E;
	wire [5:0]ram_color_E;
	
	ram_pirateship16x16 E123(count_E[7:0], clk, 6'b111_111, 0, ram_color_E);
	

	
	
	  
    // Registers a, b, c, x with respective input logic
    always@(posedge clk) 
	 begin
        if(!resetn) begin
            x_start <= 9'b0; 
            y_start <= 8'b0;
			   color   <= 6'b0;


			   x_start_M <= 9'd50; 
            y_start_M <= 8'd50;

            x_start_M1 <= 9'd50; 
            y_start_M1 <= 8'd50;

            x_start_M2 <= 9'd50; 
            y_start_M2 <= 8'd50;
				
				x_start_M3 <= 9'd50; 
            y_start_M3 <= 8'd50;
				
				x_start_M4 <= 9'd50; 
            y_start_M4 <= 8'd50;
				
				x_start_P1 <= 9'd50; 
            y_start_P1 <= 8'd50;
				
				x_start_P2 <= 9'd50; 
            y_start_P2 <= 8'd50;
				
				x_start_P3 <= 9'd50; 
            y_start_P3 <= 8'd50;
				
				x_start_P4 <= 9'd50; 
            y_start_P4 <= 8'd50;
				
				x_start_P5 <= 9'd50; 
            y_start_P5 <= 8'd50;
				
				x_start_P6 <= 9'd50; 
            y_start_P6 <= 8'd50;
				
				x_start_E <= 9'd50; 
            y_start_E <= 8'd50;
        end
		  
		  else if(black_enable)begin
			//when u want to be cool
			 color <= 6'b0;
		   //change the code above
		  end
		  
		  else if(count_enable) color[5:0] <= ram_color[5:0];


		   //meteor
		  else if(black_enable_M)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_M) color[5:0] <= ram_color_M[5:0];

		  
		  
		  //meteor1
		  else if(black_enable_M1)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_M1) color[5:0] <= ram_color_M1[5:0];

		  
		  
		  //meteor2
		  else if(black_enable_M2)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_M2) color[5:0] <= ram_color_M2[5:0];
		  
		  
		  //meteor3
		  else if(black_enable_M3)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_M3) color[5:0] <= ram_color_M3[5:0];
		  
		  
		  //meteor4
		  else if(black_enable_M4)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_M4) color[5:0] <= ram_color_M4[5:0];
		  
		  //PIRATE 1
		  else if(black_enable_P1)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_P1) color[5:0] <= ram_color_P1[5:0];
		  
		  
		  //PIRATE 2
		  else if(black_enable_P2)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_P2) color[5:0] <= ram_color_P2[5:0];
		  
		  
		  //PIRATE 3
		  else if(black_enable_P3)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_P3) color[5:0] <= ram_color_P3[5:0];
		  
		  
		  //PIRATE 4
		  else if(black_enable_P4)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_P4) color[5:0] <= ram_color_P4[5:0];
		  
		  
		  
		  //PIRATE 5
		  else if(black_enable_P5)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_P5) color[5:0] <= ram_color_P5[5:0];
		  
		  
		  //PIRATE 6
		  else if(black_enable_P6)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_P6) color[5:0] <= ram_color_P6[5:0];
		  
		  
		  //EARTH 
		  else if(black_enable_E)begin
			//when u want to be cool
			  color <= 6'b0;
		   //change the code above
		  end
		  else if(count_enable_E) color[5:0] <= ram_color_E[5:0];


		  
        else begin
            if(ld_x) x_start[8:0] <= X[8:0]; // IDLE x from data_in
            if(ld_y) y_start[7:0] <= Y[7:0]; // IDLE y from data_in

            if(ld_x_M)  x_start_M[8:0] <= X_M[8:0]; // IDLE x from data_in
            if(ld_y_M)  y_start_M[7:0] <= Y_M[7:0]; // IDLE y from data_in

            if(ld_x_M1)  x_start_M1[8:0] <= X_M1[8:0]; // IDLE x from data_in
            if(ld_y_M1)  y_start_M1[7:0] <= Y_M1[7:0]; // IDLE y from data_in

            if(ld_x_M2)  x_start_M2[8:0] <= X_M2[8:0]; // IDLE x from data_in
            if(ld_y_M2)  y_start_M2[7:0] <= Y_M2[7:0]; // IDLE y from data_in
				
				if(ld_x_M3)  x_start_M3[8:0] <= X_M3[8:0]; // IDLE x from data_in
            if(ld_y_M3)  y_start_M3[7:0] <= Y_M3[7:0]; // IDLE y from data_in
				
				if(ld_x_M4)  x_start_M4[8:0] <= X_M4[8:0]; // IDLE x from data_in
            if(ld_y_M4)  y_start_M4[7:0] <= Y_M4[7:0]; // IDLE y from data_in
				
				
				
				if(ld_x_P1)  x_start_P1[8:0] <= X_P1[8:0]; // IDLE x from data_in
            if(ld_y_P1)  y_start_P1[7:0] <= Y_P1[7:0]; // IDLE y from data_in
				
				if(ld_x_P2)  x_start_P2[8:0] <= X_P2[8:0]; // IDLE x from data_in
            if(ld_y_P2)  y_start_P2[7:0] <= Y_P2[7:0]; // IDLE y from data_in
				
				if(ld_x_P3)  x_start_P3[8:0] <= X_P3[8:0]; // IDLE x from data_in
            if(ld_y_P3)  y_start_P3[7:0] <= Y_P3[7:0]; // IDLE y from data_in
				
				if(ld_x_P4)  x_start_P4[8:0] <= X_P4[8:0]; // IDLE x from data_in
            if(ld_y_P4)  y_start_P4[7:0] <= Y_P4[7:0]; // IDLE y from data_in
				
				if(ld_x_P5)  x_start_P5[8:0] <= X_P5[8:0]; // IDLE x from data_in
            if(ld_y_P5)  y_start_P5[7:0] <= Y_P5[7:0]; // IDLE y from data_in
				
				if(ld_x_P6)  x_start_P6[8:0] <= X_P6[8:0]; // IDLE x from data_in
            if(ld_y_P6)  y_start_P6[7:0] <= Y_P6[7:0]; // IDLE y from data_in
				
				
				
				
				if(ld_x_E)  x_start_E[8:0] <= X_E[8:0]; // IDLE x from data_in
            if(ld_y_E)  y_start_E[7:0] <= Y_E[7:0]; // IDLE y from data_in
				

		  end
		  
        
    end
	 

    // counter to change x and y coordinate or clear to black
	always @(posedge clk)
	begin
	
		if (!resetn) begin
			count[7:0] = 8'b0;
			first = 1'b1;
			black_first = 1'b1;
			black_count[7:0] = 8'b0;	


			count_M[7:0] = 8'b0;
			first_M = 1'b1;
			black_first_M = 1'b1;
			black_count_M[7:0] = 8'b0;	

			count_M1[7:0] = 8'b0;
			first_M1 = 1'b1;
			black_first_M1 = 1'b1;
			black_count_M1[7:0] = 8'b0;

			count_M2[7:0] = 8'b0;
			first_M2 = 1'b1;
			black_first_M2 = 1'b1;
			black_count_M2[7:0] = 8'b0;
			
			count_M3[7:0] = 8'b0;
			first_M3 = 1'b1;
			black_first_M3 = 1'b1;
			black_count_M3[7:0] = 8'b0;
			
			count_M4[7:0] = 8'b0;
			first_M4 = 1'b1;
			black_first_M4 = 1'b1;
			black_count_M4[7:0] = 8'b0;
			
			count_P1[7:0] = 8'b0;
			first_P1 = 1'b1;
			black_first_P1 = 1'b1;
			black_count_P1[7:0] = 8'b0;
			
			count_P2[7:0] = 8'b0;
			first_P2 = 1'b1;
			black_first_P2 = 1'b1;
			black_count_P2[7:0] = 8'b0;
			
			count_P3[7:0] = 8'b0;
			first_P3 = 1'b1;
			black_first_P3 = 1'b1;
			black_count_P3[7:0] = 8'b0;
			
			count_P4[7:0] = 8'b0;
			first_P4 = 1'b1;
			black_first_P4 = 1'b1;
			black_count_P4[7:0] = 8'b0;
			
			count_P5[7:0] = 8'b0;
			first_P5 = 1'b1;
			black_first_P5 = 1'b1;
			black_count_P5[7:0] = 8'b0;
			
			count_P6[7:0] = 8'b0;
			first_P6 = 1'b1;
			black_first_P6 = 1'b1;
			black_count_P6[7:0] = 8'b0;
			
			count_E[7:0] = 8'b0;
			first_E = 1'b1;
			black_first_E = 1'b1;
			black_count_E[7:0] = 8'b0;
	
		
		end

		
		else if(first) begin
			count[7:0] = 8'b0;
			first = 1'b0;
		end	
	
		else if (count_enable)
			count[7:0] = count + 1;	
		
		
		else if(black_first)begin
			black_count[7:0] = 8'b0;
			black_first = 1'b0;
		end
	
		else if (black_enable)
			black_count[7:0] = black_count[7:0] + 1;	



		//*************************************
		else if(first_M) begin
			count_M[7:0] = 8'b0;
			first_M = 1'b0;
		end	
	
		else if (count_enable_M)
			count_M[7:0] = count_M + 1;	
		
		
		else if(black_first_M)begin
			black_count_M[7:0] = 8'b0;
			black_first_M = 1'b0;
		end
	
		else if (black_enable_M)
			black_count_M[7:0] = black_count_M[7:0] + 1;	

		//*************************************
		else if(first_M1) begin
			count_M1[7:0] = 8'b0;
			first_M1 = 1'b0;
		end	
	
		else if (count_enable_M1)
			count_M1[7:0] = count_M1 + 1;	
		
		
		else if(black_first_M1)begin
			black_count_M1[7:0] = 8'b0;
			black_first_M1 = 1'b0;
		end
	
		else if (black_enable_M1)
			black_count_M1[7:0] = black_count_M1[7:0] + 1;

		//*************************************
		else if(first_M2) begin
			count_M2[7:0] = 8'b0;
			first_M2 = 1'b0;
		end	
	
		else if (count_enable_M2)
			count_M2[7:0] = count_M2 + 1;	
		
		
		else if(black_first_M2)begin
			black_count_M2[7:0] = 8'b0;
			black_first_M2 = 1'b0;
		end
	
		else if (black_enable_M2)
			black_count_M2[7:0] = black_count_M2[7:0] + 1;
			
			
		//*************************************
		else if(first_M3) begin
			count_M3[7:0] = 8'b0;
			first_M3 = 1'b0;
		end	
	
		else if (count_enable_M3)
			count_M3[7:0] = count_M3 + 1;	
		
		
		else if(black_first_M3)begin
			black_count_M3[7:0] = 8'b0;
			black_first_M3 = 1'b0;
		end
	
		else if (black_enable_M3)
			black_count_M3[7:0] = black_count_M3[7:0] + 1;
			
			
		//*************************************
		else if(first_M4) begin
			count_M4[7:0] = 8'b0;
			first_M4 = 1'b0;
		end	
	
		else if (count_enable_M4)
			count_M4[7:0] = count_M4 + 1;	
		
		
		else if(black_first_M4)begin
			black_count_M4[7:0] = 8'b0;
			black_first_M4 = 1'b0;
		end
	
		else if (black_enable_M4)
			black_count_M4[7:0] = black_count_M4[7:0] + 1;
			
			
			
		//*************************************
		else if(first_P1) begin
			count_P1[7:0] = 8'b0;
			first_P1 = 1'b0;
		end	
	
		else if (count_enable_P1)
			count_P1[7:0] = count_P1 + 1;	
		
		
		else if(black_first_P1)begin
			black_count_P1[7:0] = 8'b0;
			black_first_P1 = 1'b0;
		end
	
		else if (black_enable_P1)
			black_count_P1[7:0] = black_count_P1[7:0] + 1;
			
		//*************************************
		else if(first_P2) begin
			count_P2[7:0] = 8'b0;
			first_P2 = 1'b0;
		end	
	
		else if (count_enable_P2)
			count_P2[7:0] = count_P2 + 1;	
		
		
		else if(black_first_P2)begin
			black_count_P2[7:0] = 8'b0;
			black_first_P2 = 1'b0;
		end
	
		else if (black_enable_P2)
			black_count_P2[7:0] = black_count_P2[7:0] + 1;
			
			
		//*************************************
		else if(first_P3) begin
			count_P3[7:0] = 8'b0;
			first_P3 = 1'b0;
		end	
	
		else if (count_enable_P3)
			count_P3[7:0] = count_P3 + 1;	
		
		
		else if(black_first_P3)begin
			black_count_P3[7:0] = 8'b0;
			black_first_P3 = 1'b0;
		end
	
		else if (black_enable_P3)
			black_count_P3[7:0] = black_count_P3[7:0] + 1;
			
			
			
			
		//*************************************
		else if(first_P4) begin
			count_P4[7:0] = 8'b0;
			first_P4 = 1'b0;
		end	
	
		else if (count_enable_P4)
			count_P4[7:0] = count_P4 + 1;	
		
		
		else if(black_first_P4)begin
			black_count_P4[7:0] = 8'b0;
			black_first_P4 = 1'b0;
		end
	
		else if (black_enable_P4)
			black_count_P4[7:0] = black_count_P4[7:0] + 1;
			
			
		//*************************************
		else if(first_P5) begin
			count_P5[7:0] = 8'b0;
			first_P5 = 1'b0;
		end	
	
		else if (count_enable_P5)
			count_P5[7:0] = count_P5 + 1;	
		
		
		else if(black_first_P5)begin
			black_count_P5[7:0] = 8'b0;
			black_first_P5 = 1'b0;
		end
	
		else if (black_enable_P5)
			black_count_P5[7:0] = black_count_P5[7:0] + 1;
			
			
		//*************************************
		else if(first_P6) begin
			count_P6[7:0] = 8'b0;
			first_P6 = 1'b0;
		end	
	
		else if (count_enable_P6)
			count_P6[7:0] = count_P6 + 1;	
		
		
		else if(black_first_P6)begin
			black_count_P6[7:0] = 8'b0;
			black_first_P6 = 1'b0;
		end
	
		else if (black_enable_P6)
			black_count_P6[7:0] = black_count_P6[7:0] + 1;


		//*************************************
		else if(first_E) begin
			count_E[7:0] = 8'b0;
			first_E = 1'b0;
		end	
	
		else if (count_enable_E)
			count_E[7:0] = count_E + 1;	
		
		
		else if(black_first_E)begin
			black_count_E[7:0] = 8'b0;
			black_first_E = 1'b0;
		end
	
		else if (black_enable_E)
			black_count_E[7:0] = black_count_E[7:0] + 1;
			
			
			
			


	end

	//--------------------------------------------------------



	// counter to change x and y coordinate
	always @(posedge clk)
	begin

	if (!resetn)
		begin
		x_final[8:0] <= 9'b0;
		y_final[7:0] <= 8'b0;
	end
		
		
    else if (black_enable)
	begin
		x_final[8:0] <= x_start + black_count[3:0];
		y_final[7:0] <= y_start + black_count[7:4];

	end	

	else if (count_enable)
	begin
		x_final[8:0] <= x_start + count[3:0];
		y_final[7:0] <= y_start + count[7:4];
	end



	//-----------------------------------------------------------
	else if (black_enable_M)
	begin
		x_final[8:0] <= x_start_M + black_count_M[3:0];
		y_final[7:0] <= y_start_M + black_count_M[7:4];

	end	
	
	else if (count_enable_M)
	begin
		x_final[8:0] <= x_start_M + count_M[3:0];
		y_final[7:0] <= y_start_M + count_M[7:4];
	end

	//-----------------------------------------------------------
	else if (black_enable_M1)
	begin
		x_final[8:0] <= x_start_M1 + black_count_M1[3:0];
		y_final[7:0] <= y_start_M1 + black_count_M1[7:4];

	end	
	
	else if (count_enable_M1)
	begin
		x_final[8:0] <= x_start_M1 + count_M1[3:0];
		y_final[7:0] <= y_start_M1 + count_M1[7:4];
	end
	
	
	//-----------------------------------------------------------
	else if (black_enable_M2)
	begin
		x_final[8:0] <= x_start_M2 + black_count_M2[3:0];
		y_final[7:0] <= y_start_M2 + black_count_M2[7:4];

	end	
	
	else if (count_enable_M2)
	begin
		x_final[8:0] <= x_start_M2 + count_M2[3:0];
		y_final[7:0] <= y_start_M2 + count_M2[7:4];
	end

	
	//-----------------------------------------------------------
	else if (black_enable_M3)
	begin
		x_final[8:0] <= x_start_M3 + black_count_M3[3:0];
		y_final[7:0] <= y_start_M3 + black_count_M3[7:4];

	end	
	
	else if (count_enable_M3)
	begin
		x_final[8:0] <= x_start_M3 + count_M3[3:0];
		y_final[7:0] <= y_start_M3 + count_M3[7:4];
	end
	
	
	//-----------------------------------------------------------
	else if (black_enable_M4)
	begin
		x_final[8:0] <= x_start_M4 + black_count_M4[3:0];
		y_final[7:0] <= y_start_M4 + black_count_M4[7:4];

	end	
	
	else if (count_enable_M4)
	begin
		x_final[8:0] <= x_start_M4 + count_M4[3:0];
		y_final[7:0] <= y_start_M4 + count_M4[7:4];
	end
	
	
	//-----------------------------------------------------------
	else if (black_enable_P1)
	begin
		x_final[8:0] <= x_start_P1 + black_count_P1[3:0];
		y_final[7:0] <= y_start_P1 + black_count_P1[7:4];

	end	
	
	else if (count_enable_P1)
	begin
		x_final[8:0] <= x_start_P1 + count_P1[3:0];
		y_final[7:0] <= y_start_P1 + count_P1[7:4];
	end
	
	
	
	//-----------------------------------------------------------
	else if (black_enable_P2)
	begin
		x_final[8:0] <= x_start_P2 + black_count_P2[3:0];
		y_final[7:0] <= y_start_P2 + black_count_P2[7:4];

	end	
	
	else if (count_enable_P2)
	begin
		x_final[8:0] <= x_start_P2 + count_P2[3:0];
		y_final[7:0] <= y_start_P2 + count_P2[7:4];
	end
	
	
	//-----------------------------------------------------------
	else if (black_enable_P3)
	begin
		x_final[8:0] <= x_start_P3 + black_count_P3[3:0];
		y_final[7:0] <= y_start_P3 + black_count_P3[7:4];

	end	
	
	else if (count_enable_P3)
	begin
		x_final[8:0] <= x_start_P3 + count_P3[3:0];
		y_final[7:0] <= y_start_P3 + count_P3[7:4];
	end
	
	
	
	//-----------------------------------------------------------
	else if (black_enable_P4)
	begin
		x_final[8:0] <= x_start_P4 + black_count_P4[3:0];
		y_final[7:0] <= y_start_P4 + black_count_P4[7:4];

	end	
	
	else if (count_enable_P4)
	begin
		x_final[8:0] <= x_start_P4 + count_P4[3:0];
		y_final[7:0] <= y_start_P4 + count_P4[7:4];
	end
	
	//-----------------------------------------------------------
	else if (black_enable_P5)
	begin
		x_final[8:0] <= x_start_P5 + black_count_P5[3:0];
		y_final[7:0] <= y_start_P5 + black_count_P5[7:4];

	end	
	
	else if (count_enable_P5)
	begin
		x_final[8:0] <= x_start_P5 + count_P5[3:0];
		y_final[7:0] <= y_start_P5 + count_P5[7:4];
	end
	
	
	
	//-----------------------------------------------------------
	else if (black_enable_P6)
	begin
		x_final[8:0] <= x_start_P6 + black_count_P6[3:0];
		y_final[7:0] <= y_start_P6 + black_count_P6[7:4];

	end	
	
	else if (count_enable_P6)
	begin
		x_final[8:0] <= x_start_P6 + count_P6[3:0];
		y_final[7:0] <= y_start_P6 + count_P6[7:4];
	end
	
	
	//-----------------------------------------------------------
	else if (black_enable_E)
	begin
		x_final[8:0] <= x_start_E + black_count_E[3:0];
		y_final[7:0] <= y_start_E + black_count_E[7:4];

	end	
	
	else if (count_enable_E)
	begin
		x_final[8:0] <= x_start_E + count_E[3:0];
		y_final[7:0] <= y_start_E + count_E[7:4];
	end
	
	
	

	
	end    
	
endmodule
