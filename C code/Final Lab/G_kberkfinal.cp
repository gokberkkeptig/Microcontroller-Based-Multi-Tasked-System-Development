#line 1 "C:/Users/user/Desktop/Final Lab/G_kberkfinal.c"
sbit LCD_RS at PORTB2_bit;
sbit LCD_EN at PORTB5_bit;
sbit LCD_D4 at PORTC4_bit;
sbit LCD_D5 at PORTC5_bit;
sbit LCD_D6 at PORTC6_bit;
sbit LCD_D7 at PORTC7_bit;

sbit LCD_RS_Direction at DDB2_bit;
sbit LCD_EN_Direction at DDB5_bit;
sbit LCD_D4_Direction at DDC4_bit;
sbit LCD_D5_Direction at DDC5_bit;
sbit LCD_D6_Direction at DDC6_bit;
sbit LCD_D7_Direction at DDC7_bit;

unsigned int checkTemp()
{
 unsigned int analogTempHigh, val ;
 ADCSRA |= (1 << ADSC);
 while ((ADCSRA & (1 << ADIF)) != 0);
 analogTempHigh = ADCH;
 ADCSRA |= (1 << ADIF);
 val = ((unsigned int)(analogTempHigh * 0.39215686274));

 return val;

}

void displayLcd2(char* tempatureStr)
{
 Lcd_Out(2, 1, "T:");
 Lcd_Out(2, 4, tempatureStr);
 Lcd_Out(2, 9, "C");
}


void displayLcd1(char* fanSpeedStr)
{
 Lcd_Out(1, 1, "FS:");
 Lcd_Out(1, 4, fanSpeedStr);
}


char fanSpeedStr[8];
char tempatureStr[8];
void updateLcd(unsigned int fanSpeed, unsigned int temp)
{

 IntToStr(fanSpeed, fanSpeedStr);
 IntToStr(temp, tempatureStr);

 Lcd_Cmd(_LCD_CLEAR);
 if ((PIND & 1 << 1) != 0)
 displayLcd1(fanSpeedStr + 1);


 if ((PIND & 1 << 0) != 0)
 displayLcd2(tempatureStr + 1);
}

char chForPortA;
void displayLeds(unsigned int t)
{
 if (t > 8) {
 t = 8;
 }

 chForPortA = 0x01;
 while (t > 0) {
 t--;
 chForPortA = (chForPortA * 2) + 1;
 }
 PORTA = chForPortA;
}

void squareWave()
{
 TIMSK |= (1 << OCIE2);
 DDRC |= 0b00000010;
 PORTC |= 0b00000010;
 TCCR2 = 0x0B;
 OCR2 = 39;
}

void holdSound()
{

 TCCR2 = 0x00;
 TIMSK &= ~(1 << OCIE2);
 PORTC &= ~(1 << 1);

}


void twoSecs()
{
 TCCR1A = 0x00;
 TCCR1B = 0x0D; ;
 OCR1AH = 0x4C;
 OCR1AL = 0x4C;
 TIMSK |= (1 << OCIE1A);

 squareWave();
}

void Timer2Compare_ISR() iv IVT_ADDR_TIMER2_COMP
{
 PORTC ^= 0x02;
}

void Timer1Compare_ISR() iv IVT_ADDR_TIMER1_COMPA
{
 holdSound();
}

int fanSpeed;
int changeFanSpeed(unsigned int temp)
{
 fanSpeed = 0;
 if (temp == 30) {
 fanSpeed = 1;
 }
 else if (temp > 30) {
 fanSpeed = (int)((temp - 30) * (1.42857142857));
 }
 OCR0 = (int)(fanSpeed * 2.55);

 return fanSpeed;
}

void setText(char* text)
{

 text[0] = UDR0;
}

void getText(char* text)
{
 char i = 0;
 while (text[i] != '\0')
 {
 while (!(UCSR0A & (1 << UDRE0)));
 UDR0 = text[i];
 i = i + 1;
 }
}

void addNewLine()
{
 while (!(UCSR0A & (1 << UDRE0)));
 UDR0 = 13;
}

char inputType(char* str)
{
 char type = 'n';
 if (str[0] == 'T' || str[0] == 't') {
 type = 't';
 }
 else if (str[0] == 'S' || str[0] == 's') {
 type = 's';
 }

 return type;
}

void request() iv IVT_ADDR_USART0__RX
{

 char recievedText[2];
 setText(recievedText);

 switch (inputType(recievedText))
 {
 case 't':
 getText(tempatureStr);
 addNewLine();
 getText("Enter S for % fan speed and T for temperature:");
 break;
 case 's':
 getText(fanSpeedStr);
 addNewLine();
 getText("Enter S for % fan speed and T for temperature:");
 break;
 case 'n':
 getText("Wrong Input!");
 addNewLine();
 getText("Enter S for % fan speed and T for temperature:");
 break;

 }

}

char prevBitPIND0;
char prevBitPIND1;
int previousFanSpeed;
unsigned int previousTemp;
unsigned int temp;
unsigned int didBuzzerRing;
char tempStr[4];

void main()
{
 DDRA = 0xFF;
 DDRB = 0xFF;
 DDRC |= 0x02;
 DDRD = 0x00;
 DDRF = 0x00;
 ADMUX = (1 << ADLAR);
 ADCSRA = 0x87;
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);
 TCCR0 = 0x65;
 SREG_I_bit = 1;

 TIMSK |= (1 << OCIE2);
 TIMSK |= (1 << OCIE3A);

 UCSR0B = (1 << RXEN0) | (1 << TXEN0) | (1 << RXCIE0);
 UCSR0C = (1 << UCSZ01) | (1 << UCSZ00);
 UBRR0H = 0;
 UBRR0L = 65;

 getText("Enter S for % fan speed and T for temperature:");
 while (1) {
 previousTemp = temp;
 temp = checkTemp();


 if ((PIND & 1 << 3) == 0)
 PORTA = 0x00;

 else
 {
 displayLeds((int)(temp / 12.5));
 }

 if ((PIND & 1 << 2) == 0 || temp < 30) {
 holdSound();
 didBuzzerRing = 0;
 }

 if (temp >= 30 && ((PIND & 1 << 2) != 0) && (!didBuzzerRing)) {
 twoSecs();
 didBuzzerRing = 1;
 }

 previousFanSpeed = fanSpeed;
 fanSpeed = changeFanSpeed(temp);

 if ((prevBitPIND0 != PIND0_bit) || (previousTemp != temp) || (prevBitPIND1 != PIND1_bit))
 updateLcd(fanSpeed, temp);

 prevBitPIND0 = PIND0_bit;
 prevBitPIND1 = PIND1_bit;
 }
}
