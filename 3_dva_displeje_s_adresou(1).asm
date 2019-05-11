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
mvi d, 0 ;stav 0 -> vyber cisla ; 1-> vyber operacie, stav 2 -> vyber cisla , stav 3 -> vypocet	
Start:

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
	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret


nula:
	mvi D,0
	pus d
	;scall dsp	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret

styri:
	mvi D,4
	pus d
	;scall dsp	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret
osem:
	mvi D,8
	pus d
	;scall dsp	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret

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
	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret
jeden:
	mvi D,1
	pus d
	;scall dsp	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret
pat:
	mvi D,5
	pus d
	;scall dsp	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret
devet:
	mvi D,9
	pus d
	;scall dsp	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret
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
	mvi D,2
	pus d
	;scall dsp	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret
sest:
	mvi D,6
	pus d
	;scall dsp	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret
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
	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret

tri:
	mvi D,3
	pus d
	;scall dsp	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret
sedem:
	mvi D,7
	pus d
	;scall dsp	
	mvi	a,0
	out	0,a		;aktivacia celej klavesnice
	eit
	ret