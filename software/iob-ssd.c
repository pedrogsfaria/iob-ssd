#include "iob-ssd.h"

//SSD functions

//Initialize SSD 
void ssd_init(int base_address, uint32_t refresh_rate){
  //Set SSD base address
  IOB_SSD_INIT_BASEADDR(base_address);

  //Define SSD refresh rate
  //refresh_rate should be equal to (rate_period/clk_period)
  //E.g., for a rate_period = 5 ms and clk_period = 1 ns, refresh_rate = 5e6
  IOB_SSD_SET_RATE(refresh_rate);
}

//Set SSD number to display
void ssd_set_number(uint16_t number) {
  IOB_SSD_SET_DATA_IN(number);
}

