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
	
	
	control_top c1(CLOCK_50, resetn, load, 

				   DD, DE, up, down, left, right,
				   DD_M, DE_M,
				   DD_M1, DE_M1,
				   DD_M2, DE_M2,

				   SD, SE, enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right,
				   SD_M, SE_M, enable_x_M, enable_y_M, ld_color_M, 
				   SD_M1, SE_M1, enable_x_M1, enable_y_M1, ld_color_M1, 
				   SD_M2, SE_M2, enable_x_M2, enable_y_M2, ld_color_M2, 

				   state);
	
	datapath_top d1(CLOCK_50, resetn, 

					SW[2:0], enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right, 
					SW[2:0], enable_x_M, enable_y_M, ld_color_M,
					SW[2:0], enable_x_M1, enable_y_M1, ld_color_M1,
					SW[2:0], enable_x_M2, enable_y_M2, ld_color_M2,

					X, Y, color,
					X_M, Y_M, color_M,
					X_M1, Y_M1, color_M1,
					X_M2, Y_M2, color_M2

					);

	fill D1(CLOCK_50, resetn, 

			X, Y, color, SD, SE, 
			X_M, Y_M, color_M, SD_M, SE_M,
			X_M1, Y_M1, color_M1, SD_M1, SE_M1,
			X_M2, Y_M2, color_M2, SD_M2, SE_M2,

			DD, DE, 
			DD_M, DE_M,
			DD_M1, DE_M1,
			DD_M2, DE_M2,

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
 					input iDD_M, iDE_M, 
 					input iDD_M1, iDE_M1, 
 					input iDD_M2, iDE_M2, 


					output reg oSD, oSE, enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right, 
					output reg oSD_M, oSE_M, enable_x_M, enable_y_M, ld_color_M,
					output reg oSD_M1, oSE_M1, enable_x_M1, enable_y_M1, ld_color_M1,
					output reg oSD_M2, oSE_M2, enable_x_M2, enable_y_M2, ld_color_M2,

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

					 
				S_IDLE             = 8'd9,
					 
				//these are the spaceship states	 
				S_ERASE        	   = 8'd10,
				S_ACKERASE         = 8'd11,
					 
				S_MOVE			   = 8'd12,
					 
            	S_DRAW             = 8'd13,
				S_ACKDRAW          = 8'd14,

				//these are other sprites states******************************************

				//these is the meteor
				S_ERASE_M          = 8'd15,
				S_ACKERASE_M       = 8'd16,
					 
				S_MOVE_M		   = 8'd17,
					 
            	S_DRAW_M           = 8'd18,
				S_ACKDRAW_M        = 8'd19,


				//these is the meteor1
				S_ERASE_M1          = 8'd20,
				S_ACKERASE_M1       = 8'd21,
					 
				S_MOVE_M1		   = 8'd22,
					 
            	S_DRAW_M1           = 8'd23,
				S_ACKDRAW_M1        = 8'd24,

				//these is the meteor2
				S_ERASE_M2          = 8'd25,
				S_ACKERASE_M2       = 8'd26,
					 
				S_MOVE_M2		   = 8'd27,
					 
            	S_DRAW_M2           = 8'd28,
				S_ACKDRAW_M2        = 8'd29,


					 
            	S_WAIT             = 8'd30;
					 			
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
					
					S_INACKDRAW_M2: next_state = S_IDLE;

					 
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
					S_ACKDRAW_M2:   next_state = S_WAIT;

				 				 
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
		  oSD_M2      = 1'b0;
		  oSE_M2      = 1'b0;



       	  
        case (current_state)
		  
			S_RESET: begin
				ld_color = 1'b1;
				ld_color_M = 1'b1;
				ld_color_M1 = 1'b1;
				ld_color_M2 = 1'b1;
			end
				
			S_INDRAW:    oSD = 1'b1;
			S_INACKDRAW: oSD = 1'b0;

			S_INDRAW_M:    oSD_M = 1'b1;
			S_INACKDRAW_M: oSD_M = 1'b0;

			S_INDRAW_M1:    oSD_M1 = 1'b1;
			S_INACKDRAW_M1: oSD_M1 = 1'b0;

			S_INDRAW_M2:    oSD_M2 = 1'b1;
			S_INACKDRAW_M2: oSD_M2 = 1'b0;




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

					x_final, y_final, color,

					x_final_M, y_final_M, color_M,

					x_final_M1, y_final_M1, color_M1,
					x_final_M2, y_final_M2, color_M2
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
			x_final_M1 <= 9'd280;
		else if(enable_x_M1 && (H_M1 == 0))
			x_final_M1 <= x_final_M1 - 1;
		else if(enable_x_M1 && (H_M1 == 1))
			x_final_M1 <= x_final_M1 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_M1 <= 8'd80;
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
			x_final_M2 <= 9'd80;
		else if(enable_x_M2 && (H_M2 == 0))
			x_final_M2 <= x_final_M2 - 1;
		else if(enable_x_M2 && (H_M2 == 1))
			x_final_M2 <= x_final_M2 + 1;
	end
	
	always@(posedge clk) begin
		if(!resetn)
			y_final_M2 <= 8'd180;
		else if(enable_y_M2 && (V_M2 == 0))
			y_final_M2 <= y_final_M2 - 1;
		else if(enable_y_M2 && (V_M2 == 1))
			y_final_M2 <= y_final_M2 + 1;
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
