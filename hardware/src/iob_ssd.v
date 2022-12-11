/*
 * file    iob_seven_segment
 * date    December 2022
 * 
 * brief   Seven-Segment Display (SSD) driver Wrapper.
*/
`timescale 1ns/1ps

`include "iob_lib.vh"
`include "iob_ssd_swreg_def.vh"

module iob_ssd 
  # (
     parameter DATA_W = 32,        //PARAM & 32 & 64 & CPU data width
     parameter ADDR_W = `iob_ssd_swreg_ADDR_W 	//CPU address section width     
     )

  (

   //CPU interface
`include "iob_s_if.vh"

   //additional inputs and outputs
   `IOB_OUTPUT(ssd_anode, 4), 	 //Anode selection
   `IOB_OUTPUT(ssd_seg, 8), 	 //Segment signal
   
`include "iob_gen_if.vh"
   );

//BLOCK Register File & Configuration control and status register file.
`include "iob_ssd_swreg_gen.vh"

    // SWRegs
    `IOB_WIRE(SSD_TXDATA, 16)
    iob_reg #(.DATA_W(16), .RST_VAL(0))
    ssd_txdata (
        .clk        (clk),
        .arst       (rst),
        .rst        (rst),
        .en         (SSD_TXDATA_en),
        .data_in    (SSD_TXDATA_wdata),
        .data_out   (SSD_TXDATA)
    ); 

   // Seven_segment instantiation
   ssd ssd_core
     (
      .clk (clk),
      .rst (rst),
      .data_in (SSD_TXDATA),
      .anode (ssd_anode),
      .seg (ssd_seg)
      );			     

endmodule
