import random 

# ============================================================================================================================
# 36. Escribir un programa que pida un número al usuario y calcule la suma de sus dígitos.
# ============================================================================================================================

#Pedir un número al usuario  

numero_str = str(input ("36. Introduce un número de 2 dígitos o más:"))


#convertir el número en digitos y sumarlos  


suma = sum(int(digito) for digito in numero_str)

print(f"La suma de los dígitos es: {suma}")


# ==============================================================================================================
# 37. Simular el lanzamiento de un dado repetidas veces hasta que salga el número 6.
# ==============================================================================================================

# definir la variable

dado = [1,2,3,4,5,6]

# Lanzaminto dado 

while True:

	dado = random.randint(1, 6)
	if dado==1:
	 	print(f"{dado}")
	elif dado==2:
		print(f"{dado}")
	elif dado==3:
		print(f"{dado}")
	elif dado==4:
		print(f"{dado}")
	elif dado==5:
		print(f"{dado}")
	elif dado==6:
		break
print(f"37. Bien! obtuviste {dado}")

# ==============================================================================================================
# 38. Solicitar los tres lados de un triángulo y clasificarlo en equilátero, isósceles o escaleno..
# ==============================================================================================================

#Pedir medidas de los lados del triangulo  

lado_1 = float(input ("38. Introduce la medida de un lado del triangulo:"))
lado_2 = float(input ("38. Introduce la medida de un lado del triangulo:"))
lado_3 = float(input ("38. Introduce la medida de un lado del triangulo:"))

#Clasificar los triangulos 

if lado_1 == lado_2 == lado_3:
	print(f"Tienes un triangulo equilátero")
elif lado_1 == lado_2 or lado_2 == lado_3 or lado_1 == lado_3:
	print(f"Tienes un triangulo isósceles")
elif lado_1 != lado_2 != lado_3:	
	print(f"Tienes un triangulo escaleno")

# ==============================================================================================================================
# 39. Crear una lista con 5 frutas y utilizar un bucle para mostrar cada una con su índice numérico.
# ==============================================================================================================================

#Definir la variable 

contar=0

frutas = ["manzana", "plátano", "mandarina", "sandía", "naranja"]
for frutas in frutas:

	contar = contar + 1
	print(f" La fruta es: {contar}. {frutas}")

# ==================================================================================================================
# 40. Pedir números enteros al usuario y acumular la suma. Detener el proceso cuando la suma supere 100.
# ==================================================================================================================

#Pedir numero clientes y while

numero_tot = 0
while True:
	numero = int(input ("40. Introduce un numero:"))
	numero_tot = numero_tot + numero
	if numero_tot>100:
		break
	print (f" introduce otro número hasta llegar a 100: {numero_tot}")
print (f" la suma supero 100 esta es igual a: {numero_tot}")


