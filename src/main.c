#include <stm32f4xx.h>

#define LED_RED (1 << 14)

#define DELAY_CYCLES 2000000

void delay(volatile int delay_cycles) {
    for (int i = 0; i < delay_cycles; i++) {}
}

int main() {
    SET_BIT(RCC->AHB1ENR, RCC_AHB1ENR_GPIODEN);   // Enable the clock of port D of the GPIO
    SET_BIT(GPIOD->MODER, GPIO_MODER_MODER14_0);  // set pin 14 (red LED) as output

    while (1) {
        GPIOD->ODR ^= LED_RED;
        delay(DELAY_CYCLES);
    }
}
