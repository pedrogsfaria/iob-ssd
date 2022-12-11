   //
   // SSD
   //

   iob_ssd ssd
     (
      .clk     (clk),
      .rst     (rst),

      // Registers interface
      //.ssd_data_in (ssd_data_in),
      .ssd_anode (ssd_anode),
      .ssd_seg (ssd_seg),

      // CPU interface
      .valid   (slaves_req[`valid(`SSD)]),
      .address (slaves_req[`address(`SSD,`iob_ssd_swreg_ADDR_W+2)-2]),
      .wdata   (slaves_req[`wdata(`SSD)]),
      .wstrb   (slaves_req[`wstrb(`SSD)]),
      .rdata   (slaves_resp[`rdata(`SSD)]),
      .ready   (slaves_resp[`ready(`SSD)])
      );
