#include "defines.h"
#include "stm32f4xx.h"
#include "stm32f4xx_gpio.h"

static GPIO_InitTypeDef gpio_a;
static GPIO_InitTypeDef gpio_b;

int main(void)
{
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA, ENABLE);
	GPIO_StructInit(&gpio_a);
	gpio_a.GPIO_Pin = GPIO_Pin_1;
	gpio_a.GPIO_Mode = GPIO_Mode_IN;
	GPIO_Init(GPIOA, &gpio_a);
	
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOC, ENABLE);
	GPIO_StructInit(&gpio_b);
	gpio_b.GPIO_Pin = GPIO_Pin_3;
	gpio_b.GPIO_Mode = GPIO_Mode_OUT;
	GPIO_Init(GPIOB, &gpio_b);
	
	while (1)
	{
		if(GPIO_ReadInputDataBit(GPIOA,GPIO_Pin_1) == 0)
			GPIO_SetBits(GPIOC,GPIO_Pin_3);
		else
		GPIO_ResetBits(GPIOC,GPIO_Pin_3);
	}
	return 0;
}
