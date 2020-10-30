	#include <pic18_chip_select.inc>
	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw	0xff
	movwf	TRISD, A	    ; Port D all inputs
	movff	PORTD, 0x05	    ; Saves value read by PORTD into 0x05
	movlw 	0x0
	movwf	TRISC, A	    ; Port C all outputs
	clrf	LATC, A		    ; Clears the output
	bra 	test
loop:
	movff 	0x06, PORTC
	incf 	0x06, W, A
test:
	movwf	0x06, A		    ; Test for end of loop condition
	movf 	0x05, W
	cpfsgt 	0x06, A
	bra 	loop		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start

	end	main
	hello
