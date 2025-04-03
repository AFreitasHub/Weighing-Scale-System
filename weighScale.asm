; Perifericos
ON/OFF			EQU	1A0H	; On/Off button's address
SEL_NR_MENU		EQU	1B0H	; Option selected input address
OK			EQU	1C0H	; Confirmation input address
CHANGE			EQU	1D0H	; Change/Edit input address
CANCEL			EQU	1E0H	; Cancel/Go back input address
PESO			EQU	1F0H	;
					
; Display 7x16				
DISPLAY_START		EQU	200H	; Start of the 7x16 display
DISPLAY_END		EQU	26FH	; End of the 7x16 display
EMPTY_CHAR		EQU 	20H	; Blank ASCII character 	

MENU_WEIGHT_SCALE	EQU	01H	; Option to weight a product
MENU_HISTORY		EQU	02H	; Option to view weighting history
HISTORY_RESET		EQU	03H	; Option to reset weighting history

; === Main Program ===
START:
		CALL CLEAR_DISPLAY
		CALL CHECK_ON_BUTTON
		CALL SHOW_MAIN_MENU

Place 2000H
SHOW_MAIN_MENU:
		String " MENU PRINCIPAL "
		String "                "
		String "1 - Balança     "
		String "2 - Registos    "
		String "----------------"
		String "3 - Limpar      "
		String "    Registos    "

; === Clear Display ===
CLEAR_DISPLAY:
		
