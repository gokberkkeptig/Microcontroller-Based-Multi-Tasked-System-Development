
_checkTemp:

;G_kberkfinal.c,15 :: 		unsigned int checkTemp()
;G_kberkfinal.c,18 :: 		ADCSRA |= (1 << ADSC); // start conversion
	IN         R27, ADCSRA+0
	SBR        R27, 64
	OUT        ADCSRA+0, R27
;G_kberkfinal.c,19 :: 		while ((ADCSRA & (1 << ADIF)) != 0); // wait for end of conversion
L_checkTemp0:
	IN         R16, ADCSRA+0
	ANDI       R16, 16
	CPI        R16, 0
	BRNE       L__checkTemp59
	JMP        L_checkTemp1
L__checkTemp59:
	JMP        L_checkTemp0
L_checkTemp1:
;G_kberkfinal.c,20 :: 		analogTempHigh = ADCH; // send the high byte
; analogTempHigh start address is: 20 (R20)
	IN         R20, ADCH+0
	LDI        R21, 0
;G_kberkfinal.c,21 :: 		ADCSRA |= (1 << ADIF); // write 1 to clear ADIF flag
	IN         R16, ADCSRA+0
	ORI        R16, 16
	OUT        ADCSRA+0, R16
;G_kberkfinal.c,22 :: 		val = ((unsigned int)(analogTempHigh * 0.39215686274));  //(100/255)
	MOVW       R16, R20
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
; analogTempHigh end address is: 20 (R20)
	LDI        R20, 201
	LDI        R21, 200
	LDI        R22, 200
	LDI        R23, 62
	CALL       _float_fpmul1+0
	CALL       _float_fpint+0
;G_kberkfinal.c,24 :: 		return val;
;G_kberkfinal.c,26 :: 		}
L_end_checkTemp:
	RET
; end of _checkTemp

_displayLcd2:

;G_kberkfinal.c,28 :: 		void displayLcd2(char* tempatureStr)
;G_kberkfinal.c,30 :: 		Lcd_Out(2, 1, "T:");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R3
	PUSH       R2
	LDI        R27, #lo_addr(?lstr1_G_kberkfinal+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_G_kberkfinal+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	POP        R2
	POP        R3
;G_kberkfinal.c,31 :: 		Lcd_Out(2, 4, tempatureStr);
	MOVW       R4, R2
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;G_kberkfinal.c,32 :: 		Lcd_Out(2, 9, "C");
	LDI        R27, #lo_addr(?lstr2_G_kberkfinal+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr2_G_kberkfinal+0)
	MOV        R5, R27
	LDI        R27, 9
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;G_kberkfinal.c,33 :: 		}
L_end_displayLcd2:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _displayLcd2

_displayLcd1:

;G_kberkfinal.c,36 :: 		void displayLcd1(char* fanSpeedStr)
;G_kberkfinal.c,38 :: 		Lcd_Out(1, 1, "FS:");
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R3
	PUSH       R2
	LDI        R27, #lo_addr(?lstr3_G_kberkfinal+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr3_G_kberkfinal+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	POP        R2
	POP        R3
;G_kberkfinal.c,39 :: 		Lcd_Out(1, 4, fanSpeedStr);
	MOVW       R4, R2
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;G_kberkfinal.c,40 :: 		}
L_end_displayLcd1:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _displayLcd1

_updateLcd:

;G_kberkfinal.c,45 :: 		void updateLcd(unsigned int fanSpeed, unsigned int temp)
;G_kberkfinal.c,48 :: 		IntToStr(fanSpeed, fanSpeedStr);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R5
	PUSH       R4
	LDI        R27, #lo_addr(_fanSpeedStr+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_fanSpeedStr+0)
	MOV        R5, R27
	CALL       _IntToStr+0
	POP        R4
	POP        R5
;G_kberkfinal.c,49 :: 		IntToStr(temp, tempatureStr);
	MOVW       R2, R4
	LDI        R27, #lo_addr(_tempatureStr+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_tempatureStr+0)
	MOV        R5, R27
	CALL       _IntToStr+0
;G_kberkfinal.c,51 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;G_kberkfinal.c,52 :: 		if ((PIND & 1 << 1) != 0)
	IN         R16, PIND+0
	ANDI       R16, 2
	CPI        R16, 0
	BRNE       L__updateLcd63
	JMP        L_updateLcd2
L__updateLcd63:
;G_kberkfinal.c,53 :: 		displayLcd1(fanSpeedStr + 1);
	LDI        R27, #lo_addr(_fanSpeedStr+1)
	MOV        R2, R27
	LDI        R27, hi_addr(_fanSpeedStr+1)
	MOV        R3, R27
	CALL       _displayLcd1+0
L_updateLcd2:
;G_kberkfinal.c,56 :: 		if ((PIND & 1 << 0) != 0)
	IN         R16, PIND+0
	ANDI       R16, 1
	CPI        R16, 0
	BRNE       L__updateLcd64
	JMP        L_updateLcd3
L__updateLcd64:
;G_kberkfinal.c,57 :: 		displayLcd2(tempatureStr + 1);
	LDI        R27, #lo_addr(_tempatureStr+1)
	MOV        R2, R27
	LDI        R27, hi_addr(_tempatureStr+1)
	MOV        R3, R27
	CALL       _displayLcd2+0
L_updateLcd3:
;G_kberkfinal.c,58 :: 		}
L_end_updateLcd:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _updateLcd

_displayLeds:

;G_kberkfinal.c,61 :: 		void displayLeds(unsigned int t)
;G_kberkfinal.c,63 :: 		if (t > 8) {
	LDI        R16, 8
	LDI        R17, 0
	CP         R16, R2
	CPC        R17, R3
	BRLO       L__displayLeds66
	JMP        L_displayLeds4
L__displayLeds66:
;G_kberkfinal.c,64 :: 		t = 8;
	LDI        R27, 8
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
;G_kberkfinal.c,65 :: 		}
L_displayLeds4:
;G_kberkfinal.c,67 :: 		chForPortA = 0x01;
	LDI        R27, 1
	STS        _chForPortA+0, R27
;G_kberkfinal.c,68 :: 		while (t > 0) {
L_displayLeds5:
	LDI        R16, 0
	LDI        R17, 0
	CP         R16, R2
	CPC        R17, R3
	BRLO       L__displayLeds67
	JMP        L_displayLeds6
L__displayLeds67:
;G_kberkfinal.c,69 :: 		t--;
	MOVW       R16, R2
	SUBI       R16, 1
	SBCI       R17, 0
	MOVW       R2, R16
;G_kberkfinal.c,70 :: 		chForPortA = (chForPortA * 2) + 1;
	LDS        R16, _chForPortA+0
	LSL        R16
	SUBI       R16, 255
	STS        _chForPortA+0, R16
;G_kberkfinal.c,71 :: 		}
	JMP        L_displayLeds5
L_displayLeds6:
;G_kberkfinal.c,72 :: 		PORTA = chForPortA;
	LDS        R16, _chForPortA+0
	OUT        PORTA+0, R16
;G_kberkfinal.c,73 :: 		}
L_end_displayLeds:
	RET
; end of _displayLeds

_squareWave:

;G_kberkfinal.c,75 :: 		void squareWave()
;G_kberkfinal.c,77 :: 		TIMSK |= (1 << OCIE2);
	IN         R27, TIMSK+0
	SBR        R27, 128
	OUT        TIMSK+0, R27
;G_kberkfinal.c,78 :: 		DDRC |= 0b00000010;
	IN         R16, DDRC+0
	ORI        R16, 2
	OUT        DDRC+0, R16
;G_kberkfinal.c,79 :: 		PORTC |= 0b00000010;
	IN         R16, PORTC+0
	ORI        R16, 2
	OUT        PORTC+0, R16
;G_kberkfinal.c,80 :: 		TCCR2 = 0x0B;
	LDI        R27, 11
	OUT        TCCR2+0, R27
;G_kberkfinal.c,81 :: 		OCR2 = 39;
	LDI        R27, 39
	OUT        OCR2+0, R27
;G_kberkfinal.c,82 :: 		}
L_end_squareWave:
	RET
; end of _squareWave

_holdSound:

;G_kberkfinal.c,84 :: 		void holdSound()
;G_kberkfinal.c,87 :: 		TCCR2 = 0x00; // Stopping timer
	LDI        R27, 0
	OUT        TCCR2+0, R27
;G_kberkfinal.c,88 :: 		TIMSK &= ~(1 << OCIE2); // Disable interrupt for timer 2. //clear
	IN         R16, TIMSK+0
	ANDI       R16, 127
	OUT        TIMSK+0, R16
;G_kberkfinal.c,89 :: 		PORTC &= ~(1 << 1);  //clear
	IN         R27, PORTC+0
	CBR        R27, 2
	OUT        PORTC+0, R27
;G_kberkfinal.c,91 :: 		}
L_end_holdSound:
	RET
; end of _holdSound

_twoSecs:

;G_kberkfinal.c,94 :: 		void twoSecs() // enabling the 2k wave
;G_kberkfinal.c,96 :: 		TCCR1A = 0x00;
	LDI        R27, 0
	OUT        TCCR1A+0, R27
;G_kberkfinal.c,97 :: 		TCCR1B = 0x0D; ; // presacaler 1:1024 (CSn2, CSn0), CTC mode
	LDI        R27, 13
	OUT        TCCR1B+0, R27
;G_kberkfinal.c,98 :: 		OCR1AH = 0x4C; //counter high
	LDI        R27, 76
	OUT        OCR1AH+0, R27
;G_kberkfinal.c,99 :: 		OCR1AL = 0x4C; // counter low
	LDI        R27, 76
	OUT        OCR1AL+0, R27
;G_kberkfinal.c,100 :: 		TIMSK |= (1 << OCIE1A);
	IN         R27, TIMSK+0
	SBR        R27, 16
	OUT        TIMSK+0, R27
;G_kberkfinal.c,102 :: 		squareWave();
	CALL       _squareWave+0
;G_kberkfinal.c,103 :: 		}
L_end_twoSecs:
	RET
; end of _twoSecs

_Timer2Compare_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;G_kberkfinal.c,105 :: 		void Timer2Compare_ISR() iv IVT_ADDR_TIMER2_COMP
;G_kberkfinal.c,107 :: 		PORTC ^= 0x02;
	IN         R16, PORTC+0
	LDI        R27, 2
	EOR        R16, R27
	OUT        PORTC+0, R16
;G_kberkfinal.c,108 :: 		}
L_end_Timer2Compare_ISR:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Timer2Compare_ISR

_Timer1Compare_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;G_kberkfinal.c,110 :: 		void Timer1Compare_ISR() iv IVT_ADDR_TIMER1_COMPA // stop it
;G_kberkfinal.c,112 :: 		holdSound();
	CALL       _holdSound+0
;G_kberkfinal.c,113 :: 		}
L_end_Timer1Compare_ISR:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Timer1Compare_ISR

_changeFanSpeed:

;G_kberkfinal.c,116 :: 		int changeFanSpeed(unsigned int temp)
;G_kberkfinal.c,118 :: 		fanSpeed = 0;
	LDI        R27, 0
	STS        _fanSpeed+0, R27
	STS        _fanSpeed+1, R27
;G_kberkfinal.c,119 :: 		if (temp == 30) {
	LDI        R27, 0
	CP         R3, R27
	BRNE       L__changeFanSpeed74
	LDI        R27, 30
	CP         R2, R27
L__changeFanSpeed74:
	BREQ       L__changeFanSpeed75
	JMP        L_changeFanSpeed7
L__changeFanSpeed75:
;G_kberkfinal.c,120 :: 		fanSpeed = 1;
	LDI        R27, 1
	STS        _fanSpeed+0, R27
	LDI        R27, 0
	STS        _fanSpeed+1, R27
;G_kberkfinal.c,121 :: 		}
	JMP        L_changeFanSpeed8
L_changeFanSpeed7:
;G_kberkfinal.c,122 :: 		else if (temp > 30) {
	LDI        R16, 30
	LDI        R17, 0
	CP         R16, R2
	CPC        R17, R3
	BRLO       L__changeFanSpeed76
	JMP        L_changeFanSpeed9
L__changeFanSpeed76:
;G_kberkfinal.c,123 :: 		fanSpeed = (int)((temp - 30) * (1.42857142857)); // 100/70 using after 30 degree
	MOVW       R16, R2
	SUBI       R16, 30
	SBCI       R17, 0
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	LDI        R20, 110
	LDI        R21, 219
	LDI        R22, 182
	LDI        R23, 63
	CALL       _float_fpmul1+0
	CALL       _float_fpint+0
	STS        _fanSpeed+0, R16
	STS        _fanSpeed+1, R17
;G_kberkfinal.c,124 :: 		}
L_changeFanSpeed9:
L_changeFanSpeed8:
;G_kberkfinal.c,125 :: 		OCR0 = (int)(fanSpeed * 2.55);  //255/100
	LDS        R16, _fanSpeed+0
	LDS        R17, _fanSpeed+1
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	CALL       _float_slong2fp+0
	LDI        R20, 51
	LDI        R21, 51
	LDI        R22, 35
	LDI        R23, 64
	CALL       _float_fpmul1+0
	CALL       _float_fpint+0
	OUT        OCR0+0, R16
;G_kberkfinal.c,127 :: 		return fanSpeed;
	LDS        R16, _fanSpeed+0
	LDS        R17, _fanSpeed+1
;G_kberkfinal.c,128 :: 		}
L_end_changeFanSpeed:
	RET
; end of _changeFanSpeed

_setText:

;G_kberkfinal.c,130 :: 		void  setText(char* text)
;G_kberkfinal.c,133 :: 		text[0] = UDR0;
	IN         R16, UDR0+0
	MOVW       R30, R2
	ST         Z, R16
;G_kberkfinal.c,134 :: 		}
L_end_setText:
	RET
; end of _setText

_getText:

;G_kberkfinal.c,136 :: 		void getText(char* text)
;G_kberkfinal.c,138 :: 		char i = 0;
; i start address is: 17 (R17)
	LDI        R17, 0
; i end address is: 17 (R17)
;G_kberkfinal.c,139 :: 		while (text[i] != '\0')
L_getText10:
; i start address is: 17 (R17)
	MOV        R30, R17
	LDI        R31, 0
	ADD        R30, R2
	ADC        R31, R3
	LD         R16, Z
	CPI        R16, 0
	BRNE       L__getText79
	JMP        L_getText11
L__getText79:
; i end address is: 17 (R17)
;G_kberkfinal.c,141 :: 		while (!(UCSR0A & (1 << UDRE0)));
L_getText12:
; i start address is: 17 (R17)
	IN         R16, UCSR0A+0
	SBRC       R16, 5
	JMP        L_getText13
	JMP        L_getText12
L_getText13:
;G_kberkfinal.c,142 :: 		UDR0 = text[i];
	MOV        R30, R17
	LDI        R31, 0
	ADD        R30, R2
	ADC        R31, R3
	LD         R16, Z
	OUT        UDR0+0, R16
;G_kberkfinal.c,143 :: 		i = i + 1;
	MOV        R16, R17
	SUBI       R16, 255
	MOV        R17, R16
;G_kberkfinal.c,144 :: 		}
; i end address is: 17 (R17)
	JMP        L_getText10
L_getText11:
;G_kberkfinal.c,145 :: 		}
L_end_getText:
	RET
; end of _getText

_addNewLine:

;G_kberkfinal.c,147 :: 		void addNewLine()
;G_kberkfinal.c,149 :: 		while (!(UCSR0A & (1 << UDRE0)));
L_addNewLine14:
	IN         R16, UCSR0A+0
	SBRC       R16, 5
	JMP        L_addNewLine15
	JMP        L_addNewLine14
L_addNewLine15:
;G_kberkfinal.c,150 :: 		UDR0 = 13;
	LDI        R27, 13
	OUT        UDR0+0, R27
;G_kberkfinal.c,151 :: 		}
L_end_addNewLine:
	RET
; end of _addNewLine

_inputType:

;G_kberkfinal.c,153 :: 		char inputType(char* str)
;G_kberkfinal.c,155 :: 		char type = 'n';
; type start address is: 17 (R17)
	LDI        R17, 110
;G_kberkfinal.c,156 :: 		if (str[0] == 'T' || str[0] == 't') {
	MOVW       R30, R2
	LD         R16, Z
	CPI        R16, 84
	BRNE       L__inputType82
	JMP        L__inputType44
L__inputType82:
	MOVW       R30, R2
	LD         R16, Z
	CPI        R16, 116
	BRNE       L__inputType83
	JMP        L__inputType43
L__inputType83:
	JMP        L_inputType18
; type end address is: 17 (R17)
L__inputType44:
L__inputType43:
;G_kberkfinal.c,157 :: 		type = 't';
; type start address is: 17 (R17)
	LDI        R17, 116
;G_kberkfinal.c,158 :: 		}
	JMP        L_inputType19
L_inputType18:
;G_kberkfinal.c,159 :: 		else if (str[0] == 'S' || str[0] == 's') {
	MOVW       R30, R2
	LD         R16, Z
	CPI        R16, 83
	BRNE       L__inputType84
	JMP        L__inputType46
L__inputType84:
	MOVW       R30, R2
	LD         R16, Z
	CPI        R16, 115
	BRNE       L__inputType85
	JMP        L__inputType45
L__inputType85:
; type end address is: 17 (R17)
	JMP        L_inputType22
L__inputType46:
L__inputType45:
;G_kberkfinal.c,160 :: 		type = 's';
; type start address is: 16 (R16)
	LDI        R16, 115
; type end address is: 16 (R16)
	MOV        R17, R16
;G_kberkfinal.c,161 :: 		}
L_inputType22:
; type start address is: 17 (R17)
; type end address is: 17 (R17)
L_inputType19:
;G_kberkfinal.c,163 :: 		return type;
; type start address is: 17 (R17)
	MOV        R16, R17
; type end address is: 17 (R17)
;G_kberkfinal.c,164 :: 		}
L_end_inputType:
	RET
; end of _inputType

_request:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 3
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;G_kberkfinal.c,166 :: 		void request() iv IVT_ADDR_USART0__RX // interrupt function!
;G_kberkfinal.c,170 :: 		setText(recievedText);
	PUSH       R2
	PUSH       R3
	MOVW       R16, R28
	MOVW       R2, R16
	CALL       _setText+0
;G_kberkfinal.c,172 :: 		switch (inputType(recievedText)) //make actions for type we get
	MOVW       R16, R28
	MOVW       R2, R16
	CALL       _inputType+0
	STD        Y+2, R16
	JMP        L_request23
;G_kberkfinal.c,174 :: 		case 't':
L_request25:
;G_kberkfinal.c,175 :: 		getText(tempatureStr);
	LDI        R27, #lo_addr(_tempatureStr+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_tempatureStr+0)
	MOV        R3, R27
	CALL       _getText+0
;G_kberkfinal.c,176 :: 		addNewLine();
	CALL       _addNewLine+0
;G_kberkfinal.c,177 :: 		getText("Enter S for % fan speed and T for temperature:");
	LDI        R27, #lo_addr(?lstr4_G_kberkfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr4_G_kberkfinal+0)
	MOV        R3, R27
	CALL       _getText+0
;G_kberkfinal.c,178 :: 		break;
	JMP        L_request24
;G_kberkfinal.c,179 :: 		case 's':      //fan speed!
L_request26:
;G_kberkfinal.c,180 :: 		getText(fanSpeedStr);
	LDI        R27, #lo_addr(_fanSpeedStr+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_fanSpeedStr+0)
	MOV        R3, R27
	CALL       _getText+0
;G_kberkfinal.c,181 :: 		addNewLine();
	CALL       _addNewLine+0
;G_kberkfinal.c,182 :: 		getText("Enter S for % fan speed and T for temperature:");
	LDI        R27, #lo_addr(?lstr5_G_kberkfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr5_G_kberkfinal+0)
	MOV        R3, R27
	CALL       _getText+0
;G_kberkfinal.c,183 :: 		break;
	JMP        L_request24
;G_kberkfinal.c,184 :: 		case 'n':   //wrong input!
L_request27:
;G_kberkfinal.c,185 :: 		getText("Wrong Input!");
	LDI        R27, #lo_addr(?lstr6_G_kberkfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr6_G_kberkfinal+0)
	MOV        R3, R27
	CALL       _getText+0
;G_kberkfinal.c,186 :: 		addNewLine();
	CALL       _addNewLine+0
;G_kberkfinal.c,187 :: 		getText("Enter S for % fan speed and T for temperature:");
	LDI        R27, #lo_addr(?lstr7_G_kberkfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr7_G_kberkfinal+0)
	MOV        R3, R27
	CALL       _getText+0
;G_kberkfinal.c,188 :: 		break;
	JMP        L_request24
;G_kberkfinal.c,190 :: 		}
L_request23:
	LDD        R16, Y+2
	CPI        R16, 116
	BRNE       L__request87
	JMP        L_request25
L__request87:
	CPI        R16, 115
	BRNE       L__request88
	JMP        L_request26
L__request88:
	CPI        R16, 110
	BRNE       L__request89
	JMP        L_request27
L__request89:
L_request24:
;G_kberkfinal.c,192 :: 		}
L_end_request:
	POP        R3
	POP        R2
	ADIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _request

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;G_kberkfinal.c,202 :: 		void main()
;G_kberkfinal.c,204 :: 		DDRA = 0xFF; // Port A is output for LEDS
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 255
	OUT        DDRA+0, R27
;G_kberkfinal.c,205 :: 		DDRB = 0xFF; // lcd
	LDI        R27, 255
	OUT        DDRB+0, R27
;G_kberkfinal.c,206 :: 		DDRC |= 0x02; // lcd
	IN         R27, DDRC+0
	SBR        R27, 2
	OUT        DDRC+0, R27
;G_kberkfinal.c,207 :: 		DDRD = 0x00;
	LDI        R27, 0
	OUT        DDRD+0, R27
;G_kberkfinal.c,208 :: 		DDRF = 0x00; //  Port F input mode for ADC input
	LDI        R27, 0
	STS        DDRF+0, R27
;G_kberkfinal.c,209 :: 		ADMUX = (1 << ADLAR);
	LDI        R27, 32
	OUT        ADMUX+0, R27
;G_kberkfinal.c,210 :: 		ADCSRA = 0x87;
	LDI        R27, 135
	OUT        ADCSRA+0, R27
;G_kberkfinal.c,211 :: 		Lcd_Init(); // turn On LCD
	CALL       _Lcd_Init+0
;G_kberkfinal.c,212 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cno cursor
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;G_kberkfinal.c,213 :: 		Lcd_Cmd(_LCD_CLEAR); // lcd display clear
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;G_kberkfinal.c,214 :: 		TCCR0 = 0x65;
	LDI        R27, 101
	OUT        TCCR0+0, R27
;G_kberkfinal.c,215 :: 		SREG_I_bit = 1; // Enable Interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;G_kberkfinal.c,217 :: 		TIMSK |= (1 << OCIE2);
	IN         R16, TIMSK+0
	ORI        R16, 128
	OUT        TIMSK+0, R16
;G_kberkfinal.c,218 :: 		TIMSK |= (1 << OCIE3A);
	ORI        R16, 16
	OUT        TIMSK+0, R16
;G_kberkfinal.c,220 :: 		UCSR0B = (1 << RXEN0) | (1 << TXEN0) | (1 << RXCIE0);
	LDI        R27, 152
	OUT        UCSR0B+0, R27
;G_kberkfinal.c,221 :: 		UCSR0C = (1 << UCSZ01) | (1 << UCSZ00);
	LDI        R27, 6
	STS        UCSR0C+0, R27
;G_kberkfinal.c,222 :: 		UBRR0H = 0;
	LDI        R27, 0
	STS        UBRR0H+0, R27
;G_kberkfinal.c,223 :: 		UBRR0L = 65;
	LDI        R27, 65
	OUT        UBRR0L+0, R27
;G_kberkfinal.c,225 :: 		getText("Enter S for % fan speed and T for temperature:");
	LDI        R27, #lo_addr(?lstr8_G_kberkfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr8_G_kberkfinal+0)
	MOV        R3, R27
	CALL       _getText+0
;G_kberkfinal.c,226 :: 		while (1) {
L_main28:
;G_kberkfinal.c,227 :: 		previousTemp = temp;
	LDS        R16, _temp+0
	LDS        R17, _temp+1
	STS        _previousTemp+0, R16
	STS        _previousTemp+1, R17
;G_kberkfinal.c,228 :: 		temp = checkTemp();
	CALL       _checkTemp+0
	STS        _temp+0, R16
	STS        _temp+1, R17
;G_kberkfinal.c,231 :: 		if ((PIND & 1 << 3) == 0)
	IN         R16, PIND+0
	ANDI       R16, 8
	CPI        R16, 0
	BREQ       L__main91
	JMP        L_main30
L__main91:
;G_kberkfinal.c,232 :: 		PORTA = 0x00;
	LDI        R27, 0
	OUT        PORTA+0, R27
	JMP        L_main31
L_main30:
;G_kberkfinal.c,236 :: 		displayLeds((int)(temp / 12.5));
	LDS        R16, _temp+0
	LDS        R17, _temp+1
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 72
	LDI        R23, 65
	CALL       _float_fpdiv1+0
	CALL       _float_fpint+0
	MOVW       R2, R16
	CALL       _displayLeds+0
;G_kberkfinal.c,237 :: 		}
L_main31:
;G_kberkfinal.c,239 :: 		if ((PIND & 1 << 2) == 0 || temp < 30) {
	IN         R16, PIND+0
	ANDI       R16, 4
	CPI        R16, 0
	BRNE       L__main92
	JMP        L__main51
L__main92:
	LDS        R16, _temp+0
	LDS        R17, _temp+1
	CPI        R17, 0
	BRNE       L__main93
	CPI        R16, 30
L__main93:
	BRSH       L__main94
	JMP        L__main50
L__main94:
	JMP        L_main34
L__main51:
L__main50:
;G_kberkfinal.c,240 :: 		holdSound();
	CALL       _holdSound+0
;G_kberkfinal.c,241 :: 		didBuzzerRing = 0;
	LDI        R27, 0
	STS        _didBuzzerRing+0, R27
	STS        _didBuzzerRing+1, R27
;G_kberkfinal.c,242 :: 		}
L_main34:
;G_kberkfinal.c,244 :: 		if (temp >= 30 && ((PIND & 1 << 2) != 0) && (!didBuzzerRing)) {
	LDS        R16, _temp+0
	LDS        R17, _temp+1
	CPI        R17, 0
	BRNE       L__main95
	CPI        R16, 30
L__main95:
	BRSH       L__main96
	JMP        L__main54
L__main96:
	IN         R16, PIND+0
	ANDI       R16, 4
	CPI        R16, 0
	BRNE       L__main97
	JMP        L__main53
L__main97:
	LDS        R16, _didBuzzerRing+0
	LDS        R17, _didBuzzerRing+1
	MOV        R27, R16
	OR         R27, R17
	BREQ       L__main98
	JMP        L__main52
L__main98:
L__main48:
;G_kberkfinal.c,245 :: 		twoSecs();
	CALL       _twoSecs+0
;G_kberkfinal.c,246 :: 		didBuzzerRing = 1;
	LDI        R27, 1
	STS        _didBuzzerRing+0, R27
	LDI        R27, 0
	STS        _didBuzzerRing+1, R27
;G_kberkfinal.c,244 :: 		if (temp >= 30 && ((PIND & 1 << 2) != 0) && (!didBuzzerRing)) {
L__main54:
L__main53:
L__main52:
;G_kberkfinal.c,249 :: 		previousFanSpeed = fanSpeed;
	LDS        R16, _fanSpeed+0
	LDS        R17, _fanSpeed+1
	STS        _previousFanSpeed+0, R16
	STS        _previousFanSpeed+1, R17
;G_kberkfinal.c,250 :: 		fanSpeed = changeFanSpeed(temp);
	LDS        R2, _temp+0
	LDS        R3, _temp+1
	CALL       _changeFanSpeed+0
	STS        _fanSpeed+0, R16
	STS        _fanSpeed+1, R17
;G_kberkfinal.c,252 :: 		if ((prevBitPIND0 != PIND0_bit) || (previousTemp != temp) ||  (prevBitPIND1 != PIND1_bit))
	IN         R0, PIND0_bit+0
	CLR        R17
	SBRC       R0, BitPos(PIND0_bit+0)
	INC        R17
	LDS        R16, _prevBitPIND0+0
	CP         R16, R17
	BREQ       L__main99
	JMP        L__main57
L__main99:
	LDS        R18, _previousTemp+0
	LDS        R19, _previousTemp+1
	LDS        R16, _temp+0
	LDS        R17, _temp+1
	CP         R18, R16
	CPC        R19, R17
	BREQ       L__main100
	JMP        L__main56
L__main100:
	IN         R0, PIND1_bit+0
	CLR        R17
	SBRC       R0, BitPos(PIND1_bit+0)
	INC        R17
	LDS        R16, _prevBitPIND1+0
	CP         R16, R17
	BREQ       L__main101
	JMP        L__main55
L__main101:
	JMP        L_main40
L__main57:
L__main56:
L__main55:
;G_kberkfinal.c,253 :: 		updateLcd(fanSpeed, temp);
	LDS        R4, _temp+0
	LDS        R5, _temp+1
	LDS        R2, _fanSpeed+0
	LDS        R3, _fanSpeed+1
	CALL       _updateLcd+0
L_main40:
;G_kberkfinal.c,255 :: 		prevBitPIND0 = PIND0_bit;
	IN         R0, PIND0_bit+0
	CLR        R27
	SBRC       R0, BitPos(PIND0_bit+0)
	INC        R27
	STS        _prevBitPIND0+0, R27
;G_kberkfinal.c,256 :: 		prevBitPIND1 = PIND1_bit;
	IN         R0, PIND1_bit+0
	CLR        R27
	SBRC       R0, BitPos(PIND1_bit+0)
	INC        R27
	STS        _prevBitPIND1+0, R27
;G_kberkfinal.c,257 :: 		}
	JMP        L_main28
;G_kberkfinal.c,258 :: 		}
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
