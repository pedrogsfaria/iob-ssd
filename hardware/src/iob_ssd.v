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
   `IOB_OUTPUT(ssd_dp, 1), 	 //Decimal point "active low"   
   `IOB_OUTPUT(ssd_seg, 7), 	 //Segment signal
   
`include "iob_gen_if.vh"
   );

//BLOCK Register File & Configuration control and status register file.
`include "iob_ssd_swreg_gen.vh"

    // SWRegs   
   `IOB_WIRE(SSD_RATE, 32)
    iob_reg #(.DATA_W(32), .RST_VAL(0))
    ssd_rate (
        .clk        (clk),
        .arst       (rst),
        .rst        (rst),
        .en         (SSD_RATE_en),
        .data_in    (SSD_RATE_wdata),
        .data_out   (SSD_RATE)
    );

   `IOB_WIRE(SSD_DATA_IN, 16)
    iob_reg #(.DATA_W(16), .RST_VAL(0))
    ssd_data_in (
        .clk        (clk),
        .arst       (rst),
        .rst        (rst),
        .en         (SSD_DATA_IN_en),
        .data_in    (SSD_DATA_IN_wdata),
        .data_out   (SSD_DATA_IN)
    );

   // Seven_segment instantiation
   ssd ssd_core
     (
      .clk (clk),
      .rst (rst),
      .rate (SSD_RATE),
      .data_in (SSD_DATA_IN),
      .anode (ssd_anode),
      .dp (ssd_dp),
      .seg (ssd_seg)
      );			     

endmodule
