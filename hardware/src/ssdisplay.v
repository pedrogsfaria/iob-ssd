/*
 * file    ssdisplay.v
 * date    December 2022
 * 
 * brief   Seven-Segment Display (SSD) update module.
 * 
 * This code is a modification to FPGA4student approach.
*/
`timescale 1ns/1ps
`include "iob_ssd_swreg_def.vh"

module ssdisplay  
   (    
    input 		    clk,
    input 		    rst, 
    input [`SSD_RATE_W-1:0] rate, 
    input [6:0] 	    seg0, 
    input [6:0] 	    seg1,
    input [6:0] 	    seg2,
    input [6:0] 	    seg3,
 
    output reg [3:0] 	    anode,
    output 		    dp,	
    output reg [6:0] 	    seg 
    );

   assign dp = 1; // Switch off decimal point

   reg [`SSD_RATE_W-1:0]    counter;   
   reg [1:0] 		    seg_counter;
   
    
   // Generation of Seven Segment refresh signal (clock division)
   always @(posedge(clk) or posedge(rst)) 
     begin
	if(rst == 1 || rate == 0) begin
	   	   
	   counter <= 0;
	   seg_counter <= 0;
	end
	else if(counter == rate - 1) begin
	   counter <= 0;
	   seg_counter <= seg_counter + 1;	   
	end
	else
	  counter <= counter + 1;
     end // always @ (posedge(clk) or posedge(rst))


   // Generation of anode and seg signals
   always @(seg_counter)
     begin
	case(seg_counter)	  
	  2'b00: begin // Turn on Segment 3
	     anode <= 4'b0111;
	     seg <= seg3;
	  end
	  2'b01: begin // Turn on Segment 2
	     anode <= 4'b1011;
	     seg <= seg2;
	  end
	  2'b10: begin // Turn on Segment 1
	     anode <= 4'b1101;
	     seg <= seg1;
	  end
	  2'b11: begin // Turn on Segment 0
	     anode <= 4'b1110;
	     seg <= seg0;
	  end
	endcase // case (seg_counter)
     end // always @ (*)
   
endmodule // ssdisplay

   

   
