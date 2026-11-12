
# ==============================================================================================================
# 16. Imprimir todos los números pares que se encuentren entre el 1 y el 30.
# ==============================================================================================================

# Cuenta de 2 en 2 hasta el 30

print("Números Pares del 1 al 30:")

for i in range(2, 31, 2):

	print(f"Par: {i}")

# ==============================================================================================================
# 17. Pedir al usuario una temperatura en grados Celsius y convertirla a Fahrenheit
# ==============================================================================================================

#Pedir temperatura al usuario

Celsius = int(input ("17. Dame la temperatura en ºC:"))

#Convertir a Farenheit 

farenheit = (Celsius * 1.8) + 32

print(f"La temperatura equivalente en Farenheit es {farenheit}")

# ==============================================================================================================
# 18. Crear un programa que convierta una cantidad de minutos introducida por el usuario a horas y minutos.
# ==============================================================================================================

#Pedir temperatura al usuario

Minutos = int(input ("18. Dame la cantidad de minutos que quieres convertir:"))

# Convertir a horas + min

Horas, minutos_r = divmod(Minutos, 60)

print(f" {Minutos} es equivalente a {Horas} horas y {minutos_r} minutos ")

# ==============================================================================================================
# 19. Solicitar al usuario un precio base y aplicar un descuento del 15% si el precio es mayor a 50
# ==============================================================================================================


#Pedir Precio al usuario

precio = float(input ("19. Introduce el precio:"))

precio_final = precio * 0.85

if precio >50:
	print(f" Tiene descuento, el precio final es {precio_final}")
else:
	print(f" No tiene descuento")
	
# ==============================================================================================================
# 20. Escribir un programa que cuente cuántas letras tiene una palabra introducida por el usuario.
# ==============================================================================================================

#Pedir Palabra al usuario

palabra = str(input ("19. Introduce una palabra:"))

contar = len(palabra)

print(f" La palabra tiene {contar} letras")
