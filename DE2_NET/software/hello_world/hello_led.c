
#include "basic_io.h"
#include "test.h"
#include "LCD.h"
#include "DM9000A.C"

unsigned int aaa,rx_len,i,packet_num;
unsigned char RXT[68];

void ethernet_interrupts()
{
    packet_num++;
    aaa=ReceivePacket(RXT,&rx_len);
    if(!aaa)
    {
      printf("\n\nReceive Packet Length = %d",rx_len);
      for(i=0;i<rx_len;i++)
      {
        if(i%8==0)
        printf("\n");
        printf("0x%2X,",RXT[i]);
      }
    }
    outport(SEG7_DISPLAY_BASE,packet_num);
}

int main(void)
{
  unsigned char TXT[] = { 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
                          0x01,0x60,0x6E,0x11,0x02,0x0F,
                          0x08,0x00,0x11,0x22,0x33,0x44,
                          0x55,0x66,0x77,0x88,0x99,0xAA,
                          0x55,0x66,0x77,0x88,0x99,0xAA,
                          0x55,0x66,0x77,0x88,0x99,0xAA,
                          0x55,0x66,0x77,0x88,0x99,0xAA,
                          0x55,0x66,0x77,0x88,0x99,0xAA,
                          0x55,0x66,0x77,0x88,0x99,0xAA,
                          0x55,0x66,0x77,0x88,0x99,0xAA,
                          0x00,0x00,0x00,0x20 };
  printf("Ethernet Testing!\n");
  LCD_Test();
  DM9000_init();
  alt_irq_register( DM9000A_IRQ, NULL, (void*)ethernet_interrupts ); 
  packet_num=0;
  while (1)
  {
    TransmitPacket(TXT,0x40);
    msleep(500);
  }

  return 0;
}

//-------------------------------------------------------------------------


