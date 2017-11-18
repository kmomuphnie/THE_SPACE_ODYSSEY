module STEM(CLOCK_50, KEY, SW, VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B, HEX0, HEX1, HEX2, HEX3, HEX4);

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
	
	wire resetn, load;
	assign load = ~KEY[1];
	assign resetn = KEY[0];
	wire [2:0] color;
	wire [7:0] X;
	wire [6:0] Y;
	wire enable_x, enable_y, ld_color, erase, go;
   wire DD, DE, SD, SE;
	
	wire up, down, left, right;
	assign up    = SW[9];
	assign down  = SW[8];
	assign left  = SW[7];
	assign right = SW[6];
	
	wire move_up, move_down, move_left, move_right;
	wire [3:0]state;
	
	control_top c2(CLOCK_50, resetn, load, DD, DE, up, down, left, right ,SD, SE, enable_x, enable_y, ld_color, erase, go, move_up, move_down, move_left, move_right, state);
	
	datapath_top d2(CLOCK_50, resetn, SW[2:0], enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right, X, Y, color);
	
	fill D1(CLOCK_50, X, Y, color, resetn, go, erase, SD, SE, DD, DE, VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B);
	
	hexDisplay H0(X[3:0], HEX0[6:0]);
	hexDisplay H1(X[7:4], HEX1[6:0]);
	hexDisplay H2(Y[3:0], HEX2[6:0]);
	hexDisplay H3({1'b0,Y[6:4]}, HEX3[6:0]);
	hexDisplay H4(state[3:0], HEX4[6:0]);
	
	
	
 endmodule
 
 module control_top(input clk, resetn, load, iDD, iDE, up, down, left, right,
						  output reg oSD, oSE, enable_x, enable_y, ld_color, erase, go, move_up, move_down, move_left, move_right, output reg [3:0]state);
	 reg [3:0] current_state, next_state; 
	 reg [27:0] count;
	 reg [27:0] ecount;
	    
    localparam  S_RESET            = 4'd0,
	 
					 S_INDRAW           = 4'd1,
					 S_INACKDRAW        = 4'd2,
					 
					 S_IDLE             = 4'd3,
					 
					 S_MOVE_SIGNAL      = 4'd4,
					 
					 S_ERASE        	  = 4'd5,
					 S_ACKERASE         = 4'd6,
					 S_EWAIT            = 4'd7,
					 
					 S_MOVE			     = 4'd8,
					 
                S_DRAW             = 4'd9,
					 S_ACKDRAW          = 4'd10,
					 
                S_WAIT             = 4'd11;
					 			
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
				state[3:0] = current_state[3:0];
            case (current_state)
				    S_RESET:       next_state = load ? S_INDRAW : S_RESET;
					 
                S_INDRAW:      next_state = iDD ? S_INACKDRAW : S_INDRAW;
					 S_INACKDRAW:   next_state = S_IDLE;
					 
					 S_IDLE:        next_state = ( (up == 1)||(down == 1)||(left == 1)||(right == 1) ) ? S_ERASE : S_IDLE;
					 
//					 S_MOVE_SIGNAL: next_state = S_ERASE;
					 
					 S_ERASE:       next_state = iDE ? S_ACKERASE : S_ERASE;
					 S_ACKERASE:    next_state = ( (up == 1)||(down == 1)||(left == 1)||(right == 1) ) ? S_MOVE : S_ACKERASE;
					 
//					 S_EWAIT:       next_state = (ecount == 28'd20000)? S_MOVE : S_EWAIT;//28'd1666666
					 
					 S_MOVE:			 next_state = S_DRAW;
					 
					 S_DRAW:        next_state = iDD ? S_ACKDRAW : S_DRAW;
					 S_ACKDRAW:     next_state = S_WAIT;
					 				 
                S_WAIT :       next_state = (count ==  28'd24_999_999)? S_IDLE : S_WAIT;//wait 0.5s  28'd10000000
		 
					 default:       next_state = S_RESET;
				endcase	
    end // state_table

	 // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
		  enable_x = 1'b0; 
		  enable_y = 1'b0; 
		  ld_color = 1'b0;
		  erase    = 1'b0; 
		  go       = 1'b0;
		  oSD      = 1'b0;
		  oSE      = 1'b0;
		  move_up  = 1'b0;
		  move_down= 1'b0;
		  move_left= 1'b0; 
		  move_right=1'b0;
       	  
        case (current_state)
		  
				S_RESET: begin
						ld_color = 1'b1;
				end
				
				S_INDRAW:    oSD = 1'b1;
				S_INACKDRAW: oSD = 1'b0;
							
				
//				S_IDLE :
				
            S_ERASE:  begin
					//erase    = 1'b1; //only need to erase to trigger the erase process
//					go       = 1'b1;
				   oSE = 1'b1;
				end
				
				S_ACKERASE: oSE = 1'b0;
							
				
			   S_MOVE:	begin
								if(up) move_up = 1;
								else if(down) move_down = 1;
								else if(left) move_left = 1;
								else if(right) move_right = 1;

				end
				
				S_DRAW:     oSD = 1'b1;
				S_ACKDRAW:  oSD = 1'b0;
				
        endcase
    end // enable_signals

    always@(posedge clk)
    begin: state_FFs
	 
        if(!resetn)
				begin
					current_state <= S_RESET;
					count <= 28'd0;  
					ecount <= 28'd0;
				end
				
        else if((current_state == S_WAIT) && (count != 28'd24_999_999))//count != 28'd12500000
				begin
				current_state <= next_state;
				count <= count + 1'b1;
				end
				
		  else if((current_state == S_EWAIT) && (ecount != 28'd20000))//ecount != 28'd1666666
				begin
				current_state <= next_state;
				ecount <= ecount + 1'b1;
			end
				
		  else if(current_state == S_ERASE)
				begin
					current_state <= next_state;
					count <= 28'd0;
					ecount <= 28'd0;
				end
				
		  else
				current_state <= next_state;
			
    end // state_FFS
endmodule
 
 
 
module datapath_top(clk, resetn, data_in, enable_x, enable_y, ld_color, move_up, move_down, move_left, move_right, x_final, y_final, color);
	input clk, resetn, enable_x, enable_y, ld_color;
	input [2:0] data_in;
	input move_up, move_down, move_left, move_right;
	output reg [7:0] x_final;
	output reg [6:0] y_final;
	output reg [2:0] color;
	
	reg H, V;
	
	always@(posedge clk) begin
		if(ld_color) color[2:0] <= data_in[2:0];
	end
	
//	always@(*) begin
//		if(!resetn) begin
//			H <= 1'b0;
//			V <= 1'b0;
//		end
//		
//		if((x_final == 8'b0) && (H == 0))
//			H <= 1;
//		else if((x_final == 8'd156) && (H == 1))
//			H <= 0;
//		
//		if((y_final == 7'b0) && (V == 0))
//			V <= 1;
//		else if((y_final == 7'd116) && (V == 1))
//			V <= 0;
//	end
	
	always@(posedge clk) begin
		if(!resetn)
			x_final <= 8'd0;
			
		else if(move_left == 1) begin
			if(x_final == 8'd0) x_final = 8'd156;
			else x_final = x_final - 4;
			
		end
		
		else if(move_right == 1) begin
			if(x_final == 8'd156) x_final = 8'd0;
			else x_final = x_final + 4;
		end
	end
	
	
	always@(posedge clk) begin
		if(!resetn)
			y_final <= 7'd0;
			
		else if(move_up == 1)begin	
			if(y_final == 7'd0) y_final = 7'd116;
			else y_final <= y_final - 4;
		end
		
		else if(move_down == 1)begin
			if(y_final == 7'd116) y_final = 7'd0;
			else y_final <= y_final + 4;
		end
		
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
 
 
 
 module rateDivider(input clk, input clear_n, output reg result);
	reg [28:0]count;
   wire enable;
	reg [28:0]number;
	
	always @(*)
	begin
		number[28:0] = 28'd833334;
	end

  assign enable = (count == number[28:0])? 1'b1 : 1'b0;

 //when count is equal to the number, enable is 1, reset the count, pass out the enable to the 4-bits counter
  always @ (posedge clk) begin
    if(enable == 1'b1 | clear_n == 1'b0)
      count <= 0; // reset
		
    else if(enable == 1'b0)
      count <= count + 1; // count
  end

  
  	always@(*)begin
		result = enable;
	end
endmodule
