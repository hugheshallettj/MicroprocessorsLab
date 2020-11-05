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
	movlw 	11B
	movwf	PORTD, A	    ; Port D rd0 and rd1 on
	
	
	setf	TRISE, A	    ; Set port E to inputs
	banksel	PADCFG1		    ; selects bank to the location of PADCFG1
	bsf	REPU		    ; PORT e PULLUPS on
	movlb	0x00		    ; set bsr back to Bank 0
	
loop:	
	call 	dataout1	    ; go to dataout
	
	movlw	01B		    ; output enable turned off so that memory is
				    ; is transferred to data bus
	movwf	LATD, A
	
	goto	loop		    ; end of code
	
dataout1:	
	clrf	TRISE, A	    ; Clears the tri-state register
	movlw	0xAA		    ; Random number chosen (10101010 in binary)
	movwf	LATE, A		    ; Storing byte 0xAA in lat E
	call	clkpls1		    ; go to clkpls1
	setf	TRISE, A	    ; sets port E to inputs
	return			    ; returns to line 26

clkpls1:
	movlw	10B		    ; Port D rd1 kept on, but rd0 turned off to
	movwf	LATD, A		    ; initiate clock pulse
	nop			    
	nop
	nop			    ; delays for clock pulse
	nop
	movlw	11B		    ; clock pulse turned back on - end of pluse.
	movwf	LATD, A		    ; Leading edge of clock pulse turned back on
				    ; causes date stored in PortE to be moved to
				    ; memory chip.
	
	return			    ; returns to line 37
	
	end	main
