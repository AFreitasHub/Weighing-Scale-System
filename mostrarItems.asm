; =========================
; === Find Product Code ===
; =========================
FIND_ID:
		MOV R11, 4000H 			; 4000H is the start of the products table 
		MOV R10, [R0]			; Read the PRODUCT_CODE peripheric
		MOV R9, 20			; Each product entry is 20 bytes long
		MOV R8, 2			; Load 2 since the name is always 2 bytes from the product code
		JMP FIND_ID_LOOP		; Start the loop to find the corresponding item
FIND_ID_LOOP:
		MOV R7, [R11]			; Read the products table at the current position
		CMP R7, R10			; Check if the read code is the same as the one in the peripherics
		JEQ FOUND_ID			; If so, stop searching
		ADD R11, R9			; If not, check the next product
		JMP FIND_ID_LOOP		; Repeat the loop until found
FOUND_ID:
		ADD R11, R8			; Adds 2 so that now its the name of the product and not the ID
		;R11 now has the adress of the name of the product
		RET				; Return