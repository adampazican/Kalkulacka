;Zobrazenie znakov na dvoch displejoch
;Prvy displej: AB0=0
;Druhy displej: AB1=0
;Schema - dva_displeje_s_adresou.schx

	;mvi	a,0x0d		;znak '3' 
	;out	1110b,a		;1. displej

	;mvi	a,0x99		;znak '4'
	;out	1101b,a		;2. displej

	;mvi	a,0x41
	;out	1011b,a		;3. displej

	;mvi	a,0
	;out	0111b,a		
	;eit	

	mvi	a, 00000011b	;znak '3' 
	out	1110b,a		;1. displej

	mvi	a, 00000011b	;znak '4'
	out	1101b,a		;2. displej

	mvi	a, 00000011b
	out	1011b,a
	eit

mvi c, 0 ;operacia plus -> 1, minus -> 2, deleno -> 3
mvi d, 0 ;stav 0 -> vyber cisla ; 1-> vyber  cisla, stav 2 -> vyber operacie, stav 3 -> vypocet	
Start:
	cmi d, 2
	

	jmp Start
;a je cislo z kt bude pocet jednotiek, b bude pocet desiatiek
recalculate:
	mvi d, 1
	cmi a, 10
	jcy redrawDisplay

	sbi a, 10
	adi b, 1
	jmp recalculate

redrawDisplay: ; b pocet desiatok, a pocet jednotiek, c vypisujeme, d cislo displeja
	cmi b, 0
	jzr vypis0
	cmi b, 1
	jzr vypis1
	cmi b, 2
	jzr vypis2
	cmi b, 3
	jzr vypis3
	cmi b, 4
	jzr vypis4
	cmi b, 5
	jzr vypis5
	cmi b, 6
	jzr vypis6
	cmi b, 7
	jzr vypis7
	cmi b, 8
	jzr vypis8
	cmi b, 9
	jzr vypis9

vypis0:
	mvi	c,00000011b
	jmp vypisNaDisplej
vypis1:
	mvi 	c,10011111b
	jmp vypisNaDisplej
vypis2:
	mvi 	c,00100101b
	jmp vypisNaDisplej
vypis3:
	mvi	c,00001101b
	jmp vypisNaDisplej
vypis4:
	mvi 	c,10011001b
	jmp vypisNaDisplej
vypis5:
	mvi	c,01001001b
	jmp vypisNaDisplej
vypis6:
	mvi	c,01000001b
	jmp vypisNaDisplej
vypis7:
	mvi	c,00011111b
	jmp vypisNaDisplej
vypis8:
	mvi	c,00000001b
	jmp vypisNaDisplej
vypis9:
	mvi	c,00001001b
	jmp vypisNaDisplej
vypisNaDisplej:
	cmi d, 1
	jzr vypisNaDisplej2
	jmp vypisNaDisplej3
vypisNaDisplej2:
	out	1101b,c	
	inc d
	mov b, a
	jmp redrawDisplay	
vypisNaDisplej3:
	out	1011b,c
	jmp endPrerus
int07: 
	mvi a,1110b ;riadok 1
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 0111b 
	jzr nula 

	mvi a,1101b ; riadok 2
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 0111b 
	jzr styri

	mvi a,1011b ; riadok 3
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 0111b 
	jzr osem

	mvi a,0111b ; riadok 4
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 0111b 
	jzr reset
	
	jmp endPrerus
nula:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jzr endPrerus

	mvi b, 0 
	str d, b ;uloz do ramky cislo (nula)
	inc d
	
	jmp endPrerus
styri:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jzr endPrerus

	mvi b,4
	str d, b
	inc d

	jmp endPrerus
osem:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jzr endPrerus

	mvi b,8
	str d, b
	inc d

	jmp endPrerus
reset:
	mvi d, 0

	mvi	a, 00000011b	;znak '3' 
	out	1110b,a		;1. displej

	mvi	a, 00000011b	;znak '4'
	out	1101b,a		;2. displej

	mvi	a, 00000011b
	out	1011b,a

	jmp endPrerus
int11:
	mvi a,1110b ;riadok 1
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 1011b 
	jzr jeden 

	mvi a,1101b ; riadok 2
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 1011b 
	jzr pat

	mvi a,1011b ; riadok 3
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 1011b 
	jzr devet

	mvi a,0111b ; riadok 4
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 1011b 
	jzr plus
	
	jmp endPrerus
jeden:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jzr endPrerus

	mvi b,1
	str d, b
	inc d
	
	jmp endPrerus
pat:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jzr endPrerus

	mvi b,5
	str d, b
	inc d
	
	jmp endPrerus
devet:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jzr endPrerus

	mvi b,9
	str d, b
	inc d
	
	jmp endPrerus
plus:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jnz endPrerus
	mvi b, 0
	ldr b, b

	mvi a, 1
	ldr a, a

	add a, b
	mvi b, 0
	jmp recalculate
int13:
	mvi a,1110b ;riadok 1
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 1101b 
	jzr dva 

	mvi a,1101b ; riadok 2
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 1101b 
	jzr sest

	mvi a,0111b ; riadok 4
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 1101b 
	jzr minus
	
	jmp endPrerus
dva:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jzr endPrerus

	mvi b,2
	str d, b
	inc d
	
	jmp endPrerus
sest:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jzr endPrerus

	mvi b,6
	str d, b
	inc d
	
	jmp endPrerus
minus:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jnz endPrerus

	mvi b, 1
	ldr b, b

	mvi a, 0
	ldr a, a

	sub a, b
	mvi b, 0
	jcy recalculateNegative

	jmp recalculate
recalculateNegative:
	mvi b, 0
	ldr b, b

	mvi a, 1
	ldr a, a

	sub a, b
	mvi b, 0

	mvi	b,11111101b		;znak '-' 
	out	1110b,b

	jmp recalculate
int14:
	mvi a,1110b ;riadok 1
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 1110b 
	jzr tri 

	mvi a,1101b ; riadok 2
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 1110b 
	jzr sedem

	mvi a,0111b ; riadok 4
	out 0111b,a 
	inn a,0 
	ani a, 00001111b 
	cmi a , 1110b 
	jzr krat
	
	jmp endPrerus
tri:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jzr endPrerus

	mvi b,3
	str d, b
	inc d
	
	jmp endPrerus
sedem:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jzr endPrerus

	mvi b,7
	str d, b
	inc d

	jmp endPrerus
krat:
	cmi d, 2 ;zakaze tlacidl0 v mode vyberu operacii
	jnz endPrerus

	mvi b, 1
	ldr b, b

	mvi a, 0
	ldr a, a

	mov c, a
	sbi b, 1

	jmp vynasob

vynasob:
	cmi b, 0
	jzr recalculate

	add a, c
	sbi b, 1

	jmp vynasob
endPrerus:
	mvi	a,0
	out	0111b,a	;aktivacia celej klavesnice
	eit
	ret
