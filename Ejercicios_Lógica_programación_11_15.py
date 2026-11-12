
# ==============================================================================================================
# 11. Calcular la suma de todos los números enteros del 1 al 50 utilizando un bucle.
# ==============================================================================================================


# Suma del 1 al 50 

print("Suma números enteros del 1 al 50:")

suma_total = 0 

for i in range(1, 51):

	suma_total = suma_total + i
	
print(f"11. Suma:{suma_total}")

# ==============================================================================================================
# 12. Mostrar la tabla de multiplicar del número 5 utilizando un bucle del 1 al 10.
# ==============================================================================================================

# Tabla de multiplicar  

print("Tabla de multiplicar del número 5:")

for i in range(1, 11):

	print(f"12. {i} x 5 = {i*5}")


# ==============================================================================================================
# 13. Pedir una palabra al usuario y mostrarla por pantalla 5 veces consecutivas usando un ciclo.
# ==============================================================================================================

# Pedir una palabra 

palabra = str(input("13.Introduce una palabra:"))

for vez in range (5):

	print (f"Palabra: {palabra}")

# ==============================================================================================================
# 14. Crear un programa que pida el radio de un círculo y calcule su área.
# ==============================================================================================================


# Pedir Radio 

radio = int(input("13.Introduce el radio del circulo:"))

pi =3.1416

Area = pi * radio**2

print (f"Area circulo: {Area}")

# ==============================================================================================================
# 15. Solicitar tres notas al usuario, calcular el promedio e indicar si está aprobado (nota >= 5).
# ==============================================================================================================


# Pedir Notas 

nota_1 = int(input("15.Introduce tu Primera Nota (del 1 al 10):")) 
nota_2 = int(input("15.Introduce tu Segunda Nota (del 1 al 10):")) 
nota_3 = int(input("15.Introduce tu Tercera Nota (del 1 al 10):")) 

promedio = (nota_1 + nota_2 + nota_3)/3

if promedio >= 5:
	print(f"Promedio = {promedio}, Aprobaste el Curso")
else:
	print(f"Promedio = {promedio}, Reprobaste el Curso")

