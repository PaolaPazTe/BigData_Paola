from datetime import datetime

# ==============================================================================================
# 1.Escribir un programa que guarde tu nombre en una variable e imprima un saludo personalizado
# ==============================================================================================

# Guardar el nombre en una variable

nombre="Paola"

# Poner el mensaje que sale en pantalla

print(f"1. Bienvenida {nombre}")

# ==============================================================================================
# 2.Declarar dos variables numéricas, sumarlas y mostrar el resultado por pantalla.
# ==============================================================================================

# Guardar los números en dos variables

numero1= 10 
numero2= 20 

# generar el cálculo 

Suma = numero1 + numero2

# Poner el resultado en pantalla

print(f"2.Suma= {Suma}")

# ==============================================================================================================
#3.Crear una variable con el precio de un producto y otra con el IVA (21%). Calcular y mostrar el precio total.
# ==============================================================================================================

#Variable con el Precio 

Precio= 200
IVA=0.21

#Cálculo 

Precio_Total= round(Precio * (1+IVA),2)

# Resultado en Pantalla

print(f"3.Precio Total = {Precio_Total}")


# ==============================================================================================================
#4.Solicitar al usuario su año de nacimiento y calcular su edad actual.
# ==============================================================================================================


# Solicitar año de nacimiento


respuesta = int(input ("4. ¿Qué año naciste?:"))

fecha_actual = datetime.now()

año_actual = fecha_actual.year

# Calcular edad

Edad = año_actual - respuesta

# Resultado

print(f"4.Cumples {Edad} años")

# ==============================================================================================================
# 5.Pedir un número al usuario y determinar si es positivo, negativo o cero utilizando un condicional simple.
# ==============================================================================================================

#Pedir el número al usuario
numero = int(input ("5. Dame un número:"))

#Condicional 

if numero > 0:

	print(f"número positivo")

elif numero < 0:

	print(f"número negativo")

else:

	print(f"número es 0")



