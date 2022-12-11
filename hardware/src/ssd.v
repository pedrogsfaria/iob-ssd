/*
 * file    seven_segment
 * date    December 2022
 * 
 * brief   Seven-Segment Display (SSD) driver.
 * 
 * This code is a modification to FPGA4student approach.
*/
`timescale 1ns/1ps

module ssd  
   (
    input 	     clk,
    input 	     rst,
    input [15:0]     data_in,    // Only uses 14
    output reg [3:0] anode, 
    output reg [7:0] seg     
    ); 


   // Implement verilog logic   

endmodule
