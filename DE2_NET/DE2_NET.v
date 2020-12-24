// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions:	DE2 NIOS Reference Design
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V2.0 :| Johnny Chen       :| 06/07/19  :|      Initial Revision
//   V3.0 :| Ben               :| 01/30/2012:| Quartus 11.1 sp1
// ============================================================================

module DE2_NET
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	On Board 27 MHz
		CLOCK_50,						//	On Board 50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		UART_TXD,						//	UART Transmitter
		UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		IRDA_TXD,						//	IRDA Transmitter
		IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 1
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 20 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask
		SRAM_LB_N,						//	SRAM Low-byte Data Mask  
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		SD_DAT,							//	SD Card Data
		SD_WP_N,						   //	SD Write protect 
		SD_CMD,							//	SD Card Command Signal
		SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							//	CPLD -> FPGA (Data in)
		TCK,  							//	CPLD -> FPGA (Clock)
		TCS,  							//	CPLD -> FPGA (CS)
	   TDO,  							//	FPGA -> CPLD (Data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		TD_CLK27,                  //	TV Decoder 27MHz CLK
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

////////////////////////	Clock Input	 	////////////////////////
input			   CLOCK_27;				//	On Board 27 MHz
input			   CLOCK_50;				//	On Board 50 MHz
input			   EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	   [3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	  [17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Display	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output  [17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
output			UART_TXD;				//	UART Transmitter
input			   UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
output			IRDA_TXD;				//	IRDA Transmitter
input			   IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	  [15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output  [11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	  [7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output [21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	  [15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output  [17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM Low-byte Data Mask 
output			SRAM_LB_N;				//	SRAM High-byte Data Mask 
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	  [15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
output   [1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
output			OTG_CS_N;				//	ISP1362 Chip Select
output			OTG_RD_N;				//	ISP1362 Write
output			OTG_WR_N;				//	ISP1362 Read
output			OTG_RST_N;				//	ISP1362 Reset
output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			   OTG_INT0;				//	ISP1362 Interrupt 0
input			   OTG_INT1;				//	ISP1362 Interrupt 1
input			   OTG_DREQ0;				//	ISP1362 DMA Request 0
input			   OTG_DREQ1;				//	ISP1362 DMA Request 1
output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	   [7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
inout	 [3:0]	SD_DAT;					//	SD Card Data
input			   SD_WP_N;				   //	SD write protect
inout			   SD_CMD;					//	SD Card Command Signal
output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			   I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
input		 	   PS2_DAT;				//	PS2 Data
input			   PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			ENET_CS_N;				//	DM9000A Chip Select
output			ENET_WR_N;				//	DM9000A Write
output			ENET_RD_N;				//	DM9000A Read
output			ENET_RST_N;				//	DM9000A Reset
input			   ENET_INT;				//	DM9000A Interrupt
output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			   AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			   AUD_ADCDAT;				//	Audio CODEC ADC Data
inout			   AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout			   AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	 [7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			   TD_HS;					//	TV Decoder H_SYNC
input			   TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
input          TD_CLK27;            //	TV Decoder 27MHz CLK
////////////////////////	GPIO	////////////////////////////////
inout	 [35:0]	GPIO_0;					//	GPIO Connection 0
inout	 [35:0]	GPIO_1;					//	GPIO Connection 1

wire	CPU_CLK;
wire	CPU_RESET;
wire	CLK_18_4;
wire	CLK_25;

//	Flash
assign	FL_RST_N	=	1'b1;

//	16*2 LCD Module
assign	LCD_ON		=	1'b1;	//	LCD ON
assign	LCD_BLON	=	1'b1;	//	LCD Back Light	

//	All inout port turn to tri-state
assign	SD_DAT[0]		=	1'bz;
assign	AUD_ADCLRCK	=	AUD_DACLRCK;

//
wire [31:0] ogpio;
wire [31:0] igpio;
wire [4:0]  sg_steps;
wire [4:0]  sg_dirs;
wire spindle_pwm;
wire cp;

assign	GPIO_1[35] = sg_dirs[0];
assign	GPIO_1[34] = ~sg_dirs[0];
assign	GPIO_1[33] = sg_steps[0];
assign	GPIO_1[32] = ~sg_steps[0];

assign	GPIO_1[31] = sg_dirs[1];
assign	GPIO_1[30] = ~sg_dirs[1];
assign	GPIO_1[29] = sg_steps[1];
assign	GPIO_1[28] = ~sg_steps[1];

assign	GPIO_1[26] = sg_dirs[2];
assign	GPIO_1[27] = ~sg_dirs[2];
assign	GPIO_1[24] = sg_steps[2];
assign	GPIO_1[25] = ~sg_steps[2];

assign	GPIO_1[22] = ~spindle_pwm;  // Spindle 0 PWM
assign	GPIO_1[23] = ogpio[0];     // Spindle 1 CW
assign  igpio[0] = GPIO_1[20];     // Spindle 2 index

assign	GPIO_1[18] = ogpio[1];  // 1
assign	GPIO_1[21] = ogpio[2];  // 2
assign	GPIO_1[19] = cp;  
								// gpio 3 not assigned to anything yet

assign igpio[1] = GPIO_1[17];  // 4
assign igpio[2] = GPIO_1[16];  // 5
assign igpio[3] = GPIO_1[15];  // 6
assign igpio[4] = GPIO_1[14];  // 7
assign igpio[5] = GPIO_1[13];  // 8

assign  igpio[17:6] = SW[17:6]; 

wire [17:0] LEDR_FROM_PC;
wire [8:0] LEDG_FROM_NIOS;

assign LEDR[11:0] = ogpio[11:0];

assign LEDG[8] = LEDG_FROM_NIOS[8];
assign LEDG[0] = sg_steps[0];
assign LEDG[2] = sg_steps[1];
assign LEDG[4] = sg_steps[2];
assign LEDG[6] = sg_steps[3];

assign LEDG[1] = sg_dirs[0];
assign LEDG[3] = sg_dirs[1];
assign LEDG[5] = sg_dirs[2];
assign LEDG[7] = sg_dirs[3];


//
assign	GPIO_0[35:2]		=	34'hzzzzzzzzz;
assign GPIO_0[0] = ENET_RD_N;
assign GPIO_0[1] = ENET_WR_N;

//	Disable USB speed select
assign	OTG_FSPEED	=	1'bz;
assign	OTG_LSPEED	=	1'bz;

//	Turn On TV Decoder
assign	TD_RESET	=	1'b1;

//	Set SD Card to SD Mode
assign	SD_DAT[3]=	1'b1;

Reset_Delay	delay1	(.iRST(KEY[0]),.iCLK(CLOCK_50),.oRESET(CPU_RESET));

SDRAM_PLL 	PLL1	(.inclk0(CLOCK_50),.c0(CPU_CLK),.c1(DRAM_CLK),.c2(CLK_25));
Audio_PLL 	PLL2	(.areset(!CPU_RESET),.inclk0(CLOCK_27),.c0(CLK_18_4));

system_0 	u0	(
				// 1) global signals:
   				  .clk_50(CPU_CLK),
                 .reset_n(CPU_RESET),

                // the_Audio_0
					  .audio_0_oAUD_DATA                    (AUD_DACDAT),   //.oAUD_DATA
                 .audio_0_oAUD_LRCK                    (AUD_DACLRCK),  //.oAUD_LRCK
                 .audio_0_oAUD_BCK                     (AUD_BCLK),     //.oAUD_BCK
                 .audio_0_oAUD_XCK                     (AUD_XCK),      //.oAUD_XCK
                 .audio_0_iCLK_18_4                    (CLK_18_4),  

                // the_VGA_0			  
					  .vga_0_VGA_R                          (VGA_R),        //.VGA_R
                 .vga_0_VGA_G                          (VGA_G),        //.VGA_G
                 .vga_0_VGA_B                          (VGA_B),        //.VGA_B
                 .vga_0_VGA_HS                         (VGA_HS),       //.VGA_HS
                 .vga_0_VGA_VS                         (VGA_VS),       //.VGA_VS
                 .vga_0_VGA_SYNC                       (VGA_SYNC),     //.VGA_SYNC
                 .vga_0_VGA_BLANK                      (VGA_BLANK),    //.VGA_BLANK
                 .vga_0_VGA_CLK                        (VGA_CLK),      //.VGA_CLK
                 .vga_0_iCLK_25                        (CLK_25),       //.iCLK_25

                // the_SD_CLK
                 .out_port_from_the_SD_CLK(SD_CLK),

                // the_SD_CMD
                 .bidir_port_to_and_from_the_SD_CMD(SD_CMD),

                // the_SD_DAT
                 .bidir_port_to_and_from_the_SD_DAT(SD_DAT[0]),

                // the_SEG7_Display
					  .seg7_display_oSEG0                   (HEX0),        //seg7_display.oSEG0
                 .seg7_display_oSEG1                   (HEX1),        //.oSEG1
                 .seg7_display_oSEG2                   (HEX2),        //.oSEG2
                 .seg7_display_oSEG3                   (HEX3),        //.oSEG3
                 .seg7_display_oSEG4                   (HEX4),        //.oSEG4
                 .seg7_display_oSEG5                   (HEX5),        //.oSEG5
                 .seg7_display_oSEG6                   (HEX6),        //.oSEG6
                 .seg7_display_oSEG7                   (HEX7),        //.oSEG7

                // the_DM9000A
				     .dm9000a_iOSC_50                      (CLOCK_50),   // .iOSC_50
                 .dm9000a_ENET_DATA                    (ENET_DATA),  // .ENET_DATA
                 .dm9000a_ENET_CMD                     (ENET_CMD),   // .ENET_CMD
                 .dm9000a_ENET_RD_N                    (ENET_RD_N),  // .ENET_RD_N
                 .dm9000a_ENET_WR_N                    (ENET_WR_N),  // .ENET_WR_N
                 .dm9000a_ENET_CS_N                    (ENET_CS_N),  // .ENET_CS_N
                 .dm9000a_ENET_RST_N                   (ENET_RST_N), // .ENET_RST_N
                 .dm9000a_ENET_CLK                     (ENET_CLK),   // .ENET_CLK
                 .dm9000a_ENET_INT                     (ENET_INT),   // .ENET_INT
				
                // the_ISP1362
                 .USB_ADDR_from_the_ISP1362            (OTG_ADDR),
					  .USB_CS_N_from_the_ISP1362            (OTG_CS_N),
					  .USB_DATA_to_and_from_the_ISP1362     (OTG_DATA),
					  .USB_INT0_to_the_ISP1362              (OTG_INT0),
					  .USB_INT1_to_the_ISP1362              (OTG_INT1),
					  .USB_RD_N_from_the_ISP1362            (OTG_RD_N),
					  .USB_RST_N_from_the_ISP1362           (OTG_RST_N),
					  .USB_WR_N_from_the_ISP1362            (OTG_WR_N),

                // the_button_pio
                 .in_port_to_the_button_pio(KEY),

                // the_lcd_16207_0
                 .LCD_E_from_the_lcd_16207_0(LCD_EN),
                 .LCD_RS_from_the_lcd_16207_0(LCD_RS),
                 .LCD_RW_from_the_lcd_16207_0(LCD_RW),
                 .LCD_data_to_and_from_the_lcd_16207_0(LCD_DATA),

                // the_led_green
                 .out_port_from_the_led_green(LEDG_FROM_NIOS),

                // the_led_red
                 .out_port_from_the_led_red(LEDR_FROM_PC),

                // the_sdram_0
                 .zs_addr_from_the_sdram_0(DRAM_ADDR),
                 .zs_ba_from_the_sdram_0({DRAM_BA_1,DRAM_BA_0}),
                 .zs_cas_n_from_the_sdram_0(DRAM_CAS_N),
                 .zs_cke_from_the_sdram_0(DRAM_CKE),
                 .zs_cs_n_from_the_sdram_0(DRAM_CS_N),
                 .zs_dq_to_and_from_the_sdram_0(DRAM_DQ),
                 .zs_dqm_from_the_sdram_0({DRAM_UDQM,DRAM_LDQM}),
                 .zs_ras_n_from_the_sdram_0(DRAM_RAS_N),
                 .zs_we_n_from_the_sdram_0(DRAM_WE_N),

                  // the_sram_0
					  .sram_0_avalon_slave_0_export_DQ      (SRAM_DQ),      //    sram_0_avalon_slave_0_export.DQ
                 .sram_0_avalon_slave_0_export_ADDR    (SRAM_ADDR),    //    .ADDR
                 .sram_0_avalon_slave_0_export_UB_N    (SRAM_UB_N),    //    .UB_N
                 .sram_0_avalon_slave_0_export_LB_N    (SRAM_LB_N),    //    .LB_N
                 .sram_0_avalon_slave_0_export_WE_N    (SRAM_WE_N),    //    .WE_N
                 .sram_0_avalon_slave_0_export_CE_N    (SRAM_CE_N),    //    .CE_N
                 .sram_0_avalon_slave_0_export_OE_N    (SRAM_OE_N),    //    .OE_N

                // the_switch_pio
                 .in_port_to_the_switch_pio(SW),

                // the_tri_state_bridge_0_avalon_slave
                 .select_n_to_the_cfi_flash_0(FL_CE_N),
                 .tri_state_bridge_0_address(FL_ADDR),
                 .tri_state_bridge_0_data(FL_DQ),
                 .tri_state_bridge_0_readn(FL_OE_N),
                 .write_n_to_the_cfi_flash_0(FL_WE_N),

                // the_uart_0
                 .rxd_to_the_uart_0(UART_RXD),
                 .txd_from_the_uart_0(UART_TXD),

				// cnc hardware
				.cnc_module_ospindle_pwm              (spindle_pwm),              //                      cnc_module.ospindle_pwm
				.cnc_module_cp              		  (cp),              //                      cnc_module.ospindle_pwm
				.cnc_module_odirs                     (sg_dirs),                     //                                .odirs
				.cnc_module_ogpio                     (ogpio),                     //                                .ogpio
				.cnc_module_igpio                     (igpio),                     //                                .igpio
				.cnc_module_osteps                    (sg_steps)                     //                                .osteps

                );

I2C_AV_Config 	u1	(	//	Host Side
						.iCLK(CLOCK_50),
						.iRST_N(KEY[0]),
						//	I2C Side
						.I2C_SCLK(I2C_SCLK),
						.I2C_SDAT(I2C_SDAT)	);

endmodule
