#include "iob-ssd.h"

//SSD functions

//Set SSD base address
void ssd_init(int base_address){
  IOB_SSD_INIT_BASEADDR(base_address);
}

//Set SSD number to display
void ssd_set_number(uint16_t number) {
  IOB_SSD_SET_TXDATA(number);
}

