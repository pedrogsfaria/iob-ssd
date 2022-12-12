/*
 * file    seven_segment
 * date    December 2022
 * 
 * brief   Seven-Segment Display (SSD) driver.
*/
`timescale 1ns/1ps
`include "iob_ssd_swreg_def.vh"

module ssd  
   (
    input 		       clk,
    input 		       rst,
    
    input [`SSD_RATE_W-1:0]    rate, 
    input [`SSD_DATA_IN_W-1:0] data_in, 

    output 		       dp, 
    output reg [3:0] 	       anode,    
    output reg [6:0] 	       seg     
    );   
   
   // Wires
   wire [6:0] 		       seg0;
   wire [6:0] 		       seg1;   
   wire [6:0] 		       seg2;   
   wire [6:0] 		       seg3;
   
   // Modules instance 
   ssdisplay display
     (
      .clk (clk),
      .rst (rst),

      .rate (rate),
      .seg0 (seg0),
      .seg1 (seg1),
      .seg2 (seg2),
      .seg3 (seg3),
      
      .anode (anode),
      .dp (dp),
      .seg (seg)
      );
   
   hex2ssd i0
     (
      .bcd_number (data_in[3:0]),
      .seg (seg0)
      );

   hex2ssd i1
     (
      .bcd_number (data_in[7:4]),
      .seg (seg1)
      );

   hex2ssd i2
     (
      .bcd_number (data_in[11:8]),
      .seg (seg2)
      );

   hex2ssd i3
     (
      .bcd_number (data_in[15:12]),
      .seg (seg3)
      );

endmodule // ssd

