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

; Constants
MAX_WEIGHT		EQU	12CH	; Max weight (30kg) expressed in grams
MIN_PRODUCT_CODE	EQU	64H	; 100
MAX_PRODUCT_CODE	EQU	7CH	; 124
ENTRY_SIZE		EQU 	14H 	; 20
STRING_SIZE		EQU	10H	; 16
STACK_POINTER 		EQU 	1000H	; Top of the stack address
PURCHASES_SAVED		EQU	4FF0H	; Number of purchases saved in memory address
SAVE_POINTER		EQU	4FF2H	; Where the next free adress to use to store permanently will be used
TEMP_MEMORY		EQU 	5000H 	; Where the data of the purchase should be saved temporarily
PERM_MEMORY_START	EQU	5006H	; Where the data of the purchases should be stored permanently
TABLE_END		EQU	41E0H	; Last product code of the products table

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
Place 1F00H
EMPTY_HISTORY:
		String "    ATENÇÃO!    "
		String "----------------"
		String " NENHUMA COMPRA "
		String "    EFETUADA    "
		String "                "
		String "  PRESSIONE OK  "
		String " PARA CONTINUAR "
Place 1F80H
OVERFLOW_ERROR:
		String " ERRO: OVERFLOW "
		String "----------------"
		String " PESO DEMASIADO "
		String "    ELEVADO!    "
		String "                "
		String "  PRESSIONE OK  "
		String " PARA CONTINUAR "
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
		String "              KG"
		String "Preço:          "
		String "          EUR/KG"
		String "Total:       EUR"
Place 2100H
HISTORY_MENU:
		String "   HISTÓRICO    "
		String "----------------"
		String "Nome:           "
		String "Peso:  00.0KG   "
		String "Total: 000.00EUR"
		String "----------------"
		String "PRÓXIMO [CHANGE]"
					
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
		String "INSIRA UM CÓDIGO"
		String "  OU USE CHANGE "
		String "PARA SELECIONAR!"
Place 2280H
SELECT_FRUIT_MENU: 
		String "ESCOLHA UM ITEM:"
		String "1 - A           "	; 0214H
		String "2 - B           "	; 0224H
		String "3 - C           " 	; 0234H
		String "4 - D           " 	; 0244H	
		String "5 - E           "	; 0254H
		String "PRÓXIMO [CHANGE]"

Place 2380H
ASK_TO_DELETE:
        	String " ESTÁ PRESTES A "
        	String " ELIMINAR TODOS "
        	String "  OS REGISTOS   "
       	 	String "                "
        	String " OK -> DELETAR  " 
        	String "  CANCEL PARA   "
        	String " VOLTAR AO MENU "

PLACE 2400H
CONFIRM_DELETED:
        	String "    TODOS OS    "
        	String "    REGISTOS    "
        	String "  ACABARAM DE   "
        	String " SER ELIMINADOS "
        	String "                " 
        	String " PRIMA OK PARA  "
        	String " VOLTAR AO MENU "



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
		CALL CLEAR_PERIPHERALS		; Clear the inputs 
		MOV R0, ON_OFF			; Prepare to read ON/OFF button
TURN_ON:				
		MOVB R1, [R0]			; Read ON/OFF button
		CMP R1, 1			; Check if it's on
		JNE TURN_ON			; Loop back if not on
ON:
		MOV R2, MAIN_MENU		; Load the main menu into R2
		CALL SHOW_DISPLAY		; Display the main menu
		CALL CLEAR_PERIPHERALS		; Clear peripherals
READ_INPUT:
		MOV R0, ON_OFF			; Prepare to read ON/OFF button
		MOVB R1, [R0]			; Read ON/OFF button
		CMP R1, 0			; Check if it's off
		JEQ BEGINNING			; If so, turn off the weighing scale
		MOV R0, SEL_NR_MENU		; Prepare to read user input
		MOVB R1, [R0]			; Read the user input
		CMP R1, 0			; Check if there's no user input
		JEQ READ_INPUT			; Loop back if it's empty
		CALL CONFIRM
MODE_SELECTION:
		CMP R1, MENU_WEIGHT_SCALE	; Check if input is option 1
		JEQ OPTION_WEIGHT_SCALE		; Jump to option 1
		CMP R1, MENU_HISTORY		; Check if input is option 2
		JEQ OPTION_MENU_HISTORY		; Jump to option 2
		CMP R1, HISTORY_RESET		; Check if input is option 3
		JEQ OPTION_RESET		; Jump to option 3
		CALL SHOW_ERROR			; If no valid option was chosen, show error
		JMP ON				; Loop back to the starting menu
; ========================================
; === Weighing Scale (Option 1) - MAIN ===
; ========================================
OPTION_WEIGHT_SCALE:
		MOV R0, PRODUCT_CODE		; Prepare to read PRODUCT_CODE input
		MOV R10, MIN_PRODUCT_CODE	; Load the minimum PRODUCT_CODE (100)
		MOV R11, MAX_PRODUCT_CODE	; Load the maximum PRODUCT_CODE (124)
		MOV R1, [R0]			; Read PRODUCT_CODE input
		CALL WEIGHT_SCALE_MAIN		; Go to the main cycle
		JMP ON				; Go back to the main menu

; ===================================
; === Weighing History (Option 2) ===
; ===================================
OPTION_MENU_HISTORY:
		CALL WEIGHT_HISTORY		; Go to the main cycle
		JMP ON				; Go back to the main menu

; ========================
; === Reset (Option 3) ===
; ========================
OPTION_RESET:
        	CALL CONFIRM_TO_DELETE		; Go to the main cycle
        	JMP ON				; Go back to the main menu

; ================================================
; === Weighing Scale (Option 1) - SUB-ROUTINES ===
; ================================================
WEIGHT_SCALE_MAIN:
		CMP R1, 0			; Check if there was user input (PRODUCT_CODE)
		JEQ WEIGHT_SCALE_EMPTY		; If not, display warning message				
		MOV R10, MIN_PRODUCT_CODE	; Load the minimum valid code (100)
		MOV R11, MAX_PRODUCT_CODE	; Load the maximum valid code (124)
		CMP R1, R10			; Compare the input to the minimum
		JLT WEIGHT_SCALE_EMPTY		; If lower than minimum, display warning message
		CMP R1, R11			; Compare the input to the maximum
		JGT WEIGHT_SCALE_EMPTY		; If higher than maximum, display a warning message
		JMP WEIGHT_SCALE		; If there was a valid input, display the normal menu
WEIGHT_SCALE_EMPTY:
		MOV R2, WEIGHT_SCALE_MENU_EMPTY	; Load the warning message
		CALL SHOW_DISPLAY		; Show in the display
		CALL CLEAR_PERIPHERALS		; Clear the peripherals
		JMP WEIGHT_SCALE_CYCLE		; Start the menu's cycle
WEIGHT_SCALE:
		MOV R2, WEIGHT_SCALE_MENU	; Load the normal menu 
		CALL SHOW_DISPLAY		; Display the menu
		MOV R0, PRODUCT_CODE		; Prepare to read the PRODUCT_CODE inserted
		CALL FILL_WEIGHT_SCALE		; Fill the menu with dynamic data
WEIGHT_SCALE_CYCLE:
		MOV R0, CANCEL			; Prepare to read the CANCEL input
		MOVB R1, [R0]			; Read CANCEL
		CMP R1, 1			; Check if it's on
		JEQ RETURN			; If so, return to the previous menu
		MOV R0, CHANGE			; Prepare to read CHANGE input
		MOVB R1, [R0]			; Read CHANGE
		CMP R1, 1			; Check if it's on
		JEQ CHANGE_MENU			; If so, go to the corresponding sub-routine
		MOV R0, PESO			; If not, prepare to read the PESO on the peripheral
		MOV R1, [R0]			; Read PESO

		CMP R1, R7			; Check if the PESO In the peripheral is the same as the last known PESO
		JEQ SKIP_DISPLAY_UPDATE		; If it's the same, do nothing
		CALL DISPLAY_TOTAL_PRICE_START	; Calculate and display the total price
		CALL DISPLAY_WEIGHT_START	; If not the same, display the new PESO value
		CALL STORE_WEIGHT_AND_PRICE	; 
		MOV R7, [R0]			; Update the last known PESO

			
SKIP_DISPLAY_UPDATE:
		MOV R0, PRODUCT_CODE		; Prepare to read PRODUCT_CODE
		MOV R11, [R0]			; Read the PRODUCT_CODE
		MOV R10, 0			;  
		CMP R11, R10			; Check if there was any PRODUCT_CODE inserted when the user selected "OK"
		JEQ CHECK_TO_SAVE		; If there was no PRODUCT_CODE, it means the user intends to save the purchase;
		MOV R10, MIN_PRODUCT_CODE	; Load the minimum valid code (100)
		MOV R11, MAX_PRODUCT_CODE	; Load the maximum valid code (124)
		MOV R3, [R0]			; Read the value in PRODUCT_CODE
		CMP R3, R10			; Compare it to the minimum
		JLT WEIGHT_SCALE_CYCLE		; If it's below the minimum, do nothing
		CMP R3, R11			; If above, compare it to the maximum
		JGT WEIGHT_SCALE_CYCLE		; If above  maximum, do nothing
		MOV R0, OK			; If within the valid range, prepare to read OK
		MOVB R4, [R0]			; Read the value of OK
		CMP R4, 1			; Check if it's on
		JEQ WEIGHT_SCALE		; If so, update the display with the new product
		JMP WEIGHT_SCALE_CYCLE		; If not, do nothing until "OK" is pressed
RETURN: 
		RET				; Return
CHANGE_MENU: 
		CALL CHANGE_ITEM		; Sub-routine that allows the user to select one item from a list
		JMP WEIGHT_SCALE		; Loop back once a product has been chosen

CHECK_TO_SAVE:
		MOV R0, OK			; Prepare to read the OK peripheral
		MOVB R11, [R0]			; Read the OK peripheral
		CMP R11, 1			; Check if OK is on
		JEQ SAVE_IT			; If so, save the current purchase in the memory
		JMP WEIGHT_SCALE_CYCLE		; If not, loop back
SAVE_IT:
		CALL SAVE_ON_MEMORY		; Save the purchase on the memory
		RET				; Return 

; ==================================================
; === Weighing History (Option 2) - SUB-ROUTINES ===
; ==================================================
WEIGHT_HISTORY:
		MOV R2, HISTORY_MENU		; Load the menu for weighing history
		CALL SHOW_DISPLAY		; Display the menu
		CALL CLEAR_PERIPHERALS		; Clear the peripherals
		MOV R0, PURCHASES_SAVED		; Prepare to read how many entries exist in memory
		MOV R1, [R0]			; Read how many entries exist in memory
		CMP R1, 0			; Check if there are any registers
		JGT CYCLE_START			; If there are any registers, continue normally
WARNING_EMPTY:
		MOV R2, EMPTY_HISTORY		; Load warning message
		CALL SHOW_DISPLAY		; Display warning message
		CALL CONFIRM			; Check if user pressed OK
		RET				; If so, return
CYCLE_START:
		MOV R0, PERM_MEMORY_START	; First product code
WEIGHT_HISTORY_CYCLE:
		PUSH R1				; Save the current value of remaining registers, on the stack, to prevent data loss
		CALL FIND_ID			; Based on the product code in R0, find the name of the product
		MOV R6, 227H			; Where the name must be written
		MOV R5, 0			; Initialize character counter
		MOV R4, 9			; Max amount of characters that can be displayed
		CALL DISPLAY_NAME_CYCLE		; Display the name
		ADD R0, 2			; Prepare to read the weight
		MOV R6, 23AH			; Where the weight should be displayed
		MOV R7, 0AH			; 10, used for conversion (10cg is 1kg) 
		MOV R8, 01H			; 1, will be used to skip rounding (there's no need to round up in this case)
		PUSH R0				; Save R0 in the stack to prevent data loss
		CALL CONVERT_WEIGHT		; Convert and display the weight
		POP R0				; Load the value back
		ADD R0, 2			; Prepare to read the price
		MOV R6, 24CH			; Where the price should be displayed
		MOV R7, 64H			; 100, used for conversion (cent/hg to eur/kg)
		MOV R8, 01H			; 1 to skip rounding
		PUSH R0				; Save R0 in the stack to prevent data loss
		CALL CONVERT_TOTAL_PRICE	; Convert and display the price
		POP R0				; Restore 
		POP R1				; Load the counter from the stack to decrement it properly
CHECK_CANCEL:	
		MOV R2, CANCEL			; Prepare to read the CANCEL peripheral
		MOVB R3, [R2]			; Read the CANCEL peripheral
		CMP R3, 0			; Check if CANCEL has been pressed
		JNE CANCEL_HISTORY		; If so, return
CHECK_NEXT:
		MOV R2, CHANGE 			; Prepare to read the CHANGE peripheral
		MOVB R3, [R2]			; Read the CHANGE peripheral
		CMP R3, 0			; Check if CHANGE has been pressed
		JEQ CHECK_CANCEL		; If not, check for input again
NEXT: 						; If so, go to the next register
		SUB R1, 1			; Subtract one from the counter (how many items left to display)
		CMP R1, 0			; Check if we've already reached the end of the weighing history
		JEQ WRAP			; If so, wrap around
		CALL CLEAR_PERIPHERALS		; If not, clear peripherals
		ADD R0, 2			; Prepare to read the next product's code
		JMP WEIGHT_HISTORY_CYCLE	; Loop back
WRAP: 
		JMP WEIGHT_HISTORY		; Wrap around to the very start
CANCEL_HISTORY:
		RET				; Return


; =========================================================
; === Sub-routine to fill the display with dynamic data ===
; =========================================================
FILL_WEIGHT_SCALE:
		CALL STORE_PRODUCT_CODE		; Stores the PRODUCT_CODE
		CALL FIND_ID			; Look for the current PRODUCT_CODE within the memory
		CALL DISPLAY_NAME		; Display the name of the corresponding item
		MOV R0, PESO			; Prepare to read PESO
		MOV R9, 0			; Load 0, will be used to clear the peripheral
		MOV [R0], R9 			; Clear the PESO peripheral
		CALL DISPLAY_WEIGHT_START	; Display the weight (starts at zero because no product has been weighed yet)
		CALL FIND_PRICE			; Look for the price of the current item within the memory
		CALL DISPLAY_PRICE_START	; Display the price of the item
		CALL DISPLAY_TOTAL_PRICE_START	; Calculate and display the total price
		CALL CLEAR_PERIPHERALS		; Clear peripherals
		RET				; Return

; =====================================		
; === Sub-routine to change product ===		
; =====================================		
CHANGE_ITEM: 					
		MOV R2, SELECT_FRUIT_MENU	; Load the fruit selection menu
		CALL SHOW_DISPLAY 		; Display the menu
		CALL CLEAR_PERIPHERALS		; Clear peripherals
						
; ====================================		
; === Show and Choose the Products ===		
; ====================================		
SHOW_PRODUCTS_START:				
		MOV R11, PRODUCTS		; R11: Pointer to current PRODUCT_CODE
		MOV R10, R11        		
		ADD R10, 2			; R10: Pointer to current product NAME
		MOV R8, ENTRY_SIZE		; R8: Size of one product entry
		MOV R7, 12            		; R7: Max characters in product name
		MOV R0, 214H          		; R0: Initial display address
		MOV R1, 0             		; Index counter
FETCH_PRODUCTS:
		PUSH R11             		; Save current product code 
		CALL DISPLAY_PRODUCTS		; Display the fetched products
		ADD R11, R8          		; Next product's code
		ADD R10, R8          		; Next product's name
		ADD R1, 1			; Increment the counter 
		CMP R1, 5			; Check if we've already displayed 5 items
		JLT FETCH_PRODUCTS		; If not, keep going
		POP R6				; Load the 5th product code
		POP R5				; Load the 4th product code
		POP R4				; Load the 3rd product code
		POP R3				; Load the 2nd product code
		POP R2				; Load the 1st product code
		
; ===========================
; === Wait For User Input ===
; ===========================
CHECK_INPUT:	
		MOV R0, CANCEL			; Prepare to read the CANCEL peripheral
		MOVB R1, [R0]			; Read the CANCEL peripheral
		CMP R1, 0			; Check if it's off
		JNE CANCEL_CHANGE		; If it's on, go to the previous menu
		MOV R0, CHANGE			; Prepare to read the CHANGE peripheral
		MOVB R1, [R0]			; Read the CHANGE peripheral
		CMP R1, 0			; Check if it's off
		JNE CHANGE_PRODUCTS		; If it's on, show the next 5 products
		MOV R0, SEL_NR_MENU		; Prepare to read SEL_NR_MENU
		MOVB R1, [R0]			; Read SEL_NR_MENU
		CMP R1, 0			; Check if it's off
		JEQ CHECK_INPUT			; If so, check for user input again
		CALL CONFIRM			; If it's on, wait for confirmation
; ========================
; === Handle Selection ===
; ========================
ITEM_SELECTION:
		CMP R1, 1			; See if SEL_NR_MENU = 1
		JEQ SELECT_1			
		CMP R1, 2			; See if SEL_NR_MENU = 2
		JEQ SELECT_2			
		CMP R1, 3			; See if SEL_NR_MENU = 3
		JEQ SELECT_3			
		CMP R1, 4			; See if SEL_NR_MENU = 4
		JEQ SELECT_4			
		CMP R1, 5			; See if SEL_NR_MENU = 5
		JEQ SELECT_5
		CALL SHOW_ERROR			; If none of the valid options were selected, show an error
		JMP CHANGE_ITEM			; Go back to the start after the error
SELECT_1: 
		MOV R1, R2			; Load the 1st product code to R1
		JMP END
SELECT_2: 	
		MOV R1, R3			; Load the 2nd product code to R1
		JMP END
SELECT_3: 
		MOV R1, R4			; Load the 3rd product code to R1
		JMP END
SELECT_4: 
		MOV R1, R5			; Load the 4th product code to R1
		JMP END
SELECT_5: 
		MOV R1, R6			; Load the 5th product code to R1
		JMP END
CHANGE_PRODUCTS:
		MOV R1, 0			
		MOV [R0], R1			; Clear the CHANGE peripheral
		MOV R0, 214H     		; Set the position to start displaying
		MOV R2, TABLE_END		; Last product code of the table
		CMP R11, R2			; Check if we've reached the last item
		JGE WRAP_AROUND			; If so, go back to the beginning
		JMP FETCH_PRODUCTS		; If not, continue normally
WRAP_AROUND:
		JMP SHOW_PRODUCTS_START		; Start all over
END:
		MOV R0, PRODUCT_CODE		; Prepare to write in PRODUCT_CODE
		MOV R2, [R1]			; Load the selected product code to R2
		MOV [R0], R2			; Write the selected product code in the peripheral
		RET				; Return
CANCEL_CHANGE:
		JMP WEIGHT_SCALE_MAIN		; If cancel is pressed, jump back to the weighing scale cycle

; ======================
; === Display Helper ===
; ======================
DISPLAY_PRODUCTS:
		PUSH R10			; Keep the initial position of the string for later use
		MOV R9, 0			; Character index
DISP_LOOP:
		MOVB R2, [R10]			; Load character
		MOVB [R0], R2			; Write to display
		ADD R10, 1			; Shit to the next character
		ADD R0, 1			; Shift to the next display position
		ADD R9, 1			; Increment the character counter
		CMP R9, R7			; Check if we've written all the characters
		JLT DISP_LOOP			; If not, keep writing
		ADD R0, 4			; Next display position
		POP R10				; Load the initial position of the string, from the stack
		RET				; Return

; =========================
; === Find Product Code ===
; =========================
FIND_ID:
		MOV R11, PRODUCTS		; 4000H is the start of the products table 
		MOV R10, [R0]			; Read the PRODUCT_CODE peripheral
		MOV R9, 20			; Each product entry is 20 bytes long
		MOV R8, 2			; Load 2 since the name is always 2 bytes from the product code
		JMP FIND_ID_LOOP		; Start the loop to find the corresponding item
FIND_ID_LOOP:
		MOV R7, [R11]			; Read the products table at the current position
		CMP R7, R10			; Check if the read code is the same as the one in the peripherals
		JEQ FOUND_ID			; If so, stop searching
		ADD R11, R9			; If not, check the next product
		JMP FIND_ID_LOOP		; Repeat the loop until found
FOUND_ID:
		ADD R11, R8			; Adds 2 so that now its the name of the product and not the ID
		;R11 now has the adress of the name of the product
		RET				; Return
; ====================
; === Display Name ===
; ====================
DISPLAY_NAME:
		MOV R6, DISPLAY_START		; Load the address where the display starts
		MOV R5, 0			; Initialize a counter
		MOV R4, STRING_SIZE		; Load the max size of a string (16)
DISPLAY_NAME_CYCLE:
		MOVB R7, [R11]			; Read the first character of the product's name from the table
		MOVB [R6], R7			; Write 1 characters to the display address
		ADD R6, 1			; Shift the display address to the right by 1
		ADD R11, 1			; Prepare to read the next character of the name
		ADD R5, 1			; Increment the counter by the amount of characters written
		CMP R5, R4			; Check if we've written all characters already
		JEQ DISPLAY_NAME_END	  	; Stop writing on the display once all characters have been written
		JMP DISPLAY_NAME_CYCLE		; If we haven't written all characters yet, keep going
DISPLAY_NAME_END:
		RET				; Returns
; ======================			
; === Display Weight ===			
; ======================			
DISPLAY_WEIGHT_START:				
		MOV R0, PESO			; Load PESO to R0
		MOV R7, 0AH			; 10, used for conversion (10cg is 1kg) 
		MOV R8, 01H			; 1, will be used to skip rounding (there's no need to round up in this case)
		MOV R6, 23DH                   	; For line positioning
CHECK_WEIGHT_LIMIT:
		MOV R1, [R0]			; Read the value of PESO to R1
		MOV R2, MAX_WEIGHT		; Load MAX_WEIGHT (300cg) to R2
		CMP R1, R2			; Compare the input with the maximum
		JGT SET_ZERO
		MOV R2, 0
		CMP R1, R2
		JLT SET_ZERO
		JMP CONVERT_WEIGHT		; If not greater than maximum, convert it to kg		
SET_ZERO:
		MOV R1, 0			; If greater than maximum, set the weight to zero
		MOV [R0], R1			; Write zero on the PESO peripheral
CONVERT_WEIGHT:
		CALL CONVERT_FOR_DISPLAY	; Convert the value in PESO peripheral from cg to kg		
DISPLAY_WEIGHT:                  		; R6 -> Start of the display
    		MOV R0, 2			; Amount of digits the whole part should have in the display
		MOV R10, 1			; Amount of digits the decimal part should have in the display
		CALL DISPLAY_NUMBER 		; Write weight on the display
		RET				; Return

; ===================
; === Find Price  ===
; ===================

FIND_SPECIFIC_PRICE:
		MOV R0, TEMP_MEMORY		; Prepare to read address where the product code is being stored temporarily
        	JMP FIND_PRICE_PREPARE       	; Initialize values

FIND_PRICE:
		MOV R0, PRODUCT_CODE		; Prepare to read the PRODUCT_CODE peripheral
FIND_PRICE_PREPARE:
        	MOV R11, PRODUCTS		; Starting address of the products table
		MOV R10, [R0]			; Read the product code in R0
        	MOV R9, 20            		; Size of an entry (20 bytes)
        	MOV R8, 18            		; How far the price is from the product code (18 bytes apart)
FIND_PRICE_LOOP:
        	MOV R7, [R11]            	; Read the current product code
        	CMP R7, R10            		; Compare it to the one we're looking for
        	JEQ FOUND_PRICE            	; If it's the same, then we found the right item
        	ADD R11, R9            		; If not, shift to the next product code
        	JMP FIND_PRICE_LOOP        	; And repeat the cycle

FOUND_PRICE:
		ADD R11, R8            		; Adds 18 so that now its the price of the product and not the ID
		RET
DISPLAY_PRICE_START: 
		MOV R0, R11			; Copy the price address to R0 (it'll be read in CONVERT_FOR_DISPLAY)
		MOV R7, 64H			; 100, used for conversion from cents to euros
		MOV R8, 01H			; 1, skip rounding
		CALL CONVERT_FOR_DISPLAY	; Read the price and convert it to euros
DISPLAY_PRICE:
		MOV R6, 259H			; Display address
		MOV R0, 2			; Number of digits the whole part should have
		MOV R10, 2			; Number of digits the decimal part should have
		CALL DISPLAY_NUMBER		; Display the number
        	RET		        	; Return

; ===========================
; === Display Total Price ===
; ===========================
DISPLAY_TOTAL_PRICE_START:
		MOV R0, R8			; R0 now holds the address where the total price is stored
		MOV R7, 64H			; 100, will be used for conversion
		MOV R8, 01H 			; 1, skips rounding up (total price has already been rounded up)
		MOV R6, 26CH			; Position where the number should be written
CONVERT_TOTAL_PRICE:
		CALL CONVERT_FOR_DISPLAY	; Convert the total price from cent/hg to eur/kg
DISPLAY_TOTAL_PRICE:
		MOV R0, 3			; Number of digits the whole part should have
		MOV R10, 2			; Number of digits the decimal part should have
		CALL DISPLAY_NUMBER		; Display the number
		RET				; Return

; ======================================
; === Sub-Routine To Read User Input === 
; ======================================
CONFIRM:	
		MOV R0, OK			; Prepare to read OK peripheral
		MOVB R7, [R0]			; Read OK peripheral 
		CMP R7, 0			; Check if the OK button hasn't been pressed
		JEQ CONFIRM			; If it hasn't been pressed, keep checking
		RET				; Return
; ====================================
; === Sub-Routine To Display Error ===
; ====================================
SHOW_ERROR:
		PUSH R0				; Save current registers in the stack to prevent data loss
		PUSH R1				
		PUSH R2				
		MOV R2, ERROR_MENU		; Load the error message
		CALL SHOW_DISPLAY		; Display the error message
		CALL CLEAR_PERIPHERALS		; Clear all peripherals
		MOV R0, OK			; Prepare to read OK
ERROR:
		MOVB R1, [R0]			; Read OK
		CMP R1, 1			; Check if OK was pressed
		JNE ERROR			; If not, keep the error message and check again
		POP R2				; If OK was pressed, restore register values and return
		POP R1				
		POP R0				
		RET				

; ===================================
; === Sub-Routine To Show Display ===
; ===================================
SHOW_DISPLAY:
		PUSH R0				; Save current registers in the stack to prevent data loss
		PUSH R1				
		PUSH R3				
		MOV R0, DISPLAY_START		; Starting address of the display
		MOV R1, DISPLAY_END		; Ending address of the display
SHOW_DISPLAY_CYCLE:
		MOV R3, [R2]			; Load the first 2 bytes of the menu string into R3
		MOV [R0], R3			; Write the first two characters on the display
		ADD R2, 2			; Shift address in order to write the next 2 bytes
		ADD R0, 2			; Shift the display position by 2
		CMP R0, R1			; Check if we've already finished writing
		JLE SHOW_DISPLAY_CYCLE		; If we haven't finished yet, keep writing
		POP R3				; Restore original values
		POP R2				
		POP R1				
		RET				; Return

; ========================================	
; === Sub-Routine To Clear Peripherics ===			
; ========================================			
CLEAR_PERIPHERALS:
		PUSH R0				; Save current registers in the stack to prevent data loss
		PUSH R1				
		PUSH R2				
		PUSH R3				
		PUSH R4				
		PUSH R5				
		PUSH R6				
		MOV R1, SEL_NR_MENU		; Prepare to clear the SEL_NR_MENU peripheral
		MOV R2, OK			; Prepare to clear the OK peripheral 
		MOV R3, CHANGE			; Prepare to clear the CHANGE peripheral
		MOV R4, CANCEL			; Prepare to clear the CANCEL peripheral
		MOV R5, PESO			; Prepare to clear the PESO peripheral
		MOV R6, PRODUCT_CODE		; Prepare to clear the PRODUCT_CODE peripheral
		MOV R7, 0			; Zero will be used to clear the peripherals
		MOVB [R1], R7			; Set the SEL_NR_MENU to zero
		MOVB [R2], R7			; Set the OK to zero
		MOVB [R3], R7			; Set the CHANGE to zero
		MOVB [R4], R7			; Set the CANCEL to zero
		MOV [R5], R7			; Set the PESO to zero
		MOV [R6], R7			; Set the PRODUCT_CODE to zero
		POP R6				; Restore the original values from the stack 
		POP R5				
		POP R4				
		POP R3				
		POP R2				
		POP R1				
		POP R0				
		RET				; Return

; ====================================
; === Sub-Routine To Clear Display ===
; ====================================
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

; ======================================================================
; === Sub-routine for unit conversion (g->kg/cent->eur) and rounding ===
; ======================================================================
CONVERT_FOR_DISPLAY:
		MOV R1, [R0]			; Read the input in R0
		MOV R2, R1			; Load a copy of R1. Will be used for the decimal part
		DIV R1, R7			; Divide by R7 and keep the whole part in R1 (29850 -> 29)
		MOD R2, R7			; Divide by R7 and keep the decimal part in R2 (29850 -> 850)
		MOV R3, R2			; Load a copy of R2. Will be user for rounding
		CMP R8, 1			; If the R8 is 1, then the decimal part will not be divided at all. In this case, no rounding is needed
		JNE ROUND_UNIT			; If R8 is not 1, check if rounding is needed
		RET
ROUND_UNIT:
		DIV R2, R8			; Divide the decimal part by R8 to shift the decimal place (850 -> 8) 
		MOD R3, R8			; Divide the decimal part by R8 and keep only the remainder (850 -> 50)
		CMP R3, R9			; Compare the rest of the decimal part to R9  
		JGE ROUND_UP			; If lower than R9, do nothing. If greater, continue and round up
		RET
ROUND_UP:					; R1 -> Whole Part | R2 -> Decimal part
		MOV R5, 9			; 0.9 requires special attention when rounding up, so we'll check for it
		CMP R2, R5			; Check if the decimal is 9
		JEQ ROUND_UP_9			; If so, do the "special" round up
		ADD R2, 1			; If it's not 9, simply add 1 to the decimal part (29,75 -> 29,85)
		RET
ROUND_UP_9:
		ADD R1, 1			; If the decimal is 9, add 1 to the whole part
		MOV R2, 0			; And set the decimal to 0 (29,95 -> 30,0)
		RET

; ====================================================================
; === Sub-routine to display a number with whole and decimal parts ===
; ====================================================================
DISPLAY_NUMBER:
		MOV R5, 2CH			; Comma (for decimal separation)
		MOV R8, 30H			; 48 to convert numbers to ASCII
		MOV R9, 0AH			; 10 - used for breaking down numbers into single digits
		CALL PROCESS_DECIMAL_PART	; Process and write the decimal part on the display
		CALL PROCESS_WHOLE_PART		; Process and write the whole part on the display
		RET				; End writing on the display and return
; =====================================================
; === Sub-routine to process whole part of a number ===
; =====================================================
PROCESS_WHOLE_PART:
		MOV R10, R0			; Prepare the counter 
		MOV R2, R1			; Load the whole part to R2
		CALL PROCESS_DIGITS_START	; Process the digits and write them on the display
		RET				; End processing whole part and return
; =======================================================
; === Sub-routine to process decimal part of a number ===
; =======================================================
PROCESS_DECIMAL_PART:
		CALL PROCESS_DIGITS_START	; Process the digits and write them on the display
		MOVB [R6], R5			; Print the comma
		SUB R6, 1			; Move to the next position on the display
		RET				; End processing decimal part and return
; ==========================================================
; === Sub-routine to process and write digits on display ===
; ==========================================================
PROCESS_DIGITS_START:
		MOV R3, R2			; Copy number to R3 for processing
PROCESS_DIGITS:
		CMP R10, 0			; Check if there are still digits to process
		JEQ PROCESS_END			; End if no more digits
		CMP R3, R9			; Compare current number with 10
		JLT WRITE_DIGIT			; If it's a single digit, write it
		MOD R3, R9                      ; Divide number by 10 if not a single digit and store the remainder (to get the least significant digit) 
		JMP PROCESS_DIGITS		; Continue processing next digit
WRITE_DIGIT:    
		ADD R3, R8                      ; Convert the digit to ASCII
		MOVB [R6], R3                   ; Write the digit on the display
		SUB R6, 1			; Move to the next position on the display
		MOV R3, R2			; Load the original number
		DIV R3, R9			; Divide by 10 and store the whole part to remove the digit already displayed
		MOV R2, R3			; Update the number in R2
		SUB R10, 1			; Decrement counter for next digit
		JMP PROCESS_DIGITS		; Continue processing next digit
PROCESS_END:
		RET				; End digit processing and return


; =================================
; === Store in memory temporary ===
; =================================
STORE_WEIGHT_AND_PRICE:
		MOV R0, PESO			; R0 has the adress of PESO
		MOV R1, [R0]			; R1 has a copy of the weight
		CALL STORE_WEIGHT		; Stores the weight in the memory
		CALL STORE_FINAL_PRICE		; Stores the final price in the memory
		RET

STORE_WEIGHT:
		MOV R8, TEMP_MEMORY		; 5000H, where it will be stored the purchase
		ADD R8, 2			; Add 2 to point where it'll be stored the purchased products's weight
		MOV [R8], R1			; Store the weight
		RET

STORE_FINAL_PRICE:
		CALL FIND_SPECIFIC_PRICE	; Iterates through the products table to find the product's price
						; R1 holds the weight
		MOV R2, R1			; R2 has a copy of the weight
		MOV R8, 10			; 10, to divide
		DIV R1, R8			; R1 holds the whole part of the division
		MOD R2, R8			; R2 holds the decimal part of the division
		MOV R7, [R11]			; R7 now holds the price of the current product
		MUL R1, R7			; R1 gets multiplied by the price of the product
		MUL R2, R7			; R2 gets multiplied by the price of the product
		CMP R1, 0			; Check if the first multiplication overflowed
		JLT OVERFLOW_MESSAGE		; If it's a number below zero, then it overflowed. Display
		CMP R2, 0			; Check if the second multiplication overflowed
		JLT OVERFLOW_MESSAGE		; Display warning message

		MOV R3, R2			; R3 holds copy of R2 which will be used for rounding
		MOV R9, 5			; Rounding threshold 
		CALL ROUND_UNIT			; Round up if needed
		ADD R1, R2			; Sum R1 and R2
		JV OVERFLOW_MESSAGE		; If overflow is detected, display a warning
		MOV R8, TEMP_MEMORY		; R8 now holds the address where the purchase should be stored
		ADD R8, 4			; R8 now holds the address where the price will be sotred
		MOV [R8], R1			; Stores the price
		RET				; Returns
OVERFLOW_MESSAGE:
		MOV R2, OVERFLOW_ERROR 		; Load overflow warning message
		CALL SHOW_DISPLAY		; Show it on the display
		CALL CLEAR_PERIPHERALS		; Clear all peripherals
		MOV R0, OK			; Prepare to read OK
OVERFLOW:
		MOVB R1, [R0]			; Read OK
		CMP R1, 1			; Check if OK is on
		JNE OVERFLOW			; If it's not on, check again
		CALL CLEAR_PERIPHERALS		; Clear the peripherals
RESTORE_PRODUCT_CODE:				; If it's on, prepare to take the user back
		MOV R8, TEMP_MEMORY		; Place in memory where the PRODUCT_CODE was temporarily stored
		MOV R0, PRODUCT_CODE		; PRODUCT_CODE peripheral
		MOV R1, [R8]			; Read the product code of the last item weighted
		MOV [R0], R1			; Write it down on the PRODUCT_CODE peripheral so it loads back the correct display
		JMP WEIGHT_SCALE_MAIN		; Go back to the weighing scale menu (option 1)
STORE_PRODUCT_CODE:
		MOV R8, TEMP_MEMORY		; Where will be stored the purchased product's PRODUCT_CODE
		MOV R9, [R0]			; Temporarly hold the PRODUCT_CODE
		MOV [R8], R9			; Store the PRODUCT_CODE
		RET

; ===============================
; === Save confirmed purchases===
; ===============================
SAVE_ON_MEMORY:
		CALL PURCHASED_CONFIRMED
		MOV R0, TEMP_MEMORY		; R0 has the adress of the PRODUCT_CODE of the product from the last purchase
		MOV R1, SAVE_POINTER		; R1 has the adress of where the next free adress is stored
		MOV R2, [R1]			; R2 has the adress of the next free adress
		MOV R3, [R1]			; R3 has the adress of the next free adress, will be used to update the next free adress
		MOV R4, 6H			; 6, since every purchase holds 6 bytes, the next free space will be in 6 bytes
		ADD R3, R4			; Now has the next free adress (taking in account that the previous free adress will be used right now)
		MOV [R1], R3			; Next free adress updated
		MOV R3, 2H			; 2, will be useful since each purchase is divided in 3 parts, each with 2 byes (2 bytes for the product code, 2 bytes for the weight, 2 bytes for the price)
		JMP SAVING_ON_MEMORY		; Will save the temporary memory in the permanent part

SAVING_ON_MEMORY:
		MOV R1, [R0]			; R1 has the product code of the confirmed purchase
		MOV [R2], R1			; The new confirmed purchase's product code has been stored!
		ADD R0, R3			; R0 now has the adress where the purchase's weight is being stored
		ADD R2, R3			; R2 now has the adress where the purchase's weight will be stored
		MOV R1, [R0]			; R1 has the weight of the confirmed purchase
		MOV [R2], R1			; The new confirmed purchase's weight has been stored!
		ADD R0, R3			; R0 now has the adress where the purchase's price is being stored
		ADD R2, R3			; R2 now has the adress where the purchase's price will be stored
		MOV R1, [R0]			; R1 has the price of the confirmed purchase
		MOV [R2], R1			; The new confirmed purchase's price has been stored!
		RET

PURCHASED_CONFIRMED:
		MOV R0, PURCHASES_SAVED		; R0 has the adress where the number of confirmed orders is being stored
		MOV R1, [R0]			; R1 has a copy of the ammount of times a purchase has been confirmed
		ADD R1, 1			; +1 purchase
		MOV [R0], R1			; Store the updated ammount of confirmed purchases in the memory
		SUB R1, 1			; Subtracts 1 just to see if it is the first purchase, which if it is, it will have to reset the SAVE_POINTER
		CMP R1, 0			; If it is the first ever confirmed purchase, it means the save pointer should be PERM_MEMORY_START, which is the start where all purchases will be saved
		JEQ RESET_POINTER
		RET

RESET_POINTER:
		MOV R0, SAVE_POINTER		; R0 holds the adress of SAVE_POINTER
		MOV R1, PERM_MEMORY_START	; R1 holds the adress of PERM_MEMORY_START
		MOV [R0], R1			; Resets the save pointer by updating SAVE_POINTER's contents
		RET

; =========================================
; === Deleting of registrations routine ===
; =========================================
CONFIRM_TO_DELETE:
        	MOV R2, ASK_TO_DELETE		; Load the menu that will ask the user if he truly wants to delete all his registrations
	        CALL SHOW_DISPLAY		; Display the menu
       		CALL CLEAR_PERIPHERALS		; Clear all peripherals
	        MOV R0, OK			; R0 has the adress of OK
	        MOV R1, CANCEL			; R1 has the adress of CANCEL
	        CALL TO_DELETE			; Will check the users input to determine the following action
	        RET				; Return

TO_DELETE:
	        MOVB R11, [R0]			; R11 has the value of OK
        	CMP R11, 1			; Checks if OK was pressed
   	     	JEQ DELETING			; If OK was pressed it will delete all saved information on the memory
   		MOVB R11, [R1]			; R11 has the value of CANCEL
        	CMP R11, 1			; Checks if CANCEL was pressed
        	JEQ CANCEL_DELETE		; If CANCEL was pressed it will go back to the main menu and there will be no erasing of any information
        	JMP TO_DELETE			; The cycle repeats until the user chooses one

DELETING:
        	MOV R2, CONFIRM_DELETED		; Load the menu that will inform the user that all registrations have been deleted
        	CALL SHOW_DISPLAY		; Display the menu
        	CALL CLEAR_HISTORY		; Will put all the adresses value to 0 (the adresses responsible for storing the information saved)
        	CALL ALL_REG_DELETED		; Function that will interact with the user to return to the main menu
        	RET

CLEAR_HISTORY:
		MOV R0, PURCHASES_SAVED		; R0 holds the adress where the number of purchases has been made
		MOV R1, 0H			; 0
		MOV [R0], R1			; Now the number of purchases made is 0
		MOV R0, PERM_MEMORY_START	; R0 holds the adress of SAVE_POINTER
		MOV R1, SAVE_POINTER		; R1 holds the adress of PERM_MEMORY_START
		MOV R2, [R1]			; R2 holds a copy of the previous memory adress that would be used to store the next purchase
		MOV [R2], R0			; Resets the save pointer by updating SAVE_POINTER's contents
		MOV R3, 2H			; 2
		MOV R0, R2
		SUB R0, R3			; Now R0 holds the price of the last purchased saved
		MOV R6, TEMP_MEMORY		; R6 has a copy of the adress where the stored information from purchases is stored
		MOV R7, 0H			; 0
		CALL SET_IT_TO_ZERO		; Will make every single adress from 5000H till the last adress that was filled to 0
		RET

SET_IT_TO_ZERO:
		CMP R0, R6			; Until R0 is not equal to 5000H (the adress that represents the start when it comes to store information), it will make the current adress value to 0 and go back
		JGE MAKE_IT_ZERO		; If R0 is not 5000H it will set to 0 the value of the current adress
		RET

MAKE_IT_ZERO:
		MOV [R0], R7			; Sets the content of the current adress to 0
		SUB R0, R5			; R0 - 2 so that it will set to 0 all 3 parts of each purchase saved (including the temporary part)
		JMP SET_IT_TO_ZERO


CANCEL_DELETE:
        	CALL CLEAR_PERIPHERALS		; Clear peripherals
        	RET				; Return
ALL_REG_DELETED:
        	CALL CLEAR_PERIPHERALS		; Clear peripherals
        	CALL REG_DELETED		; Function that will interact with the user to return to the main menu
        	RET				; Return
REG_DELETED:
        	MOV R1, OK			; R1 has the adress of OK
        	MOVB R11, [R1]			; R11 has the value of OK
        	CMP R11, 1			; Checks if OK was pressed
        	JEQ RETURNING			; If OK was pressed it will return to the main menu
        	JMP REG_DELETED			; This cycle repeats until the user presses the OK button
RETURNING:
		RET				; Return
