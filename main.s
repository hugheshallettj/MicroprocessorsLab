	#include <pic18_chip_select.inc>
	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw 	0x3
	movwf	TRISD, A	    ; Port D rd0 and rd1 on
	movlw	0x0
	movwf	TRISE, A	    ; Port E to outputs
	
	bra 	data
	
data:	
	movlw	0xAA
	movwf	LATE, A		    ; Storing byte 0xAA in lat E


	end	main
