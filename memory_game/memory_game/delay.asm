/*
 * delay.asm
 *
 *  Created: 3/19/2018 1:14:31 PM
 *   Author: chris
 */ 


delay:
    ldi r18, 255 
delay_loop_1:
    ldi r19, 255
delay_loop_2:
    ldi r20, 255
delay_loop_3:
    dec r20
    brne delay_loop_3
    dec r19
    brne delay_loop_2
    dec r18
    brne delay_loop_1
    ret