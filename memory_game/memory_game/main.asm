;
; memory_game.asm
;
; Created: 3/16/2018 10:54:35 AM
; Author : chris
;


start:
	call	display_init
	call	display_welcome
end:
	rjmp	end

; includes
.include "display.asm"
.include "delay.asm"
