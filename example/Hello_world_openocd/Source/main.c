/*********************************************************************
*                    SEGGER Microcontroller GmbH                     *
*                        The Embedded Experts                        *
**********************************************************************

-------------------------- END-OF-HEADER -----------------------------

File    : main.c
Purpose : Generic application start

*/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>


#define NOP() __asm__("ADDI x0,x0,0")

void timer_rst(){
  uint32_t timer_base = 0x80000000;

  volatile uint8_t* timer_rst = (volatile uint8_t*) timer_base + 0x04;

  *timer_rst = 1;
}

void timer_setdiv(uint16_t div){
  uint32_t timer_base = 0x80000000;

  volatile uint8_t* timer_divl = (volatile uint8_t*) timer_base + 0x06;
  volatile uint8_t* timer_divh = (volatile uint8_t*) timer_base + 0x07;

  *timer_divl = div&0xFF;
  *timer_divh = div>>8;
}

uint32_t timer_read(){
  uint8_t read_tmp;
  uint32_t timer_rst = 0;
  uint32_t timer_base = 0x80000000;
  
  volatile uint8_t* timer_snapshot = (volatile uint8_t*) timer_base + 0x05;

  volatile uint8_t* timer_b0 = (volatile uint8_t*) timer_base + 0x00;
  volatile uint8_t* timer_b1 = (volatile uint8_t*) timer_base + 0x01;
  volatile uint8_t* timer_b2 = (volatile uint8_t*) timer_base + 0x02;
  volatile uint8_t* timer_b3 = (volatile uint8_t*) timer_base + 0x03;


  *timer_snapshot = 1;

  
  read_tmp = *timer_b0; NOP(); read_tmp = *timer_b0;
  timer_rst += read_tmp << 0;
  read_tmp = *timer_b1; NOP(); read_tmp = *timer_b1;
  timer_rst += read_tmp << 8;
  read_tmp = *timer_b2; NOP(); read_tmp = *timer_b2;
  timer_rst += read_tmp << 16;
  read_tmp = *timer_b3; NOP(); read_tmp = *timer_b3;
  timer_rst += read_tmp << 24;

  return timer_rst;
}

void uart_set_div(uint16_t div){
  uint32_t uart_base = 0x80000010;

  volatile uint8_t* uart_divl = (volatile uint8_t*) uart_base + 0x00;
  volatile uint8_t* uart_divh = (volatile uint8_t*) uart_base + 0x01;

  *uart_divl = div&0xFF;
  *uart_divh = div>>8;
}

//busy return 1
//idle return 0
uint8_t uart_get_sta(){
  uint32_t uart_base = 0x80000010;
  volatile uint8_t* uart_sta = (volatile uint8_t*) uart_base + 0x03;

  uint8_t r = 0;
  r = *uart_sta; NOP(); r = *uart_sta; 

  return r != 0;
}

void uart_send_arr(uint8_t* src, uint16_t len){
  uint32_t uart_base = 0x80000010;

  volatile uint8_t* uart_tx = (volatile uint8_t*) uart_base + 0x02;
  

  for(int i = 0;i < len;i++){
    while(uart_get_sta()){}
    *uart_tx = src[i];
  }
}

uint8_t print_buf[64];
char* print_buf_ptr = (char*)print_buf;

int main(void) {
  uint32_t i;
  uint32_t j;
  timer_setdiv(49999); // 1ms
  timer_rst();
  uart_set_div(50000000 / 115200); // uart_bps 115200

  for (i = 0; 1; i++) {
    do {
      j = timer_read();
    }while (j < i * 1000);
    
    sprintf(print_buf_ptr, "Hello World #:%d Tick:%i\r\n", i, j);
    uart_send_arr(print_buf, strlen(print_buf_ptr));
    printf("Hello World #:%d Tick:%i\r\n", i, j);
  }
}
