#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting SOF File: C:\projects\DE2_NET\DE2_NET.sof to: "..\flash/DE2_NET_epcs_controller.flash"
#
sof2flash --input="C:/projects/DE2_NET/DE2_NET.sof" --output="../flash/DE2_NET_epcs_controller.flash" --epcs 

#
# Programming File: "..\flash/DE2_NET_epcs_controller.flash" To Device: epcs_controller
#
nios2-flash-programmer "../flash/DE2_NET_epcs_controller.flash" --base=0x81000 --epcs --sidp=0x821F0 --id=0x0 --timestamp=1608772346 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program 

#
# Converting ELF File: C:\projects\DE2_NET\software\cnc\cnc.elf to: "..\flash/cnc_epcs_controller.flash"
#
elf2flash --input="C:/projects/DE2_NET/software/cnc/cnc.elf" --output="../flash/cnc_epcs_controller.flash" --epcs --after="../flash/DE2_NET_epcs_controller.flash" 

#
# Programming File: "..\flash/cnc_epcs_controller.flash" To Device: epcs_controller
#
nios2-flash-programmer "../flash/cnc_epcs_controller.flash" --base=0x81000 --epcs --sidp=0x821F0 --id=0x0 --timestamp=1608772346 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program 

