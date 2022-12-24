ifeq ($(filter SSD, $(HW_MODULES)),)

include $(SSD_DIR)/config.mk

#add itself to HW_MODULES list
HW_MODULES+=SSD


SSD_INC_DIR:=$(SSD_HW_DIR)/include
SSD_SRC_DIR:=$(SSD_HW_DIR)/src

#import module
include $(LIB_DIR)/hardware/iob_reg/hardware.mk

#include files
VHDR+=$(wildcard $(SSD_INC_DIR)/*.vh)
VHDR+=iob_ssd_swreg_gen.vh iob_ssd_swreg_def.vh
VHDR+=$(LIB_DIR)/hardware/include/iob_lib.vh $(LIB_DIR)/hardware/include/iob_s_if.vh $(LIB_DIR)/hardware/include/iob_gen_if.vh

#hardware include dirs
INCLUDE+=$(incdir). $(incdir)$(SSD_INC_DIR) $(incdir)$(LIB_DIR)/hardware/include

#sources
VSRC+=$(wildcard $(SSD_SRC_DIR)/*.v)

ssd-hw-clean:
	@rm -rf $(SSD_HW_DIR)/fpga/vivado/XCKU $(SSD_HW_DIR)/fpga/quartus/CYCLONEV-GT

.PHONY: ssd-hw-clean

endif
