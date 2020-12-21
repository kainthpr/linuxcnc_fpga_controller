#include "basic_io.h"
#include "test.h"
#include "LCD.h"
#include "DM9000A.C"
#include "system.h"

unsigned int aaa, rx_len, i, packet_num;
unsigned char RXT[512];
unsigned int to_send = 0;
unsigned char TXT[40] = { 0x50, 0x46, 0x5d, 0x48, 0x37, 0x42, 0x01, 0x60,
		0x6E, 0x11, 0x02, 0x0F, 0x08, 0xab };

void ethernet_interrupts() {
	unsigned int inter = ior(ISR);
	iow(ISR, inter);
	if ((inter & 1) == 1) // receive
	{
		aaa = ReceivePacket(RXT, &rx_len);
		// First return values regardless of what kind of request it is
		unsigned int temp = IORD(CNC_MODULE_0_BASE, 9);
		TXT[14] = temp&0xFF;
		TXT[15] = (temp&0xFF00) >> 8;
		TXT[16] = (temp&0xFF0000) >> 16;
		TXT[17] = (temp&0xFF000000) >> 24;

		temp = IORD(CNC_MODULE_0_BASE, 10);
		outport(SEG7_DISPLAY_BASE, temp);

		TXT[18] = temp&0xFF;
		TXT[19] = (temp&0xFF00) >> 8;
		TXT[20] = (temp&0xFF0000) >> 16;
		TXT[21] = (temp&0xFF000000) >> 24;

		temp = IORD(CNC_MODULE_0_BASE, 11);
		TXT[22] = temp&0xFF;
		TXT[23] = (temp&0xFF00) >> 8;
		TXT[24] = (temp&0xFF0000) >> 16;
		TXT[25] = (temp&0xFF000000) >> 24;

		temp = IORD(CNC_MODULE_0_BASE, 12);
		TXT[26] = temp&0xFF;
		TXT[27] = (temp&0xFF00) >> 8;
		TXT[28] = (temp&0xFF0000) >> 16;
		TXT[29] = (temp&0xFF000000) >> 24;

		temp = IORD(CNC_MODULE_0_BASE, 13);
		TXT[30] = temp&0xFF;
		TXT[31] = (temp&0xFF00) >> 8;
		TXT[32] = (temp&0xFF0000) >> 16;
		TXT[33] = (temp&0xFF000000) >> 24;

		temp = IORD(CNC_MODULE_0_BASE, 14);
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
	printf("Ethernet Testing!\n");
	DM9000_init();
	DM9000_init();
	alt_irq_register(DM9000A_IRQ, NULL, (void*) ethernet_interrupts);
	packet_num = 0;

	volatile unsigned int count = 0;
	while (1) {
		count += 1;
	}
	return 0;
}

//-------------------------------------------------------------------------

