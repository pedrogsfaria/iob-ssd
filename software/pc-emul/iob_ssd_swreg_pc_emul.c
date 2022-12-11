/* PC Emulation of SSD peripheral */

#include <stdint.h>
#include <stdio.h>

#include "iob_ssd_swreg.h"

static uint32_t base;

void SSD_INIT_BASEADDR(uint32_t addr) {
    base = addr;
    return;

