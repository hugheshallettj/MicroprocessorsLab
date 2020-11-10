	#include <pic18_chip_select.inc>
#include <xc.inc>



psect code, abs

main:
    org 0x0
    
    goto    start


    org	    0x100	    ; Main code starts here at address 0x100
    
start:
    
    banksel PADCFG1	    ; selects bank to the location of PADCFG1
    bsf	    REPU	    ; PORT e PULLUPS on
    movlb   0x00	    ; set bsr back to Bank 0
    
    clrf    LATE
    
    movlw   0x0f
    movwf   0x30, A
    
;    movwf   TRISE, A	    ; set tristate D value to be 1's for 1st four pins therefore input pins
;    
;    movff   PORTE, 0x30	    ; move the value input at port E to address 0x30

;    movlw   0xf0
;    movwf   TRISE, A	    ; set tristate D value to be 1's for last four pins therefore input pins
;
;    movff   PORTE, 0x40
    
;    movlw   0x0
;    movwf   TRISD, A	    ; PORT F all output
;    clrf    LATF, A	    ; clears the output
;    bra	    loaddata
;    
;loaddata:
;    
;    movf    0x30, W, A
;    iorwf   0x40, W, A
;    movwf   PORTF, A



;    goto 0x0		    ; Re-run program from start



end main