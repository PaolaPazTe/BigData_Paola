
# ==============================================================================================================
# 26. Crear un sistema de inicio de sesión que pida usuario y contraseña, y valide ambos con operadores lógicos.
# ==============================================================================================================

usuario = "Paola Paz"
contraseña = "p1234Pt"

#Pedir usuario y contraseña

usuario_s = (input ("26. Introduce tu usuario:"))

contraseña_s = (input ("26. Introduce tu contraseña:"))

#Validar con operadores lógicos 

if usuario_s == usuario and contraseña_s == contraseña:
	print(f"Login correcto")
else:
	print(f"Usuario o contraseña incorrectos")
	
	
# ==============================================================================================================
# 27. Escribir un programa que pida una letra y determine si es una vocal o una consonante.
# ==============================================================================================================

#Pedir usuario una letra

letra = str(input ("27. Introduce una letra:"))

letra_v = ["a","e","i","o","u"]

#Determinar si es vocal o consonante 

if letra in letra_v:

	print(f"La letra introducida es una vocal")
else:
	print(f"La letra introducida es una consonante")
	
# ==============================================================================================================
# 28. Solicitar un año al usuario y determinar si es bisiesto o no.
# ==============================================================================================================

#Pedir usuario un año

año = int(input ("28. Introduce un año:"))

#Determinar si es bisiesto

if (año % 4 == 0 and año % 100 != 0) or (año % 400 == 0):
	print(f"El año es bisiesto")
else:
	print(f"El año no es bisiesto")

# =================================================================================================================
# 29. Crear una calculadora básica que pida dos números y un operador (+, -, *, /) mediante condicionales múltiples.
# =================================================================================================================


#Pedir numeros y operador 

numero_1 = float(input ("29. Introduce un número:"))
numero_2 = float(input ("29. Introduce otro número:"))
operador = str(input ("29. Introduce un operador (+, -, *, /):"))

#Condicionales 

if operador == "+":
	Resultado_1 = numero_1 + numero_2
	print (f" El resultado es {Resultado_1}")
elif operador == "-":
	Resultado_2 = numero_1 - numero_2
	print (f" El resultado es {Resultado_2}")
elif operador == "*":
	Resultado_3 = numero_1 * numero_2
	print (f" El resultado es {Resultado_3}")
elif operador== "/":
	if numero_2 == 0:
		print (f" no se puede dividir entre 0 ")
	else:
		Resultado_4 = numero_1 / numero_2
		print (f" El resultado es {Resultado_4}")
else: 
	print (f" operación no permitida")

# ==================================================================================================================
# 30. Usar un bucle 'while' para pedir números al usuario de forma continua hasta que introduzca un número negativo.
# ==================================================================================================================

numero = float(input ("30. Introduce un número:"))
while True:
	numero = float(input ("30. Introduce un número:"))
	if numero <0:
		break
	print (f" número positivo, introduce otro número")
print (f" número negativo, ya no puedes poner más números")










