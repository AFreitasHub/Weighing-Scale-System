PESO            	EQU    	280H    	; Acho que 280H fica bonitinho logo abaixo
TOTAL_PURCHASE_INT     	EQU    	290H    	; Parte inteira
TOTAL_PURCHASE_FRAC	EQU	2A0H		; Parte fracional
MAX_WEIGHT		EQU	7530H		; Max weight (30kg) expressed in grams

; ===================
; === Find Price  ===
; ===================
FIND_PRICE:
        	MOV R11, 4000H             	;
        	MOV R10, 124             	; PRODUCT_CODE but for testes
        	MOV R9, 20            		;
        	MOV R8, 18            		;
        	JMP FIND_PRICE_LOOP        	;
FIND_PRICE_LOOP:
        	MOV R7, [R11]            	;
        	CMP R7, R10            		;
        	JEQ FOUND_PRICE            	;
        	ADD R11, R9            		;
        	JMP FIND_PRICE_LOOP        	;

FOUND_PRICE:
		ADD R11, R8            		; Adds 18 so that now its the price of the product and not the ID
        	JMP CALCULATE_PRICE        	;

CALCULATE_PRICE:
        	MOV R0, PESO			; Load PESO to R0
		MOV R1, [R0]			; Load the value of PESO to R1
		MOV R2, MAX_WEIGHT		; R2 will be used to certify that the weight does not exceed 30kg
		CMP R1, R2			; Comparison to guarantee the weight is within limit
		JGT TOO_HEAVY			; If it is too heavy (>) it will not work
		MUL R1, R11			; R11 holds the value of the price which will be multiplied by R1 which holds the weight ammount
		MOV R3, R1			; Copy of R1, will be used to hold the whole part
		MOV R4, R1			; Copy of R1, will be used to hold the decimal part of R1
		MOV R5, 3E8H			; 1000
		DIV R3, R5			; Divides by R5 and keeps the whole part in R3
		MOD R4,	R5			; Divides by R5 and keeps the decimal part in R4
		JMP UPDATE_TOTAL_PRICE
		

TOO_HEAVY:
		;não pode ser superior a 30Kg logo diz erro e pede para tentar novamente, levando ao menu principal possivelmente


UPDATE_TOTAL_PRICE:
		MOV R7, TOTAL_PURCHASE_INT	; Load TOTAL_PURCHASE_INT to R7
		MOV R8, [R7]			; Load the value of TOTAL_PURCHASE_INT to R8
		ADD R8, R3			; Adds this new purchase price into the total price in the whole part
		MOV [R7], R8			; Stores the new total price in the whole part
		MOV R7, TOTAL_PURCHASE_FRAC	; Load TOTAL_PURCHASE_FRAC to R7
		MOV R8, [R7]			; Load the value of TOTAL_PURCHASE_FRAC to R8
		ADD R8, R4			; Adds this new purchase price into the total price in the decimal part
		CMP R8, R5			; Checks if the decimal part is or exceeds 1000
		JGE ADD_WHOLE_FROM_DECIMAL	; Will subtract 1000 from the decimal part and adds 1 to the whole part, this works since it will never exceed 2000, so just have to make this once maximum
		MOV R7, TOTAL_PURCHASE_FRAC	; Load TOTAL_PURCHASE_FRAC to R7
		MOV [R7], R8			; Stores the new total price in the decimal part
		JMP FULLY_UPDATED_PRICE		; now both TOTAL_PURCHASE_INT and TOTAL_PURCHASE_FRAC have been updated properly

ADD_WHOLE_FROM_DECIMAL:
		SUB R8, R5			; Subtracts 1000 from the previous decimal part so that it doesnt go over 1000
		MOV R9, R8			; Copy of R8, will be used to store the new decimal part
		MOV R7, TOTAL_PURCHASE_INT 	; Load TOTAL_PURCHASE_INT to R7
		MOV R8, [R7]               	; Load the value of TOTAL_PURCHASE_INT to R8
		ADD R8, 1                  	; Adds the 1 from the 1000 exceeded from the decimal part
		MOV [R7], R8               	; Stores the new total price in the whole part
		MOV R7, TOTAL_PURCHASE_FRAC	; Load TOTAL_PURCHASE_FRAC to R7
		MOV [R7], R9			; Stores the copy of the new decimal part in the
		JMP FULLY_UPDATED_PRICE		; now both TOTAL_PURCHASE_INT and TOTAL_PURCHASE_FRAC have been updated properly

FULLY_UPDATED_PRICE:
		;handles what to do after updating the total price
