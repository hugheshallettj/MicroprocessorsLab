	#include <pic18_chip_select.inc>
	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw   0x00		    ; portd is always output
	movwf   TRISD, A
	movlw 	0x3
	movwf	PORTD, A	    ; Port D rd0 and rd1 on
	
	
	setf	TRISE		    ; Set port E to inputs
	banksel	PADCFG1		    ; selects bank to the location of PADCFG1
	bsf	REPU		    ; PORT e PULLUPS on
	movlb	0x00		    ; set bsr back to Bank 0
	
	
	bra 	data
	
	movlw	0xff
	movwf	0x20, A		    ; store 255 in FR 0x20 for delay loop
	
	bra	delay
	
	setf	TRISE

delay:	
	decfsz	0x20, f, A	    ; decrement value in 0x20 until 0
	tstfsz	0x20, A		    ; test f, skip if zero
	bra	delay
	return
	
data:	
	movlw	0xAA
	movwf	LATE, A		    ; Storing byte 0xAA in lat E


	end	main
