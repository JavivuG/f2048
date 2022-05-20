f2048: #a0: Direccion de la matriz, a1: Tipo de movimiento

	addi $sp, $sp, -36#Se guarda en la pila
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	add $s0, $a0, $zero # Se guarda la dirección de la matriz
	
	beq $a1, 68, Derecha
	beq $a1, 100, Derecha

	beq $a1, 87, Arriba
	beq $a1, 119, Arriba
	
	beq $a1, 65, Izquierda
	beq $a1, 97, Izquierda
	
	beq $a1, 83, Abajo
	beq $a1, 115, Abajo
	
	addi $v0, $zero, 1 # Si no ha cogido ningún salto: - Moviento desconocido
	j Fin
	
	Derecha: 
		add $a0, $s0, $zero
		jal MoverDerecha
		
		add $a0, $s0, $zero
		jal SumaDerecha
		
		add $a0, $s0, $zero
		jal MoverDerecha
		
		add $a0, $s0, $zero
		add $v0, $zero, $zero
		j Fin
	Arriba:
		add $a0, $s0, $zero
		jal MoverArriba
		
		add $a0, $s0, $zero
		jal SumaArriba
		
		add $a0, $s0, $zero
		jal MoverArriba
		
		add $a0, $s0, $zero
		add $v0, $zero, $zero
		j Fin
	Izquierda:
		add $a0, $s0, $zero
		jal MoverIzquierda
		
		add $a0, $s0, $zero
		jal SumaIzquierda
		
		add $a0, $s0, $zero
		jal MoverIzquierda
		
		add $a0, $s0, $zero
		add $v0, $zero, $zero
		j Fin
	Abajo:
		add $a0, $s0, $zero
		jal MoverAbajo
		
		add $a0, $s0, $zero
		jal SumaAbajo
		
		add $a0, $s0, $zero
		jal MoverAbajo
		
		add $a0, $s0, $zero
		add $v0, $zero, $zero
		
	Fin:	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, 32($sp)	
	addi $sp, $sp, 36 #Se guarda en la pila	
	jr $ra		      			
						
MoverDerecha:#a0: Direccion de la matriz

	addi $sp, $sp, -36#Se guarda en la pila
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp) 
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	add $s5, $a0, $zero #Direccion de la matriz
	addi $s1, $zero, 3 #i
	addi $s2, $zero, 3 #j
			
	BuclePrincipal:
		
		bne $s2, -1, Cont
		beq $s1, 0, Exit # Se acabó la matriz
		addi $s1, $s1, -1 #Se cambia de fila
		addi $s2, $zero, 3
		
		Cont:
		
		add $a0, $s5, $zero
		add $a1, $s1, $zero
		add $a2, $s2, $zero
		jal LeeAij #a0: Direccion de la matriz, a1: i, a2:j
		beq $v0, $zero, IncrementaJ #La casilla esta vacia, se pasa a la siguiente posicion
		add $s0, $zero, $v0 # Guardamos valor distinto de cero en s0
				
		#Si llegamos aqui se ha encontrado un número
		add $s4, $s2, $zero # Posicion de borrado: s4
		Mueve:	
			addi $s2, $s2, 1
			beq $s2, 4, Escribe # Final del tablero
			
			add $a0, $s5, $zero
			add $a1, $s1, $zero
			add $a2, $s2, $zero
			jal LeeAij
			bne $v0, $zero, Escribe #Si se topa con otro numero distinto de cero
			
			j Mueve #Si la casilla siguiente esta vacia vuelve al bucle
					
			Escribe:
			
				add $s3, $s2, $zero #Posicion actual
				
				add $a0, $s5, $zero #Borrado
				add $a1, $s1, $zero
				add $a2, $s4, $zero 
				add $a3, $zero, $zero
				jal EscAij	
				
				add $a0, $s5, $zero
				
				add $a1, $s1, $zero #Se escribe el número
				add $a2, $zero, $s3
				addi $a2, $a2, -1
				add $a3, $zero, $s0
				jal EscAij
				
				add $s2, $s4, $zero
				addi $s2, $s2, -1
				j BuclePrincipal
				
			IncrementaJ:
			      	addi $s2, $s2, -1
			      	j BuclePrincipal			
	Exit:	
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		lw $s7, 28($sp)
		lw $ra, 32($sp)	
		addi $sp, $sp, 36 #Se restaura la pila
		jr $ra	
		
MoverAbajo:#a0: Direccion de la matriz

	addi $sp, $sp, -36#Se guarda en la pila
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	add $s5, $a0, $zero #Dirección de la matriz
	addi $s1, $zero, 3 #i
	addi $s2, $zero, 3 #j
			
	BuclePrincipalAbajo:
	
		bne $s1, -1, ContAbajo
		beq $s2, 0, ExitAbajo #Se acabo la matrix
		addi $s2, $s2, -1 #Se cambia de columna
		addi $s1, $zero, 3
		
		ContAbajo:
		
		add $a0, $s5, $zero
		add $a1, $s1, $zero
		add $a2, $s2, $zero
		jal LeeAij #a0: Direccion de la matriz, a1: i, a2:j
		beq $v0, $zero, IncrementaI #La casilla esta vacia, se pasa a la siguiente posicion
		add $s0, $zero, $v0 # Guardamos valor distinto de cero en s0
				
		#Si llegamos aqui se ha encontrado un número
		add $s4, $s1, $zero
		MueveAbajo:	
			addi $s1, $s1, 1
			beq $s1, 4, EscribeAbajo # Final del tablero
			
			add $a0, $s5, $zero
			add $a1, $s1, $zero
			add $a2, $s2, $zero
			jal LeeAij
			bne $v0, $zero, EscribeAbajo #Si se topa con otro numero distinto de cero
			
			j MueveAbajo #Si la casilla siguiente esta vacia vuelve al bucle
					
			EscribeAbajo:
			
				add $s3, $s1, $zero #Posicion actual
				
				add $s1, $s4, $zero #Borrado
				
				add $a0, $s5, $zero
				add $a1, $s1, $zero
				add $a2, $s2, $zero
				add $a3, $zero, $zero
				jal EscAij	
				
				add $s1, $zero, $s3
				addi $s1, $s1, -1
			
				add $a0, $s5, $zero # Se escribe el valor
				add $a1, $s1, $zero
				add $a2, $s2, $zero
				add $a3, $zero, $s0
				jal EscAij
				
				add $s1, $s4, $zero
				addi $s1, $s1, -1
				j BuclePrincipalAbajo
					
			IncrementaI:
			      	addi $s1, $s1 -1
			      	j BuclePrincipalAbajo		
	ExitAbajo:	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, 32($sp)	
	addi $sp, $sp, 36 #Se restaura en la pila	
	jr $ra	
		
MoverIzquierda:#a0: Direccion de la matriz

	addi $sp, $sp, -36#Se guarda en la pila
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	add $s5, $a0, $zero #Direccion de la matriz
	addi $s1, $zero, 0 #i
	addi $s2, $zero, 0 #j
			
	BuclePrincipalIzquierda:
		
		bne $s2, 4, ContIzquierda
		beq $s1, 3, ExitIzquierda
		addi $s1, $s1, 1 
		addi $s2, $zero, 0
		ContIzquierda:
		
		add $a0, $s5, $zero
		add $a1, $s1, $zero
		add $a2, $s2, $zero
		jal LeeAij #a0: Direccion de la matriz, a1: i, a2:j
		beq $v0, $zero, IncrementaJIzquierda#La casilla esta vacia, se pasa a la siguiente posicion
		add $s0, $zero, $v0 # Guardamos valor distinto de cero en s0
				
		#Si llegamos aqui se ha encontrado un número
		add $s4, $s2, $zero
		MueveIzquierda:	
		
			addi $s2, $s2, -1
			beq $s2, -1, EscribeIzquierda
			
			add $a0, $s5, $zero
			add $a1, $s1, $zero
			add $a2, $s2, $zero
			jal LeeAij
			bne $v0, $zero, EscribeIzquierda #Si se topa con otro numero distinto de cero
			
			j MueveIzquierda #Si la casilla siguiente esta vacia vuelve al bucle
					
			EscribeIzquierda:
			
				add $s3, $s2, $zero #Posicion actual
				
				add $s2, $s4, $zero #Borrado
				
				add $a0, $s5, $zero
				add $a1, $s1, $zero
				add $a2, $s2, $zero
				add $a3, $zero, $zero
				jal EscAij	
				
				add $s2, $zero, $s3
				addi $s2, $s2, 1
				
				add $a0, $s5, $zero # Se escribe el valor
				add $a1, $s1, $zero
				add $a2, $s2, $zero
				add $a3, $zero, $s0
				jal EscAij
				
				add $s2, $s4, $zero
				addi $s2, $s2, 1
				j BuclePrincipalIzquierda
						
			IncrementaJIzquierda:
			      	addi $s2, $s2, 1
			      	j BuclePrincipalIzquierda		
	ExitIzquierda:	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, 32($sp)	
	addi $sp, $sp, 36 #Se restaura en la pila	
	jr $ra	
		
MoverArriba:#a0: Direccion de la matriz

	addi $sp, $sp, -36#Se guarda en la pila
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	add $s5, $a0, $zero #Direccion de la matriz
	addi $s1, $zero, 0 #i
	addi $s2, $zero, 0 #j
			
	BuclePrincipalArriba:
	
		bne $s1, 4, ContArriba
		beq $s2, 3, ExitArriba
		addi $s2, $s2, 1 
		addi $s1, $zero, 0
		
		ContArriba:
		
		add $a0, $s5, $zero
		add $a1, $s1, $zero
		add $a2, $s2, $zero
		jal LeeAij #a0: Direccion de la matriz, a1: i, a2:j
		beq $v0, $zero, IncrementaIArriba #La casilla esta vacia, se pasa a la siguiente posicion
		add $s0, $zero, $v0 # Guardamos valor distinto de cero en s0
				
		#Si llegamos aqui se ha encontrado un número
		add $s4, $s1, $zero
		MueveArriba:	
			
			addi $s1, $s1, -1
			beq $s1, -1, EscribeArriba
			
			add $a0, $s5, $zero
			add $a1, $s1, $zero
			add $a2, $s2, $zero
			jal LeeAij
			bne $v0, $zero, EscribeArriba#Si se topa con otro numero distinto de cero
			
			j MueveArriba #Si la casilla siguiente esta vacia vuelve al bucle
					
			EscribeArriba:
			
				add $s3, $s1, $zero #Posicion actual
				
				add $s1, $s4, $zero #Borrado
				
				add $a0, $s5, $zero
				add $a1, $s1, $zero
				add $a2, $s2, $zero
				add $a3, $zero, $zero
				jal EscAij	
				
				add $s1, $zero, $s3
				addi $s1, $s1, 1
				
				add $a0, $s5, $zero #Se escribe el valor
				add $a1, $s1, $zero
				add $a2, $s2, $zero
				add $a3, $zero, $s0
				jal EscAij
				
				add $s1, $s4, $zero
				addi $s1, $s1, 1
				j BuclePrincipalArriba
					
			IncrementaIArriba:
			      	addi $s1, $s1 1
			      	j BuclePrincipalArriba		
	ExitArriba:	
			lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, 32($sp)	
	addi $sp, $sp, 36 #Se guarda en la pila	
	jr $ra	
	
SumaDerecha:
	addi $sp, $sp, -36#Se guarda en la pila
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	add $s5, $a0, $zero
	addi $s1, $zero, 3 # Posicion inicial de recorrido 
	addi $s2, $zero, 3 #
	
	BucleSumaDerecha:
		add $a0, $s5, $zero
		add $a1, $s1, $zero
		add $a2, $s2, $zero
		jal LeeAij
		add $s6, $zero, $v0 # Numero leido lo pongo en $s6
		#beq $s0, $zero, IncrementaISumaAbajo # Si es cero paso a la siguiente fila
		addi $s2, $s2, -1
		
		add $a0, $s5, $zero
		add $a1, $s1, $zero
		add $a2, $s2, $zero
		jal LeeAij # Me devuelve en $v0 el valor de la posicion siguiente
		add $s7, $v0, $zero # Numero leido lo pongo en $s1
		beq $s7, $s6, SumaDer
		bne $s7, $s6, IncrementoJSumaDerecha
			
		SumaDer:
			#addi $a1, $a1, 1
			add $a0, $s5, $zero
			add $a1, $s1, $zero
			add $a2, $s2, $zero
			add $a3, $zero, $zero
			jal EscAij
			addi $s2, $s2, 1
			
			add $a0, $s5, $zero
			add $a1, $s1, $zero
			add $a2, $s2, $zero
			add $a3, $s7, $s6
			jal EscAij
			
			addi $s2, $s2, -1
			beq $s2, $zero, IncrementaISumaDerecha#Si estoy en j 0 paso a la siguiente fila
			bne $s2, $zero, IncrementoJSumaDerecha
			
		IncrementaISumaDerecha:
			beq $s1, $zero, ExitSumaDerecha
			addi $s1, $s1, -1
			addi $s2, $zero, 3
			j BucleSumaDerecha
				
		IncrementoJSumaDerecha:
			beq $s2, $zero, IncrementaISumaDerecha#Si estoy en j 0 paso a la siguiente fila
			j BucleSumaDerecha
	ExitSumaDerecha:
			lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, 32($sp)	
	addi $sp, $sp, 36 #Se guarda en la pila	
	jr $ra	

SumaAbajo:
	addi $sp, $sp, -36#Se guarda en la pila
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	add $s5, $a0, $zero
	addi $s1, $zero, 3 # Posicion inicial de recorrido 
	addi $s2, $zero, 3 #
	
	BucleSumaAbajo:
		add $a0, $s5, $zero
		add $a2, $s1, $zero
		add $a1, $s2, $zero
		jal LeeAij
		add $s6, $zero, $v0 # Numero leido lo pongo en $s6
		#beq $s0, $zero, IncrementaISumaAbajo # Si es cero paso a la siguiente fila
		addi $s2, $s2, -1
		
		add $a0, $s5, $zero
		add $a2, $s1, $zero
		add $a1, $s2, $zero
		jal LeeAij # Me devuelve en $v0 el valor de la posicion siguiente
		add $s7, $v0, $zero # Numero leido lo pongo en $s1
		beq $s7, $s6, SumaAbaj
		bne $s7, $s6, IncrementoJSumaAbajo
			
		SumaAbaj:
			#addi $a1, $a1, 1
			add $a0, $s5, $zero
			add $a2, $s1, $zero
			add $a1, $s2, $zero
			add $a3, $zero, $zero
			jal EscAij
			addi $s2, $s2, 1
			
			add $a0, $s5, $zero
			add $a2, $s1, $zero
			add $a1, $s2, $zero
			add $a3, $s7, $s6
			jal EscAij
			
			addi $s2, $s2, -1
			beq $s2, $zero, IncrementaISumaAbajo#Si estoy en j 0 paso a la siguiente fila
			bne $s2, $zero, IncrementoJSumaAbajo
			
		IncrementaISumaAbajo:
			beq $s1, $zero, ExitSumaAbajo
			addi $s1, $s1, -1
			addi $s2, $zero, 3
			j BucleSumaAbajo
				
		IncrementoJSumaAbajo:
			beq $s2, $zero, IncrementaISumaAbajo#Si estoy en j 0 paso a la siguiente fila
			j BucleSumaAbajo
	ExitSumaAbajo:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		lw $s7, 28($sp)
		lw $ra, 32($sp)	
		addi $sp, $sp, 36 #Se guarda en la pila	
		jr $ra	

		
SumaIzquierda:
	addi $sp, $sp, -36#Se guarda en la pila
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	add $s5, $a0, $zero
	add $s1, $zero, $zero # Posicion inicial de recorrido 
	add $s2, $zero, $zero #
	
	BucleSumaIzquierda:
		add $a0, $s5, $zero
		add $a1, $s1, $zero
		add $a2, $s2, $zero
		jal LeeAij
		
		add $s6, $zero, $v0 # Numero leido lo pongo en $s6
		#beq $s0, $zero, IncrementaISumaAbajo # Si es cero paso a la siguiente fila
		
		addi $s2, $s2, 1
		
		add $a0, $s5, $zero
		add $a1, $s1, $zero
		add $a2, $s2, $zero
		jal LeeAij # Me devuelve en $v0 el valor de la posicion siguiente
		add $s7, $v0, $zero # Numero leido lo pongo en $s7
		beq $s7, $s6, SumaIzq
		bne $s7, $s6, IncrementoJSumaIzquierda
			
		SumaIzq:
			#addi $a1, $a1, 1
			add $a0, $s5, $zero
			add $a1, $s1, $zero
			add $a2, $s2, $zero
			add $a3, $zero, $zero
			jal EscAij
			
			addi $s2, $s2, -1
			
			add $a0, $s5, $zero
			add $a1, $s1, $zero
			add $a2, $s2, $zero
			add $a3, $s7, $s6
			jal EscAij
			
			addi $s2, $s2, 1
			beq $s2, 3, IncrementaISumaIzquierda#Si estoy en j 3 paso a la siguiente fila
			bne $s2, 3, IncrementoJSumaIzquierda
			
		IncrementaISumaIzquierda:
			beq $s1, 3, ExitSumaIzquierda# Si estoy en i 3
			addi $s1, $s1, 1
			add $s2, $zero, $zero
			j BucleSumaIzquierda
				
		IncrementoJSumaIzquierda:
			beq $s2, 3, IncrementaISumaIzquierda#Si estoy en j 0 paso a la siguiente fila
			j BucleSumaIzquierda
			
	ExitSumaIzquierda:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		lw $s7, 28($sp)
		lw $ra, 32($sp)	
		addi $sp, $sp, 36 #Se guarda en la pila	
		jr $ra	
			

SumaArriba:
	addi $sp, $sp, -36#Se guarda en la pila
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	add $s5, $a0, $zero
	add $s2, $zero, $zero # Posicion inicial de recorrido 
	add $s1, $zero, $zero #
	
	BucleSumaArriba:
		add $a0, $s5, $zero
		add $a2, $s1, $zero
		add $a1, $s2, $zero
		jal LeeAij
		
		add $s6, $zero, $v0 # Numero leido lo pongo en $s6
		#beq $s0, $zero, IncrementaISumaAbajo # Si es cero paso a la siguiente fila
		
		addi $s2, $s2, 1
		
		add $a0, $s5, $zero
		add $a2, $s1, $zero
		add $a1, $s2, $zero
		jal LeeAij # Me devuelve en $v0 el valor de la posicion siguiente
		add $s7, $v0, $zero # Numero leido lo pongo en $s7
		beq $s7, $s6, SumaArr
		bne $s7, $s6, IncrementoJSumaArriba
			
		SumaArr:
			#addi $a1, $a1, 1
			add $a0, $s5, $zero
			add $a2, $s1, $zero
			add $a1, $s2, $zero
			add $a3, $zero, $zero
			jal EscAij
			
			addi $s2, $s2, -1
			
			add $a0, $s5, $zero
			add $a2, $s1, $zero
			add $a1, $s2, $zero
			add $a3, $s7, $s6
			jal EscAij
			
			addi $s2, $s2, 1
			beq $s2, 3, IncrementaISumaArriba#Si estoy en j 3 paso a la siguiente fila
			bne $s2, 3, IncrementoJSumaArriba
			
		IncrementaISumaArriba:
			beq $s1, 3, ExitSumaArriba # Si estoy en i 3
			addi $s1, $s1, 1
			add $s2, $zero, $zero
			j BucleSumaArriba
				
		IncrementoJSumaArriba:
			beq $s2, 3, IncrementaISumaArriba#Si estoy en j 0 paso a la siguiente fila
			j BucleSumaArriba
			
	ExitSumaArriba:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		lw $s7, 28($sp)
		lw $ra, 32($sp)	
		addi $sp, $sp, 36 #Se guarda en la pila	
		jr $ra		
