
module fill(CLOCK_50, x_input, y_input, color_input, resetn, go, clear, iSD, iSE, oDD, oDE, VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B);

	input	CLOCK_50;				//	50 MHz
	// Declare your inputs and outputs here	
	input [7:0] x_input;
	input [6:0] y_input;
	input [2:0] color_input;
	input resetn, go, clear;
	
	
	input iSD;
	input iSE;
	
	output reg oDD;
	output reg oDE;
	
	
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

	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;
	wire [2:0] color;
	
	wire ld_x, ld_y, count_enable, black_enable;
	
	
	wire DD, DE;
	always @(*)begin
		 oDD = DD;
	    oDE = DE;
	end
	
	
	control c1(CLOCK_50, resetn, go, clear, iSD, iSE, DD, DE, ld_x, ld_y, count_enable, black_enable, writeEn);
	
	datapath d1(CLOCK_50, resetn, x_input, y_input, color_input, ld_x, ld_y, count_enable, black_enable, color, x, y);
			
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
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";		
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.	
endmodule

module control(input clk, resetn, go, clear, iSD, iSE,
					output reg oDD, oDE, ld_x, ld_y, count_enable,black_enable, plot);
	
	 reg [3:0] current_state, next_state; 
	 reg [4:0] count;
	 reg [4:0] black_count;
	    
    localparam  S_IDLE            	= 4'd0,
                S_PLOT        		= 4'd1,
					 S_ERASE					= 4'd2,
					 S_FinishDraw			= 4'd3,
					 S_FinishErase		   = 4'd4;
					 
					 
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
            case (current_state)
				
                S_IDLE:begin
						if((iSD == 0) && (iSE == 0)) next_state = S_IDLE;						
						else begin
							if(iSE == 1) next_state = S_ERASE;
					      if(iSD == 1) next_state = S_PLOT;
						end
					 end
					 
                S_PLOT:        next_state = (count == 5'd16)? S_FinishDraw : S_PLOT; // Loop in current state until value is input									 
					 
					 S_FinishDraw:  next_state =  iSD ? S_FinishDraw : S_IDLE;
					 
					 S_ERASE:       next_state = (black_count == 5'd16)? S_FinishErase : S_ERASE;
					 
					 S_FinishErase: next_state = iSE ? S_FinishErase : S_IDLE;
					 
					default:        next_state = S_IDLE;
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
		  
		  
		  
        case (current_state)
            S_IDLE: begin
                ld_x = 1'b1;
					 ld_y = 1'b1;
					 oDD = 1'b0;
					 oDE = 1'b0;
                end

            S_PLOT: begin
                count_enable = 1'b1;
					 plot = 1'b1;
                end
            S_FinishDraw: begin
                oDD = 1'b1;
                end
				
				S_ERASE: begin
                black_enable = 1'b1;
					 plot = 1'b1;
                end
					 
            S_FinishErase: begin
                oDE = 1'b1;
                end
					 
					 
        endcase
    end // enable_signals

    always@(posedge clk)
    begin: state_FFs
	 
        if(!resetn)
				begin
					current_state <= S_IDLE;
					count <= 5'b0;
					black_count <= 5'b0;
				end
				
        else if((current_state == S_PLOT) && (count != 5'd16))
				begin
				current_state <= next_state;
				count <= count + 1'b1;
				end
				
	     else if((current_state == S_ERASE) && (black_count != 5'd16))
				begin
				current_state <= next_state;
				black_count <= black_count + 1'b1;
				end
				
		  else if(current_state == S_IDLE)
				begin
					current_state <= next_state;
					count <= 5'b0;
					black_count <= 5'b0;					
				end
		  else
				current_state <= next_state;
			
    end // state_FFS
endmodule




module datapath(
    input clk,
    input resetn,
	 input [7:0] X,
    input [6:0] Y,
	 input [2:0] color_input,
    input ld_x, ld_y,
	 input count_enable, black_enable,
	 output reg [2:0] color,
    output reg [7:0] x_final,
	 output reg [6:0] y_final
    );
    
    // input registers
    reg [7:0] x_start;
	 reg [6:0] y_start;
	 reg [3:0] count;
	 reg [3:0] black_count;
	 reg first, black_first;

    // Registers a, b, c, x with respective input logic
    always@(posedge clk) begin
	 
        if(!resetn) begin
            x_start <= 8'b0; 
            y_start <= 7'b0;
				color   <= 3'b0;
        end
		  
		  else if(black_enable)begin
			//when u want to be cool
			color = 3'b000;
		   //change the code above
		  end
		  
		  else if(count_enable) color[2:0] = color_input[2:0];
		  
        else begin
            if(ld_x) 
					x_start[7:0] <= X[7:0]; // IDLE x from data_in
            if(ld_y) begin
               y_start[6:0] <= Y[6:0]; // IDLE y from data_in
//					color[2:0] <= color_input[2:0];
				end
        end
    end
 
    // counter to change x and y coordinate or clear to black
	always @(posedge clk)
	begin
	
		if (!resetn) begin
			count[3:0] = 4'b0;
			first = 1'b1;
			black_first = 1'b1;
			black_count[3:0] = 4'b0;			
		end

		
		else if(first) begin
			count[3:0] = 4'b0;
			first = 1'b0;
		end	
	
		else if (count_enable)
			count[3:0] = count + 1;	
		
		
		else if(black_first)begin
			black_count[3:0] = 4'b0;
			black_first = 1'b0;
		end
	
		else if (black_enable)
			black_count[3:0] = black_count[3:0] + 1;	
	end
	
	
	 // counter to change x and y coordinate
	always @(posedge clk)
	begin
	if (!resetn)
		begin
		x_final[7:0] <= 8'b0;
		y_final[6:0] <= 7'b0;
	end
		
		
   else if (black_enable)
	begin
		x_final[7:0] <= x_start + black_count[1:0];
		y_final[6:0] <= y_start + black_count[3:2];

	end	
	else if (count_enable)
		begin
		x_final[7:0] <= x_start + count[1:0];
		y_final[6:0] <= y_start + count[3:2];
		end
	end    
	
endmodule
