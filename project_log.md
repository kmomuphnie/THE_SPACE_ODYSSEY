11.7.2017 First meeting 7:32pm-21:22pm Tuesday

	-set the project name
	-project description done
	-briefly draw the block diagram
	-set the project proposal and milestones

11.8.2017 7:30pm-7:38pm meeting with TA Wednesday 

	-went through the project proposal
	-confirm several details of the project
	-figure how to use the memory
	-adjust sequence of project contents priority 

11.12.2017 2:00pm-7:30pm dongfang cui  Sunday

	-designed the general diagram for the stem FSM
	-modified the part 3 code 
	-generalized the square code
	-successfully let the square controlled by arrow keys
	-BUG: strangely stop and back to reset sate: Solved, maybe latch or default state is wrong
	1:00PM - 6:00PM Sunday Barton Dong
design the 320 x 240 pixel image of spaceship, pirateship, asteriod, planet, earth, map
convert the bmp to mif type.

11.13.2017 11:30-15:00 dongfang Cui, monday

	-imported the spaceship image into the SRAM
	-SRAM read successfully
	-transferred the white square to the spaceship
	-successfully let the spaceship controlled by arrow keys
BUG report: seperate direction control may cause state change to RESET

11.13.2017 15:10-16:00  first milestone lab, monday

	-demo the spaceship with arrow keys to TA
	-change the default state from reset to IDLE to fix the control bug, 

11.14.2017 Tuesday 12:40-13:50 DCdongfang CUI
	-scale the screen size from 160x120 to 320x240
	BUG: encounted strange move boundary probelm
		         18:00-19:00 DC Barton Dong
learn about the PS2 keyboard interface with FPGA
implement the keyboard verilog module in the top level
Result: pass compilation but no significant output on the screen

11.15.2017 Wed 12:30-1:55DC dongfang CUI

	-tried to find a way to draw the two sprite and the hero in 1 loop
	-figured out two ways
	-to be implemented
	
	3:00 - 4:00 DC Barton Dong
working on our own keyboard, the signal does not match further hardware driver needed
switch from module style to a always block inside the control module
	5:00 - 6:00 DC Barton Dong
finish the keyboard interface verilog code and successfully compile
keyboard worked in the DE1-SOC board to control spaceship moving around 
modify the bmp picture for all sprite	

11.16.2017 Thur dongfang cui

	23:00-2:46
	-replot the diagram of extendable modules
	-tried to merge the part3_revised and the spaceship code
	
11.17.2017 Fri dongfang cui

	19:00-24:00
	-merged code passed the compilation not tested




