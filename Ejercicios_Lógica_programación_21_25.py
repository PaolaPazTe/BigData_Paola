
# ==============================================================================================================
# 21. Imprimir los múltiplos de 3 del rango del 1 al 30.
# ==============================================================================================================

# Múltiplos de 3 del rango 1 hasta el 30

print("21Múltiplos de 3 hasta el 30:")

for i in range(3, 31, 3):

	print(f"Múltiplos de 3: {i}")


# ==============================================================================================================
# 22.	Pedir al usuario dos palabras y comprobar si son idénticas utilizando un condicional.
# ==============================================================================================================

#Pedir dos palabras al usuario

palabra_1 = str(input ("22. Introduce la primera palabra:"))

palabra_2 = str(input ("Introduce la segunda palabra:"))

if palabra_1.lower() == palabra_2.lower():
	print(f" {palabra_1} y {palabra_2} son iguales")
else:
	print(f" {palabra_1} y {palabra_2} no coinciden")


# ==============================================================================================================
# 23.	Multiplicar todos los números del 1 al 5 (calcular el factorial de 5 de forma manual con bucle).
# ==============================================================================================================

# Multiplica todos los números del 1 al 5 

print("Factorial de 5:")

factorial = 1
for i in range(1, 6):
	factorial = factorial * i
		
print(f"23. factorial:{factorial}")


# ==============================================================================================================
# 24.	Pedir al usuario un número y mostrar un mensaje si se encuentra en el rango de 10 a 20.
# ==============================================================================================================

#Pedir dos palabras al usuario

numero = int(input ("24. Introduce un número:"))

if 10 <= numero <= 20:
	print(f" {numero} está en el rango de 10 a 20")
else: 
	print(f" {numero} no está en el rango de 10 a 20")

# ==============================================================================================================
# 25.	Crear una variable que almacene una contraseña fija y pedir al usuario que intente adivinarla una vez.
# ==============================================================================================================

#Creamos la variable

contraseña = "PaolaP22"

#Pedir adivinar la contraseña

contraseña_u = str(input ("25. Adivina la contraseña:"))

#Condicional 

if contraseña_u == contraseña:
	print(f"Adivinaste la contraseña")
else:
	print(f"contraseña erronea")



