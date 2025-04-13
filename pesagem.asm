PESO            	EQU    	280H    	; Acho que 280H fica bonitinho logo abaixo
TOTAL_PURCHASE        	EQU    	290H    	; O preco total logo abaixo
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
        	MOV R0, PESO            	; Lê o peso em gramas
        	MOV R1, [R0]            	; R1 = gramas
		CMP R1, MAX_WEIGHT		; Garante que é menor que 30kg
		JA TOO_HEAVY			;
        	MOV R2, [R11]            	; R2 = preco por kilograma
        	MOV R3, R1            		; R3 = gramas
        	MUL R3, R2            		; R3 = gramas * preco_por_kilograma
        	MOV R4, 1000            	; R4 = 1000
        	DIV R3, R4            		; R3 = (gramas * preco_por_kilograma) / 1000 = preco total do item
        	MOV R0, TOTAL_PURCHASE        	; Lê o preço total da compra
        	MOV R5, [R0]            	; R5 = TOTAL
        	ADD R5, R3            		; R5 = TOTAL + preco calculado agora
        	MOV [R0], R5            	; Atualiza o preco total da compra

TOO_HEAVY:
		;não pode ser superior a 30Kg logo diz erro e pede para tentar novamente, levando ao menu principal possivelmente
