SHELL:=/bin/bash

TOP_MODULE=iob_ssd

#PATHS
REMOTE_ROOT_DIR ?=sandbox/iob-ssd
SIM_DIR ?=$(SSD_HW_DIR)/simulation/$(SIMULATOR)
FPGA_DIR ?=$(SSD_DIR)/hardware/fpga/$(FPGA_COMP)
DOC_DIR ?=

LIB_DIR ?=$(SSD_DIR)/submodules/LIB
SSD_HW_DIR:=$(SSD_DIR)/hardware

#MAKE SW ACCESSIBLE REGISTER
MKREGS:=$(shell find $(LIB_DIR) -name mkregs.py)

#DEFAULT FPGA FAMILY AND FAMILY LIST
FPGA_FAMILY ?=XCKU
FPGA_FAMILY_LIST ?=CYCLONEV-GT XCKU

#DEFAULT DOC AND DOC LIST
DOC ?=pb
DOC_LIST ?=pb ug

# default target
default: sim

# VERSION
VERSION ?=V0.1
$(TOP_MODULE)_version.txt:
	echo $(VERSION) > version.txt

#cpu accessible registers
iob_ssd_swreg_def.vh iob_ssd_swreg_gen.vh: $(SSD_DIR)/mkregs.conf
	$(MKREGS) iob_ssd $(SSD_DIR) HW

ssd-gen-clean:
	@rm -rf *# *~ version.txt

.PHONY: default ssd-gen-clean
