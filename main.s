#include <pic18_chip_select.inc>
#include <xc.inc>


psect code, abs


main:
    org 0x0
    goto    keypad_setup
    org     0x100     ; Main code starts here at address 0x100
 
keypad_setup:   
    clrf    TRISH     ; sets PORTH as output
    banksel PADCFG1     ; selects bank to the location of PADCFG1
    bsf     REPU     ; PORT e PULLUPS on

    movlb   0x00     ; set bsr back to Bank 0

    clrf    LATE     ; sets PORTE as output
    bra	    keypad_loading

keypad_loading:
    movlw   0x0f     ; 00001111 binary for first four bits as input

    movwf   TRISE, A     ; set tristate D value to be 1's for 1st four pins therefore input pins

    movlw   0x18    ; delay length
    movwf   0x10, A
    call    delay

    movff   PORTE, 0x30     ; move the value input at port E to address 0x30

    movlw   0xf0     ; 11110000 binary for last four bits as input

    movwf   TRISE, A     ; set tristate D value to be 1's for last four pins therefore input pins

    movlw   0x18     ; delay length
    movwf   0x10, A    
    call    delay   

    movff   PORTE, 0x40    

    movlw   0x0

    bra     loaddata

loaddata:

    movf    0x30, W, A
    iorwf   0x40, W, A
    movwf   0x50, A
    movff   0x50, PORTH, A

    goto    keypad_loading     ; Re-run program from start

delay:

    decfsz  0x10, F, A
    bra     delay
    return


end main