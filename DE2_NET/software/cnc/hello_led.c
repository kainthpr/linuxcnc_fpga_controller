#include "basic_io.h"
#include "test.h"
#include "LCD.h"
#include "DM9000A.C"
#include "system.h"
#include "altera_avalon_uart_regs.h"

unsigned int aaa, rx_len, i, packet_num;
unsigned int temp;
volatile unsigned char RXT[512];
unsigned int to_send = 0;
volatile unsigned char TXT[40] = { 0x50, 0x46, 0x5d, 0x48, 0x37, 0x42, 0x01, 0x60,
		0x6E, 0x11, 0x02, 0x0F, 0x08, 0xab };
volatile unsigned char igpio_31_24;  // inputs from pendant
volatile unsigned char igpio_23_16;  // inputs from pendant
volatile unsigned char old_pendant_leds;
volatile unsigned char pendant_keys;
volatile unsigned char pendant_pressed;
volatile unsigned char button;
volatile unsigned char temp_but;
void receiver_interupts()
{

	alt_u8 status;
	status= IORD_ALTERA_AVALON_UART_STATUS(UART_0_BASE);
	if(status & ALTERA_AVALON_UART_STATUS_RRDY_MSK)  // receive interrupt
	{
		pendant_keys=IORD_ALTERA_AVALON_UART_RXDATA(UART_0_BASE);  //receive character
		IOWR_ALTERA_AVALON_UART_STATUS(UART_0_BASE, 0);  // clear interrupt?
		pendant_pressed = 1;
	}
}
unsigned char receive(){
	alt_u8 status;
	status= IORD_ALTERA_AVALON_UART_STATUS(UART_0_BASE);
	unsigned char buffer = 255;
	if((status & ALTERA_AVALON_UART_STATUS_RRDY_MSK))
	{	// check if reception ready{
		buffer=IORD_ALTERA_AVALON_UART_RXDATA(UART_0_BASE);  //receive character
	}
	return buffer;
}

void transmit(unsigned int val){
	alt_u8 status;
	status= IORD_ALTERA_AVALON_UART_STATUS(UART_0_BASE);
	if((status & ALTERA_AVALON_UART_CONTROL_TRDY_MSK))
	{
		IOWR_ALTERA_AVALON_UART_TXDATA(UART_0_BASE, val);  //transmit
	}
}

void ethernet_interrupts() {
	unsigned int inter = ior(ISR);
	iow(ISR, inter);
	if ((inter & 1) == 1) // receive
	{
		aaa = ReceivePacket(RXT, &rx_len);
		if (RXT[12] != 0x80 || RXT[13] != 0xab)
		{ i++;
//		outport(SEG7_DISPLAY_BASE, i);
		TXT[13] = 0xaa;
		TransmitPacket(TXT, 14);
		TXT[13] = 0xab;
		return;

		}
		// First return values regardless of what kind of request it is
		temp = IORD(CNC_MODULE_0_BASE, 9);  // igpio
		TXT[14] = temp&0xFF;
		TXT[15] = (temp&0xFF00) >> 8;
//		TXT[16] = (temp&0xFF0000) >> 16;
//		TXT[17] = (temp&0xFF000000) >> 24;

		TXT[16] = igpio_23_16;  // lower 8 bits from pendant
		TXT[17] = igpio_31_24;  // upper 8 bits from pendant

		temp = IORD(CNC_MODULE_0_BASE, 10); // sg0_loc
		//outport(SEG7_DISPLAY_BASE, i);

		TXT[18] = temp&0xFF;
		TXT[19] = (temp&0xFF00) >> 8;
		TXT[20] = (temp&0xFF0000) >> 16;
		TXT[21] = (temp&0xFF000000) >> 24;

		temp = IORD(CNC_MODULE_0_BASE, 11); // sg1_loc
		TXT[22] = temp&0xFF;
		TXT[23] = (temp&0xFF00) >> 8;
		TXT[24] = (temp&0xFF0000) >> 16;
		TXT[25] = (temp&0xFF000000) >> 24;

		temp = IORD(CNC_MODULE_0_BASE, 12);// sg2_loc
		TXT[26] = temp&0xFF;
		TXT[27] = (temp&0xFF00) >> 8;
		TXT[28] = (temp&0xFF0000) >> 16;
		TXT[29] = (temp&0xFF000000) >> 24;

		temp = IORD(CNC_MODULE_0_BASE, 13);// sg3_loc
		TXT[30] = temp&0xFF;
		TXT[31] = (temp&0xFF00) >> 8;
		TXT[32] = (temp&0xFF0000) >> 16;
		TXT[33] = (temp&0xFF000000) >> 24;

		temp = IORD(CNC_MODULE_0_BASE, 14); // sg4_loc
		TXT[34] = temp&0xFF;
		TXT[35] = (temp&0xFF00) >> 8;
		TXT[36] = (temp&0xFF0000) >> 16;
		TXT[37] = (temp&0xFF000000) >> 24;

		TransmitPacket(TXT, 38);

		// write regs if this is correct
		if (RXT[12] == 0x80 && RXT[13] == 0xab)
		{
			packet_num++;
			IOWR(CNC_MODULE_0_BASE, 0, (RXT[17]<<24 | RXT[16]<<16 | RXT[15]<<8 | RXT[14])); // SG0
			IOWR(CNC_MODULE_0_BASE, 1, (RXT[21]<<24 | RXT[20]<<16 | RXT[19]<<8 | RXT[18])); // SG1
			IOWR(CNC_MODULE_0_BASE, 2, (RXT[25]<<24 | RXT[24]<<16 | RXT[23]<<8 | RXT[22])); // SG2
			IOWR(CNC_MODULE_0_BASE, 3, (RXT[29]<<24 | RXT[28]<<16 | RXT[27]<<8 | RXT[26])); // SG3
			IOWR(CNC_MODULE_0_BASE, 4, (RXT[33]<<24 | RXT[32]<<16 | RXT[31]<<8 | RXT[30])); // SG4

			IOWR(CNC_MODULE_0_BASE, 5, (RXT[37]<<24 | RXT[36]<<16 | RXT[35]<<8 | RXT[34])); // dirs, enables
			IOWR(CNC_MODULE_0_BASE, 6, (RXT[41]<<24 | RXT[40]<<16 | RXT[39]<<8 | RXT[38])); // pwm counter
			IOWR(CNC_MODULE_0_BASE, 7, (RXT[45]<<24 | RXT[44]<<16 | RXT[43]<<8 | RXT[42])); // pwm compare
			IOWR(CNC_MODULE_0_BASE, 8, (RXT[49]<<24 | RXT[48]<<16 | RXT[47]<<8 | RXT[46])); // ogpio

			outport(LED_GREEN_BASE, (packet_num >> 7)&1);
//			outport(LED_GREEN_BASE, IORD(CNC_MODULE_0_BASE, 7));
		}
	}
}

int main(void) {

	IOWR(CNC_MODULE_0_BASE, 5, 0);  // DISABLE ALL STEP GENS FIRST !!!!
	usleep(100000);
	LCD_Test();
//	printf("Ethernet Testing!\n");
	DM9000_init();
	DM9000_init();
	alt_irq_register(DM9000A_IRQ, NULL, (void*) ethernet_interrupts);
	alt_irq_register(UART_0_IRQ, NULL, (void*) receiver_interupts);

	packet_num = 0;

	char Texta[16] = "Ready           ";
	LCD_Line2();
	LCD_Show_Text(Texta);
	volatile unsigned int count = 0;
	unsigned char a;
	unsigned char buffer;
	int size;
	while (1) {
		// data from pendant
		if (pendant_pressed == 1)
		{
			pendant_pressed = 0;
			outport(LED_GREEN_BASE, ~(inport(LED_GREEN_BASE)));
			outport(SEG7_DISPLAY_BASE, pendant_keys);

			button = ((pendant_keys)>>4)&0x0F;
			if (button <= 7)
			{
				temp_but = ~(1<<button);
				igpio_23_16 = (igpio_23_16 & temp_but) | ((pendant_keys&1) << button);
			}
			else // 8 to 15
			{
				button = button - 8;
				temp_but = ~(1<<button);
				igpio_31_24 = (igpio_31_24 & temp_but) | ((pendant_keys&1) << button);
			}

//			IOWR_ALTERA_AVALON_UART_TXDATA(UART_0_BASE, (pendant_keys & 1) << button);
		}

		if ((count % 100000) == 0)
		{
			outport(LED_GREEN_BASE, ~(inport(LED_GREEN_BASE)));
		}

		if (RXT[49] != old_pendant_leds) // send data if it has changed.
		{
			old_pendant_leds = RXT[49];
			IOWR_ALTERA_AVALON_UART_TXDATA(UART_0_BASE, RXT[49]);
		}
		// end data to pendant

		count += 1;
	}
	return 0;
}

//-------------------------------------------------------------------------

