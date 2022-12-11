include $(SSD_DIR)/config.mk

SSD_SW_DIR:=$(SSD_DIR)/software

#include
INCLUDE+=-I$(SSD_SW_DIR)

#headers
HDR+=$(SSD_SW_DIR)/*.h iob_ssd_swreg.h

#sources
SRC+=$(SSD_SW_DIR)/iob-ssd.c

iob_ssd_swreg.h: $(SSD_DIR)/mkregs.conf
	$(MKREGS) iob_ssd $(SSD_DIR) SW
