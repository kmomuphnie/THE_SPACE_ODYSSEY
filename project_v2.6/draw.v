
module fill(CLOCK_50, resetn, 

			x_input, y_input, color_input, iSD, iSE, 
			x_input_M, y_input_M, color_input_M, iSD_M, iSE_M,
			x_input_M1, y_input_M1, color_input_M1, iSD_M1, iSE_M1,
			x_input_M2, y_input_M2, color_input_M2, iSD_M2, iSE_M2,

			oDD, oDE, 
			oDD_M, oDE_M,
			oDD_M1, oDE_M1,
			oDD_M2, oDE_M2,

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
	


	output reg oDD;
	output reg oDE;

	output reg oDD_M;
	output reg oDE_M;

	output reg oDD_M1;
	output reg oDE_M1;

	output reg oDD_M2;
	output reg oDE_M2;
	


	
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
	





	control c1(CLOCK_50, resetn,

			   iSD, iSE, 

			   iSD_M, iSE_M,
			   iSD_M1, iSE_M1,
			   iSD_M2, iSE_M2,

			   DD, DE, ld_x, ld_y, count_enable, black_enable,

			   DD_M, DE_M,ld_x_M, ld_y_M, count_enable_M, black_enable_M,
			   DD_M1, DE_M1,ld_x_M1, ld_y_M1, count_enable_M1, black_enable_M1,
			   DD_M2, DE_M2,ld_x_M2, ld_y_M2, count_enable_M2, black_enable_M2,

			   writeEn);
	
	
	datapath d1(CLOCK_50, resetn, 

				x_input, y_input, color_input, ld_x, ld_y, count_enable, black_enable, 

				x_input_M, y_input_M, color_input_M, ld_x_M, ld_y_M, count_enable_M, black_enable_M, 
				x_input_M1, y_input_M1, color_input_M1, ld_x_M1, ld_y_M1, count_enable_M1, black_enable_M1, 
				x_input_M2, y_input_M2, color_input_M2, ld_x_M2, ld_y_M2, count_enable_M2, black_enable_M2, 

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



			   output reg oDD, oDE, ld_x, ld_y, count_enable,black_enable, 
			   output reg oDD_M, oDE_M, ld_x_M, ld_y_M, count_enable_M,black_enable_M,
			   output reg oDD_M1, oDE_M1, ld_x_M1, ld_y_M1, count_enable_M1,black_enable_M1,
			   output reg oDD_M2, oDE_M2, ld_x_M2, ld_y_M2, count_enable_M2,black_enable_M2,

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
	    
    localparam  S_IDLE            		= 8'd0,

                S_PLOT        			= 8'd1,
				S_ERASE					= 8'd2,
				S_FinishDraw			= 8'd3,
				S_FinishErase			= 8'd4, 

				S_PLOT_M        		= 8'd5,
				S_ERASE_M				= 8'd6,
				S_FinishDraw_M			= 8'd7,
				S_FinishErase_M			= 8'd8,

				S_PLOT_M1        		= 8'd9,
				S_ERASE_M1				= 8'd10,
				S_FinishDraw_M1			= 8'd11,
				S_FinishErase_M1		= 8'd12,

				S_PLOT_M2        		= 8'd13,
				S_ERASE_M2				= 8'd14,
				S_FinishDraw_M2			= 8'd15,
				S_FinishErase_M2		= 8'd16;


					 
					 
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
        case (current_state)
				
        S_IDLE:begin
					if((iSD == 0) && (iSE == 0) && (iSD_M == 0) && (iSE_M == 0) && (iSD_M1 == 0) && (iSE_M1 == 0)&& (iSD_M2 == 0) && (iSE_M2 == 0))
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


		  
        else begin
            if(ld_x) x_start[8:0] <= X[8:0]; // IDLE x from data_in
            if(ld_y) y_start[7:0] <= Y[7:0]; // IDLE y from data_in

            if(ld_x_M)  x_start_M[8:0] <= X_M[8:0]; // IDLE x from data_in
            if(ld_y_M)  y_start_M[7:0] <= Y_M[7:0]; // IDLE y from data_in

            if(ld_x_M1)  x_start_M1[8:0] <= X_M1[8:0]; // IDLE x from data_in
            if(ld_y_M1)  y_start_M1[7:0] <= Y_M1[7:0]; // IDLE y from data_in

            if(ld_x_M2)  x_start_M2[8:0] <= X_M2[8:0]; // IDLE x from data_in
            if(ld_y_M2)  y_start_M2[7:0] <= Y_M2[7:0]; // IDLE y from data_in

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

	end    
	
endmodule
