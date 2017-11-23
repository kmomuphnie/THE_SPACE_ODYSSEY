module STEM(CLOCK_50, KEY, 
			SW, 
				
			PS2_CLK, PS2_DAT,
				
			VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B, 
			HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
			LEDR);

	input	CLOCK_50;				//	50 MHz
	// Declare your inputs and outputs here
	input [9:0] SW;
	input [3:0] KEY;
	
	
	
	// Do not change the following outputsfile

	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]

	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	output [6:0] HEX4;
	output [6:0] HEX5;
	output [9:6] LEDR;
	
	//************************************************************//
	//keyboard setup
	inout PS2_CLK;
	inout PS2_DAT;
	
	
	wire [7:0]ps2_key_data;
	wire ps2_key_pressed;
	reg  [7:0] last_data_received;
	
	wire up, down, left, right;
	
	always @(posedge CLOCK_50)
	begin
	if (~KEY[0] == 1'b1)
		last_data_received <= 8'h00;
	else if (ps2_key_pressed == 1'b1)
		last_data_received <= ps2_key_data;
	end
	
	PS2_Controller PS2 (
	// Inputs
	.CLOCK_50		(CLOCK_50),
	.reset			(~KEY[0]),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(ps2_key_pressed)
	);
	
	//constant
	reg [7:0]up_sig = 8'h1D;
	reg [7:0]left_sig = 8'h1C;
	reg [7:0]right_sig = 8'h23;
	reg [7:0]down_sig = 8'h1B;
	reg [7:0]start_sig = 8'h29;
	
	//displaying output in LEDR
	assign LEDR[9] = up;
	assign LEDR[8] = down;
	assign LEDR[7] = left;
	assign LEDR[6] = right;
	
	assign up = (last_data_received == up_sig);
	assign down = (last_data_received == down_sig);
	assign left = (last_data_received == left_sig);
	assign right = (last_data_received == right_sig);
	assign start = (last_data_received == start_sig);
		
	//*****************************************************************************//	
		
	
	//the public input signals
	wire resetn;
//   wire load;
	reg  load;
	always@(*)begin
		if((KEY[1] == 0)||(start == 1)) load = 1;
		else load = 0;
	end
//	assign load = ~KEY[1];
	assign resetn = KEY[0];
	wire [7:0]state;




	//the control signals for the spaceship
	wire [2:0] color;
	wire [8:0] X;
	wire [7:0] Y;
	wire enable_x, enable_y, ld_color;
    wire DD, DE, SD, SE;
//	wire up, down, left, right;
//	assign up    = SW[9];
//	assign down  = SW[8];
//	assign left  = SW[7];
//	assign right = SW[6];
	wire move_up, move_down, move_left, move_right;


	//the control signals for the meteor
	wire [2:0] color_M;
	wire [8:0] X_M;
	wire [7:0] Y_M;
	wire enable_x_M, enable_y_M, ld_color_M;
    wire DD_M, DE_M, SD_M, SE_M;

    //the control signals for the meteor1
	wire [2:0] color_M1;
	wire [8:0] X_M1;
	wire [7:0] Y_M1;
	wire enable_x_M1, enable_y_M1, ld_color_M1;
    wire DD_M1, DE_M1, SD_M1, SE_M1;

    //the control signals for the meteor2
	wire [2:0] color_M2;
	wire [8:0] X_M2;
	wire [7:0] Y_M2;
	wire enable_x_M2, enable_y_M2, ld_color_M2;
    wire DD_M2, DE_M2, SD_M2, SE_M2;

    //the control signals for the meteor3
	wire [2:0] color_M3;
	wire [8:0] X_M3;
	wire [7:0] Y_M3;
	wire enable_x_M3, enable_y_M3, ld_color_M3;
    wire DD_M3, DE_M3, SD_M3, SE_M3;
	 
    //the control signals for the meteor4
	wire [2:0] color_M4;
	wire [8:0] X_M4;
	wire [7:0] Y_M4;
	wire enable_x_M4, enable_y_M4, ld_color_M4;
    wire DD_M4, DE_M4, SD_M4, SE_M4;


    //the control signals for the pirate1
	wire [2:0] color_P1;
	wire [8:0] X_P1;
	wire [7:0] Y_P1;
	wire enable_x_P1, enable_y_P1, ld_color_P1;
    wire DD_P1, DE_P1, SD_P1, SE_P1;
    //the control signals for the pirate2
	wire [2:0] color_P2;
	wire [8:0] X_P2;
	wire [7:0] Y_P2;
	wire enable_x_P2, enable_y_P2, ld_color_P2;
    wire DD_P2, DE_P2, SD_P2, SE_P2;
    //the control signals for the pirate3
	wire [2:0] color_P3;
	wire [8:0] X_P3;
	wire [7:0] Y_P3;
	wire enable_x_P3, enable_y_P3, ld_color_P3;
    wire DD_P3, DE_P3, SD_P3, SE_P3;
    //the control signals for the pirate4
	wire [2:0] color_P4;
	wire [8:0] X_P4;
	wire [7:0] Y_P4;
	wire enable_x_P4, enable_y_P4, ld_color_P4;
    wire DD_P4, DE_P4, SD_P4, SE_P4;
    //the control signals for the pirate5
	wire [2:0] color_P5;
	wire [8:0] X_P5;
	wire [7:0] Y_P5;
	wire enable_x_P5, enable_y_P5, ld_color_P5;
    wire DD_P5, DE_P5, SD_P5, SE_P5;

    //the control signals for the pirate6
	wire [2:0] color_P6;
	wire [8:0] X_P6;
	wire [7:0] Y_P6;
	wire enable_x_P6, enable_y_P6, ld_color_P6;
    wire DD_P6, DE_P6, SD_P6, SE_P6;


     //the control signals for the Earth
	wire [2:0] color_E;
	wire [8:0] X_E;
	wire [7:0] Y_E;
	wire enable_x_E, enable_y_E, ld_color_E;
    wire DD_E, DE_E, SD_E, SE_E;
	
	


	control_top c1(CLOCK_50, resetn, load, 

				   DD, DE, up, down, left, right,

				   DD_M, DE_M,
				   DD_M1, DE_M1,
				   DD_M2, DE_M2,
				   DD_M3, DE_M3,
				   DD_M4, DE_M4,

				   DD_P1, DE_P1,
				   DD_P2, DE_P2,
				   DD_P3, DE_P3,
				   DD_P4, DE_P4,
				   DD_P5, DE_P5,
				   DD_P6, DE_P6,

				   DD_E, DE_E,




				   SD, SE, enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right,

				   SD_M, SE_M, enable_x_M, enable_y_M, ld_color_M, 
				   SD_M1, SE_M1, enable_x_M1, enable_y_M1, ld_color_M1, 
				   SD_M2, SE_M2, enable_x_M2, enable_y_M2, ld_color_M2, 
				   SD_M3, SE_M3, enable_x_M3, enable_y_M3, ld_color_M3, 
				   SD_M4, SE_M4, enable_x_M4, enable_y_M4, ld_color_M4, 

				   SD_P1, SE_P1, enable_x_P1, enable_y_P1, ld_color_P1, 
				   SD_P2, SE_P2, enable_x_P2, enable_y_P2, ld_color_P2, 
				   SD_P3, SE_P3, enable_x_P3, enable_y_P3, ld_color_P3, 
				   SD_P4, SE_P4, enable_x_P4, enable_y_P4, ld_color_P4, 
				   SD_P5, SE_P5, enable_x_P5, enable_y_P5, ld_color_P5, 
				   SD_P6, SE_P6, enable_x_P6, enable_y_P6, ld_color_P6, 


				   SD_E, SE_E, enable_x_E, enable_y_E, ld_color_E, 

				   state);
	
	datapath_top d1(CLOCK_50, resetn, 

					SW[2:0], enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right, 

					SW[2:0], enable_x_M, enable_y_M, ld_color_M,
					SW[2:0], enable_x_M1, enable_y_M1, ld_color_M1,
					SW[2:0], enable_x_M2, enable_y_M2, ld_color_M2,
					SW[2:0], enable_x_M3, enable_y_M3, ld_color_M3,
					SW[2:0], enable_x_M4, enable_y_M4, ld_color_M4,

					SW[2:0], enable_x_P1, enable_y_P1, ld_color_P1,
					SW[2:0], enable_x_P2, enable_y_P2, ld_color_P2,
					SW[2:0], enable_x_P3, enable_y_P3, ld_color_P3,
					SW[2:0], enable_x_P4, enable_y_P4, ld_color_P4,
					SW[2:0], enable_x_P5, enable_y_P5, ld_color_P5,
					SW[2:0], enable_x_P6, enable_y_P6, ld_color_P6,

					SW[2:0], enable_x_E, enable_y_E, ld_color_E,




					X, Y, color,

					X_M, Y_M, color_M,
					X_M1, Y_M1, color_M1,
					X_M2, Y_M2, color_M2,
					X_M3, Y_M3, color_M3,
					X_M4, Y_M4, color_M4,

					X_P1, Y_P1, color_P1,
					X_P2, Y_P2, color_P2,
					X_P3, Y_P3, color_P3,
					X_P4, Y_P4, color_P4,
					X_P5, Y_P5, color_P5,
					X_P6, Y_P6, color_P6,

					X_E, Y_E, color_E

					);

	fill D1(CLOCK_50, resetn, 

			X, Y, color, SD, SE, 

			X_M, Y_M, color_M, SD_M, SE_M,
			X_M1, Y_M1, color_M1, SD_M1, SE_M1,
			X_M2, Y_M2, color_M2, SD_M2, SE_M2,
			X_M3, Y_M3, color_M3, SD_M3, SE_M3,
			X_M4, Y_M4, color_M4, SD_M4, SE_M4,

			X_P1, Y_P1, color_P1, SD_P1, SE_P1,
			X_P2, Y_P2, color_P2, SD_P2, SE_P2,
			X_P3, Y_P3, color_P3, SD_P3, SE_P3,
			X_P4, Y_P4, color_P4, SD_P4, SE_P4,
			X_P5, Y_P5, color_P5, SD_P5, SE_P5,
			X_P6, Y_P6, color_P6, SD_P6, SE_P6,

			X_E, Y_E, color_E, SD_E, SE_E,



			DD, DE, 

			DD_M, DE_M,
			DD_M1, DE_M1,
			DD_M2, DE_M2,
			DD_M3, DE_M3,
			DD_M4, DE_M4,

			DD_P1, DE_P1,
			DD_P2, DE_P2,
			DD_P3, DE_P3,
			DD_P4, DE_P4,
			DD_P5, DE_P5,
			DD_P6, DE_P6,

			DD_E, DE_E,

			VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B);

	hexDisplay H0(X[3:0], HEX0[6:0]);
	hexDisplay H1(Y[3:0], HEX1[6:0]);
	hexDisplay H2(X_M[3:0], HEX2[6:0]);
	hexDisplay H3(Y_M[3:0], HEX3[6:0]);
	hexDisplay H4(state[3:0], HEX4[6:0]);
	hexDisplay H5(state[7:4], HEX5[6:0]);
 endmodule
 
 module control_top(input clk, resetn, load, 

 					input iDD, iDE, up, down, left, right,

 					input iDD_M,  iDE_M, 
 					input iDD_M1, iDE_M1, 
 					input iDD_M2, iDE_M2, 
 				    input iDD_M3, iDE_M3,
				    input iDD_M4, iDE_M4,

				    input iDD_P1, iDE_P1,
				    input iDD_P2, iDE_P2,
				    input iDD_P3, iDE_P3,
				    input iDD_P4, iDE_P4,
				    input iDD_P5, iDE_P5,
				    input iDD_P6, iDE_P6,

				    input iDD_E,  iDE_E,








					output reg oSD, oSE, enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right, 

					output reg oSD_M,  oSE_M,  enable_x_M,  enable_y_M,  ld_color_M,
					output reg oSD_M1, oSE_M1, enable_x_M1, enable_y_M1, ld_color_M1,
					output reg oSD_M2, oSE_M2, enable_x_M2, enable_y_M2, ld_color_M2,
				    output reg oSD_M3, oSE_M3, enable_x_M3, enable_y_M3, ld_color_M3, 
				    output reg oSD_M4, oSE_M4, enable_x_M4, enable_y_M4, ld_color_M4,

				    output reg oSD_P1, oSE_P1, enable_x_P1, enable_y_P1, ld_color_P1, 
				    output reg oSD_P2, oSE_P2, enable_x_P2, enable_y_P2, ld_color_P2, 
				    output reg oSD_P3, oSE_P3, enable_x_P3, enable_y_P3, ld_color_P3, 
				    output reg oSD_P4, oSE_P4, enable_x_P4, enable_y_P4, ld_color_P4, 
				    output reg oSD_P5, oSE_P5, enable_x_P5, enable_y_P5, ld_color_P5, 
				    output reg oSD_P6, oSE_P6, enable_x_P6, enable_y_P6, ld_color_P6, 

				    output reg oSD_E,  oSE_E,  enable_x_E,  enable_y_E,  ld_color_E, 

					output reg [7:0]state);

	 reg [7:0] current_state, next_state; 
	 reg [27:0] count;
	 // reg [27:0] ecount;
	    
    localparam  S_RESET            = 8'd0,
	 

				S_INDRAW           = 8'd1,
				S_INACKDRAW        = 8'd2,

				S_INDRAW_M         = 8'd3,
				S_INACKDRAW_M      = 8'd4,

				S_INDRAW_M1         = 8'd5,
				S_INACKDRAW_M1      = 8'd6,

				S_INDRAW_M2         = 8'd7,
				S_INACKDRAW_M2      = 8'd8,

				S_INDRAW_M3         = 8'd9,
				S_INACKDRAW_M3      = 8'd10,

				S_INDRAW_M4         = 8'd11,
				S_INACKDRAW_M4      = 8'd12,



				S_INDRAW_P1         = 8'd13,
				S_INACKDRAW_P1      = 8'd14,

				S_INDRAW_P2         = 8'd15,
				S_INACKDRAW_P2      = 8'd16,

				S_INDRAW_P3         = 8'd17,
				S_INACKDRAW_P3      = 8'd18,

				S_INDRAW_P4         = 8'd19,
				S_INACKDRAW_P4      = 8'd20,

				S_INDRAW_P5         = 8'd21,
				S_INACKDRAW_P5      = 8'd22,

				S_INDRAW_P6         = 8'd23,
				S_INACKDRAW_P6      = 8'd24,

				S_INDRAW_E          = 8'd25,
				S_INACKDRAW_E       = 8'd26,

					 
				S_IDLE             = 8'd27,
					 
				//these are the spaceship states	 
				S_ERASE        	   = 8'd28,
				S_ACKERASE         = 8'd29,
					 
				S_MOVE			   = 8'd30,
					 
            	S_DRAW             = 8'd31,
				S_ACKDRAW          = 8'd32,

				//these are other sprites states******************************************

				//these is the meteor
				S_ERASE_M          = 8'd33,
				S_ACKERASE_M       = 8'd34,
					 
				S_MOVE_M		   = 8'd35,
					 
            	S_DRAW_M           = 8'd36,
				S_ACKDRAW_M        = 8'd37,


				//these is the meteor1
				S_ERASE_M1          = 8'd38,
				S_ACKERASE_M1       = 8'd39,
					 
				S_MOVE_M1		   = 8'd40,
					 
            	S_DRAW_M1           = 8'd41,
				S_ACKDRAW_M1        = 8'd42,

				//these is the meteor2
				S_ERASE_M2          = 8'd43,
				S_ACKERASE_M2       = 8'd44,
					 
				S_MOVE_M2		   = 8'd45,
					 
            	S_DRAW_M2           = 8'd46,
				S_ACKDRAW_M2        = 8'd47,


				//these is the meteor3
				S_ERASE_M3          = 8'd48,
				S_ACKERASE_M3       = 8'd49,
					 
				S_MOVE_M3		   = 8'd50,
					 
            	S_DRAW_M3           = 8'd51,
				S_ACKDRAW_M3        = 8'd52,


				//these is the meteor4
				S_ERASE_M4          = 8'd53,
				S_ACKERASE_M4       = 8'd54,
					 
				S_MOVE_M4		   = 8'd55,
					 
            	S_DRAW_M4           = 8'd56,
				S_ACKDRAW_M4        = 8'd57,


				//these is the PIRATE 1
				S_ERASE_P1          = 8'd58,
				S_ACKERASE_P1       = 8'd59,
					 
				S_MOVE_P1		   = 8'd60,
					 
            	S_DRAW_P1           = 8'd61,
				S_ACKDRAW_P1        = 8'd62,

				//these is the PIRATE 2
				S_ERASE_P2          = 8'd63,
				S_ACKERASE_P2       = 8'd64,
					 
				S_MOVE_P2		   = 8'd65,
					 
            	S_DRAW_P2           = 8'd66,
				S_ACKDRAW_P2        = 8'd67,
				//these is the PIRATE 3
				S_ERASE_P3          = 8'd68,
				S_ACKERASE_P3       = 8'd69,
					 
				S_MOVE_P3		   = 8'd70,
					 
            	S_DRAW_P3           = 8'd71,
				S_ACKDRAW_P3        = 8'd72,

				//these is the PIRATE 4
				S_ERASE_P4          = 8'd73,
				S_ACKERASE_P4       = 8'd74,
					 
				S_MOVE_P4		   = 8'd75,
					 
            	S_DRAW_P4           = 8'd76,
				S_ACKDRAW_P4        = 8'd77,

				//these is the PIRATE 5
				S_ERASE_P5          = 8'd78,
				S_ACKERASE_P5       = 8'd79,
					 
				S_MOVE_P5		   = 8'd80,
					 
            	S_DRAW_P5           = 8'd81,
				S_ACKDRAW_P5        = 8'd82,

				//these is the PIRATE 6
				S_ERASE_P6          = 8'd83,
				S_ACKERASE_P6       = 8'd84,
					 
				S_MOVE_P6		   = 8'd85,
					 
            	S_DRAW_P6           = 8'd86,
				S_ACKDRAW_P6        = 8'd87,

				//these is the EARTH
				S_ERASE_E          = 8'd88,
				S_ACKERASE_E       = 8'd89,
					 
				S_MOVE_E		   = 8'd90,
					 
            	S_DRAW_E           = 8'd91,
				S_ACKDRAW_E        = 8'd92,




					 
            	S_WAIT             = 8'd93;
					 			
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
			state[7:0] = current_state[7:0];
            case (current_state)
				    S_RESET:       next_state = load ? S_INDRAW : S_RESET;
					 
               		S_INDRAW:      next_state = iDD ? S_INACKDRAW : S_INDRAW;
					S_INACKDRAW:   next_state = S_INDRAW_M;


					S_INDRAW_M:    next_state = iDD_M ? S_INACKDRAW_M : S_INDRAW_M;
					S_INACKDRAW_M: next_state = S_INDRAW_M1;


					S_INDRAW_M1:    next_state = iDD_M1 ? S_INACKDRAW_M1 : S_INDRAW_M1;
					S_INACKDRAW_M1: next_state = S_INDRAW_M2;


					S_INDRAW_M2:    next_state = iDD_M2 ? S_INACKDRAW_M2 : S_INDRAW_M2;
					S_INACKDRAW_M2: next_state = S_INDRAW_M3;

					S_INDRAW_M3:    next_state = iDD_M3 ? S_INACKDRAW_M3 : S_INDRAW_M3;
					S_INACKDRAW_M3: next_state = S_INDRAW_M4;

					S_INDRAW_M4:    next_state = iDD_M4 ? S_INACKDRAW_M4 : S_INDRAW_M4;
					S_INACKDRAW_M4: next_state = S_INDRAW_P1;



					S_INDRAW_P1:    next_state = iDD_P1 ? S_INACKDRAW_P1 : S_INDRAW_P1;
					S_INACKDRAW_P1: next_state = S_INDRAW_P2;

					S_INDRAW_P2:    next_state = iDD_P2 ? S_INACKDRAW_P2 : S_INDRAW_P2;
					S_INACKDRAW_P2: next_state = S_INDRAW_P3;

					S_INDRAW_P3:    next_state = iDD_P3 ? S_INACKDRAW_P3 : S_INDRAW_P3;
					S_INACKDRAW_P3: next_state = S_INDRAW_P4;

					S_INDRAW_P4:    next_state = iDD_P4 ? S_INACKDRAW_P4 : S_INDRAW_P4;
					S_INACKDRAW_P4: next_state = S_INDRAW_P5;

					S_INDRAW_P5:    next_state = iDD_P5 ? S_INACKDRAW_P5 : S_INDRAW_P5;
					S_INACKDRAW_P5: next_state = S_INDRAW_P6;

					S_INDRAW_P6:    next_state = iDD_P6 ? S_INACKDRAW_P6 : S_INDRAW_P6;
					S_INACKDRAW_P6: next_state = S_IDLE;

					 
					S_IDLE:        next_state = ( (up == 1)||(down == 1)||(left == 1)||(right == 1) ) ? S_ERASE : S_ERASE_M;
					 
					 
					S_ERASE:       next_state = iDE ? S_ACKERASE : S_ERASE;
					// S_ACKERASE:    next_state = ( (up == 1)||(down == 1)||(left == 1)||(right == 1) ) ? S_MOVE : S_ACKERASE;
					S_ACKERASE:    next_state = S_MOVE ;
					 
					S_MOVE:		   next_state = S_DRAW;
					 
					S_DRAW:        next_state = iDD ? S_ACKDRAW : S_DRAW;
					S_ACKDRAW:     next_state = S_ERASE_M;





					S_ERASE_M:     next_state = iDE_M ? S_ACKERASE_M : S_ERASE_M;
					S_ACKERASE_M:  next_state = S_MOVE_M;
					 
					S_MOVE_M:	   next_state = S_DRAW_M;
					 
					S_DRAW_M:      next_state = iDD_M ? S_ACKDRAW_M : S_DRAW_M;
					S_ACKDRAW_M:   next_state = S_ERASE_M1;




					S_ERASE_M1:     next_state = iDE_M1 ? S_ACKERASE_M1 : S_ERASE_M1;
					S_ACKERASE_M1:  next_state = S_MOVE_M1;
					 
					S_MOVE_M1:	   next_state = S_DRAW_M1;
					 
					S_DRAW_M1:      next_state = iDD_M1 ? S_ACKDRAW_M1 : S_DRAW_M1;
					S_ACKDRAW_M1:   next_state = S_ERASE_M2;



					S_ERASE_M2:     next_state = iDE_M2 ? S_ACKERASE_M2 : S_ERASE_M2;
					S_ACKERASE_M2:  next_state = S_MOVE_M2;
					 
					S_MOVE_M2:	    next_state = S_DRAW_M2;
					 
					S_DRAW_M2:      next_state = iDD_M2 ? S_ACKDRAW_M2 : S_DRAW_M2;
					S_ACKDRAW_M2:   next_state = S_ERASE_M3;


					S_ERASE_M3:     next_state = iDE_M3 ? S_ACKERASE_M3 : S_ERASE_M3;
					S_ACKERASE_M3:  next_state = S_MOVE_M3;
					 
					S_MOVE_M3:	    next_state = S_DRAW_M3;
					 
					S_DRAW_M3:      next_state = iDD_M3 ? S_ACKDRAW_M3 : S_DRAW_M3;
					S_ACKDRAW_M3:   next_state = S_ERASE_M4;


					S_ERASE_M4:     next_state = iDE_M4 ? S_ACKERASE_M4 : S_ERASE_M4;
					S_ACKERASE_M4:  next_state = S_MOVE_M4;
					 
					S_MOVE_M4:	    next_state = S_DRAW_M4;
					 
					S_DRAW_M4:      next_state = iDD_M4 ? S_ACKDRAW_M4 : S_DRAW_M4;
					S_ACKDRAW_M4:   next_state = S_ERASE_P1;



					S_ERASE_P1:     next_state = iDE_P1 ? S_ACKERASE_P1 : S_ERASE_P1;
					S_ACKERASE_P1:  next_state = S_MOVE_P1;
					 
					S_MOVE_P1:	    next_state = S_DRAW_P1;
					 
					S_DRAW_P1:      next_state = iDD_P1 ? S_ACKDRAW_P1 : S_DRAW_P1;
					S_ACKDRAW_P1:   next_state = S_ERASE_P2;



					S_ERASE_P2:     next_state = iDE_P2 ? S_ACKERASE_P2 : S_ERASE_P2;
					S_ACKERASE_P2:  next_state = S_MOVE_P2;
					 
					S_MOVE_P2:	    next_state = S_DRAW_P2;
					 
					S_DRAW_P2:      next_state = iDD_P2 ? S_ACKDRAW_P2 : S_DRAW_P2;
					S_ACKDRAW_P2:   next_state = S_ERASE_P3;



					S_ERASE_P3:     next_state = iDE_P3 ? S_ACKERASE_P3 : S_ERASE_P3;
					S_ACKERASE_P3:  next_state = S_MOVE_P3;
					 
					S_MOVE_P3:	    next_state = S_DRAW_P3;
					 
					S_DRAW_P3:      next_state = iDD_P3 ? S_ACKDRAW_P3 : S_DRAW_P3;
					S_ACKDRAW_P3:   next_state = S_ERASE_P4;


					S_ERASE_P4:     next_state = iDE_P4 ? S_ACKERASE_P4 : S_ERASE_P4;
					S_ACKERASE_P4:  next_state = S_MOVE_P4;
					 
					S_MOVE_P4:	    next_state = S_DRAW_P4;
					 
					S_DRAW_P4:      next_state = iDD_P4 ? S_ACKDRAW_P4 : S_DRAW_P4;
					S_ACKDRAW_P4:   next_state = S_ERASE_P5;


					S_ERASE_P5:     next_state = iDE_P5 ? S_ACKERASE_P5 : S_ERASE_P5;
					S_ACKERASE_P5:  next_state = S_MOVE_P5;
					 
					S_MOVE_P5:	    next_state = S_DRAW_P5;
					 
					S_DRAW_P5:      next_state = iDD_P5 ? S_ACKDRAW_P5 : S_DRAW_P5;
					S_ACKDRAW_P5:   next_state = S_ERASE_P6;



					S_ERASE_P6:     next_state = iDE_P6 ? S_ACKERASE_P6 : S_ERASE_P6;
					S_ACKERASE_P6:  next_state = S_MOVE_P6;
					 
					S_MOVE_P6:	    next_state = S_DRAW_P6;
					 
					S_DRAW_P6:      next_state = iDD_P6 ? S_ACKDRAW_P6 : S_DRAW_P6;
					S_ACKDRAW_P6:   next_state = S_ERASE_E;



					S_ERASE_E:     next_state = iDE_E ? S_ACKERASE_E : S_ERASE_E;
					S_ACKERASE_E:  next_state = S_MOVE_E;
					 
					S_MOVE_E:	    next_state = S_DRAW_E;
					 
					S_DRAW_E:      next_state = iDD_E ? S_ACKDRAW_E : S_DRAW_E;
					S_ACKDRAW_E:   next_state = S_WAIT;



				 				 
               		S_WAIT :       next_state = (count ==  28'd1_099_999)? S_IDLE : S_WAIT;//wait 0.04s  28'd10000000
		 
					default:       next_state = S_IDLE;
				endcase	
    end // state_table


	 // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
		enable_x = 1'b0; 
		enable_y = 1'b0; 
		ld_color = 1'b0;
		oSD      = 1'b0;
		oSE      = 1'b0;
		move_up  = 1'b0;
		move_down= 1'b0;
		move_left= 1'b0; 
		move_right=1'b0;

		enable_x_M = 1'b0; 
		enable_y_M = 1'b0; 
		ld_color_M = 1'b0; 
		oSD_M      = 1'b0;
		oSE_M      = 1'b0;


		enable_x_M1 = 1'b0; 
		enable_y_M1 = 1'b0; 
		ld_color_M1 = 1'b0; 
		oSD_M1      = 1'b0;
		oSE_M1      = 1'b0;

		enable_x_M2 = 1'b0; 
		enable_y_M2 = 1'b0; 
		ld_color_M2 = 1'b0; 
		  	 oSD_M2 = 1'b0;
		     oSE_M2 = 1'b0;



		enable_x_M3 = 1'b0; 
		enable_y_M3 = 1'b0; 
		ld_color_M3 = 1'b0; 
		  	 oSD_M3 = 1'b0;
		     oSE_M3 = 1'b0;


		enable_x_M4 = 1'b0; 
		enable_y_M4 = 1'b0; 
		ld_color_M4 = 1'b0; 
		  	 oSD_M4 = 1'b0;
		     oSE_M4 = 1'b0;

		enable_x_P1 = 1'b0; 
		enable_y_P1 = 1'b0; 
		ld_color_P1 = 1'b0; 
		  	 oSD_P1 = 1'b0;
		     oSE_P1 = 1'b0;

		enable_x_P2 = 1'b0; 
		enable_y_P2 = 1'b0; 
		ld_color_P2 = 1'b0; 
		  	 oSD_P2 = 1'b0;
		     oSE_P2 = 1'b0;

		enable_x_P3 = 1'b0; 
		enable_y_P3 = 1'b0; 
		ld_color_P3 = 1'b0; 
		  	 oSD_P3 = 1'b0;
		     oSE_P3 = 1'b0;

		enable_x_P4 = 1'b0; 
		enable_y_P4 = 1'b0; 
		ld_color_P4 = 1'b0; 
		  	 oSD_P4 = 1'b0;
		     oSE_P4 = 1'b0;

		enable_x_P5 = 1'b0; 
		enable_y_P5 = 1'b0; 
		ld_color_P5 = 1'b0; 
		  	 oSD_P5 = 1'b0;
		     oSE_P5 = 1'b0;

		enable_x_P6 = 1'b0; 
		enable_y_P6 = 1'b0; 
		ld_color_P6 = 1'b0; 
		  	 oSD_P6 = 1'b0;
		     oSE_P6 = 1'b0;

		enable_x_E = 1'b0; 
		enable_y_E = 1'b0; 
		ld_color_E = 1'b0; 
		  	 oSD_E = 1'b0;
		     oSE_E = 1'b0;


       	  
        case (current_state)
		  
			S_RESET: begin
				ld_color = 1'b1;
				ld_color_M = 1'b1;
				ld_color_M1 = 1'b1;
				ld_color_M2 = 1'b1;
				ld_color_M3 = 1'b1;
				ld_color_M4 = 1'b1;

				ld_color_P1 = 1'b1;
				ld_color_P2 = 1'b1;
				ld_color_P3 = 1'b1;
				ld_color_P4 = 1'b1;
				ld_color_P5 = 1'b1;
				ld_color_P6 = 1'b1;

				ld_color_E = 1'b1;
				
			end
				
			S_INDRAW:    oSD = 1'b1;
			S_INACKDRAW: oSD = 1'b0;

			S_INDRAW_M:    oSD_M = 1'b1;
			S_INACKDRAW_M: oSD_M = 1'b0;

			S_INDRAW_M1:    oSD_M1 = 1'b1;
			S_INACKDRAW_M1: oSD_M1 = 1'b0;

			S_INDRAW_M2:    oSD_M2 = 1'b1;
			S_INACKDRAW_M2: oSD_M2 = 1'b0;

			S_INDRAW_M3:    oSD_M3 = 1'b1;
			S_INACKDRAW_M3: oSD_M3 = 1'b0;

			S_INDRAW_M4:    oSD_M4 = 1'b1;
			S_INACKDRAW_M4: oSD_M4 = 1'b0;

			S_INDRAW_P1:    oSD_P1 = 1'b1;
			S_INACKDRAW_P1: oSD_P1 = 1'b0;

			S_INDRAW_P2:    oSD_P2 = 1'b1;
			S_INACKDRAW_P2: oSD_P2 = 1'b0;

			S_INDRAW_P3:    oSD_P3 = 1'b1;
			S_INACKDRAW_P3: oSD_P3 = 1'b0;

			S_INDRAW_P4:    oSD_P4 = 1'b1;
			S_INACKDRAW_P4: oSD_P4 = 1'b0;

			S_INDRAW_P5:    oSD_P5 = 1'b1;
			S_INACKDRAW_P5: oSD_P5 = 1'b0;

			S_INDRAW_P6:    oSD_P6 = 1'b1;
			S_INACKDRAW_P6: oSD_P6 = 1'b0;

			S_INDRAW_E:    oSD_E = 1'b1;
			S_INACKDRAW_E: oSD_E = 1'b0;


			//the signal for the spaceship
            S_ERASE: oSE = 1'b1;
			S_ACKERASE: oSE = 1'b0;			
			S_MOVE:	begin
				if(up) move_up = 1;
				else if(down) move_down = 1;
				else if(left) move_left = 1;
				else if(right) move_right = 1;

			end
			S_DRAW:     oSD = 1'b1;
			S_ACKDRAW:  oSD = 1'b0;


			//the signals for the meteor
			S_ERASE_M: oSE_M = 1'b1;
			S_ACKERASE_M: oSE_M = 1'b0;
			S_MOVE_M:	begin
				enable_x_M = 1'b1; 
				enable_y_M = 1'b1;
			end
			S_DRAW_M:     oSD_M = 1'b1;
			S_ACKDRAW_M:  oSD_M = 1'b0;


			//the signals for the meteor1
			S_ERASE_M1: oSE_M1 = 1'b1;
			S_ACKERASE_M1: oSE_M1 = 1'b0;
			S_MOVE_M1:	begin
				enable_x_M1 = 1'b1; 
				enable_y_M1 = 1'b1;
			end
			S_DRAW_M1:     oSD_M1 = 1'b1;
			S_ACKDRAW_M1:  oSD_M1 = 1'b0;


			//the signals for the meteor2
			S_ERASE_M2: oSE_M2 = 1'b1;
			S_ACKERASE_M2: oSE_M2 = 1'b0;
			S_MOVE_M2:	begin
				enable_x_M2 = 1'b1; 
				enable_y_M2 = 1'b1;
			end
			S_DRAW_M2:     oSD_M2 = 1'b1;
			S_ACKDRAW_M2:  oSD_M2 = 1'b0;


			//the signals for the meteor3
			S_ERASE_M3: oSE_M3 = 1'b1;
			S_ACKERASE_M3: oSE_M3 = 1'b0;
			S_MOVE_M3:	begin
				enable_x_M3 = 1'b1; 
				enable_y_M3 = 1'b1;
			end
			S_DRAW_M3:     oSD_M3 = 1'b1;
			S_ACKDRAW_M3:  oSD_M3 = 1'b0;



			//the signals for the meteor4
			S_ERASE_M4: oSE_M4 = 1'b1;
			S_ACKERASE_M4: oSE_M4 = 1'b0;
			S_MOVE_M4:	begin
				enable_x_M4 = 1'b1; 
				enable_y_M4 = 1'b1;
			end
			S_DRAW_M4:     oSD_M4 = 1'b1;
			S_ACKDRAW_M4:  oSD_M4 = 1'b0;



			//the signals for the PIRATE 1
			S_ERASE_P1: oSE_P1 = 1'b1;
			S_ACKERASE_P1: oSE_P1 = 1'b0;
			S_MOVE_P1:	begin
				enable_x_P1 = 1'b1; 
				enable_y_P1 = 1'b1;
			end
			S_DRAW_P1:     oSD_P1 = 1'b1;
			S_ACKDRAW_P1:  oSD_P1 = 1'b0;


			//the signals for the PIRATE 2
			S_ERASE_P2: oSE_P2 = 1'b1;
			S_ACKERASE_P2: oSE_P2 = 1'b0;
			S_MOVE_P2:	begin
				enable_x_P2 = 1'b1; 
				enable_y_P2 = 1'b1;end
			S_DRAW_P2:     oSD_P2 = 1'b1;
			S_ACKDRAW_P2:  oSD_P2 = 1'b0;
			
			//the signals for the PIRATE 3
			S_ERASE_P3: oSE_P3 = 1'b1;
			S_ACKERASE_P3: oSE_P3 = 1'b0;
			S_MOVE_P3:	begin
				enable_x_P3 = 1'b1; 
				enable_y_P3 = 1'b1;end
			S_DRAW_P3:     oSD_P3 = 1'b1;
			S_ACKDRAW_P3:  oSD_P3 = 1'b0;
			
			//the signals for the PIRATE 4
			S_ERASE_P4: oSE_P4 = 1'b1;
			S_ACKERASE_P4: oSE_P4 = 1'b0;
			S_MOVE_P4:	begin
				enable_x_P4 = 1'b1; 
				enable_y_P4 = 1'b1;end
			S_DRAW_P4:     oSD_P4 = 1'b1;
			S_ACKDRAW_P4:  oSD_P4 = 1'b0;
			
			//the signals for the PIRATE 5
			S_ERASE_P5: oSE_P5 = 1'b1;
			S_ACKERASE_P5: oSE_P5 = 1'b0;
			S_MOVE_P5:	begin
				enable_x_P5 = 1'b1; 
				enable_y_P5 = 1'b1;end
			S_DRAW_P5:     oSD_P5 = 1'b1;
			S_ACKDRAW_P5:  oSD_P5 = 1'b0;
			
			//the signals for the PIRATE 6
			S_ERASE_P6: oSE_P6 = 1'b1;
			S_ACKERASE_P6: oSE_P6 = 1'b0;
			S_MOVE_P6:	begin
				enable_x_P6 = 1'b1; 
				enable_y_P6 = 1'b1;end
			S_DRAW_P6:     oSD_P6 = 1'b1;
			S_ACKDRAW_P6:  oSD_P6 = 1'b0;
			

			//the signals for the EARTH
			S_ERASE_E: oSE_E = 1'b1;
			S_ACKERASE_E: oSE_E = 1'b0;
			S_MOVE_E:	begin
				enable_x_E = 1'b1; 
				enable_y_E = 1'b1;
			end
			S_DRAW_E:     oSD_E = 1'b1;
			S_ACKDRAW_E:  oSD_E = 1'b0;
				
        endcase
		  
    end // enable_signals

    always@(posedge clk)
    begin: state_FFs
	 
        if(!resetn)
				begin
					current_state <= S_RESET;
					count <= 28'd0;  
					// ecount <= 28'd0;
				end
				
        else if((current_state == S_WAIT) && (count != 28'd1_099_999))//count != 28'd12500000
				begin
				current_state <= next_state;
				count <= count + 1'b1;
				end
				
		// else if((current_state == S_EWAIT) && (ecount != 28'd20000))//ecount != 28'd1666666
		// 		begin
		// 		current_state <= next_state;
		// 		ecount <= ecount + 1'b1;
		// 	end
				
		else if(current_state == S_ERASE_M)
		begin
				current_state <= next_state;
				count <= 28'd0;//reset the wait count number
				
		end
				
		else
			current_state <= next_state;
			
    end // state_FFS
endmodule
 
 
 
module datapath_top(clk, resetn, 
					
					data_in, enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right, 

					data_in_M, enable_x_M, enable_y_M, ld_color_M,
					data_in_M1, enable_x_M1, enable_y_M1, ld_color_M1,
					data_in_M2, enable_x_M2, enable_y_M2, ld_color_M2,
					data_in_M3, enable_x_M3, enable_y_M3, ld_color_M3,
					data_in_M4, enable_x_M4, enable_y_M4, ld_color_M4,

					data_in_P1, enable_x_P1, enable_y_P1, ld_color_P1,
					data_in_P2, enable_x_P2, enable_y_P2, ld_color_P2,
					data_in_P3, enable_x_P3, enable_y_P3, ld_color_P3,
					data_in_P4, enable_x_P4, enable_y_P4, ld_color_P4,
					data_in_P5, enable_x_P5, enable_y_P5, ld_color_P5,
					data_in_P6, enable_x_P6, enable_y_P6, ld_color_P6,

					data_in_E,  enable_x_E,  enable_y_E,  ld_color_E,




					x_final, y_final, color,

					x_final_M,  y_final_M,  color_M,
					x_final_M1, y_final_M1, color_M1,
					x_final_M2, y_final_M2, color_M2,
					x_final_M3, y_final_M3, color_M3,
					x_final_M4, y_final_M4, color_M4,

					x_final_P1, y_final_P1, color_P1,
					x_final_P2, y_final_P2, color_P2,
					x_final_P3, y_final_P3, color_P3,
					x_final_P4, y_final_P4, color_P4,
					x_final_P5, y_final_P5, color_P5,
					x_final_P6, y_final_P6, color_P6,

					x_final_E, y_final_E, color_E,
					


					);


	input clk, resetn;

	input [2:0] data_in;
	input enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right;

	input [2:0] data_in_M;
	input enable_x_M, enable_y_M, ld_color_M;

	input [2:0] data_in_M1;
	input enable_x_M1, enable_y_M1, ld_color_M1;

	input [2:0] data_in_M2;
	input enable_x_M2, enable_y_M2, ld_color_M2;

	input [2:0] data_in_M3;
	input enable_x_M3, enable_y_M3, ld_color_M3;

	input [2:0] data_in_M4;
	input enable_x_M4, enable_y_M4, ld_color_M4;


	input [2:0] data_in_P1;
	input enable_x_P1, enable_y_P1, ld_color_P1;


	input [2:0] data_in_P2;
	input enable_x_P2, enable_y_P2, ld_color_P2;

	input [2:0] data_in_P3;
	input enable_x_P3, enable_y_P3, ld_color_P3;

	input [2:0] data_in_P4;
	input enable_x_P4, enable_y_P4, ld_color_P4;

	input [2:0] data_in_P5;
	input enable_x_P5, enable_y_P5, ld_color_P5;

	input [2:0] data_in_P6;
	input enable_x_P6, enable_y_P6, ld_color_P6;


	input [2:0] data_in_E;
	input enable_x_E, enable_y_E, ld_color_E;


	output reg [8:0] x_final;
	output reg [7:0] y_final;
	output reg [2:0] color;
	

	output reg [8:0] x_final_M;
	output reg [7:0] y_final_M;
	output reg [2:0] color_M;


	output reg [8:0] x_final_M1;
	output reg [7:0] y_final_M1;
	output reg [2:0] color_M1;

	output reg [8:0] x_final_M2;
	output reg [7:0] y_final_M2;
	output reg [2:0] color_M2;

	output reg [8:0] x_final_M3;
	output reg [7:0] y_final_M3;
	output reg [2:0] color_M3;

	output reg [8:0] x_final_M4;
	output reg [7:0] y_final_M4;
	output reg [2:0] color_M4;





	output reg [8:0] x_final_P1;
	output reg [7:0] y_final_P1;
	output reg [2:0] color_P1;

	output reg [8:0] x_final_P2;
	output reg [7:0] y_final_P2;
	output reg [2:0] color_P2;

	output reg [8:0] x_final_P3;
	output reg [7:0] y_final_P3;
	output reg [2:0] color_P3;

	output reg [8:0] x_final_P4;
	output reg [7:0] y_final_P4;
	output reg [2:0] color_P4;

	output reg [8:0] x_final_P5;
	output reg [7:0] y_final_P5;
	output reg [2:0] color_P5;

	output reg [8:0] x_final_P6;
	output reg [7:0] y_final_P6;
	output reg [2:0] color_P6;



	output reg [8:0] x_final_E;
	output reg [7:0] y_final_E;
	output reg [2:0] color_E;

	
	always@(posedge clk) begin
		if(ld_color) color[2:0] <= data_in[2:0];
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final <= 9'd0;
			
		else if(move_left == 1) begin
			if(x_final == 9'd0) x_final <= 9'd316;
			else x_final <= x_final - 1;
			
		end
		
		else if(move_right == 1) begin
			if(x_final == 9'd316) x_final <= 9'd0;
			else x_final <= x_final + 1;
		end
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final <= 8'd0;
			
		else if(move_up == 1)begin	
			if(y_final == 8'd0) y_final <= 8'd236;
			else y_final <= y_final - 1;
		end
		
		else if(move_down == 1)begin
			if(y_final == 8'd236) y_final <= 8'd0;
			else y_final <= y_final + 1;
		end
		
	end
 




	//the meteor
	always@(posedge clk) begin
		if(ld_color_M) color_M[2:0] <= data_in_M[2:0];
	end
	
	reg H_M, V_M;	

	always@(*) begin
		if(!resetn) begin
			H_M <= 1'b0;
			V_M <= 1'b0;
		end
		
		if((x_final_M == 9'b0) && (H_M == 0))
			H_M <= 1;
		else if((x_final_M == 9'd303) && (H_M == 1))
			H_M <= 0;
		
		if((y_final_M == 8'b0) && (V_M == 0))
			V_M <= 1;
		else if((y_final_M == 8'd223) && (V_M == 1))
			V_M <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_M <= 9'd80;
		else if(enable_x_M && (H_M == 0))
			x_final_M <= x_final_M - 1;
		else if(enable_x_M && (H_M == 1))
			x_final_M <= x_final_M + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_M <= 8'd80;
		else if(enable_y_M && (V_M == 0))
			y_final_M <= y_final_M - 1;
		else if(enable_y_M && (V_M == 1))
			y_final_M <= y_final_M + 1;
	end


	//the meteor1
	always@(posedge clk) begin
		if(ld_color_M1) color_M1[2:0] <= data_in_M1[2:0];
	end
	
	reg H_M1, V_M1;	

	always@(*) begin
		if(!resetn) begin
			H_M1 <= 1'b0;
			V_M1 <= 1'b0;
		end
		
		if((x_final_M1 == 9'b0) && (H_M1 == 0))
			H_M1 <= 1;
		else if((x_final_M1 == 9'd303) && (H_M1 == 1))
			H_M1 <= 0;
		
		if((y_final_M1 == 8'b0) && (V_M1 == 0))
			V_M1 <= 1;
		else if((y_final_M1 == 8'd223) && (V_M1 == 1))
			V_M1 <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_M1 <= 9'd100;
		else if(enable_x_M1 && (H_M1 == 0))
			x_final_M1 <= x_final_M1 - 1;
		else if(enable_x_M1 && (H_M1 == 1))
			x_final_M1 <= x_final_M1 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_M1 <= 8'd110;
		else if(enable_y_M1 && (V_M1 == 0))
			y_final_M1 <= y_final_M1 - 1;
		else if(enable_y_M1 && (V_M1 == 1))
			y_final_M1 <= y_final_M1 + 1;
	end




//the meteor2
	always@(posedge clk) begin
		if(ld_color_M2) color_M2[2:0] <= data_in_M2[2:0];
	end
	
	reg H_M2, V_M2;	

	always@(*) begin
		if(!resetn) begin
			H_M2 <= 1'b0;
			V_M2 <= 1'b0;
		end
		
		if((x_final_M2 == 9'b0) && (H_M2 == 0))
			H_M2 <= 1;
		else if((x_final_M2 == 9'd303) && (H_M2 == 1))
			H_M2 <= 0;
		
		if((y_final_M2 == 8'b0) && (V_M2 == 0))
			V_M2 <= 1;
		else if((y_final_M2 == 8'd223) && (V_M2 == 1))
			V_M2 <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_M2 <= 9'd240;
		else if(enable_x_M2 && (H_M2 == 0))
			x_final_M2 <= x_final_M2 - 1;
		else if(enable_x_M2 && (H_M2 == 1))
			x_final_M2 <= x_final_M2 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_M2 <= 8'd80;
		else if(enable_y_M2 && (V_M2 == 0))
			y_final_M2 <= y_final_M2 - 1;
		else if(enable_y_M2 && (V_M2 == 1))
			y_final_M2 <= y_final_M2 + 1;
	end
	
//the meteor3
	always@(posedge clk) begin
		if(ld_color_M2) color_M3[2:0] <= data_in_M3[2:0];
	end
	
	reg H_M3, V_M3;	

	always@(*) begin
		if(!resetn) begin
			H_M3 <= 1'b0;
			V_M3 <= 1'b0;
		end
		
		if((x_final_M3 == 9'b0) && (H_M3 == 0))
			H_M3 <= 1;
		else if((x_final_M3 == 9'd303) && (H_M3 == 1))
			H_M3 <= 0;
		
		if((y_final_M3 == 8'b0) && (V_M3 == 0))
			V_M3 <= 1;
		else if((y_final_M3 == 8'd223) && (V_M3 == 1))
			V_M3 <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_M3 <= 9'd160;
		else if(enable_x_M3 && (H_M3 == 0))
			x_final_M3 <= x_final_M3 - 1;
		else if(enable_x_M3 && (H_M3 == 1))
			x_final_M3 <= x_final_M3 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_M3 <= 8'd80;
		else if(enable_y_M3 && (V_M3 == 0))
			y_final_M3 <= y_final_M3 - 1;
		else if(enable_y_M3 && (V_M3 == 1))
			y_final_M3 <= y_final_M3 + 1;
	end
	
	
//the meteor4
	always@(posedge clk) begin
		if(ld_color_M4) color_M4[2:0] <= data_in_M4[2:0];
	end
	
	reg H_M4, V_M4;	

	always@(*) begin
		if(!resetn) begin
			H_M4 <= 1'b0;
			V_M4 <= 1'b0;
		end
		
		if((x_final_M4 == 9'b0) && (H_M4 == 0))
			H_M4 <= 1;
		else if((x_final_M4 == 9'd303) && (H_M4 == 1))
			H_M4 <= 0;
		
		if((y_final_M4 == 8'b0) && (V_M4 == 0))
			V_M4 <= 1;
		else if((y_final_M4 == 8'd223) && (V_M4 == 1))
			V_M4 <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_M4 <= 9'd240;
		else if(enable_x_M4 && (H_M4 == 0))
			x_final_M4 <= x_final_M4 - 1;
		else if(enable_x_M4 && (H_M4 == 1))
			x_final_M4 <= x_final_M4 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_M4 <= 8'd160;
		else if(enable_y_M4 && (V_M4 == 0))
			y_final_M4 <= y_final_M4 - 1;
		else if(enable_y_M4 && (V_M4 == 1))
			y_final_M4 <= y_final_M4 + 1;
	end

	

//the pirate 1
	always@(posedge clk) begin
		if(ld_color_P1) color_P1[2:0] <= data_in_P1[2:0];
	end
	
	reg H_P1, V_P1;	

	always@(*) begin
		if(!resetn) begin
			H_P1 <= 1'b0;
			V_P1 <= 1'b0;
		end
		
		if((x_final_P1 == 9'b0) && (H_P1 == 0))
			H_P1 <= 1;
		else if((x_final_P1 == 9'd303) && (H_P1 == 1))
			H_P1 <= 0;
		
		if((y_final_P1 == 8'b0) && (V_P1 == 0))
			V_P1 <= 1;
		else if((y_final_P1 == 8'd223) && (V_P1 == 1))
			V_P1 <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_P1 <= 9'd300;
		else if(enable_x_P1 && (H_P1 == 0))
			x_final_P1 <= x_final_P1 - 1;
		else if(enable_x_P1 && (H_P1 == 1))
			x_final_P1 <= x_final_P1 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_P1 <= 8'd40;
		else if(enable_y_P1 && (V_P1 == 0))
			y_final_P1 <= y_final_P1 - 1;
		else if(enable_y_P1 && (V_P1 == 1))
			y_final_P1 <= y_final_P1 + 1;
	end
	
	
	
//the pirate 2
	always@(posedge clk) begin
		if(ld_color_P2) color_P2[2:0] <= data_in_P2[2:0];
	end
	
	reg H_P2, V_P2;	

	always@(*) begin
		if(!resetn) begin
			H_P2 <= 1'b0;
			V_P2 <= 1'b0;
		end
		
		if((x_final_P2 == 9'b0) && (H_P2 == 0))
			H_P2 <= 1;
		else if((x_final_P2 == 9'd303) && (H_P2 == 1))
			H_P2 <= 0;
		
		if((y_final_P2 == 8'b0) && (V_P2 == 0))
			V_P2 <= 1;
		else if((y_final_P2 == 8'd223) && (V_P2 == 1))
			V_P2 <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_P2 <= 9'd300;
		else if(enable_x_P2 && (H_P2 == 0))
			x_final_P2 <= x_final_P2 - 1;
		else if(enable_x_P2 && (H_P2 == 1))
			x_final_P2 <= x_final_P2 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_P2 <= 8'd200;
		else if(enable_y_P2 && (V_P2 == 0))
			y_final_P2 <= y_final_P2 - 1;
		else if(enable_y_P2 && (V_P2 == 1))
			y_final_P2 <= y_final_P2 + 1;
	end
	
	
	
//the pirate 3
	always@(posedge clk) begin
		if(ld_color_P3) color_P3[2:0] <= data_in_P3[2:0];
	end
	
	reg H_P3, V_P3;	

	always@(*) begin
		if(!resetn) begin
			H_P3 <= 1'b0;
			V_P3 <= 1'b0;
		end
		
		if((x_final_P3 == 9'b0) && (H_P3 == 0))
			H_P3 <= 1;
		else if((x_final_P3 == 9'd303) && (H_P3 == 1))
			H_P3 <= 0;
		
		if((y_final_P3 == 8'b0) && (V_P3 == 0))
			V_P3 <= 1;
		else if((y_final_P3 == 8'd223) && (V_P3 == 1))
			V_P3 <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_P3 <= 9'd300;
		else if(enable_x_P3 && (H_P3 == 0))
			x_final_P3 <= x_final_P3 - 1;
		else if(enable_x_P3 && (H_P3 == 1))
			x_final_P3 <= x_final_P3 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_P3 <= 8'd80;
		else if(enable_y_P3 && (V_P3 == 0))
			y_final_P3 <= y_final_P3 - 1;
		else if(enable_y_P3 && (V_P3 == 1))
			y_final_P3 <= y_final_P3 + 1;
	end
	
	
//the pirate 4

	always@(posedge clk) begin
		if(ld_color_P4) color_P4[2:0] <= data_in_P4[2:0];
	end
	
	reg H_P4, V_P4;	

	always@(*) begin
		if(!resetn) begin
			H_P4 <= 1'b0;
			V_P4 <= 1'b0;
		end
		
		if((x_final_P4 == 9'b0) && (H_P4 == 0))
			H_P4 <= 1;
		else if((x_final_P4 == 9'd303) && (H_P4 == 1))
			H_P4 <= 0;
		
		if((y_final_P4 == 8'b0) && (V_P4 == 0))
			V_P4 <= 1;
		else if((y_final_P4 == 8'd223) && (V_P4 == 1))
			V_P4 <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_P4 <= 9'd270;
		else if(enable_x_P4 && (H_P4 == 0))
			x_final_P4 <= x_final_P4 - 1;
		else if(enable_x_P4 && (H_P4 == 1))
			x_final_P4 <= x_final_P4 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_P4 <= 8'd200;
		else if(enable_y_P4 && (V_P4 == 0))
			y_final_P4 <= y_final_P4 - 1;
		else if(enable_y_P4 && (V_P4 == 1))
			y_final_P4 <= y_final_P4 + 1;
	end

//the pirate 5
	always@(posedge clk) begin
		if(ld_color_P5) color_P5[2:0] <= data_in_P5[2:0];
	end
	
	reg H_P5, V_P5;	

	always@(*) begin
		if(!resetn) begin
			H_P5 <= 1'b0;
			V_P5 <= 1'b0;
		end
		
		if((x_final_P5 == 9'b0) && (H_P5 == 0))
			H_P5 <= 1;
		else if((x_final_P5 == 9'd303) && (H_P5 == 1))
			H_P5 <= 0;
		
		if((y_final_P5 == 8'b0) && (V_P5 == 0))
			V_P5 <= 1;
		else if((y_final_P5 == 8'd223) && (V_P5 == 1))
			V_P5 <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_P5 <= 9'd30;
		else if(enable_x_P5 && (H_P5 == 0))
			x_final_P5 <= x_final_P5 - 1;
		else if(enable_x_P5 && (H_P5 == 1))
			x_final_P5 <= x_final_P5 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_P5 <= 8'd200;
		else if(enable_y_P5 && (V_P5 == 0))
			y_final_P5 <= y_final_P5 - 1;
		else if(enable_y_P5 && (V_P5 == 1))
			y_final_P5 <= y_final_P5 + 1;
	end



//the pirate 6
	always@(posedge clk) begin
		if(ld_color_P6) color_P6[2:0] <= data_in_P6[2:0];
	end
	
	reg H_P6, V_P6;	

	always@(*) begin
		if(!resetn) begin
			H_P6 <= 1'b0;
			V_P6 <= 1'b0;
		end
		
		if((x_final_P6 == 9'b0) && (H_P6 == 0))
			H_P6 <= 1;
		else if((x_final_P6 == 9'd303) && (H_P6 == 1))
			H_P6 <= 0;
		
		if((y_final_P6 == 8'b0) && (V_P6 == 0))
			V_P6 <= 1;
		else if((y_final_P6 == 8'd223) && (V_P6 == 1))
			V_P6 <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_P6 <= 9'd120;
		else if(enable_x_P6 && (H_P6 == 0))
			x_final_P6 <= x_final_P6 - 1;
		else if(enable_x_P6 && (H_P6 == 1))
			x_final_P6 <= x_final_P6 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_P6 <= 8'd200;
		else if(enable_y_P6 && (V_P6 == 0))
			y_final_P6 <= y_final_P6 - 1;
		else if(enable_y_P6 && (V_P6 == 1))
			y_final_P6 <= y_final_P6 + 1;
	end



//the EARTH

	always@(posedge clk) begin
		if(ld_color_E) color_E[2:0] <= data_in_E[2:0];
	end
	
	reg H_E, V_E;	

	always@(*) begin
		if(!resetn) begin
			H_E <= 1'b0;
			V_E <= 1'b0;
		end
		
		if((x_final_E == 9'b0) && (H_E == 0))
			H_E <= 1;
		else if((x_final_E == 9'd303) && (H_E == 1))
			H_E <= 0;
		
		if((y_final_E == 8'b0) && (V_E == 0))
			V_E <= 1;
		else if((y_final_E == 8'd223) && (V_E == 1))
			V_E <= 0;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final_E <= 9'd170;
		else if(enable_x_E && (H_E == 0))
			x_final_E <= x_final_E - 1;
		else if(enable_x_E && (H_E == 1))
			x_final_E <= x_final_E + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_E <= 8'd120;
		else if(enable_y_E && (V_E == 0))
			y_final_E <= y_final_E - 1;
		else if(enable_y_E && (V_E == 1))
			y_final_E <= y_final_E + 1;
	end







 endmodule                                                 
 
 
 module hexDisplay (input [3:0] segment, output [6:0] light);
    
    assign light[6] = (~segment[3] & ~segment[2] & ~segment[1] & ~segment[0])    |
                     (~segment[3] & ~segment[2] & ~segment[1] & segment[0])    |
                    (~segment[3] & segment[2] & segment[1] & segment[0])      |
                    (segment[3] & segment[2] & ~segment[1] & ~segment[0]);

    assign light[5] = (~segment[3] & ~segment[2] & ~segment[1] & segment[0]) |
                    (~segment[3] & ~segment[2] & segment[1] & ~segment[0])    |
                    (~segment[3] & ~segment[2] & segment[1] & segment[0])     |
                    (~segment[3] & segment[2] & segment[1] & segment[0])      |
                    (segment[3] & segment[2] & ~segment[1] & segment[0]);
    
    assign light[4] = (~segment[3] & ~segment[2] & ~segment[1] & segment[0]) |
                    (~segment[3] & ~segment[2] & segment[1] & segment[0])     |
                    (~segment[3] & segment[2] & ~segment[1] & ~segment[0])    |
                    (~segment[3] & segment[2] & ~segment[1] & segment[0])     |
                    (~segment[3] & segment[2] & segment[1] & segment[0])      |
                    (segment[3] & ~segment[2] & ~segment[1] & segment[0]);
    
    assign light[3] = (~segment[3] & ~segment[2] & ~segment[1] & segment[0]) |
                    (~segment[3] & segment[2] & ~segment[1] & ~segment[0])    |
                    (~segment[3] & segment[2] & segment[1] & segment[0])      |
                    (segment[3] & ~segment[2] & segment[1] & ~segment[0])     |
                    (segment[3] & segment[2] & segment[1] & segment[0]); 
    
    assign light[2] = (~segment[3] & ~segment[2] & segment[1] & ~segment[0]) |
                    (segment[3] & segment[2] & ~segment[1] & ~segment[0])     |
                    (segment[3] & segment[2] & segment[1] & ~segment[0])      |
                    (segment[3] & segment[2] & segment[1] & segment[0]);
    
    assign light[1] = (~segment[3] & segment[2] & ~segment[1] & segment[0])      |
                    (~segment[3] & segment[2] & segment[1] & ~segment[0])     |
                    (segment[3] & ~segment[2] & segment[1] & segment[0])      |
                    (segment[3] & segment[2] & ~segment[1] & ~segment[0])     |
                    (segment[3] & segment[2] & segment[1] & ~segment[0])      |
                    (segment[3] & segment[2] & segment[1] & segment[0]); 
                          
    assign light[0] = (~segment[3] & ~segment[2] & ~segment[1] & segment[0]) |
                    (~segment[3] & segment[2] & ~segment[1] & ~segment[0])    |
                    (segment[3] & ~segment[2] & segment[1] & segment[0])      |
                    (segment[3] & segment[2] & ~segment[1] & segment[0]); 
    
    
endmodule
