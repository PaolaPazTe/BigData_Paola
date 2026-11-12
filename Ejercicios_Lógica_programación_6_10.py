# ==============================================================================================================
# 6.Escribir un programa que pida un número entero y determine si es par o impar.
# ==============================================================================================================

#Pedir el número al usuario

numero_entero = int(input ("6. Dame un número entero:"))

#Para determinar si es par o impar la función se usa "%" para dividir el numero entre 2 y si es igual a 0 es par #

if numero_entero%2 ==0:

	print(f"número par")
else:
	print(f"número impar")


# ==============================================================================================================
# 7. Solicitar dos números al usuario y mostrar cuál de los dos es el mayor.
# ==============================================================================================================

#Pedir los números al usuario

numero_1 = int(input ("6. Dame un número:"))
numero_2 = int(input ("6. Dame otro número:"))

#Condicional

if numero_1>numero_2:
	print(f"el número_1 es mayor al número_2")
else:
	print(f"el número_2 es mayor al número_1")

# ==============================================================================================================
# 8. Declarar una variable booleana que indique si un usuario está logueado y mostrar un mensaje acorde.
# ==============================================================================================================

# Variable Booleana
Esta_loggeado = True

#Condicional
if Esta_loggeado:
	print(f"Usuario Logueado")
else:
	print(f"El Usuario Necesita Loguearse")


# ==============================================================================================================
# 9. Utilizar un bucle para imprimir los números del 1 al 10 en orden ascendente.
# ==============================================================================================================

# Cuenta del 1 al 10 

print("Contando del 1 al 10:")

for i in range(1, 11):

	print(f"Número: {i}")

# Cuenta de 1 en 1 hasta el 10

print("\nNúmeros del 1 al 10:")

for i in range(2, 11, 2):

	print(f"Par: {i}")

# Cuenta de 1 en 1 hasta el 10

print("\nNúmeros del 1 al 10:")

for i in range(1, 11, 2):

	print(f"Impar: {i}")



# ==============================================================================================================
# 10. Utilizar un bucle para imprimir los números del 10 al 1 en orden descendente.
# ==============================================================================================================

# Cuenta del 10 al 1 

print("Contando del 10 al 1:")

for i in range(10,0,-1):

	print(f"Número: {i}")

