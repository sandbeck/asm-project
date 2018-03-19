;
; memory_game.asm
;
; Created: 3/16/2018 10:54:35 AM
; Author : chris
;

.def	temp = r16

.def	round_no = r25
.def	input_no = r24

.equ	RAM_BEGIN = 0x200

init:								; setup
	ldi		temp, high(RAMEND)		; stack pointer init
	out		sph, temp
	ldi		temp, low(RAMEND)
	out		spl, temp

	call	display_init			; init display
	call	input_init				; init inputs

start:								; while (true) {
	call	display_welcome			;     ShowWelcome()
	clr		round_no				;     reset round number

	clr		temp					;     while (no user input) {
	push	temp					
	call	input_get
	pop		temp					;         wait to start
									;     }
round_begin:						;     do {
	inc		round_no				; round++
	
	clr		temp					; ***** CALL SITE *****
	push	temp					; (return value)
	ldi		temp, high(RAM_BEGIN)
	push	temp					; (1st param, high byte)
	ldi		temp, low(RAM_BEGIN)
	push	temp					; (1st param, low byte)
	push	round_no				; (2nd param)
	call	random_sequence			; RandomSequence(start, length)
	pop		temp
	pop		temp
	pop		temp
	pop		temp					; ***** CALL SITE END *****

	clr		temp					; ***** CALL SITE *****
	push	temp					; (return value)
	ldi		temp, high(RAM_BEGIN)
	push	temp
	ldi		temp, low(RAM_BEGIN)
	push	temp	
	push	round_no				; (2nd param)
	call	display_sequence ;         ShowSequence(start, length)
	pop		temp
	pop		temp
	pop		temp
	pop		temp					; ***** CALL SITE END *****

	clr		input_no
verify_next:						;         do {
	inc		input_no
	clr		temp					;             read input
	push	temp
	call	input_get
	pop		temp
	cp		temp, r17				;             if (input != expected) {
	brne	failed					;                 failed = true
									;				  break
									;             }
	cp		input_no, round_no		;         } while (inputs from user < round)
	brlo	verify_next
	
	call	display_confirmation	;         showConfirmation()
	rjmp	round_begin				;     } while (!failed)
failed:
	rjmp	start					; }



random_sequence:
	

; includes
.include "display.asm"
.include "delay.asm"
.include "input.asm"
