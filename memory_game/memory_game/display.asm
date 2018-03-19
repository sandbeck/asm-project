/*
 * display.asm
 *
 *  Created: 3/19/2018 12:27:01 PM
 *   Author: chris
 */ 

.def	param_length = r25
.def	temp = r16

; initialization
display_init:
	push	temp

	ldi		temp, 0xff
	out		ddra, temp								; port A -> output
	out		porta, temp								; turn off all

	pop		temp
	ret
	

display_welcome:
	push	ZH
	push	ZL
	push	param_length

	ldi		ZH, high(_display_welcome_seq<<1)		; load the position of patterns
	ldi		ZL, low(_display_welcome_seq<<1)		; to display into the Z-pointer
	ldi		param_length, 8							; load length of data
	call	_display_do								; call generic display routine

	pop		param_length
	pop		ZL
	pop		ZH
	ret


_display_do:
	push	temp
_display_do_loop:
	lpm		temp, Z+								; load byte from program memory
	out		porta, temp								; send pattern to port A
	call delay										; delay 100ms
	dec		param_length							; decrement counter
	brne	_display_do_loop						; jump back if not done

	pop		temp
	ret

_display_welcome_seq: .db 0xe7, 0xdb, 0xbd, 0x7e, 0xbd, 0xdb, 0xe7, 0xff