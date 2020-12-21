DE2_NET
-------

This designs demonstrates how to use the Ethernet port using a Nios II system on the DE2 board. It sends packets, and using a loopback Ethernet cable, it'll receive the same packets which are then displayed. It also works if the board is connected to another packet source.

Running the Design
------------------

1) Launch the Quartus II software.
2) Open the DE2_NET.qpf project located in the <install path>\DE2_NET folder. (File menu -> Open Project)
3) Open the Programmer window. (Tools menu -> Programmer)
4) The DE2_NET.sof programming file should be listed.
   Check the 'Program/Configure' box and set up the JTAG programming hardware connection via the 'Hardware Setup' button.
5) Press 'Start' to start programming. The design should now be programmed.
6) Launch the Nios II IDE.
7) Switch the workspace to the <install path>\DE2_NET folder.
8) Build the project. (Project menu -> Build All)
9) Run the project on the board. (Run menu)

Using a loopback cable, you should see the packet data in the Nios II terminal. Otherwise, whenever the packet source sends a packet, then the Nios II terminal will display the packet data.

User Inputs to the Design
-------------------------

None.

Compiling the Design
--------------------

1) Launch the Quartus II software.
2) Open the DE2_NET.qpf project located in the <install path>\DE2_NET folder. (File menu -> Open Project)
3) Start compilation. (Processing -> Start Compilation)
4) After compilation is finished, you can run the design with the generated SOF file. See 'Running the Design' above, which includes steps to build the Nios II project.
