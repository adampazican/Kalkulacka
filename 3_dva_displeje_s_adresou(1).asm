;Zobrazenie znakov na dvoch displejoch
;Prvy displej: AB0=0
;Druhy displej: AB1=0
;Schema - dva_displeje_s_adresou.schx

	mvi	a,0x0d		;znak '3' 
	out	1110b,a		;1. displej

	mvi	a,0x99		;znak '4'
	out	1101b,a		;2. displej

	mvi	a,0x41
	out	1011b,a		;3. displej

	mvi	a,0
	out	0111b,a		
	eit	

mvi c, 0 ;operacia plus -> 1, minus -> 2, deleno -> 3
mvi d, 0 ;stav 0 -> vyber cisla ; 1-> vyber  cisla, stav 2 -> vyber operacie, stav 3 -> vypocet	
Start:
	cmi d, 2
	jmp Start
	
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
	;TODO: reset displejov :D
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
	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret
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
endPrerus:
	mvi	a,0
	out	0,a	;aktivacia celej klavesnice
	eit
	ret
