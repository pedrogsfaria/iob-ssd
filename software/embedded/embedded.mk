ifeq ($(filter SSD, $(SW_MODULES)),)

SW_MODULES+=SSD

include $(SSD_DIR)/software/software.mk

# add embeded sources
SRC+=iob_ssd_swreg_emb.c

iob_ssd_swreg_emb.c: iob_ssd_swreg.h

endif
