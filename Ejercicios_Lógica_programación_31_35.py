# ============================================================================================================================
# 31. Validar la entrada de datos: Pedir una nota entre 0 y 10. Si es inválida, volver a pedirla usando un 'do-while' emulado.
# ============================================================================================================================


while True:
	nota = int(input ("31. Introduce tu nota:"))
	if 0 <= nota <= 10:
		break
	print (f"Error: La nota no es válida. Inténtalo de nuevo.")

print (f" Nota registrada con éxito: {nota}")
	

# ==============================================================================================================
# 32. Imprimir la suma de los números impares entre el 1 y el 100.
# ==============================================================================================================


# Suma números impares del 1 al 100

print("Suma números impares del 1 al 100:")

suma_total = 0 
 
for i in range(1, 101, 2):

	suma_total = suma_total + i

print(f"32. Suma:{suma_total}")

# ==============================================================================================================
# 33. Crear un convertidor de divisas (de euros a dólares) que valide que el importe sea siempre mayor que cero.
# ==============================================================================================================

#Pedir el valor en euros 

euros = float(input ("33. Introduce el monto en Euros:"))
tc=1.12

#condicional 

if euros >0:
	dolares= round(float(euros*tc),2)
	print(f"33. Monto Dólares:{dolares}")
else:

	print(f"33. error el monto en euros es menor que 0")

# ==============================================================================================================================
# 34. Pedir al usuario su edad y determinar su categoría tarifaria: Gratis (<4), Infantil (4-12), Adulto (13-64), Senior (>=65).
# ==============================================================================================================================

#Pedir al usuario su edad  

edad = int(input ("34. Introduce tu edad:"))

#Condicionales 

if edad <4:
	print(f"Por tu edad la tarifa es Gratis")
elif 4<= edad <= 12:
	print(f"Por tu edad te encuentras en la tarifa Infantil")
elif 13 <= edad <=64:
	print(f"Por tu edad te encuentras en la tarifa Adulto")
else:
	print(f"Por tu edad te encuentras en la tarifa Senior")

# ==================================================================================================================
# 35. Generar la secuencia de números del 1 al 100 saltando de 5 en 5 con un bucle 'for'.
# ==================================================================================================================

# Cuenta de 5 en 5 hasta el 100

print("Números de 5 en 5 del 1 al 100:")

for i in range(1, 101, 5):

	print(f"Número de 5 en 5 hasta el 100: {i}")


