; Perifericos
ON_OFF			EQU	1A0H	; On/Off button's address
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
STACK_POINTER 		EQU 	1000H	; Top of the stack address

; =============
; === Menus ===
; =============
Place 2000H
MAIN_MENU:				
		String " MENU PRINCIPAL "
		String "                "
		String "1 - Balança     "
		String "2 - Registos    "
		String "----------------"
		String "3 - Limpar      "
		String "    Registos    "
Place 2080H
WEIGHT_SCALE_MENU:
		String "                "
		String "                "
		String "Peso:           "
		String "                "
		String "Preço:          "
		String "                "
		String "Total:          "
Place 2100H
HISTORY_MENU:
		String "                "
		String "                "
		String "                "
		String "                "
		String "                "
		String "                "
		String "                "
					
Place 2180H				
ERROR_MENU:		
		String "     ERRO!      "
		String "----------------"
		String "  ESCOLHA UMA   "
		String "  OPÇÃO VÁLIDA  "
		String "                "
		String "  PRESSIONE OK  "
		String " PARA CONTINUAR "

Place 2200H
WEIGHT_SCALE_MENU_EMPTY:
		String "    ATENÇÃO!    "
		String "----------------"
		String " NENHUM PRODUTO "
		String "  SELECIONADO   "
		String "                "
		String "  PRESSIONE OK  "
		String " PARA CONTINUAR "

; ====================
; === Main Program ===
; ====================
Place 0000H
START:	
		MOV R0, BEGINNING
		JMP R0
Place 3000H				
BEGINNING:				
		MOV SP, STACK_POINTER		; Initialize stack
		CALL CLEAR_DISPLAY		; Clear the screen
		CALL CLEAR_PERIPHERICS		; Clear the inputs
		MOV R0, ON_OFF			; Prepare to read ON/OFF button
TURN_ON:				
		MOVB R1, [R0]			; Read ON/OFF button
		CMP R1, 1			; Check if it's on
		JNE TURN_ON			; Loop back if not on
ON:
		MOV R2, MAIN_MENU		; Load the main menu into R2
		CALL SHOW_DISPLAY		; Display the main menu
		CALL CLEAR_PERIPHERICS		; Clear peripherics
READ_INPUT:
		MOV R0, SEL_NR_MENU		; Prepare to read user input
		MOVB R1, [R0]			; Read the user input
		CMP R1, 0			; Check if there's no user input
		JEQ READ_INPUT			; Loop back if it's empty
		CMP R1, MENU_WEIGHT_SCALE	; Check if input is option 1
		JEQ OPTION_WEIGHT_SCALE		; Jump to option 1
		CMP R1, MENU_HISTORY		; Check if input is option 2
		JEQ OPTION_MENU_HISTORY		; Jump to option 2
		CMP R1, HISTORY_RESET		; Check if input is option 3
		JEQ OPTION_RESET		; Jump to option 3
		CALL SHOW_ERROR			; If no valid option was chosen, show error
		JMP ON				; Loop back to the starting menu

; =============
; === Error ===
; =============

SHOW_ERROR:
		PUSH R0				;
		PUSH R1				;
		PUSH R2				;
		MOV R2, ERROR_MENU		;
		CALL SHOW_DISPLAY		;
		CALL CLEAR_PERIPHERICS		;
		MOV R0, OK			;
ERROR:
		MOVB R1, [R0]			;
		CMP R1, 1			;
		JNE ERROR			;
		POP R2				;
		POP R1				;
		POP R0				;
		RET				;

; ===============================
; === Weight Scale (Option 1) ===
; ===============================
OPTION_WEIGHT_SCALE:
		; *** TO BE FINISHED ***
		MOV R2, WEIGHT_SCALE_MENU_EMPTY	; Load the weight scale menu into R2
		CALL SHOW_DISPLAY		; Display the weight scale menu
		CALL CLEAR_PERIPHERICS		; Clear all the peripherics
		MOV R0, SEL_NR_MENU		; 
OPTION_WEIGHT_SCALE_CYCLE:
		JMP OPTION_WEIGHT_SCALE_CYCLE	
				
; =================================
; === Weight History (Option 2) ===
; =================================
OPTION_MENU_HISTORY:
		JMP OPTION_MENU_HISTORY

; ========================
; === Reset (Option 3) ===
; ========================
OPTION_RESET:
		JMP OPTION_RESET

; ====================
; === Show Display ===
; ====================
SHOW_DISPLAY:
		PUSH R0				;
		PUSH R1				;
		PUSH R3				;
		MOV R0, DISPLAY_START		;
		MOV R1, DISPLAY_END		;
SHOW_DISPLAY_CYCLE:
		MOV R3, [R2]			;
		MOV [R0], R3			;
		ADD R2, 2			;
		ADD R0, 2			;
		CMP R0, R1			;
		JLE SHOW_DISPLAY_CYCLE		;
		POP R3				;
		POP R2				;
		POP R1				;
		RET				;

; =========================			
; === Clear Peripherics ===			
; =========================			
CLEAR_PERIPHERICS:
		PUSH R0				;
		PUSH R1				;
		PUSH R2				;
		PUSH R3				;
		PUSH R4				;
		PUSH R5				;
		MOV R0, ON_OFF			;
		MOV R1, SEL_NR_MENU		;
		MOV R2, OK			;
		MOV R3, CHANGE			;
		MOV R4, CANCEL			;
		MOV R5, PESO			;
		MOV R6, 0			;
		MOVB [R0], R6			;
		MOVB [R1], R6			;
		MOVB [R2], R6			;
		MOVB [R3], R6			;
		MOVB [R4], R6			;
		MOVB [R5], R6			;
		POP R5				;
		POP R4				;
		POP R3				;
		POP R2				;
		POP R1				;
		POP R0				;
		RET				;

; =====================
; === Clear Display ===
; =====================
CLEAR_DISPLAY:	
		PUSH R0				; Saves current value of R0 on the stack
		PUSH R1				; Saves current value of R1 on the stack
		PUSH R2				; Saves current value of R2 on the stack
		MOV R0, DISPLAY_START		; Set R0 to the starting address of the display
		MOV R1, DISPLAY_END		; Set R1 to the ending address of the display 
CLEAR_DISPLAY_CYCLE:
		MOV R2, EMPTY_CHAR		; Load the empty character into R2
		MOVB [R0], R2			; Store the empty character at the memory address pointed by R0
		ADD R0, 1			; Increment R0 to move to the next byte in the display memory
		CMP R0, R1			; Compare R0 with the end address of the display
		JLE CLEAR_DISPLAY_CYCLE 	; If R0 has not yet reached R1, continue the loop
		POP R2				; Restore the original value of R2 from the stack
		POP R1				; Restore the original value of R1 from the stack
		POP R0				; Restore the original value of R0 from the stack
		RET				; Returns from the function
