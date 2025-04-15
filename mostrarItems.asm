; ====================================
; === Show and Choose the Products ===
; ====================================
SHOW_PRODUCTS:
		MOV R11, 4002H			; 4002H is where the name of the first product is stored
		MOV R10, R11			; Copy of R11 that will be modified
		MOV R9, 64H			; 100, the first PRODUCT_CODE from the table
		MOV R8, 20			; Each product entry is 20 bytes long
		MOV R7, 7CH			; 124, the last PRODUCT_CODE_ from the table
		MOV R6, R9			; Copy of R9, 100, that will track the PRODUCT_CODE
		JMP SHOW_PRODUCTS_DOING		; Now it will show the first five products

SHOW_PRODUCTS_DOING:
		MOV R1, R11			; R1 will hold the adress of the name for the first option shown
		ADD R11, R8			; R11 now adds 20 to go to the second option that will be shown
		ADD R6, 1			; R6 now is the PRODUCT_CODE of the second option
		MOV R2, R11			; R2 will hold the adress of the name for the second option shown
		ADD R11, R8			; R11 now adds 20 to go to the third option that will be shown
		ADD R6, 1			; R6 now is the PRODUCT_CODE of the third option
		MOV R3, R11			; R3 will hold the adress of the name for the third option shown
		ADD R11, R8			; R11 now adds 20 to go to the forth option that will be shown
		ADD R6, 1			; R6 now is the PRODUCT_CODE of the forth option
		MOV R4, R11			; R4 will hold the adress of the name for the forth option shown
		ADD R11, R8			; R11 now adds 20 to go to the fifth and last option that will be shown
		ADD R6, 1			; R6 now is the PRODUCT_CODE of the fifth and last option
		MOV R5, R11			; R5 will hold the adress of the name for the fifth and last option shown
		ADD R11, R8			; R11 now adds 20 to go to the next first option that will be shown
		ADD R6, 1			; R6 now is the PRODUCT_CODE of the next first item
		CMP [SEL_NR], 5			; Checks if the user has selected one of the 5 options -----------------------------
		JLE SOMEWHERE			; This will stop since the product has been chosen ---------------------------------
		CMP [], 1			; The user wishes to go to the next list of five products --------------------------
		JEQ CHECK_PRODUCT_CODE		; It will verify if the PRODUCT_CODE is valid and does not exceed the maximum ammount

CHECK_PRODUCT_CODE:
		CMP R6, R7			; Ensures that the PRODUCT_CODE does not exceed the maximum ammount
		JGT MAX_PRODUCT_CODE		; Will reset to be able to show the first product of the list	
		JMP SHOW_PRODUCTS_DOING		; If the PRODUCT_CODE did not exceed the maximum ammount it will show the next five products

MAX_PRODUCT_CODE:
		MOV R11, 4002H			; 4002H is where the name of the first product is stored
		MOV R6, R9			; Restarts at 100, the first PRODUCT_CODE on the list
		JMP SHOW_PRODUCTS_DOING		; Now it will show the first five products
