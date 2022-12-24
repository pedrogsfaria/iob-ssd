`timescale 1ns/1ps


module ssd_tb;

   parameter clk_frequency = 100e6; //100 MHz
   parameter clk_per = 1e9/clk_frequency;

   parameter data = 'h012A;   
   parameter seg3 = 7'b0000001; //0
   parameter seg2 = 7'b1001111; //1
   parameter seg1 = 7'b0010010; //2
   parameter seg0 = 7'b0000010; //A
   
   
   //iterator
   integer               i;
   integer               count;
		 

   // CORE SIGNALS
   reg 			rst;
   reg 			clk;
   
   //control interface (backend)
   reg [`SSD_RATE_W-1:0]	rate;
   reg [`SSD_DATA_IN_W-1:0]	data_in;
      
   //ssd interface (frontend)
   wire                  dp;
   wire [3:0]            anode;
   wire [6:0]		 seg;
      

   initial begin

`ifdef VCD
      $dumpfile("uut.vcd");
      $dumpvars;
`endif
      
      clk = 1;
      rst = 1;
      
      rate = 0;	  
      data_in = 0;
      
      // deassert hard reset
      #100 @(posedge clk) #1 rst = 0;
      #100 @(posedge clk);

	  // verify dp 
      if (!dp) begin
         $display("ERROR: DP not prepared");
         $finish;
      end      
      
      //write refresh rate
      @(posedge clk) #1 rate = 5;

      //write number
      @(posedge clk) #1 data_in = data;
	  
      // read ssd output;
      count = 0;
      
      for(i=0; i<4; i=i+1) begin

	 $display("CASE: anode: %x, seg: %x", anode, seg);

	 // Check seg3 value
	 if(anode == 'b0111) begin //7	    
	    if(seg != seg3) begin
	      $display("seg3 got %x, expected %x", seg, seg3);
	      $display("Test failed");
	      $finish;
	    end
	    count = count + 1;	    
	 end

	 // Check seg2 value
	 if(anode == 'b1011) begin //B	    
	    if(seg != seg2) begin
	      $display("seg2 got %x, expected %x", seg, seg2);
	      $display("Test failed");
	      $finish;
	    end
	    count = count + 1;    
	 end

	 // Check seg1 value
	 if(anode == 'b1101) begin //D	    
	    if(seg != seg1) begin
	      $display("seg1 got %x, expected %x", seg, seg1);
	      $display("Test failed");
	      $finish;
	    end
	    count = count + 1;	    
	 end

	 // Check seg0 value
	 if(anode == 'b1110) begin //E	    
	    if(seg != seg0) begin
	      $display("seg0 got %x, expected %x", seg, seg0);
	      $display("Test failed");
	      $finish;
	    end
	    count = count + 1;	    
	 end

	  @(posedge clk);
	  @(posedge clk);
	  @(posedge clk);
	  @(posedge clk);
	  @(posedge clk);
	 
      end // for (i=0; i<4; i=i+1)

      if(count != 4) begin
	 $display("anodes got %d, expected 4", count);
         $display("Test failed");
         $finish;
      end
           
      $display("Test PASSED");
      #30000 $finish;

   end 

   //
   // CLOCK
   //

   //system clock
   always #(clk_per/2) clk = ~clk;

   // Instantiate the Unit Under Test (UUT)
   ssd uut
     (
      .clk(clk),
      .rst(rst),
      
      .rate(rate),
      .data_in(data_in),
	  
      .dp(dp),
      .anode(anode),
      .seg(seg)
      );

endmodule
