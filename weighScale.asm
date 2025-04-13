; Perifericos
ON_OFF			EQU	190H	; On/Off button's address
SEL_NR_MENU		EQU	1A0H	; Option selected input address
OK			EQU	1B0H	; Confirmation input address
CHANGE			EQU	1C0H	; Change/Edit input address
CANCEL			EQU	1D0H	; Cancel/Go back input address
PESO			EQU	1E0H	; Weight of the product input address
PRODUCT_CODE		EQU	1F0H	; Product code input address	
					
; Display 7x16				
DISPLAY_START		EQU	200H	; Start of the 7x16 display
DISPLAY_END		EQU	26FH	; End of the 7x16 display
EMPTY_CHAR		EQU 	20H	; Blank ASCII character 	

MENU_WEIGHT_SCALE	EQU	01H	; Option to weight a product
MENU_HISTORY		EQU	02H	; Option to view weighting history
HISTORY_RESET		EQU	03H	; Option to reset weighting history

MAX_WEIGHT		EQU	7530H	; Max weight (30kg) expressed in grams
MIN_PRODUCT_CODE	EQU	64H	; 100
MAX_PRODUCT_CODE	EQU	7CH	; 124

; Constants
STACK_POINTER 		EQU 	1000H	; Top of the stack address

PLACE 4000H
PRODUCTS:
		Word    100
		String "Uvas            "
		Word    534
		Word    101
		String "Melancia        "
		Word    187
		Word    102
		String "Ananás          "
		Word    187
		Word    103
		String "Kiwi            "
		Word    356
		Word    104
		String "Pêssego         "
		Word    446
		Word    105
		String "Banana          "
		Word    258
		Word    106
		String "Morango         "
		Word    446
		Word    107
		String "Framboesa       "
		Word    1781
		Word    108
		String "Laranja         "
		Word    160
		Word    109
		String "Tangerina       "
		Word    222
		Word    110
		String "Cenoura         "
		Word    104
		Word    111
		String "Batata          "
		Word    114
		Word    112
		String "Nabo            "
		Word    228
		Word    113
		String "Beterraba       "
		Word    523
		Word    114
		String "Alho            "
		Word    619
		Word    115
		String "Cebola          "
		Word    143
		Word    116
		String "Ervilha         "
		Word    142
		Word    117
		String "Lentilhas       "
		Word    219
		Word    118
		String "Trigo           "
		Word    95
		Word    119
		String "Milho           "
		Word    362
		Word    120
		String "Favas           "
		Word    407
		Word    121
		String "Castanhas       "
		Word    892
		Word    122
		String "Noz             "
		Word    1839
		Word    123
		String "Amendoim        "
		Word    803
		Word    124
		String "Café            "
		Word    2025

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
Place 2280H
SELECT_FRUIT_MENU: 
		String "SELECT YOUR ITEM"
		String "1-              "
		String "2-              "
		String "3-              " 
		String "4-              " 
		String "5-              "
		String "CHANGE-SHOW MORE"

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
		JEQ OPTION_WEIGHT_SCALE	; Jump to option 1
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

; =============
; === START ===
; =============
OPTION_WEIGHT_SCALE:
		PUSH R2	
		MOV R2, WEIGHT_SCALE_MENU_EMPTY	; Load the weight scale menu into R2
		CALL SHOW_DISPLAY		; Display the weight scale menu
		CALL CLEAR_PERIPHERICS		; Clear all the peripherics

; ===================
; === Read Inputs ===
; ===================
READ_PRODUCT_CODE:
		MOV R0, PRODUCT_CODE		; Prepare to read PRODUCT_CODE
		MOV R1, [R0]			; Read PRODUCT_CODE
		MOV R6, 0064H			; Load the number 100 (minimum)
		CMP R1, R6			; Compare the input and the minimum
		JLT READ_PRODUCT_CODE		; If below the minimum, repeat
		MOV R6, 007CH			; Load the number 124 (maximum)
		CMP R1, R6			; Compare the input and the maximum
		JGT READ_PRODUCT_CODE		; If above the maximum, repeat
		JMP WEIGHT_SCALE		; If within the valid range, continue
READ_INPUT_CHANGE:
		MOV R0, CHANGE			; Prepare to read CHANGE button
		MOVB R1, [R0]			; Read the CHANGE input
		CMP R1, 1			; Check if CHANGE is on
		JEQ SELECT_FRUIT_DISPLAY 	; 
READ_INPUT_CANCEL:
		MOV R0, CANCEL			; Prepare to read CANCEL button
		MOVB R1, [R0]			; Read the CANCEL input
		CMP R1, 1			; Check if CANCEL is on
		JNE READ_PRODUCT_CODE		; If no button is pressed, repeat the cycle
		POP R2
		RET
SELECT_FRUIT_DISPLAY:
		MOV R2, SELECT_FRUIT_MENU	
		CALL SHOW_DISPLAY
		CALL CLEAR_PERIPHERICS
		JMP SELECT_FRUIT_DISPLAY
; ============
; === MAIN ===
; ============
WEIGHT_SCALE:
		MOV R2, WEIGHT_SCALE_MENU
		CALL SHOW_DISPLAY
		CALL CLEAR_PERIPHERICS
		JMP WEIGHT_SCALE


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
		PUSH R6				;
		MOV R0, ON_OFF			;
		MOV R1, SEL_NR_MENU		;
		MOV R2, OK			;
		MOV R3, CHANGE			;
		MOV R4, CANCEL			;
		MOV R5, PESO			;
		MOV R6, PRODUCT_CODE		;
		MOV R7, 0			;
		MOVB [R0], R7			;
		MOVB [R1], R7			;
		MOVB [R2], R7			;
		MOVB [R3], R7			;
		MOVB [R4], R7			;
		MOV [R5], R7			;
		MOV [R6], R7			;
		POP R6				;
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


; ================
; === Find ID  ===
; ================
FIND_ID:
		MOV R11, 4000H 			;
		MOV R10, 124     		; PRODUCT_CODE but for testes
		MOV R9, 20			;
		MOV R8, 2			;
		JMP FIND_ID_LOOP		;
FIND_ID_LOOP:
		MOV R7, [R11]			;
		CMP R7, R10			;
		JEQ FOUND_ID			;
		ADD R11, R9			;
		JMP FIND_ID_LOOP		;

FOUND_ID:
		ADD R11, R8			; Adds 2 so that now its the name of the product and not the ID
		;R11 now has the adress of the name of the product
		;Still needs to print		
