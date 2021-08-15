# cnc
DE2 Design for LinuxCNC controller + LinuxCNC component + LinuxCNC config 

FPGA design:
  Ethernet controller for LinuxCNC implemented on an Altera DE2 board.
  5 step/dir, multiple counters, pwm generators, gpio, I/Q encoder counters, serial interface to communicate customer stm32 bluepill based jog pendant
  RTL + nios ii code
  
Linuxcnc HAL component:
  de2.c exposes connections to linuxcnc and implements ethernet communication to talk to DE2 board

Linuxcnc config:
  HAL file that instantiates the de2 component
